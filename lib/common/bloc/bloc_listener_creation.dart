import 'package:workmate/common/bloc/base_state.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef BlocStateCallback<S> = void Function(BuildContext context, S? state);

/// Create a [BlocListener] with its state extends [BaseState] and its Bloc
/// extends [BaseBloc]. Using defined [BlocStateCallback] callbacks to handle
/// corresponding state.
///
/// Using [onLoading] if state is loading. Using [onSuccess] if state is
/// success...
BlocListener<B, S>
    createBlocListener<E, S extends BaseState, B extends Bloc<E, S>>({
  Key? key,
  BlocListenerCondition<S>? listenWhen,
  Widget? child,
  bool? shouldShowLoadingFullScreen,
  bool? shouldShowDefaultErrorDialog,
  BlocStateCallback<S>? onLoading,
  BlocStateCallback<S>? onSuccess,
  BlocStateCallback<S>? onError,
  Function(BuildContext, S)? onErrorAction,
  Function(BuildContext, S)? onDisconnectAction,
}) {
  return BlocListener<B, S>(
    listener: (context, state) {
      switch (state.status) {
        case BlocStatus.noInternetError:
          /// show dialog lost connection in here
          break;
        case BlocStatus.forceLogout:
          /// handle force logout
          break;
        case BlocStatus.loading:
          onLoading?.call(context, state);
          break;
        case BlocStatus.success:
          onSuccess?.call(context, state);
          break;
        case BlocStatus.error:
          /// handle  and show dialog error if needed
          onError?.call(context, state);
          break;
        default:
          break;
      }
    },
    listenWhen: listenWhen,
    child: child,
  );
}
