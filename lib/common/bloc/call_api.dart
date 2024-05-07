import 'package:firebase_auth/firebase_auth.dart';
import 'package:workmate/common/widget/info_dialog.dart';
import 'package:workmate/common/widget/no_connection_dialog.dart';
import 'package:workmate/generated/l10n.dart';
import 'package:workmate/main/main_dev.dart';
import 'package:workmate/main/my_app.dart';
import 'package:workmate/model/http_raw/network_exception.dart';
import 'package:workmate/utils/connectivity_helper.dart';
import 'package:workmate/utils/const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ErrorCallback = void Function(NetworkException e);

bool isDialogShowing = false;

Future<void> handleCallApi({
  required AsyncCallback onCallApi,
  ErrorCallback? onNoInternet,
  ErrorCallback? onError,
  bool handleErrorCode = false,
  bool shouldShowDialogNotConnectionBeforeCallApi = true,
  bool shouldDefaultErrorDialogWhenCallApi = false,
  VoidCallback? actionReload,
  bool isDisplayReloadButtonInsteadOfOK = false,
}) async {
  final connectivityManager = getIt<ConnectivityHelper>();
  bool isNetworkConnected = await connectivityManager.isNetworkConnected();
  if (!isNetworkConnected) {
    if (shouldShowDialogNotConnectionBeforeCallApi) {
      _showNoConnectionDialog(action: actionReload);
    }
    onNoInternet?.call(const NetworkException(code: Const.noInternet));
    return;
  }
  try {
    await onCallApi.call();
  } on NetworkException catch (e) {
    if (shouldDefaultErrorDialogWhenCallApi) {
      _showDefaultErrorDialog(
        message: e.message ?? 'Lỗi không xác định, vui lòng thử lại!',
        action: actionReload,
        isDisplayReloadButtonInsteadOfOK: isDisplayReloadButtonInsteadOfOK,
      );
    }
    onError?.call(e);
  } on FirebaseAuthException catch (e) {
    if (shouldDefaultErrorDialogWhenCallApi) {
      _showDefaultErrorDialog(
        message: e.message ?? 'Lỗi không xác định, vui lòng thử lại!',
        action: actionReload,
        isDisplayReloadButtonInsteadOfOK: isDisplayReloadButtonInsteadOfOK,
      );
    }
    onError?.call(NetworkException(
        code: Const.unknownErrorNetworkCall, message: e.message));
  } catch (e) {
    if (shouldDefaultErrorDialogWhenCallApi) {
      _showDefaultErrorDialog(
        message: "Lỗi không xác định, vui lòng thử lại!",
        action: actionReload,
        isDisplayReloadButtonInsteadOfOK: isDisplayReloadButtonInsteadOfOK,
      );
    }
    onError?.call(const NetworkException(
        code: Const.unknownErrorNetworkCall, message: 'Lỗi không xác định, vui lòng thử lại!'));
  }
}

void _showNoConnectionDialog({Function()? action}) {
  final BuildContext? buildContext = navigatorKey.currentState?.context;
  if (buildContext != null && !isDialogShowing) {
    isDialogShowing = true;
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: buildContext,
      builder: (context) {
        return NoConnectionDialog(action: action);
      },
    ).then((_) => isDialogShowing = false);
  }
}

void _showDefaultErrorDialog({
  required String message,
  Function()? action,
  bool isDisplayReloadButtonInsteadOfOK = false,
}) {
  final BuildContext? buildContext = navigatorKey.currentState?.context;
  if (buildContext != null && !isDialogShowing) {
    isDialogShowing = true;
    showDialog(
      context: buildContext,
      builder: (context) {
        return InfoDialog(
            action: isDisplayReloadButtonInsteadOfOK ? action : null,
            title: S.current.notice,
            content: message,
            textButtonAction: isDisplayReloadButtonInsteadOfOK
                ? S.current.reload
                : S.current.ok);
      },
    ).then((_) => isDialogShowing = false);
  }
}
