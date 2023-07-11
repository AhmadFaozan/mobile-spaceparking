
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loginlagi/pages/code.dart';
import 'dart:convert';
import 'package:loginlagi/pages/backuphome.dart';
import 'package:loginlagi/pages/regist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://192.168.43.153:5000/login'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final data = jsonDecode(response.body);
      final token = data['token'];
      final code = data['code'];

      // Store session information in Flutter (you can use shared_preferences or flutter_secure_storage)
      // Example using shared_preferences:
      final preferences = await SharedPreferences.getInstance();
      preferences.setString('email', email);
      preferences.setString('token', token);

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Congratulation'),
            content: Text('Login Successfully'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CodePage()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      // TODO: Handle successful login and navigate to another page
    } else {
      final Map<String, dynamic> errorData = json.decode(response.body);
      final String errorMessage = errorData['message'];
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Sorry'),
            content: Text('Login Failed, please check again'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      // TODO: Display login error message
    }
  }

  bool passVisible = false;
  @override
  void initState() {
    super.initState();
    passVisible = true;
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
             SizedBox(height: 35),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                    height: 16,
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
                  SizedBox(height: 20),
                  CupertinoButton(
                    onPressed: _login,
                    child: Text(
                      'Login',
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Opacity(
                            opacity: 0.5,
                            child: Divider(
                              color: const Color.fromARGB(255, 109, 109, 109),
                              thickness: 0.7,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Or continue with",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Opacity(
                            opacity: 0.5,
                            child: Divider(
                              color: const Color.fromARGB(255, 109, 109, 109),
                              thickness: 0.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Action for Google login
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/google.svg',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 35),
                      GestureDetector(
                        onTap: () {
                          // Action for Facebook login
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/apple.svg',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 35),
                      GestureDetector(
                        onTap: () {
                          // Action for Apple login
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/facebook.svg',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account?  ",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 31, 64, 255),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(RegistPage());
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
        ),
      ),
    );
  }
}
