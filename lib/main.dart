import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_practical/providers/AuthProvider.dart';
import 'package:login_practical/screens/Dashboard.dart';
import 'package:login_practical/screens/Register.dart';
import 'package:provider/provider.dart';
import './models/index.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();

  // await setupServices();

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  Future<User> getUserData() => UserPreference().getUser();

  @override
  Widget build(BuildContext context) {
    int? isviewed;
    // Future<void> onBackgroundMessage(RemoteMessage message) async {
    //   // initialize firebase
    //   await Firebase.initializeApp();
    // }

    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        routes: {
          // '/order': (context) => (),
        },
        home: FutureBuilder(
            future: getUserData(),
            builder: (context, AsyncSnapshot<User> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else if (snapshot.data?.accessToken == null)
                    return Register();
                  else {
                    User user = User(
                        id: snapshot.data!.id,
                        email: snapshot.data!.email,
                        role: snapshot.data!.role,
                        accessToken: snapshot.data!.accessToken);
                    return Dashboard(user: user);
                  }
              }
            }));
  }
}
