import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'csv_null_update/csv_sheet.dart';

class TableLayout extends StatefulWidget {
  const TableLayout({Key? key}) : super(key: key);

  @override
  _TableLayoutState createState() => _TableLayoutState();
}

class _TableLayoutState extends State<TableLayout> {
  List<List<dynamic>> data = [];

  loadAsset() async {
    final myData = await rootBundle.loadString("lib/assets/gravity.csv");
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(myData);

    data = csvTable;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () async {
            await loadAsset();
            print(data);
            //TODO: lazy loading data
          }),
      appBar: AppBar(
        title: const Text("Table Layout and CSV"),
      ),
      body: SingleChildScrollView(
        child: Table(
          columnWidths: const {
            0: FixedColumnWidth(200.0),
            1: FixedColumnWidth(400.0),
          },
          border: TableBorder.all(width: 1.0),
          children: data.map((item) {
            return TableRow(
                children: item.map((row) {
              return Container(
                color:
                    row.toString().contains("NA") ? Colors.red : Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    row.toString(),
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
              );
            }).toList());
          }).toList(),
        ),
      ),
      // body: DataTable(
      //   columns: <DataColumn>[
      //     DataColumn(label: Text('')),
      //     DataColumn(label: Text('')),
      //     DataColumn(label: Text('')),
      //     DataColumn(label: Text('')),
      //   ],
      //   rows: data
      //       .map(
      //         (item) => DataRow(
      //           // cells: item.map((row) =>
      //           //     DataCell(Text(row.toString(),),),
      //           //  ),
      //           cells: [
      //             DataCell(
      //               Text(
      //                 item.toString(),
      //               ),
      //             ),
      //           ],
      //         ),
      //       )
      //       .toList(),
      // ),
    );
  }
}
