import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/controller/user_controller.dart';

class SelectAddress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateSelectAddress();
  }
}

class _StateSelectAddress extends State<SelectAddress> {
  @override
  void initState() {
    super.initState();
  }

  UserController _userController = Get.find();
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  )),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                      "Select Delivery Address",
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontSize: 18,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Obx(() => ListView.separated(
                        itemCount: _userController.arrOfAddress.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context,
                                    _userController.arrOfAddress[index]);
                              },
                              child: ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 4),
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
                                      /*Row(
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
                                  )*/
                                    ],
                                  ),
                                ),
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
                  InkWell(
                      onTap: () async {
                        /*setState(() {
                          isLoading = true;
                        });*/
                        _userController.onClickManageAddress(
                            context, "ADD", "");
                      },
                      child: Container(
                        width: Get.width,
                        height: Get.height * 0.06,
                        color: Colors.red,
                        child: Center(
                          child: !isLoading
                              ? Text(
                                  "Add New Address"
                                      .toUpperCase() /* +
                                        " ( Rs. " +
                                        finalPrice.toString() +
                                        " )"*/
                                  ,
                                  style: Theme.of(context).textTheme.button,
                                )
                              : SizedBox(
                                  height: Get.height * 0.03,
                                  width: Get.height * 0.03,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                        ),
                      )),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
