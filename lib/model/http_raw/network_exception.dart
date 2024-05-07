import 'package:workmate/model/http_raw/http_raw.dart';

class NetworkException {
  final int? code;
  final String? message;

  const NetworkException({this.code, this.message});

  factory NetworkException.copyFromHttpRaw(HttpRaw httpRaw) {
    return NetworkException(
      code: httpRaw.errorCode,
      message: httpRaw.errorMessage,
    );
  }
}
