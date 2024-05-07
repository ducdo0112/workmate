class StoreIdEvent {
  final String storeId;
  final bool isShowAllNearShopList;
  final bool isUserRequireFetchFromHistoryTabPage;

  const StoreIdEvent( {
    required this.storeId,
    this.isShowAllNearShopList = false,
    this.isUserRequireFetchFromHistoryTabPage = false,
  });
}
