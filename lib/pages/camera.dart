// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:loginlagi/pages/data.dart';
// import 'package:loginlagi/pages/editdata.dart';
// import 'package:loginlagi/pages/editpassword.dart';
// import 'package:loginlagi/pages/live_detec.dart';
// import 'package:loginlagi/pages/login.dart';
// import 'package:loginlagi/pages/profile.dart';
// import 'package:loginlagi/pages/visual.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class Camera extends StatefulWidget {
//   const Camera({Key? key}) : super(key: key);

//   @override
//   State<Camera> createState() => _CameraState();
// }

// class _CameraState extends State<Camera> {
//   Future<Map<String, dynamic>> getUserData() async {
//     final String apiUrl = 'http://192.168.43.153:5000/bearer-auth';


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

//   void _onItemTapped(int index) {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Container header
//           Container(
//             child: FutureBuilder<Map<String, dynamic>>(
//               future: getUserData(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CupertinoActivityIndicator());
//                 } else if (snapshot.hasData) {
//                   final data = snapshot.data;
//                   return Container(
//                     padding: const EdgeInsets.only(left: 8, right: 8),
//                     color: CupertinoColors.systemGreen,
//                     width: double.maxFinite,
//                     height: 90,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           width: double.maxFinite,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: CupertinoColors.white,
//                           ),
//                           child: Column(
//                             children: [
//                               Text(
//                                 'Welcome: ${data!['nama'] ?? ''}',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 22,
//                                   color: CupertinoColors.systemGreen,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 'Email: ${data!['email'] ?? ''}',
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   color: CupertinoColors.systemGreen,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
                              
//                             ],
                            
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return const Text('No data available');
//                 }
//               },
//             ),
//           ),

//           // Container body
//           Container(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 Text(
//                   'Space Parking Detection',
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: CupertinoColors.systemGreen,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Image.network(
//                   'https://cdn1-production-images-kly.akamaized.net/CVbBUWd4lTrfMgqJdJJqeKI-kk4=/1200x900/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/4010150/original/094547900_1651147565-5834.jpg',
//                   width: 300,
//                   height: 300,
//                 ),
//                 // const SizedBox(height: 12),
//                 // CupertinoButton.filled(
//                 //   onPressed: () {
//                 //     Get.to(Data());
//                 //   },
//                 //   child: Row(
//                 //     mainAxisSize: MainAxisSize.min,
//                 //     children: const [
//                 //       Icon(CupertinoIcons.person),
//                 //       SizedBox(width: 6),
//                 //       Text('Detection Results'),
//                 //     ],
//                 //   ),
//                 // ),
//                 // const SizedBox(height: 16),
//                 // CupertinoButton.filled(
//                 //   onPressed: () {
//                 //     Get.to(ChartView());
//                 //   },
//                 //   child: Row(
//                 //     mainAxisSize: MainAxisSize.min,
//                 //     children: const [
//                 //       Icon(CupertinoIcons.pencil_ellipsis_rectangle),
//                 //       SizedBox(width: 6),
//                 //       Text('Data Visualization Results'),
//                 //     ],
//                 //   ),
//                 // ),
//                 // const SizedBox(height: 16),
//                 // CupertinoButton.filled(
//                 //   onPressed: () {
//                 //     Get.to(CameraView());
//                 //   },
//                 //   child: Row(
//                 //     mainAxisSize: MainAxisSize.min,
//                 //     children: const [
//                 //       Icon(CupertinoIcons.camera),
//                 //       SizedBox(width: 6),
//                 //       Text('Detection'),
//                 //     ],
//                 //   ),
//                 // ),
//                 const SizedBox(height: 12),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: CupertinoButton.filled(
//                               onPressed: () {
//                                 Get.to(Data());
//                               },
//                               child: Icon(CupertinoIcons.person),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: CupertinoButton.filled(
//                               onPressed: () {
//                                 Get.to(ChartView());
//                               },
//                               child: Icon(CupertinoIcons.pencil_ellipsis_rectangle),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: CupertinoButton.filled(
//                               onPressed: () {
//                                 Get.to(CameraView());
//                               },
//                               child: Icon(CupertinoIcons.camera),
//                             ),
//                           ),
//                         ],
//                       ),


//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class Camerass extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoApp(
//       debugShowCheckedModeBanner: false,
//      title: 'Pages',
//       theme: CupertinoThemeData(
//         primaryColor: CupertinoColors.systemGreen,
//       ),
//       home: CupertinoPageScaffold(
//         navigationBar: CupertinoNavigationBar(
//           middle: const Text('Cheating Detection'),
//           backgroundColor: CupertinoColors.systemGreen,
//           transitionBetweenRoutes: false,
//           trailing: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Profile()),
//               );
//             },
//             child: const Icon(
//               CupertinoIcons.person,
//               color: CupertinoColors.white,
//             ),
//           ),
//         ),
//         child: Camera(),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loginlagi/pages/artikel.dart';
import 'package:loginlagi/pages/data.dart';
import 'package:loginlagi/pages/editdata.dart';
import 'package:loginlagi/pages/editpassword.dart';
import 'package:loginlagi/pages/live_detec.dart';
import 'package:loginlagi/pages/login.dart';
import 'package:loginlagi/pages/profile.dart';
import 'package:loginlagi/pages/visual.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final List<String> imageUrls = [
    'https://img.freepik.com/premium-vector/vector-illustration-city-parking-lot-with-set-different-cars-public-car-park-flat-illustration-web-urban-transport-large-number-cars-crowded-parking_589019-735.jpg',
    'https://img.freepik.com/premium-vector/bad-wrong-car-parking_169241-1316.jpg?size=626&ext=jpg',
    'https://img.freepik.com/premium-vector/city-parking-lot-with-different-cars_165488-1407.jpg?size=626&ext=jpg',
  ];

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: imageUrls.length,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Image.network(
            imageUrls[index],
            width: 100,
            height: 100,
          );
        },
      ),
    );
  }
}

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Container header
          Container(
            child: FutureBuilder<Map<String, dynamic>>(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  final data = snapshot.data;
                  return Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    color: Colors.green,
                    width: double.maxFinite,
                    height: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Welcome: ${data!['nama'] ?? ''}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Email: ${data!['email'] ?? ''}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Text('No data available');
                }
              },
            ),
          ),

          // Container body
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Space Parking Detection',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 15),

                ImageSlider(),

                const SizedBox(height: 15,),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CupertinoButton.filled(
                        onPressed: () {
                          Get.to(HomeScreen());
                        },
                        child: Icon(CupertinoIcons.person),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CupertinoButton.filled(
                        onPressed: () {
                          Get.to(ChartView());
                        },
                        child: Icon(CupertinoIcons.pencil_ellipsis_rectangle),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CupertinoButton.filled(
                        onPressed: () {
                          Get.to(CameraView());
                        },
                        child: Icon(CupertinoIcons.camera),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Artikel widget
          //Artikel(),
        ],
      ),
    );
  }
}

class Camerass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Pages',
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Cheating Detection'),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
              child: const Icon(Icons.person),
            ),
          ),
        ],
      ),
      body: Camera(),
    ),
  );
}
}
