class workmateEventFetchData {
  const workmateEventFetchData(
      {required this.storeId,
      this.needCallApiVisitRegisterBeforeFetchData = true});

  final String storeId;
  final bool needCallApiVisitRegisterBeforeFetchData;
}
