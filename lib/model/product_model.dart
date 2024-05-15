import 'package:equatable/equatable.dart';

const String tableUsers = 'User';

class UserFields {
  static const all = [
    userID,
    username,
    domainName,
    companyNumber,
    phoneNumber,
  ];
  static const String userID = "UserID";
  static const String domainName = "DomainName";
  static const String username = "UserName";
  static const String companyNumber = "CompanyNumber";
  static const String phoneNumber = "PhoneNumber";
}

class User extends Equatable {
  final String? status;
  final String? message;
  final UserData? data;

  const User({
    this.status,
    this.message,
    this.data,
  });

  User.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? UserData.fromJson(json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'status': status, 'message': message, 'data': data?.toJson()};

  @override
  List<Object?> get props => [status, message, data];
}

class UserData {
  late final String userID;
  String? username;
  late final String domainName;
  String? companyNumber;
  late final String phoneNumber;

  UserData({
    required this.userID,
    required this.domainName,
    required this.username,
    required this.phoneNumber,
    required this.companyNumber,
  });

  UserData.empty({
    this.companyNumber = '',
    this.userID = '',
    this.username = '',
    this.phoneNumber = '',
    this.domainName = '',
  });

  UserData.fromJson(Map<String, dynamic> json)
      : userID = json[UserFields.userID] as String,
        domainName = json[UserFields.domainName] as String,
        phoneNumber = json[UserFields.phoneNumber] as String,
        username = json[UserFields.username] as String?,
        companyNumber = json[UserFields.companyNumber] as String?;

  Map<String, dynamic> toJson() => {
        UserFields.userID: userID,
        UserFields.username: username,
        UserFields.domainName: domainName,
        UserFields.phoneNumber: phoneNumber,
        UserFields.companyNumber: companyNumber,
      };

  @override
  String toString() {
    return 'UserData{userID: $userID, username: $username, domainName: $domainName, companyNumber: $companyNumber, phoneNumber: $phoneNumber}';
  }
}
