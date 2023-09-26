/// Store model instance
class Store {
  final int storeId;
  final String storeName, ownerName, country, mobile, city, state, storeImage;

  const Store(
    this.storeId, {
    required this.ownerName,
    required this.country,
    required this.mobile,
    required this.city,
    required this.state,
    required this.storeName,
    required this.storeImage,
  });

  @override
  String toString() {
    return 'Store{storeId: $storeId, storeName: $storeName, ownerName: $ownerName, country: $country, mobile: $mobile, city: $city, state: $state, storeImage: $storeImage}';
  }
}
