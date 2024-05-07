import 'package:workmate/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e('${bloc.runtimeType} error: $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) {
      logger.d('${bloc.runtimeType} change: {\n'
          '> Current event: ${change.currentState}\n'
          '> Next state: ${change.nextState}\n'
          '}');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.d('${bloc.runtimeType} transition: {\n'
        '> Event: ${transition.event}\n'
        '> Current state: ${transition.currentState}\n'
        '> Next state: ${transition.nextState}\n'
        '}');
  }
}
