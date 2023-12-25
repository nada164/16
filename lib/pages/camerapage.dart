import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';
import 'package:logger/logger.dart';
import 'package:camera/camera.dart';

List<CameraDescription> camList = [];
final Logger _logger = Logger(); // Create a logger instance

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    camList = await availableCameras();
    if (camList.isEmpty) {
      _logger.w('No available cameras detected.');
    } else {
      _logger.i('Available cameras detected: $camList');
    }
    runApp(Mycamera());
  } catch (e) {
    _logger.e('Error initializing cameras: $e');
  }
}

class Mycamera extends StatelessWidget {
  const Mycamera({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera App',
      theme: ThemeData(
        primarySwatch:  Colors.blue,
      ),
      home: const CameraScreen(
        key: Key('camera_screen'),
      ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  bool _isModelHidden = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);

    await _cameraController.initialize();

    if (!mounted) return;

    setState(() {
      _isCameraInitialized = true;
    });
  }

  void _toggleModelVisibility() {
    setState(() {
      _isModelHidden = !_isModelHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Camera Loading...'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Look at object as if they are realistic',style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor:
            Color.fromARGB(255, 173, 90, 194), // Add this line
      ),
      body: Container(
        color: Color.fromARGB(83, 188, 175, 194),
        child: Stack(
          children: [
            Center(
              child: AspectRatio(
                 aspectRatio:
                    3 / 4, // Adjust the aspect ratio to your preference
                child: CameraPreview(_cameraController),
              ),
            ),
            Visibility(
              visible: !_isModelHidden,
              child: const Center(child: O3D.asset(src: 'assets/forest_house.glb')),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.02,
                  ),
                  ElevatedButton(
                    onPressed: _toggleModelVisibility,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color.fromARGB(255, 199, 96, 224)),
                    ),
                    child: Text(_isModelHidden ? 'Show Model' : 'Hide Model'),
                  ),
                  const SizedBox(
                    height: 35,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

