import 'package:workmate/main/main_dev.dart';
import 'package:workmate/model/enum/error_message.dart';
import 'package:workmate/model/http_raw/http_raw.dart';
import 'package:workmate/utils/const.dart';
import 'package:workmate/utils/logger.dart';
import 'package:workmate/utils/timestamp.dart';
import 'package:dio/dio.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

abstract class NetworkRepository {
  Future<HttpRaw> get(
      {required String endUrl, Map<String, dynamic>? queryParameters});

  Future<HttpRaw> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  Future<HttpRaw> put({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  void updateToken({required String token});
}

class NetworkRepositoryImpl extends NetworkRepository {
  late Dio _dio;
  final String baseUrl;
  late MyInterceptor interceptor;

  NetworkRepositoryImpl({required this.baseUrl}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 10),
    ));

    interceptor = MyInterceptor();
    _dio.interceptors.add(interceptor);
  }

  @override
  Future<HttpRaw> get(
      {required String endUrl, Map<String, dynamic>? queryParameters}) async {
    final httpRawResponse = (await _fetch(
            () => _dio.get(endUrl, queryParameters: queryParameters))) ??
        const HttpRaw();
    return httpRawResponse;
  }

  Future<HttpRaw?> _fetch(Future<Response> Function() function) async {
    try {
      Response response = await function.call();
      if (response.statusCode == Const.successNetworkCall) {
        return HttpRaw(isSuccessCall: true, data: response.data);
      }
    } on DioException catch (dioError) {
      final errorCode = dioError.response?.statusCode;
      final errorMessage =
          ErrorCodeMessage.getErrorCodeMessage(errorCode: errorCode);

      return HttpRaw(
        isSuccessCall: false,
        errorMessage: errorMessage,
        errorCode: errorCode,
      );
    } catch (error) {
      return const HttpRaw(
          isSuccessCall: false, errorCode: Const.unknownErrorNetworkCall);
    }
    return null;
  }

  @override
  Future<HttpRaw> post(
      {required String path,
      data,
      Map<String, dynamic>? queryParameters}) async {
    final httpRawResponse = (await _fetch(() =>
            _dio.post(path, data: data, queryParameters: queryParameters))) ??
        const HttpRaw();
    return httpRawResponse;
  }

  @override
  Future<HttpRaw> put(
      {required String path,
      data,
      Map<String, dynamic>? queryParameters}) async {
    final httpRawResponse = (await _fetch(() =>
            _dio.put(path, data: data, queryParameters: queryParameters))) ??
        const HttpRaw();
    return httpRawResponse;
  }

  @override
  void updateToken({required String token}) {
    interceptor.token = token;
  }
}

class MyInterceptor extends Interceptor {
  String token = '';
  String timezone = '';

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (token.isEmpty) {
      await getToken();
    }

    if (timezone.isEmpty) {
      await getTimezone();
    }

    if (token.isNotEmpty) {
      options.headers.addAll({"authorization": "Bearer $token"});
    }
    options.headers.addAll({"timezone": timezone});
    logger.d(
        'Request API option: method: ${options.uri}, data: ${options.data}, header: ${options.headers}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
        'Request API response: statusCode: ${response.statusCode}, ${Timestamp.getCurrentTimeStamp()}');
    logger.d('Request API response: data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
        'Request API error: ${err.requestOptions.uri} ,${err.response?.statusCode} ${err.message},${Timestamp.getCurrentTimeStamp()}');
    super.onError(err, handler);
  }

  Future<void> getToken() async {
  }


  Future<void> getTimezone() async {
    try {
      timezone = await FlutterNativeTimezone.getLocalTimezone();
    } catch (e) {
      logger.d('Error when get token and uuid');
    }
  }
}
