import 'package:flutter/material.dart';
import 'package:flutter_permission_demo/core/permission_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  bool _isPermissionGranted = false;

  @override
  void initState() {
    Permission.contacts.status.then((status) {
      setState(() {
        _isPermissionGranted = status.isGranted;
      });
    });
    super.initState();
  }

  void requestContactPermission() async {
    final status = await Permission.contacts.request();
    if (status.isGranted) {
      setState(() {
        _isPermissionGranted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Contacts access granted!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Contacts access denied.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: _isPermissionGranted
              ? Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: [
                    _buildContactChip('Mummy'),
                    _buildContactChip('Papa'),
                    _buildContactChip('Bharvi Sharma'),
                    _buildContactChip('Mubassir'),
                    _buildContactChip('Amna Ghazal'),
                    _buildContactChip('Adeeba'),
                    _buildContactChip('Akbar Ahmad'),
                    _buildContactChip('Bushra'),
                    _buildContactChip('Office'),
                  ],
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  onPressed: () {
                    showPermissionDialog(context,
                        permission: "Contact",
                        explanation:
                            "We need to access your contacts to show them here.",
                        onGrant: (){
                          Navigator.of(context).pop();
                          requestContactPermission();
                        },
                        onDeny: () => Navigator.of(context).pop());
                  },
                  child: Text('Request Contacts Permission'),
                ),
        ),
      ),
    );
  }

  Widget _buildContactChip(String name) {
    return Chip(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      label: Text(name),
      avatar: CircleAvatar(
        child: Text(name[0]),
      ),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(color: Colors.blue),
      elevation: 4,
      shadowColor: Colors.grey[50],
      padding: EdgeInsets.all(8),
    );
  }
}
