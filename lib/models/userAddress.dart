class UserAddress {
  String location;
  String? gpsAddress;
  String city;
  String region;
  String phoneNumber;
  UserAddress(
      {required this.location, required this.phoneNumber, this.gpsAddress, required this.city, required this.region});
}
