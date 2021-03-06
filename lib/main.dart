import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Happy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Happy'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<dynamic>> data = [];

  loadAsset() async {
    final myData = await rootBundle
        // .loadString('lib/assets/labtest.csv'); 
        .loadString('lib/assets/gravity.csv');
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(myData);

    data = csvTable;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: SingleChildScrollView(
      //   child: Table(
      //     defaultColumnWidth: const FixedColumnWidth(120.0),
      //     border: TableBorder.all(
      //       color: Colors.black,
      //       style: BorderStyle.solid,
      //       width: 2,
      //     ),
      //     // columnWidths: const {
      //     //   0: FixedColumnWidth(100.0),
      //     //   1: FixedColumnWidth(200.0),
      //     // },
      //     // border: TableBorder.all(width: 1.0),
      //     children: data.map(
      //       (item) {
      //         return TableRow(
      //             children: item.map(
      //           (row) {
      //             return Container(
      //               color: row.toString().contains("NA")
      //                   ? Colors.red
      //                   : Colors.green,
      //               child: Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Text(
      //                   row.toString(),
      //                   style: const TextStyle(fontSize: 20.0),
      //                 ),
      //               ),
      //             );
      //           },
      //         ).toList());
      //       },
      //     ).toList(),
      //   ),
      // ),
      
     body: SingleChildScrollView(
       child: DataTable(
          // columns: data.map((column) => 
              // DataColumn(label: Text(column.toString()))
          // ).toList(),
          columns: const <DataColumn>[
            DataColumn(label: Text('data')),
            DataColumn(label: Text('data')),
            DataColumn(label: Text('data')),
            DataColumn(label: Text('data')),
          ],
          rows: data
              .map(
                (item) => DataRow(
                  // cells: item.map((row) =>
                  //     DataCell(Text(row.toString(),),),
                  //  ),
                  cells: [
                    DataCell(
                      Text(
                        item.toString(),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
     ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.air_sharp),
        onPressed: () async {
          await loadAsset();
          print(data);
        },
      ),
    );
  }
}
