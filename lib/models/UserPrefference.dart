import 'User.dart';


import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  Future<bool> saveUser( user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', user.accessToken);
    prefs.setString('id', user.id);
    prefs.setString('email', user.email);
    prefs.setString('phoneNumber', user.phoneNumber);
    prefs.setStringList('role', user.role);


    return true;
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var accessToken = prefs.getString('accessToken');
    var role = prefs.getStringList('role');
    var email = prefs.getString('email');
    var phoneNumber = prefs.getString('phoneNumber');




    return User(id: id,
        accessToken:accessToken,
        phoneNumber:phoneNumber,
    role:role,
    email:email);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('id');
    prefs.remove('accessToken');
    prefs.remove('role');
    prefs.remove('phoneNumber');

  }
}
