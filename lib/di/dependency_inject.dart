import 'package:workmate/main/main_dev.dart';
import 'package:workmate/repository/auth_repository.dart';
import 'package:workmate/repository/firestore_repository.dart';
import 'package:workmate/repository/network_repository.dart';
import 'package:workmate/ui/account_info/bloc/account_info_bloc.dart';
import 'package:workmate/ui/home/bloc/home_bloc.dart';
import 'package:workmate/ui/login/bloc/login_bloc.dart';
import 'package:workmate/ui/register/bloc/register_bloc.dart';
import 'package:workmate/utils/connectivity_helper.dart';
import 'package:workmate/utils/const.dart';

Future<void> setupDependency({String baseUrl = Const.baseUrlStg}) async {
  var networkFactory = NetworkRepositoryImpl(baseUrl: baseUrl);
  getIt.registerSingleton<NetworkRepository>(networkFactory);
  getIt.registerSingleton<ConnectivityHelper>(ConnectivityHelper());
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(networkRepository: getIt()));
  getIt.registerFactory<LoginBloc>(() => LoginBloc(authRepository: getIt()));
  getIt.registerFactory<RegisterBloc>(
      () => RegisterBloc(authRepository: getIt()));
  getIt.registerFactory<HomeBloc>(() => HomeBloc(authRepository: getIt()));
  getIt.registerFactory<AccountInfoBloc>(() =>
      AccountInfoBloc(authRepository: getIt()));
}
