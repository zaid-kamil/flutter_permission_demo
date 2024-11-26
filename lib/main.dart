import 'package:flutter/material.dart';
import 'package:flutter_permission_demo/screens/camera_screen.dart';
import 'package:flutter_permission_demo/screens/contacts_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graceful Permission Handling',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Graceful Permission")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPermissionCard(
              context,
              icon: Icons.camera_alt,
              title: "Open Camera",
              gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CameraScreen()),
              ),
            ),
            SizedBox(height: 20),
            _buildPermissionCard(
              context,
              icon: Icons.contacts,
              title: "View Contacts",
              gradient: LinearGradient(colors: [Colors.orange, Colors.red]),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionCard(BuildContext context, {required IconData icon, required String title, required Gradient gradient, required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: gradient,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}