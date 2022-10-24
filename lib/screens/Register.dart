import 'package:flutter/material.dart';
import 'package:login_practical/components/passwordField.dart';
import 'package:login_practical/screens/Signin.dart';
import 'package:login_practical/utils/colors.dart';
import 'package:provider/provider.dart';

import '../components/Textfield.dart';

import '../models/index.dart';
import '../providers/AuthProvider.dart';
import '../utils/screen.dart';
import 'Dashboard.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _number = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    _name.dispose();
    _number.dispose();
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

    var _register = () async {
      final form = _formKey.currentState;

      if (form!.validate()) {
        form.save();

        final Future<Map<String, dynamic>> response = auth.register(
            _email.text, _name.text, _number.text, _password.text, 'worker');
        response.then((response) {
          if (response['status']) {
            User user = response['user'];
            UserPreference prefs = new UserPreference();
            prefs.saveUser(user);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                padding: EdgeInsets.only(bottom: 50.0),
                backgroundColor: txtboxColor,
                content: Text(response['message']),
                duration: Duration(seconds: 6),
              ),
            );
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Dashboard(
                          user: user,
                        )));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                padding: EdgeInsets.only(bottom: 50.0),
                backgroundColor: txtboxColor,
                content: Text(response['message']),
                duration: Duration(seconds: 5),
              ),
            );
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('invalid details'),
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
                          left: SizeConfig.blockSizeHorizontal * 5),
                      child: Text(
                        'Welcome!',
                        style: TextStyle(
                          color: txtwhite,
                          fontSize: SizeConfig.blockSizeVertical * 5,
                        ),
                      )),
                  Container(
                      width: SizeConfig.blockSizeHorizontal * 60,
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 5,
                          bottom: SizeConfig.blockSizeHorizontal * 2),
                      child: Text(
                        'Register to continue',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: txtwhite,
                          fontSize: SizeConfig.blockSizeVertical * 3,
                        ),
                      )),
                  TextFieldG(
                    controller: _name,
                    label: 'Name',
                  ),
                  TextFieldG(
                    controller: _email,
                    label: 'Email',
                  ),
                  TextFieldG(
                    controller: _number,
                    label: 'Phone Number',
                  ),
                  PasswordField(
                    controller: _password,
                    label: 'Password',
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 15,
                  ),
                  auth.registeredInStatus == Status.Registering
                      ? loading
                      : GestureDetector(
                          onTap: () {
                            _register();
                          },
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2,
                                color: bgs,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ));
  }
}
