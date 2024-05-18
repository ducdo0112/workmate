import 'package:workmate/repository/auth_repository.dart';
import 'package:workmate/ui/home/bloc/home_event.dart';
import 'package:workmate/ui/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthRepository authRepository;

  AdminHomeBloc({required this.authRepository}) : super(const HomeState()) {}
}
