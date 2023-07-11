// // ignore_for_file: prefer_final_fields

// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:loginlagi/pages/data.dart';
// import 'package:loginlagi/pages/editdata.dart';
// import 'package:loginlagi/pages/editpassword.dart';
// import 'package:loginlagi/pages/live_detec.dart';
// import 'package:loginlagi/pages/login.dart';
// import 'package:loginlagi/pages/visual.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   Future<Map<String, dynamic>> getUserData() async {
//     final String apiUrl = 'http://192.168.43.170:5000/bearer-auth';

//     final preferences = await SharedPreferences.getInstance();
//     final email = preferences.getString('email');
//     final token = preferences.getString('token');

//     final response = await http.get(
//       Uri.parse(apiUrl),
//       headers: {'Authorization': 'bearer $token'},
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data;
//     } else {
//       final data = jsonDecode(response.body);
//       final message = data['message'];
//       throw Exception('Failed to load user data: $message');
//     }
//   }

//   int _selectedIndex = 0;
//   static TextStyle optionStyle =
//       const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static List<Widget> _widgetOptions = <Widget>[
//     //Halaman home
//     Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'Hai, Selamat Datang',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[300],
//               ),
//             ),
//             Text(
//               'Cheating Detection in Exam',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[300],
//               ),
//             ),
//             const SizedBox(height: 16),
//             Image.network(
//               'https://cdn1-production-images-kly.akamaized.net/CVbBUWd4lTrfMgqJdJJqeKI-kk4=/1200x900/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/4010150/original/094547900_1651147565-5834.jpg',
//               width: 300,
//               height: 300,
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Get.to(Data());
//               },
//               icon: const Icon(Icons.person),
//               label: const Text('Hasil Deteksi Perserta'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green[300],
//                 minimumSize: const Size(400, 50),
//                 padding: const EdgeInsets.all(10),
//                 textStyle: const TextStyle(fontSize: 18),
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Get.to(ChartPage());
//               },
//               icon: const Icon(Icons.draw),
//               label: const Text('Hasil Visualisasi Data'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green[300],
//                 minimumSize: const Size(400, 50),
//                 padding: const EdgeInsets.all(10),
//                 textStyle: const TextStyle(fontSize: 18),
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Get.to(CameraView());
//               },
//               icon: const Icon(Icons.camera),
//               label: const Text('Deteksi'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green[300],
//                 minimumSize: const Size(400, 50),
//                 padding: const EdgeInsets.all(10),
//                 textStyle: const TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),

//     //halaman profil
//     Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SizedBox(
//           width: double.maxFinite,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const CircleAvatar(
//                 backgroundImage: NetworkImage(
//                     'https://media.licdn.com/dms/image/C5603AQHiLGMZUJc-KQ/profile-displayphoto-shrink_400_400/0/1658915420827?e=1693440000&v=beta&t=pt4CRXS3ceHp3KzWuIA8N0qXv9eTVuGvAQY7ELb4iDM'),
//                 maxRadius: 60,
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//               const Text(
//                 'Irfan Triadi Saputra',
//                 style: TextStyle(
//                   fontSize: 22,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Text(
//                 'irfants1710@gmail.com',
//                 style: TextStyle(
//                   fontSize: 12,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Divider(
//                 thickness: 2,
//                 color: Colors.black54,
//               ),
//               ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.green[300],
//                   minimumSize: const Size(400, 50),
//                   padding: const EdgeInsets.all(10),
//                   textStyle: const TextStyle(fontSize: 18),
//                 ),
//                 onPressed: () {
//                   // Navigasi ke halaman Edit Data
//                   Get.to(const EditDataPage());
//                 },
//                 icon: const Icon(Icons.edit),
//                 label: const Text('Edit Data'),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.green[300],
//                   minimumSize: const Size(400, 50),
//                   padding: const EdgeInsets.all(10),
//                   textStyle: const TextStyle(fontSize: 18),
//                 ),
//                 onPressed: () {
//                   // Navigasi ke halaman Edit Data
//                   Get.to(const EditPwPage());
//                 },
//                 icon: const Icon(Icons.edit),
//                 label: const Text('Edit Password'),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cheating Detection'),
//         backgroundColor: Colors.green[300],
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 20.0),
//             child: GestureDetector(
//               onTap: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: const Text('Confirmation'),
//                       content: const Text('Are you sure you want to log out?'),
//                       actions: <Widget>[
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop(); // Close the dialog
//                           },
//                           child: const Text('No'),
//                         ),
//                         TextButton(
//                           onPressed: () async {
//                             // Clear session data
//                             final preferences =
//                                 await SharedPreferences.getInstance();
//                             await preferences.clear();

//                             // Navigate to login page
//                             Navigator.of(context).pushAndRemoveUntil(
//                               MaterialPageRoute(
//                                   builder: (context) => LoginPage()),
//                               (Route<dynamic> route) => false,
//                             );
//                           },
//                           child: const Text('Yes'),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: const Icon(Icons.logout),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               FutureBuilder<Map<String, dynamic>>(
//                 future: getUserData(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasData) {
//                     final data = snapshot.data;
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Selamat Datang: ${data!['nama'] ?? ''}',
//                           style: const TextStyle(
//                             fontSize: 22,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           'Email: ${data!['email'] ?? ''}',
//                           style: const TextStyle(
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     );
//                   } else if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else {
//                     return const Text('No data available');
//                   }
//                 },
//               ),
//               const SizedBox(height: 10),
//               _widgetOptions.elementAt(_selectedIndex),
//             ],
//           ),
//         ),
//       ),
      
//     );
//   }
// }
