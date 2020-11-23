import 'dart:convert';

ModelUser modelUserFromJson(String str) => ModelUser.fromJson(json.decode(str));

String modelUserToJson(ModelUser data) => json.encode(data.toJson());

class ModelUser {
  ModelUser({
    this.cId,
    this.userName,
    this.contactNumber,
    this.email,
    this.otpCode,
    this.city,
    this.state,
    this.deviceToken,
    this.deviceType,
    this.status,
    this.createdDate,
    this.updatedDate,
  });

  int cId;
  String userName;
  String contactNumber;
  String email;
  int otpCode;
  dynamic city;
  dynamic state;
  dynamic deviceToken;
  String deviceType;
  dynamic status;
  DateTime createdDate;
  DateTime updatedDate;

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
        cId: json["c_id"],
        userName: json["user_name"],
        contactNumber: json["contact_number"],
        email: json["email"],
        otpCode: json["otp_code"],
        city: json["city"],
        state: json["state"],
        deviceToken: json["device_token"],
        deviceType: json["device_type"],
        status: json["status"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedDate: DateTime.parse(json["updated_date"]),
      );

  Map<String, dynamic> toJson() => {
        "c_id": cId,
        "user_name": userName,
        "contact_number": contactNumber,
        "email": email,
        "otp_code": otpCode,
        "city": city,
        "state": state,
        "device_token": deviceToken,
        "device_type": deviceType,
        "status": status,
        "created_date": createdDate.toIso8601String(),
        "updated_date": updatedDate.toIso8601String(),
      };
}
