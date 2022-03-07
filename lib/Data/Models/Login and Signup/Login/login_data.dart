
import 'package:json_annotation/json_annotation.dart';
import 'package:unicorn_store/Data/Models/Login%20and%20Signup/Login/user_data.dart';
part 'login_data.g.dart';

@JsonSerializable()
class LoginData
{
  @JsonKey(name: "user_data")
  UserData? userData;
  
  String? token;

  LoginData(this.userData,this.token);

  
    factory LoginData.fromJson(Map<String, dynamic> userData) =>
      _$LoginDataFromJson(userData);
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
 

 @override
  String toString() {
    return 'LoginData(userData: $userData,token:$token)';
  }

}