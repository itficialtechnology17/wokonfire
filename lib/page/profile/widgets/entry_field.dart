import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wokonfire/controller/user_controller.dart';
import 'package:wokonfire/utils/custom_color.dart';

class EntryField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String image;
  final String initialValue;
  final bool readOnly;
  final TextInputType keyboardType;
  final int maxLength;
  final int maxLines;
  final String hint;
  final IconData suffixIcon;
  final Function onTap;
  final TextCapitalization textCapitalization;
  final Function onSuffixPressed;
  final double horizontalPadding;
  final double verticalPadding;
  final FontWeight labelFontWeight;
  final double labelFontSize;
  final Color underlineColor;
  final TextStyle hintStyle;
  final bool enable;

  EntryField(
      {this.controller,
      this.label,
      this.image,
      this.initialValue,
      this.readOnly,
      this.keyboardType,
      this.maxLength,
      this.hint,
      this.suffixIcon,
      this.maxLines,
      this.onTap,
      this.textCapitalization,
      this.onSuffixPressed,
      this.horizontalPadding,
      this.verticalPadding,
      this.labelFontWeight,
      this.labelFontSize,
      this.underlineColor,
      this.hintStyle,
      this.enable});

  @override
  _EntryFieldState createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {
  bool showShadow = false;
  bool showBorder = false;

  UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding ?? 15.0,
          vertical: widget.verticalPadding ?? 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(widget.label ?? '',
              style: Theme.of(context).textTheme.headline6.copyWith(
                  color: kMainTextColor,
                  fontWeight: widget.labelFontWeight ?? FontWeight.bold,
                  fontSize: widget.labelFontSize ?? 21.7)),
          TextField(
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.sentences,
            cursorColor: kMainColor,
            autofocus: false,
            /*onEditingComplete: () {
              setState(() {
                showShadow = false;
              });
            },*/
            onChanged: (value) {
              if (widget.label == "Email Address") {
                _userController.modelUser.value.email = value;
              } else if (widget.label == "Full Name") {
                _userController.modelUser.value.userName = value;
              }
            },
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap();
              }
              setState(() {
                showShadow = true;
                showBorder = true;
              });
            },
            enabled: widget.enable,
            controller: widget.controller,
            readOnly: widget.readOnly ?? false,
            keyboardType: widget.keyboardType,
            minLines: 1,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines ?? 1,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.underlineColor ?? Colors.grey[200]),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    widget.suffixIcon,
                    size: 40.0,
                    color: Theme.of(context).backgroundColor,
                  ),
                  onPressed: widget.onSuffixPressed ?? null,
                ),
                hintText: widget.hint,
                hintStyle: widget.hintStyle ??
                    Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: kHintColor, fontSize: 18.3)),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
