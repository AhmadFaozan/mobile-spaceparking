import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartView extends StatefulWidget {
  @override
  _ChartViewState createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  List<dynamic> data = [];

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

  List<charts.Series<DataPoint, String>> createChartData() {
    // Mengurutkan data berdasarkan nilai hasil_deteksi secara menurun
    List<dynamic> sortedData = List.from(data);
    sortedData.sort((a, b) => int.parse(b['hasil_deteksi']).compareTo(int.parse(a['hasil_deteksi'])));

    // Mengambil 10 data tertinggi
    List<dynamic> top5Data = sortedData.take(5).toList();

    // Membuat objek DataPoint untuk setiap data
    List<DataPoint> chartData = top5Data.map((item) {
      return DataPoint(
        item['tanggal'],
        int.parse(item['hasil_deteksi']),
      );
    }).toList();

    return [
      charts.Series<DataPoint, String>(
        id: 'Hasil Deteksi',
        domainFn: (DataPoint point, _) => point.tanggal,
        measureFn: (DataPoint point, _) => point.hasilDeteksi,
        data: chartData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Parkir'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Text(
            'Top 5 Data Tertinggi Hasil Deteksi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: charts.BarChart(
              createChartData(),
              animate: true,
              animationDuration: Duration(milliseconds: 500),
              behaviors: [
                charts.ChartTitle(
                  'Tanggal',
                  behaviorPosition: charts.BehaviorPosition.bottom,
                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                ),
                charts.ChartTitle(
                  'Hasil Deteksi',
                  behaviorPosition: charts.BehaviorPosition.start,
                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DataPoint {
  final String tanggal;
  final int hasilDeteksi;

  DataPoint(this.tanggal, this.hasilDeteksi);
}
