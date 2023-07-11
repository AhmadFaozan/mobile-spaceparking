import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:loginlagi/pages/backuphome.dart';
import 'package:loginlagi/pages/camera.dart';
import 'package:loginlagi/pages/home.dart';

class EditPwPage extends StatefulWidget {
  const EditPwPage({Key? key}) : super(key: key);

  @override
  State<EditPwPage> createState() => _EditPwState();
}

class _EditPwState extends State<EditPwPage> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _name2Controller = TextEditingController();

  Future<void> _ubahData() async {
    final String basicAuth = _codeController.text;
    final String current = _nameController.text;
    final String newpw = _name2Controller.text;

    final response = await http.put(
      Uri.parse('http://192.168.43.153:5000/edit-password'),
      headers: {
        'Authorization': 'bearer $basicAuth',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'current_password': current,
        'new_password': newpw,
      }),
    );
    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Update User Success'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => homeScreen()),
                  );
                },
              ),
            ],
          );
        },
      );
      // TODO: Handle successful update and navigate to another page
    } else {
      final Map<String, dynamic> errorData = json.decode(response.body);
      final String errorMessage = errorData['message'];
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
      // TODO: Display error message
    }
  }

  Future<void> _showPopup() async {
    final TextEditingController popupController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Code'),
          content: TextField(
            controller: popupController,
            decoration: InputDecoration(
              labelText: 'Your Code',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Assign the value to the main code controller
                _codeController.text = popupController.text;
              },
            ),
          ],
        );
      },
    );
  }

 bool passVisible = false;
 bool passVisible1 = false;
  @override
  void initState() {
    super.initState();
    passVisible = true;
    passVisible1 = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                'https://img.freepik.com/premium-vector/flat-design-cybercrime-with-edit-profile-change-user-login-account_106954-2042.jpg?w=2000',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _showPopup,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  minimumSize: Size(400, 50),
                  padding: EdgeInsets.all(10),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: const Text(
                  'Enter Code',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Edit Password Anda",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                          icon: Icon(
                            passVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              passVisible = !passVisible;
                            });
                          },
                        ),
                  labelText: 'Old Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: passVisible,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _name2Controller,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                          icon: Icon(
                            passVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              passVisible1 = !passVisible1;
                            });
                          },
                        ),
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: passVisible1,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _ubahData,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  minimumSize: Size(400, 50),
                  padding: EdgeInsets.all(10),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: const Text(
                  'Update Data',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
