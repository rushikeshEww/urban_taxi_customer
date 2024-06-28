import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  int? id;
  String? name;
  String? email;
  String? countyCode;
  String? phoneNumber;
  String? isEmailVerified;
  String? isPhoneNumberVerified;
  String? profile;
  double? lat;
  double? long;
  int? timer;
  String? currency;
  int? averageRatting;
  ToggleData? toggleData;
  List<Address>? address;
  WorkProfile? workProfile;
  dynamic ongoingRide;
  dynamic driverData;

  LoginResponse({
    this.id,
    this.name,
    this.email,
    this.countyCode,
    this.phoneNumber,
    this.isEmailVerified,
    this.isPhoneNumberVerified,
    this.profile,
    this.lat,
    this.long,
    this.timer,
    this.currency,
    this.averageRatting,
    this.toggleData,
    this.address,
    this.workProfile,
    this.ongoingRide,
    this.driverData,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    countyCode: json["county_code"],
    phoneNumber: json["phone_number"],
    isEmailVerified: json["is_email_verified"],
    isPhoneNumberVerified: json["is_phone_number_verified"],
    profile: json["profile"],
    lat: json["lat"]?.toDouble(),
    long: json["long"]?.toDouble(),
    timer: json["timer"],
    currency: json["currency"],
    averageRatting: json["average_ratting"],
    toggleData: json["toggle_data"] == null ? null : ToggleData.fromJson(json["toggle_data"]),
    address: json["address"] == null ? [] : List<Address>.from(json["address"]!.map((x) => Address.fromJson(x))),
    workProfile: json["work_profile"] == null ? null : WorkProfile.fromJson(json["work_profile"]),
    ongoingRide: json["ongoing_ride"],
    driverData: json["driver_data"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "county_code": countyCode,
    "phone_number": phoneNumber,
    "is_email_verified": isEmailVerified,
    "is_phone_number_verified": isPhoneNumberVerified,
    "profile": profile,
    "lat": lat,
    "long": long,
    "timer": timer,
    "currency": currency,
    "average_ratting": averageRatting,
    "toggle_data": toggleData?.toJson(),
    "address": address == null ? [] : List<dynamic>.from(address!.map((x) => x.toJson())),
    "work_profile": workProfile?.toJson(),
    "ongoing_ride": ongoingRide,
    "driver_data": driverData,
  };
}

class Address {
  int? id;
  int? customerId;
  String? addressType;
  String? city;
  String? state;
  String? zipCode;
  String? address;
  double? lat;
  int? long;

  Address({
    this.id,
    this.customerId,
    this.addressType,
    this.city,
    this.state,
    this.zipCode,
    this.address,
    this.lat,
    this.long,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    customerId: json["customer_id"],
    addressType: json["address_type"],
    city: json["city"],
    state: json["state"],
    zipCode: json["zip_code"],
    address: json["address"],
    lat: json["lat"]?.toDouble(),
    long: json["long"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "address_type": addressType,
    "city": city,
    "state": state,
    "zip_code": zipCode,
    "address": address,
    "lat": lat,
    "long": long,
  };
}

class ToggleData {
  String? isOtp;
  String? isEmail;
  String? isPush;
  String? isSms;
  String? isNotification;
  String? isReminder;
  String? locale;

  ToggleData({
    this.isOtp,
    this.isEmail,
    this.isPush,
    this.isSms,
    this.isNotification,
    this.isReminder,
    this.locale,
  });

  factory ToggleData.fromJson(Map<String, dynamic> json) => ToggleData(
    isOtp: json["is_otp"],
    isEmail: json["is_email"],
    isPush: json["is_push"],
    isSms: json["is_sms"],
    isNotification: json["is_notification"],
    isReminder: json["is_reminder"],
    locale: json["locale"],
  );

  Map<String, dynamic> toJson() => {
    "is_otp": isOtp,
    "is_email": isEmail,
    "is_push": isPush,
    "is_sms": isSms,
    "is_notification": isNotification,
    "is_reminder": isReminder,
    "locale": locale,
  };
}

class WorkProfile {
  String? companyName;
  String? companyAddress;
  String? vatNumber;
  String? registrationNumber;
  String? workEmail;
  String? workPaymentMethod;

  WorkProfile({
    this.companyName,
    this.companyAddress,
    this.vatNumber,
    this.registrationNumber,
    this.workEmail,
    this.workPaymentMethod,
  });

  factory WorkProfile.fromJson(Map<String, dynamic> json) => WorkProfile(
    companyName: json["company_name"],
    companyAddress: json["company_address"],
    vatNumber: json["vat_number"],
    registrationNumber: json["registration_number"],
    workEmail: json["work_email"],
    workPaymentMethod: json["work_payment_method"],
  );

  Map<String, dynamic> toJson() => {
    "company_name": companyName,
    "company_address": companyAddress,
    "vat_number": vatNumber,
    "registration_number": registrationNumber,
    "work_email": workEmail,
    "work_payment_method": workPaymentMethod,
  };
}
