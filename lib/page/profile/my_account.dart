import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/controller/user_controller.dart';
import 'package:wokonfire/page/profile/widgets/entry_field.dart';
import 'package:wokonfire/utils/shared_preference.dart';

class MyAccount extends StatefulWidget {
  final String message;
  MyAccount(this.message);

  @override
  _StateMyAccount createState() => _StateMyAccount();
}

class _StateMyAccount extends State<MyAccount> {
  var isEditActive = true;

  final UserController _userController = Get.find();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _controllerName;
  TextEditingController _controllerPhoneNumber;

  @override
  void initState() {
    super.initState();
    if (widget.message != null && widget.message.isNotEmpty)
      showToast(widget.message);

    if (_userController.modelUser.value.contactNumber == null) {
      _userController.modelUser.value.contactNumber = "";
    }

    _controllerName = new TextEditingController(
        text: _userController.modelUser.value.userName);
    _controllerPhoneNumber = new TextEditingController(
        text: _userController.modelUser.value.contactNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Material(
          color: Colors.transparent,
          type: MaterialType.circle,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Platform.isAndroid
                  ? Icons.keyboard_backspace
                  : Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "My Account",
          style: Theme.of(context).textTheme.headline6.merge(
                TextStyle(letterSpacing: 1.3, color: Colors.black),
              ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "MY PROFILE",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 16,
                          letterSpacing: 1,
                          color: Color(0xffa9a9a9)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    EntryField(
                      controller: _controllerName,
                      labelFontWeight: FontWeight.w400,
                      horizontalPadding: 0,
                      label: "Full Name",
                      enable: true,
                      labelFontSize: 16,
                    ),
                    EntryField(
                      controller: TextEditingController()
                        ..text = _userController.modelUser.value.email,
                      labelFontWeight: FontWeight.w400,
                      horizontalPadding: 0,
                      enable: true,
                      label: "Email Address",
                      labelFontSize: 16,
                    ),
                    EntryField(
                      controller: _controllerPhoneNumber,
                      labelFontWeight: FontWeight.w400,
                      horizontalPadding: 0,
                      hint: "00000 00000",
                      maxLength: 10,
                      label: "Phone Number",
                      enable: false,
                      labelFontSize: 16,
                    ),
                  ],
                )),
          ),
          Divider(
            color: Colors.grey[100],
            thickness: 10,
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "My Addresses".toUpperCase(),
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 16,
                          letterSpacing: 1,
                          color: Color(0xffa9a9a9)),
                    ),
                    Spacer(),
                    Material(
                      color: Colors.transparent,
                      type: MaterialType.circle,
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {
                          _userController.onClickManageAddress(
                              context, "ADD", "");
                        },
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.add_box_outlined,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(() => ListView.separated(
                      itemCount: _userController.arrOfAddress.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 4),
                          title: Row(
                            children: [
                              Text(
                                  _userController
                                      .arrOfAddress[index].caTypeChoice
                                      .toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          fontSize: 14,
                                          letterSpacing: 1,
                                          color: Colors.black)),
                            ],
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              children: [
                                Text(
                                  _userController
                                      .arrOfAddress[index].caMapAddress,
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        _userController.onClickManageAddress(
                                            context,
                                            "UPDATE",
                                            _userController
                                                .arrOfAddress[index].caId
                                                .toString());
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        child: Text("Edit".toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(
                                                    fontSize: 14,
                                                    letterSpacing: 1,
                                                    color: Colors.green)),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _userController.confirmDelete(
                                            context, index);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        child: Text("Delete".toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(
                                                    fontSize: 14,
                                                    letterSpacing: 1,
                                                    color: Colors.red)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Column(
                          children: [
                            Divider(
                              color: Colors.grey[100],
                              thickness: 2,
                              height: 2,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        );
                      },
                    )),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() => Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.07,
            child: Material(
              color: Colors.yellow,
              child: InkWell(
                splashColor: Colors.grey,
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  if (_userController.modelUser.value.userName == null &&
                      _userController.modelUser.value.userName.isEmpty) {
                    showToast("Please enter name");
                  } else if (_userController.modelUser.value.email == null &&
                      _userController.modelUser.value.email.isEmpty) {
                    showToast("Please enter email");
                  } else {
                    _userController.updateProfile();
                  }
                },
                child: _userController.isLoading.value
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.07,
                        child: Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width * 0.08,
                            width: MediaQuery.of(context).size.width * 0.08,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.black),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24)),
                        child: Center(
                          child: Text(
                            "Update Profile".toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
              ),
            ),
          )),
    );
  }
}
