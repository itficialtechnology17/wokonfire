import 'package:get/get.dart';
import 'package:wokonfire/controller/user_controller.dart';

Map<String, dynamic> checkPaymentProcess() {
  UserController _userController = Get.find();
  Map<String, dynamic> _map = Map<String, dynamic>();

  if (_userController.modelUser.value.email != null &&
      _userController.modelUser.value.email.isNotEmpty) {
    _map['code'] = 1;
    _map['message'] = "Go Ahead.";
    return _map;
  } else {
    _map['code'] = 0;
    _map['message'] = "Email address required";
    return _map;
  }
}
