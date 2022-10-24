import 'package:flutter/material.dart';
import 'package:login_practical/screens/Signin.dart';
import 'package:login_practical/utils/colors.dart';

import '../models/index.dart';
import '../utils/screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({required this.user});
  final User user;
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Scaffold(
            backgroundColor: bgs,
            body: SafeArea(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: SizeConfig.blockSizeVertical * 10,
                      width: SizeConfig.blockSizeVertical * 10,
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 4),
                      decoration: BoxDecoration(
                          color: txtboxColor,
                          borderRadius: BorderRadius.all(Radius.circular(
                              SizeConfig.blockSizeVertical * 5))),
                      child: Icon(
                        Icons.person_outline,
                        color: txtwhite,
                      )),
                ),
                Text('${widget.user.name}',
                    style: TextStyle(
                        color: txtwhite,
                        fontSize: SizeConfig.blockSizeVertical * 3)),
                Text('${widget.user.email}',
                    style: TextStyle(
                        color: txtwhite,
                        fontSize: SizeConfig.blockSizeVertical * 3)),
                Text('${widget.user.phoneNumber}',
                    style: TextStyle(
                        color: txtwhite,
                        fontSize: SizeConfig.blockSizeVertical * 3)),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 5,
                    ),
                    width: SizeConfig.blockSizeHorizontal * 90,
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2),
                    decoration: BoxDecoration(
                        color: txtwhite,
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 2,
                        color: bgs,
                      ),
                    ),
                  ),
                  onTap: () async {
                    UserPreference().removeUser();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Signin()),
                        (route) => false);
                  },
                ),
              ],
            ))));
  }
}
