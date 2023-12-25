// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        'Welcome To 3D Converter',
                        style: TextStyle(
                          color: Colors.purple,
                          fontFamily: "myfont",
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      SvgPicture.asset(
                        "assets/icons/chat.svg",
                        width: 350,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        width: 250,
                        height: 70,
                        
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            'Get started',
                            style: TextStyle(
                                fontSize: 25,
                                color: const Color.fromARGB(255, 243, 241, 243),
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      elevation: 3,
                      shadowColor: Color.fromARGB(255, 52, 10, 59),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                  height: 55,
                  width: 250,
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
                  child: Image.asset(
                    "assets/images/main_bottom.png",
                    width: 90,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
