import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/controller/user_controller.dart';
import 'package:wokonfire/utils/custom_color.dart';
import 'package:wokonfire/utils/show_snackbar.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateLogin();
  }
}

class _StateLogin extends State<Login> {
  var isOTPSent = false;
  var isValidate = true;
  UserController _userController = Get.find();

  var tfMobileNumberController,
      tfOneController,
      tfTwoController,
      tfThreeController,
      tfFourController,
      tfFiveController,
      tfSixController;

  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final focus6 = FocusNode();

  @override
  void initState() {
    super.initState();
    tfOneController = TextEditingController();
    tfTwoController = TextEditingController();
    tfThreeController = TextEditingController();
    tfFourController = TextEditingController();
    tfFiveController = TextEditingController();
    tfSixController = TextEditingController();
    tfMobileNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, "NO");
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.66,
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/ic_login_bg.png"),
                  ),
                ),
              ),
              !isOTPSent
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.34,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 16),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text("Enter your phone number to proceed",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14)),
                            SizedBox(
                              height: 16,
                            ),
                            Text("Mobile No.",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14)),
                            SizedBox(
                              height: 8,
                            ),
                            TextField(
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              autofocus: true,
                              controller: tfMobileNumberController,
                              decoration: InputDecoration(
                                prefix: Text(
                                  "+91",
                                  style: TextStyle(color: Colors.black),
                                ),
                                errorText: !isValidate
                                    ? "Please enter valid mobile number"
                                    : "",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  isValidate = false;
                                  if (tfMobileNumberController.text
                                          .toString()
                                          .isEmpty ||
                                      tfMobileNumberController.text
                                              .toString()
                                              .length <
                                          10) {
                                    setState(() {
                                      isValidate = false;
                                    });
                                  } else {
                                    setState(() {
                                      isValidate = true;
                                    });
                                  }
                                  setState(() {
                                    if (isValidate) {
                                      _userController.getOTP(
                                          tfMobileNumberController.text
                                              .toString());
                                      isOTPSent = true;
                                    }
                                  });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  decoration: BoxDecoration(
                                      color: colorTheme,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                    child: Text(
                                      "NEXT".toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.34,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "OTP",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 16),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                                "Please enter OTP which you have received in your mobile ",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14)),
                            SizedBox(
                              height: 16,
                            ),
                            Text("",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14)),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: TextField(
                                          maxLength: 1,
                                          autofocus: true,
                                          controller: tfOneController,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              FocusScope.of(context)
                                                  .requestFocus(focus2);
                                            }
                                          },
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: TextField(
                                          maxLength: 1,
                                          controller: tfTwoController,
                                          textAlign: TextAlign.center,
                                          focusNode: focus2,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              FocusScope.of(context)
                                                  .requestFocus(focus3);
                                            }
                                          },
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: TextField(
                                          maxLength: 1,
                                          controller: tfThreeController,
                                          textAlign: TextAlign.center,
                                          focusNode: focus3,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              FocusScope.of(context)
                                                  .requestFocus(focus4);
                                            }
                                          },
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: TextField(
                                          maxLength: 1,
                                          focusNode: focus4,
                                          controller: tfFourController,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              FocusScope.of(context)
                                                  .requestFocus(focus5);
                                            }
                                          },
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: TextField(
                                          maxLength: 1,
                                          controller: tfFiveController,
                                          textAlign: TextAlign.center,
                                          focusNode: focus5,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              FocusScope.of(context)
                                                  .requestFocus(focus6);
                                            }
                                          },
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: TextField(
                                          maxLength: 1,
                                          controller: tfSixController,
                                          textAlign: TextAlign.center,
                                          focusNode: focus6,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  String enterOTP = getEnterOTP();
                                  if (_userController.receivedOTP.value ==
                                      enterOTP) {
                                    Navigator.pop(context, "YES");
                                  } else {
                                    showSnackBar("Mismatched",
                                        "Please enter valid OTP", Colors.red);
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  decoration: BoxDecoration(
                                      color: colorTheme,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                    child: Text(
                                      "SUBMIT".toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  String getEnterOTP() {
    return tfOneController.text.toString() +
        tfTwoController.text.toString() +
        tfThreeController.text.toString() +
        tfFourController.text.toString() +
        tfFiveController.text.toString() +
        tfSixController.text.toString();
  }
}
