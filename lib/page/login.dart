import 'package:flutter/material.dart';
import 'package:wokonfire/constant/customcolor.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateLogin();
  }
}

class _StateLogin extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          (MediaQuery.of(context).viewInsets.bottom == 0.0),
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
            (MediaQuery.of(context).viewInsets.bottom == 0.0)
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.34,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text("Enter your phone number to proceed",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                          SizedBox(
                            height: 16,
                          ),
                          Text("Mobile No.",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                          SizedBox(
                            height: 8,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            decoration: InputDecoration(
                              prefix: Text(
                                "+91",
                                style: TextStyle(color: Colors.black),
                              ),
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
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                                color: CustomColor.colorTheme,
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
                          )
                        ],
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 50,
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                    ))
          ],
        ),
      ),
    );
  }
}
