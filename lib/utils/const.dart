import 'package:flutter/material.dart';

class Const {
  static const screenDesignSize = Size(390, 844);

  static const String baseUrlStg = "https://app.cmn-gift.com/";
  static const String baseUrlProduct = "https://api.cmn-gift.com/";

  static const String urlQa = "https://view.cmn-gift.com/qa.html";
  static const String urlTermOfUse = "https://view.cmn-gift.com/policy.html";
  static const String urlPrivacy = "https://view.cmn-gift.com/privacy.html";

  static const int numberMovieItemInOnePage = 20;

  static const int timeoutRequestNetwork = 20000;
  static const int timeoutReviveResponseNetwork = 10000;

  /// Code response API
  static const int successNetworkCall = 200;
  static const int unknownErrorNetworkCall = 1001;

  static const int dioErrorConnectTimeout = 600;
  static const int dioErrorSendTimeout = 601;
  static const int dioErrorReceiveTimeout = 602;
  static const int dioErrorResponse = 603;
  static const int dioErrorCancel = 604;
  static const int dioErrorOther = 605;
  static const int noInternet = 1000;

  static const int forceUpdateResponseCode = 999;
  static const int forceLogoutResponseCode = 1000;
  static const int error401ResponseCode = 401;
  static const int error400ResponseCode = 400;
  static const int error403ResponseCode = 403;
  static const int error500ResponseCode = 500;
  static const int maintenanceResponseCode = 600;

  /// Parsing net  response error
  static const int parsingNetworkResponseError = 700;
}
