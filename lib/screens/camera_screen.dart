import 'package:flutter/material.dart';
import 'package:flutter_permission_demo/core/permission_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _isPermissionGranted = false;

  @override
  void initState() {
    Permission.camera.status.then((status) {
      setState(() {
        _isPermissionGranted = status.isGranted;
      });
    });
    super.initState();

  }

  void requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      setState(() {
        _isPermissionGranted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera access granted!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera access denied.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: _isPermissionGranted
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, size: 100, color: Colors.blue),
                  SizedBox(height: 20),
                  Text(
                    'Camera access granted! You can now take photos.',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, size: 100, color: Colors.blue),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      onPressed: () {
                        showPermissionDialog(
                          context,
                          permission: "Camera",
                          explanation:
                              "We need camera access to let you take photos.",
                          onGrant: () {
                            Navigator.of(context).pop();
                            requestCameraPermission();
                          },
                          onDeny: () => Navigator.of(context).pop(),
                        );
                      },
                      child: Text('Request Camera Permission'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
