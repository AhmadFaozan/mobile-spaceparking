// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loginlagi/pages/data.dart';
import 'package:loginlagi/pages/editdata.dart';
import 'package:loginlagi/pages/editpassword.dart';
import 'package:loginlagi/pages/live_detec.dart';
import 'package:loginlagi/pages/login.dart';
import 'package:loginlagi/pages/visual.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<Map<String, dynamic>> getUserData() async {
    final String apiUrl = 'http://192.168.43.153:5000/bearer-auth';

    final preferences = await SharedPreferences.getInstance();
    final email = preferences.getString('email');
    final token = preferences.getString('token');

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Authorization': 'bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      throw Exception('Failed to load user data: $message');
    }
  }

  void _onItemTapped(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmation'),
                      content: const Text('Are you sure you want to log out?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () async {
                            // Clear session data
                            final preferences =
                                await SharedPreferences.getInstance();
                            await preferences.clear();

                            // Navigate to login page
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Map<String, dynamic>>(
                future: getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    final data = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detail Pengguna',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black38,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Pengguna: ',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              '${data!['nama'] ?? ''}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email ',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              '${data!['email'] ?? ''}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Text(
                        //   'Email: ${data!['email'] ?? ''}',
                        //   style: const TextStyle(
                        //     fontSize: 12,
                        //   ),
                        // ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const Text('No data available');
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
                color: Colors.black38,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  minimumSize: const Size(400, 50),
                  padding: const EdgeInsets.all(10),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  // Navigasi ke halaman Edit Data
                  Get.to(const EditDataPage());
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Data'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  minimumSize: const Size(400, 50),
                  padding: const EdgeInsets.all(10),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  // Navigasi ke halaman Edit Data
                  Get.to(const EditPwPage());
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Password'),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
