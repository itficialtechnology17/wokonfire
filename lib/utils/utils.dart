import 'package:get/get.dart';
import 'package:wokonfire/controller/user_controller.dart';

Map<String, dynamic> checkPaymentProcess() {
  UserController _userController = Get.find();
  Map<String, dynamic> _map = Map<String, dynamic>();

  if (_userController.modelUser.value.email != null &&
      _userController.modelUser.value.email.isNotEmpty &&
      _userController.modelUser.value.userName != null &&
      _userController.modelUser.value.userName.isNotEmpty) {
    _map['code'] = 1;
    _map['message'] = "Go Ahead.";
    return _map;
  } else {
    if (_userController.modelUser.value.userName == null) {
      if (_userController.modelUser.value.email == null) {
        _map['code'] = 0;
        _map['message'] = "User Name & Email Address Is Required";
      } else if (_userController.modelUser.value.userName.isEmpty) {
        if (_userController.modelUser.value.email.isEmpty) {
          _map['code'] = 0;
          _map['message'] = "User Name & Email Address Is Required";
        } else {
          _map['code'] = 0;
          _map['message'] = "User Name Is Required";
        }
      } else {
        _map['code'] = 0;
        _map['message'] = "Email Address Is Required";
      }
    } else if (_userController.modelUser.value.email == null) {
      _map['code'] = 0;
      _map['message'] = "Email Address Is Required";
    }
  }
  return _map;

/*  else if(_userController.modelUser.value.userName == null) {
    if (_userController.modelUser.value.userName.isEmpty) {
      if(_userController.modelUser.value.email == null){
        _map['code'] = 0;
        _map['message'] = "User Name & Email Address Is Required";
      }else if(){

      }
    }else if(_userController.modelUser.value.email == null){
      if(_userController.modelUser.value.email.isEmpty){
        _map['code'] = 0;
        _map['message'] = "User Name required";
      }
    }
  }else if(_userController.modelUser.value.email == null){
    if (_userController.modelUser.value.email.isEmpty) {
      _map['code'] = 0;
      _map['message'] = "Email address required";
    }
  }*/
}
