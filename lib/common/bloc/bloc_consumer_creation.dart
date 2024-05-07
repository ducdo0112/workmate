import 'package:workmate/common/bloc/base_state.dart';
import 'package:workmate/common/widget/loading_progress.dart';
import 'package:workmate/model/enum/bloc_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef BlocStateCallback<S> = void Function(BuildContext context, S? state);

/// Create a [BlocConsumer] with its state extends [BaseState] and its Bloc
/// extends [BaseBloc]. Using defined [BlocStateCallback] callbacks to handle
/// corresponding state.
///
/// Using [onLoading] if state is loading. Using [onSuccess] if state is
/// success...
BlocConsumer<B, S>
    createBlocConsumer<E, S extends BaseState, B extends Bloc<E, S>>({
  Key? key,
  required BlocWidgetBuilder<S> builder,
  BlocBuilderCondition<S>? buildWhen,
  BlocListenerCondition<S>? listenWhen,
  bool? shouldShowLoadingFullScreen,
  bool? shouldShowDefaultErrorDialog,
  BlocStateCallback<S>? onLoading,
  BlocStateCallback<S>? onSuccess,
  BlocStateCallback<S>? onError,
  BlocStateCallback<S>? onInternetError,
  Function(BuildContext, S)? listener,
  Function(BuildContext, S)? onErrorAction,
  Function(BuildContext, S)? onDisconnectAction,
}) {
  return BlocConsumer<B, S>(
    key: key,
    listener: (context, state) {
      listener?.call(context, state);
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
    builder: (context, state) {
      if (shouldShowLoadingFullScreen ?? false) {
        if (state.status == BlocStatus.loading) {
          return const LoadingProgress();
        }
      }
      return builder.call(context, state);
    },
    buildWhen: buildWhen,
    listenWhen: listenWhen,
  );
}
