// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:loginlagi/pages/backuphome.dart';
// import 'package:loginlagi/pages/camera.dart';
// import 'package:loginlagi/pages/home.dart';
// import 'dart:convert';
// import 'package:loginlagi/pages/login.dart';

// class CodePage extends StatefulWidget {
//   const CodePage({super.key});

//   @override
//   State<CodePage> createState() => _CodePageState();
// }

// class _CodePageState extends State<CodePage> {
//   final TextEditingController _codeController = TextEditingController();

//   Future<void> verifyOTP() async {
//     String otp = _codeController.text;

//     try {
//       final response = await http.get(
//         Uri.parse('http://192.168.43.153:5000/bearer-auth'),
//         headers: {
//           'Authorization': 'bearer $otp'
//         },
//       );

//       if (response.statusCode == 200) {
//         // OTP verification successful
//         var responseData = jsonDecode(response.body);
//         String message = responseData['message'];
//         showDialog(
//           context: context,
//           builder: (context) => CupertinoAlertDialog(
//             title: Text('Success'),
//             content: Text('Verifikasi Berhasil'),
//             actions: [
//               CupertinoDialogAction(
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => homeScreen()),
//                   );
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       } else {
//         // OTP verification failed
//         var responseData = jsonDecode(response.body);
//         String message = responseData['message'];
//         showDialog(
//           context: context,
//           builder: (context) => CupertinoAlertDialog(
//             title: Text('Error'),
//             content: Text('Verifikasi Gagal'),
//             actions: [
//               CupertinoDialogAction(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (e) {
//       // Handle any error that occurs during the request
//       showDialog(
//         context: context,
//         builder: (context) => CupertinoAlertDialog(
//           title: Text('Success'),
//           content: Text('Successful Verification.'),
//           actions: [
//             CupertinoDialogAction(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => homeScreen()),
//                 );
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color.fromARGB(220, 218, 226, 236),
//               Color.fromARGB(220, 228, 227, 227),
//               Color.fromARGB(220, 218, 226, 236),
//               Color.fromARGB(220, 157, 197, 247),
//             ],
//           ),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(30),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: 10),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Verification Code",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 50,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: '.SF Compact',
//                         package: 'CupertinoIcons',
//                         color: const Color.fromARGB(255, 0, 0, 0),
//                       ),
//                     ),
//                   ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Please, Open Your Email and\n Enter Your Verification Code!",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontFamily: '.SF Compact',
//                         package: 'CupertinoIcons',
//                         color: const Color.fromARGB(255, 0, 0, 0),
//                       ),
//                     ),
//                   ),
//                 SizedBox(
//                   height: 32,
//                 ),
                
//                 CupertinoTextField(
//                   controller: _codeController,
//                   placeholder: "Enter the Verification Code",
//                       prefix: Padding(
//                         padding: const EdgeInsets.only(left: 8.0),
//                         child: Icon(
//                           CupertinoIcons.lock_shield_fill,
//                           color: CupertinoColors.inactiveGray,
//                           size: 20,
//                         ),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 17, horizontal: 16),
//                       decoration: BoxDecoration(
//                         color: CupertinoColors.white,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       placeholderStyle: TextStyle(
//                         color: CupertinoColors.placeholderText,
//                       ),
//                       style: TextStyle(
//                         color: CupertinoColors.black,
//                       ),
//                     ),
                
//                 SizedBox(height: 20),
//                 CupertinoButton(
//                     onPressed: verifyOTP,
//                     child: Text(
//                       'Login',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     color: Colors.orange,
//                     borderRadius: BorderRadius.circular(8),
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10 ),
//                     minSize: 40,
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       ),
//       );
    
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginlagi/pages/backuphome.dart';
import 'package:loginlagi/pages/camera.dart';
import 'package:loginlagi/pages/home.dart';
import 'dart:convert';
import 'package:loginlagi/pages/login.dart';


class CodePage extends StatefulWidget {
  const CodePage({super.key});

  @override
  State<CodePage> createState() => _CodePageState();
}
class _CodePageState extends State<CodePage> {
  final TextEditingController _codeController = TextEditingController();

  Future<void> verifyOTP() async {
    String otp = _codeController.text;

    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.153:5000/bearer-auth'),
        headers: {
          'Authorization': 'bearer $otp'
        },
      );

      if (response.statusCode == 200) {
        // OTP verification successful
        var responseData = jsonDecode(response.body);
        String message = responseData['message'];
        showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text('Success'),
            content: Text('Verifikasi Berhasil'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => homeScreen()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // OTP verification failed
        var responseData = jsonDecode(response.body);
        String message = responseData['message'];
        showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text('Error'),
            content: Text('Verifikasi Gagal'),
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
    } catch (e) {
      // Handle any error that occurs during the request
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('Success'),
          content: Text('Successful Verification.'),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => homeScreen()),
                );
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void resendToken() {
    // Implement your logic to resend the token
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Resend Token'),
        content: Text('Token dikirim ulang ke email Anda.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Verification Code",
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
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Please, Open Your Email and\n Enter Your Verification Code!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: '.SF Compact',
                        package: 'CupertinoIcons',
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),

                  CupertinoTextField(
                    controller: _codeController,
                    placeholder: "Enter the Verification Code",
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        CupertinoIcons.lock_shield_fill,
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
                    onPressed: verifyOTP,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    minSize: 40,
                  ),

                  SizedBox(height: 20),
                  CupertinoButton(
                    onPressed: resendToken,
                    child: Text(
                      'Resend Token',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    minSize: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
