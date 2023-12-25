import 'package:flutter/material.dart';
import 'package:saharapp/auth.dart';
import 'package:saharapp/firebase_options.dart';
import 'package:saharapp/pages/login.dart';
import 'package:saharapp/pages/signup.dart';
import 'package:saharapp/pages/welcome.dart';
//import 'package:saharapp/pages/camerapage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
 );
 runApp( const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: Auth(),
      debugShowCheckedModeBanner: false,
      initialRoute:'/welcome',
      routes: {
        '/welcome':(context) => const Welcome(),
        '/':(context) => const Auth(),
        '/Signup':(context) => const SignUp(),
        '/login':(context) => const Login(),
        // '/camerapage':(context) =>  Mycamera(),
        
     },
    );
  }
}
