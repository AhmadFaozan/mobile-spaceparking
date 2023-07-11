// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Data extends StatefulWidget {
//   @override
//   _MyWidgetState createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<Data> {
//   List<dynamic> data = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final response = await http.get(Uri.parse('http://192.168.43.153:5000/history'));
//     if (response.statusCode == 200) {
//       setState(() {
//         data = jsonDecode(response.body);
//       });
//     } else {
//       throw Exception('Failed to fetch data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Parking Data'),
//       backgroundColor: Colors.green,
//     ),
//     body: Padding(
//       padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
//       child: ListView(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Text(
//                   'Label ID',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Expanded(
//                 flex: 2,
//                 child: Text(
//                   'Label Name',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8),
//           ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: data.length,
//             itemBuilder: (context, index) {
//               final item = data[index];
//               final number = index + 1;
//               return Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Text(number.toString()),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     flex: 2,
//                     child: Text(item['label_name']),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     ),
//   );
// }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> data = [];
  String searchDate = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.43.153:80/api.php'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          data = jsonData;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  int calculateTotal(String searchDate) {
    int total = 0;
    for (var item in data) {
      if (item['tanggal'].toString().toLowerCase().contains(searchDate.toLowerCase())) {
        total += int.parse(item['hasil_deteksi']);
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Data Parkir'),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CupertinoTextField(
                      onChanged: (value) {
                        setState(() {
                          searchDate = value;
                        });
                      },
                      placeholder: 'Cari berdasarkan tanggal',
                      prefix: Icon(CupertinoIcons.search),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center( // Posisikan tabel di tengah layar
                  child: CupertinoScrollbar(
                    child: ListView.builder(
                      itemCount: data.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          'Tanggal',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          'Hasil Deteksi',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          var item = data[index - 1];
                          if (item['tanggal'].toString().toLowerCase().contains(searchDate.toLowerCase())) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Card(
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(item['tanggal']),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(item['hasil_deteksi']),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Total: ${calculateTotal(searchDate)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


