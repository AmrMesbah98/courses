import 'package:json_annotation/json_annotation.dart';

part 'appuser.g.dart';
@JsonSerializable()

class UserDate {
  String firstName;
  String lastName;
  String email;
  String phone;
  String address;
  String pic;

  UserDate({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.pic,
  });

  factory UserDate.fromJson(Map<String ,dynamic> json) =>_$UserDateFromJson(json);
  Map<String,dynamic> toJson()=>_$UserDateToJson(this);

}
