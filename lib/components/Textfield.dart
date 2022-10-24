import 'package:flutter/material.dart';
import 'package:login_practical/utils/colors.dart';
import 'package:login_practical/utils/screen.dart';

class TextFieldG extends StatelessWidget {
  const TextFieldG({
    required String this.label,
    required TextEditingController this.controller,
  });

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 1,
          left: SizeConfig.blockSizeHorizontal * 4),
      width: SizeConfig.blockSizeHorizontal * 90,
      child: TextFormField(
        controller: controller,
        validator: (String? name) {
          if (name!.isEmpty) {
            return "$label name cannot be empty";
          }
        },
        decoration: InputDecoration(
          hintText: '$label',
          hintStyle: TextStyle(
              color: txtwhite,
              letterSpacing: 1.0,
              fontSize: SizeConfig.blockSizeVertical * 2.5),
          fillColor: txtboxColor,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: grey.withOpacity(0.4), width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
        ),
      ),
    );
  }
}
