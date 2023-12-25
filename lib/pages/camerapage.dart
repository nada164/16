import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saharapp/pages/login.dart';

void main() {
  runApp(Mycamera());
}

class Mycamera extends StatelessWidget {
  Mycamera();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Camera & Gallery",
      theme: ThemeData(primarySwatch: Colors.purple),
      home: CameraPage(),
    );
  }
}

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        } else {
          print('No image selected');
        }
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Look at objects as if they are realistic',
            style: TextStyle(
              color: Colors.purple,
              fontFamily: "myfont",
              fontSize: 30,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            await FirebaseAuth.instance
                .signOut(); // Go back to the previous page (login page)
            Navigator.of(context)
                .pushNamedAndRemoveUntil('login', (route) => false);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              _imageFile != null
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.file(
                          _imageFile!,
                          height: 200,
                        ),
                        Icon(
                          Icons.camera,
                          size: 50,
                          color: Color.fromARGB(255, 186, 125, 201),
                        ),
                      ],
                    )
                  : Container(
                      height: 300,
                      width: 350,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 135, 45, 143)
                                .withOpacity(0.6),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              color: Colors.grey[300],
                            ),
                            Icon(
                              Icons.camera,
                              size: 50,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
              SizedBox(height: 22),
              SizedBox(
                height: 55,
                width: 250,
                child: ElevatedButton(
                  onPressed: () => _getImage(ImageSource.camera),
                  child: Text(
                    'Take picture',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[100],
                    ),
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
                child: ElevatedButton(
                  onPressed: () => _getImage(ImageSource.gallery),
                  child: Text(
                    'Upload from gallery',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[100],
                    elevation: 3,
                    shadowColor: Color.fromARGB(255, 52, 10, 59),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
