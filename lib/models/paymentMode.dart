import 'dart:convert';

class PaymentDetails {
  String paymentDetails;
  PaymentDetails({required this.paymentDetails});
}

class MoMoPayments {
  num amount;
  String email;
  String currency;
  MobileMoney momo;
  MoMoPayments({
    required this.amount,
    required this.email,
    required this.currency,
    required this.momo,
  });

  MoMoPayments copyWith({
    num? amount,
    String? email,
    String? currency,
    MobileMoney? momo,
  }) {
    return MoMoPayments(
      amount: amount ?? this.amount,
      email: email ?? this.email,
      currency: currency ?? this.currency,
      momo: momo ?? this.momo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'email': email,
      'currency': currency,
      'momo': momo.toMap(),
    };
  }

  factory MoMoPayments.fromMap(Map<String, dynamic> map) {
    return MoMoPayments(
      amount: map['amount'],
      email: map['email'],
      currency: map['currency'],
      momo: MobileMoney.fromMap(map['momo']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MoMoPayments.fromJson(String source) => MoMoPayments.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MoMoPayments(amount: $amount, email: $email, currency: $currency, momo: $momo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MoMoPayments &&
        other.amount == amount &&
        other.email == email &&
        other.currency == currency &&
        other.momo == momo;
  }

  @override
  int get hashCode {
    return amount.hashCode ^ email.hashCode ^ currency.hashCode ^ momo.hashCode;
  }
}

class MobileMoney {
  String phone;
  String provider;
  MobileMoney({
    required this.phone,
    required this.provider,
  });

  MobileMoney copyWith({
    String? phone,
    String? provider,
  }) {
    return MobileMoney(
      phone: phone ?? this.phone,
      provider: provider ?? this.provider,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'provider': provider,
    };
  }

  factory MobileMoney.fromMap(Map<String, dynamic> map) {
    return MobileMoney(
      phone: map['phone'],
      provider: map['provider'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MobileMoney.fromJson(String source) => MobileMoney.fromMap(json.decode(source));

  @override
  String toString() => 'MobileMoney(phone: $phone, provider: $provider)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MobileMoney && other.phone == phone && other.provider == provider;
  }

  @override
  int get hashCode => phone.hashCode ^ provider.hashCode;
}
