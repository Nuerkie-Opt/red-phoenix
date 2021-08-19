import 'dart:convert';

class UserAddress {
  String address;
  String? gpsAddress;
  String city;
  String? region;
  UserAddress({
    required this.address,
    this.gpsAddress,
    required this.city,
    this.region,
  });

  UserAddress copyWith({
    String? address,
    String? gpsAddress,
    String? city,
    String? region,
  }) {
    return UserAddress(
      address: address ?? this.address,
      gpsAddress: gpsAddress ?? this.gpsAddress,
      city: city ?? this.city,
      region: region ?? this.region,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'gpsAddress': gpsAddress,
      'city': city,
      'region': region,
    };
  }

  factory UserAddress.fromMap(Map<String, dynamic> map) {
    return UserAddress(
      address: map['address'],
      gpsAddress: map['gpsAddress'],
      city: map['city'],
      region: map['region'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAddress.fromJson(String source) => UserAddress.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserAddress(address: $address, gpsAddress: $gpsAddress, city: $city, region: $region)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserAddress &&
        other.address == address &&
        other.gpsAddress == gpsAddress &&
        other.city == city &&
        other.region == region;
  }

  @override
  int get hashCode {
    return address.hashCode ^ gpsAddress.hashCode ^ city.hashCode ^ region.hashCode;
  }
}
