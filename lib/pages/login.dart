// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  Future<void> signIn() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailcontroller.text.trim(),
      password: _passwordcontroller.text.trim(),
    );
    Navigator.of(context).pushReplacementNamed('camerapage');
  } on FirebaseAuthException catch (e) {
    String errorMessage = "email or password are incorrect try again";

    if (e.code == 'user-not-found') {
      errorMessage = "No user found for this email.";
    } else if (e.code == 'wrong-password') {
      errorMessage = "Wrong password.";
    }

    _showErrorDialog(errorMessage);
  }
}

void _showErrorDialog(String errorMessage) {
  AwesomeDialog(
    dialogBackgroundColor: Color.fromARGB(255, 234, 231, 235),
    context: context,
    dialogType: DialogType.error,
    title: "Error",
    desc: errorMessage,
    dialogBorderRadius:BorderRadius.circular(20),
  ).show();
}


  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 35),
                    Text(
                      'LogIn',
                      style: TextStyle(
                        color: Colors.purple,
                        fontFamily: "myfont",
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 35),
                    SvgPicture.asset(
                      "assets/icons/login.svg",
                      width: 350,
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(66),
                        color: Colors.purple[100],
                      ),
                      width: 266,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _emailcontroller,
                        decoration: InputDecoration(
                          hintText: "Email:",
                          icon: Icon(
                            Icons.person,
                            color: Colors.purple[900],
                            size: 30,
                          ),
                          fillColor: Colors.purple[800],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(66),
                        color: Colors.purple[100],
                      ),
                      width: 266,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _passwordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          suffix: Icon(
                            Icons.visibility,
                            color: Colors.purple[900],
                          ),
                          icon: Icon(
                            Icons.lock,
                            color: Colors.purple[800],
                            size: 30,
                          ),
                          hintText: "Password:",
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 258,
                      height: 52,
                      child: GestureDetector(
                        onTap: signIn,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(27),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 77, vertical: 13),
                          child: Center(
                            child: Text(
                              'LogIn',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple[100],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('You Dont Have An Accont ?  '),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/Signup');
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: 150,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/login_bottom.png",
                  width: 90,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
