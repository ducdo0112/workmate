import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityHelper {
  final _internetChecker = InternetConnectionChecker();

  Future<bool> isNetworkConnected() async {
    bool result = await _internetChecker.hasConnection;
    return result;
  }
}
