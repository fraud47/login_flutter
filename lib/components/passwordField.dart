import 'package:flutter/material.dart';
import 'package:login_practical/utils/colors.dart';
import 'package:login_practical/utils/screen.dart';

class PasswordField extends StatelessWidget {
  const PasswordField(
      {required String this.label,
      required TextEditingController this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 2),
      margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 1,
          left: SizeConfig.blockSizeHorizontal * 4),
      width: SizeConfig.blockSizeHorizontal * 90,
      child: TextFormField(
        obscureText: true,
        controller: controller,
        validator: (String? name) {
          if (name!.isEmpty) {
            return "$label name cannot be empty";
          }
        },
        decoration: InputDecoration(
          hintText: '$label',
          hintStyle: TextStyle(
              fontFamily: 'Poppins',
              color: txtwhite,
              fontSize: SizeConfig.blockSizeVertical * 2.5),
          suffixIcon: Icon(
            Icons.key,
            color: txtwhite,
          ),
          fillColor: txtboxColor,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: grey, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
        ),
      ),
    );
  }
}
