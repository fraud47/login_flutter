import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:login_practical/components/passwordField.dart';
import 'package:login_practical/screens/Register.dart';
import 'package:login_practical/screens/Signin.dart';
import 'package:login_practical/utils/colors.dart';
import 'package:provider/provider.dart';

import '../components/Textfield.dart';

import '../models/index.dart';
import '../providers/AuthProvider.dart';
import '../utils/screen.dart';
import 'Dashboard.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          strokeWidth: SizeConfig.blockSizeHorizontal * 1.5,
          color: grey,
        )
      ],
    );
    AuthProvider auth = Provider.of<AuthProvider>(context);

    var loginExec = () {
      final form = _formKey.currentState;
      if (form!.validate()) {
        form.save();
        final Future<Map<String, dynamic>> response =
            auth.login(_email.text, _password.text);
        response.then((response) {
          if (response['status']) {
            User user = response['user'];
            UserPreference prefs = new UserPreference();
            prefs.saveUser(user);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Dashboard(
                          user: user,
                        )));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response['message']),
                duration: Duration(seconds: 5),
              ),
            );
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('invalid login details'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    };

    return Scaffold(
        backgroundColor: bgs,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 10,
                          left: SizeConfig.blockSizeHorizontal * 5),
                      child: Text(
                        'Welcome!',
                        style: TextStyle(
                          color: txtwhite,
                          fontSize: SizeConfig.blockSizeVertical * 6,
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 5),
                      width: SizeConfig.blockSizeHorizontal * 60,
                      child: Text(
                        'Sign in to continue',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: txtwhite,
                          fontSize: SizeConfig.blockSizeVertical * 4,
                        ),
                      )),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  TextFieldG(
                    controller: _email,
                    label: 'Email',
                  ),
                  PasswordField(
                    controller: _password,
                    label: 'Password',
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 25,
                  ),
                  auth.loggedInStatus == Status.Authenticating
                      ? loading
                      : Container(
                          height: SizeConfig.blockSizeVertical * 20,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()));
                                },
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 100,
                                  margin: EdgeInsets.only(
                                      bottom:
                                          SizeConfig.blockSizeHorizontal * 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Do you have an account?",
                                        style: TextStyle(color: txtwhite),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1),
                                        child: Text(
                                          "Register",
                                          style: TextStyle(
                                              color: txtwhite,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  loginExec();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.blockSizeHorizontal * 5,
                                  ),
                                  width: SizeConfig.blockSizeHorizontal * 90,
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          SizeConfig.blockSizeVertical * 2),
                                  decoration: BoxDecoration(
                                      color: txtwhite,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0))),
                                  child: Text(
                                    'sign in',
                                    style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 2,
                                      color: bgs,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ),
        ));
  }
}
