import 'package:workmate/main/main_dev.dart';
import 'package:workmate/repository/auth_repository.dart';
import 'package:workmate/repository/firestore_repository.dart';
import 'package:workmate/repository/network_repository.dart';
import 'package:workmate/ui/account_info/bloc/account_info_bloc.dart';
import 'package:workmate/ui/add_chat_group/bloc/add_chat_group_bloc.dart';
import 'package:workmate/ui/calendar/bloc/calender_bloc.dart';
import 'package:workmate/ui/chat/bloc/chat_bloc.dart';
import 'package:workmate/ui/events/bloc/add_event_bloc.dart';
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
  getIt.registerLazySingleton<FireStoreRepository>(() => FireStoreRepository());
  getIt.registerFactory<LoginBloc>(() => LoginBloc(authRepository: getIt()));
  getIt.registerFactory<RegisterBloc>(
      () => RegisterBloc(authRepository: getIt()));
  getIt.registerFactory<HomeBloc>(() => HomeBloc(authRepository: getIt()));
  getIt.registerFactory<AccountInfoBloc>(
      () => AccountInfoBloc(authRepository: getIt()));
  getIt.registerFactory<ChatBloc>(() => ChatBloc(fireStoreRepository: getIt()));
  getIt.registerFactory<AddChatGroupBloc>(
      () => AddChatGroupBloc(fireStoreRepository: getIt()));
  getIt.registerFactory<CalendarBloc>(
      () => CalendarBloc(fireStoreRepository: getIt()));
  getIt.registerFactory<AddEventBloc>(
      () => AddEventBloc(fireStoreRepository: getIt()));
}
