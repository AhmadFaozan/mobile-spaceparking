// // ignore_for_file: prefer_const_constructors, sort_child_properties_last

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:loginlagi/pages/code.dart';
// import 'dart:convert';

// import 'package:loginlagi/pages/login.dart';

// class RegistPage extends StatefulWidget {
//   const RegistPage({super.key});

//   @override
//   State<RegistPage> createState() => _RegistPageState();
// }

// class _RegistPageState extends State<RegistPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _rePasswordController = TextEditingController();

//   Future<void> register() async {
//     String nama = _nameController.text;
//     String email = _emailController.text;
//     String password = _passwordController.text;
//     String confirmPassword = _rePasswordController.text;

//     if (password != confirmPassword) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text('Password tidak cocok'),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//       return;
//     }

//     final response = await http.post(
//       Uri.parse('http://192.168.43.153:5000/register'),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'nama': nama,
//         'email': email,
//         'password': password,
//         'confirm_password': confirmPassword
//       }),
//     );

//     if (response.statusCode == 200) {
//       // Registration successful
//       var responseData = jsonDecode(response.body);
//       String message = responseData['message'];
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Success'),
//           content: Text(message),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginPage()),
//                 );
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     } else {
//       // Registration failed
//       var responseData = jsonDecode(response.body);
//       String message = responseData['message'];
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text(message),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   bool passVisible = false;
//   bool passVisible1 = false;
//   @override
//   void initState() {
//     super.initState();
//     passVisible = true;
//     passVisible1 = true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Daftar'),
//       // ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(
//             left: 16,
//             right: 16,
//             top: 48,
//           ),
//           child: Center(
//             child: Column(
//               children: [
//                 Text(
//                   'Space Parking Detection',
//                   style: TextStyle(
//                     fontSize: 40,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 // Text(
//                 //   '',
//                 //   style: TextStyle(
//                 //     fontSize: 40,
//                 //     fontWeight: FontWeight.w500,
//                 //   ),
//                 // ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Image.asset(
//                   'assets/images/jukir.png',
//                   height: 180,
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Text(
//                   'Selamat Datang. Silakan Daftar',
//                   style: TextStyle(
//                     fontSize: 18,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
                    
//                     TextField(
//                       controller: _nameController,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.person),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         labelText: 'Nama',
//                       ),
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     TextField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.email),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         labelText: 'Email',
//                       ),
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     TextField(
//                       controller: _passwordController,
//                       decoration: InputDecoration(
//                           labelText: 'Password',
//                           prefixIcon: Icon(Icons.lock),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               passVisible
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 passVisible = !passVisible;
//                               });
//                             },
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           )),
//                       obscureText: passVisible,
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     TextField(
//                       controller: _rePasswordController,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.lock),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             passVisible1
//                                 ? Icons.visibility
//                                 : Icons.visibility_off,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               passVisible1 = !passVisible1;
//                             });
//                           },
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         labelText: 'Ulang Password',
//                       ),
//                       obscureText: passVisible1,
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: register,
//                       child: Text(
//                         'Daftar',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         elevation: 0,
//                         fixedSize: Size(
//                           180,
//                           56,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 0,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Sudah Punya Akun?"),
//                         SizedBox(
//                           width: 0,
//                         ),
//                         TextButton(
//                           style: TextButton.styleFrom(
//                             //backgroundColor: Colors.red,
//                             minimumSize: Size(
//                               42,
//                               30,
//                             ),
//                           ),
//                           onPressed: () {
//                             Navigator.pushReplacement(context,
//                                 MaterialPageRoute(
//                                     builder: (BuildContext context) {
//                               return LoginPage();
//                             }));
//                           },
//                           child: Text('Login'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loginlagi/pages/code.dart';
import 'dart:convert';

import 'package:loginlagi/pages/login.dart';
import 'package:flutter/cupertino.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({Key? key}) : super(key: key);

  @override
  State<RegistPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  Future<void> register() async {
    String nama = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _rePasswordController.text;

    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Password tidak cocok'),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('http://192.168.43.153:5000/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nama': nama,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword
      }),
    );

    if (response.statusCode == 200) {
      // Registration successful
      var responseData = jsonDecode(response.body);
      String message = responseData['message'];
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Registration failed
      var responseData = jsonDecode(response.body);
      String message = responseData['message'];
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
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
      backgroundColor: CupertinoColors.systemGroupedBackground,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(220, 218, 226, 236),
              Color.fromARGB(220, 228, 227, 227),
              Color.fromARGB(220, 218, 226, 236),
              Color.fromARGB(220, 157, 197, 247),
            ],
          ),
        ),
          child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Hello Again!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontFamily: '.SF Compact',
                        package: 'CupertinoIcons',
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Welcome to our app\npelase LOGIN!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: '.SF Compact',
                        package: 'CupertinoIcons',
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CupertinoTextField(
                      keyboardType: TextInputType.name,
                      controller: _nameController,
                      placeholder: "Nama",
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          CupertinoIcons.person,
                          color: CupertinoColors.inactiveGray,
                          size: 20,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 17, horizontal: 16),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      placeholderStyle: TextStyle(
                        color: CupertinoColors.placeholderText,
                      ),
                      style: TextStyle(
                        color: CupertinoColors.black,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CupertinoTextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      placeholder: "Email",
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          CupertinoIcons.mail_solid,
                          color: CupertinoColors.inactiveGray,
                          size: 20,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 17, horizontal: 16),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      placeholderStyle: TextStyle(
                        color: CupertinoColors.placeholderText,
                      ),
                      style: TextStyle(
                        color: CupertinoColors.black,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CupertinoTextField(
                      controller: _passwordController,
                      obscureText: passVisible,
                      placeholder: 'Password',
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          CupertinoIcons.lock,
                          color: CupertinoColors.inactiveGray,
                          size: 20,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 17, horizontal: 16),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      placeholderStyle: TextStyle(
                        color: CupertinoColors.placeholderText,
                      ),
                      style: TextStyle(
                        color: CupertinoColors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    CupertinoTextField(
                      controller: _rePasswordController,
                      obscureText: passVisible1,
                      placeholder: 'Ulang Password',
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          CupertinoIcons.lock,
                          color: CupertinoColors.inactiveGray,
                          size: 20,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 17, horizontal: 16),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      placeholderStyle: TextStyle(
                        color: CupertinoColors.placeholderText,
                      ),
                      style: TextStyle(
                        color: CupertinoColors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    CupertinoButton(
                    onPressed: register,
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10 ),
                    minSize: 40,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Do you already have an account?  ",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 31, 64, 255),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(LoginPage());
                              },
                          ),
                ],
              ),
                    ),
                  ),
                  ],
                ),
              ],
            ),
          ),
        ),
          ),),
    );
    
  }
}
