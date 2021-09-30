import 'dart:convert';

class PaystackRespData {
  String? reference;
  String? status;
  String? displayText;
  PaystackRespData({
    this.reference,
    this.status,
    this.displayText,
  });

  PaystackRespData copyWith({
    String? reference,
    String? status,
    String? displayText,
  }) {
    return PaystackRespData(
      reference: reference ?? this.reference,
      status: status ?? this.status,
      displayText: displayText ?? this.displayText,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reference': reference,
      'status': status,
      'displayText': displayText,
    };
  }

  factory PaystackRespData.fromMap(Map<String, dynamic> map) {
    return PaystackRespData(
      reference: map['reference'],
      status: map['status'],
      displayText: map['display_text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaystackRespData.fromJson(String source) => PaystackRespData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaystackRespData(reference: $reference, status: $status, displayText: $displayText,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaystackRespData &&
        other.reference == reference &&
        other.status == status &&
        other.displayText == displayText;
  }

  @override
  int get hashCode {
    return reference.hashCode ^ status.hashCode ^ displayText.hashCode;
  }
}

class PaystackResp {
  String? status;
  String? message;
  PaystackRespData? data;
  PaystackResp({
    this.status,
    this.message,
    this.data,
  });

  PaystackResp copyWith({
    String? reference,
    String? status,
    String? displayText,
  }) {
    return PaystackResp(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data!.toMap(),
    };
  }

  factory PaystackResp.fromMap(Map<String, dynamic> map) {
    return PaystackResp(status: map['status'], message: map['message'], data: PaystackRespData.fromMap(map['data']));
  }

  String toJson() => json.encode(toMap());

  factory PaystackResp.fromJson(String source) => PaystackResp.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaystackResp( status: $status,message:$message, data: ${data!.toString()})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaystackResp && other.status == status && other.message == message && other.data == data;
  }

  @override
  int get hashCode {
    return status.hashCode ^ message.hashCode ^ data.hashCode;
  }
}
