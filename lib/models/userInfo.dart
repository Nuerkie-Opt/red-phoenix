import 'dart:convert';

class UserData {
  String? displayName;
  String? email;
  String? phoneNumber;
  String? photoUrl;
  String? uid;
  num? numberOfOrders;
  UserData({
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.uid,
  });

  UserData copyWith({
    String? displayName,
    String? email,
    String? phoneNumber,
    String? photoUrl,
    String? uid,
  }) {
    return UserData(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'uid': uid,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      displayName: map['displayName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      photoUrl: map['photoUrl'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) => UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(displayName: $displayName, email: $email, phoneNumber: $phoneNumber, photoUrl: $photoUrl, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.displayName == displayName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.photoUrl == photoUrl &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return displayName.hashCode ^ email.hashCode ^ phoneNumber.hashCode ^ photoUrl.hashCode ^ uid.hashCode;
  }
}
