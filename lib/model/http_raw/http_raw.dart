class HttpRaw {
  final bool? isSuccessCall;
  final dynamic data;
  final int? errorCode;
  final String errorMessage;

  const HttpRaw({
    this.isSuccessCall = false,
    this.data,
    this.errorCode = -1,
    this.errorMessage = '',
  });
}
