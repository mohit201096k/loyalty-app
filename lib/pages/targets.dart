import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../api_url/api_url.dart';
import '../widget/Big_text.dart';
import '../widget/My_app_bar.dart';
import '../widget/drawer.dart';

class Targets extends StatefulWidget {
  const Targets({Key? key}) : super(key: key);
  @override
  State<Targets> createState() => _TargetsState();
}

class _TargetsState extends State<Targets> {
  List<Map<String, dynamic>> targetsData = [];
  final storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    fetchTargets().then((fetchedTargets) {
      setState(() {
        targetsData = fetchedTargets;
      });
    });
  }

  Future<List<Map<String, dynamic>>> fetchTargets() async {
    String? value = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('${Constants.BASE_URL}/api/v1/performances/targets/me'),
      headers: {
        'Authorization': value.toString(),
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonList.map((json) {
        return Map<String, dynamic>.from(json);
      }));
    } else {
      throw Exception('Failed to load Targets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            targetsData.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 10, left: 170),
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text('No data found')
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Center(
                            child:
                                BigText(text: 'Targets', color: Colors.teal)),
                      ),
                      Card(
                        child: DataTable(
                          columnSpacing: 30.0,
                          dataRowHeight: 35.0,
                          columns: targetsData[0]
                              .keys
                              .map<DataColumn>((String columnName) {
                            return DataColumn(
                              label:
                                  BigText(text: columnName, color: Colors.teal),
                            );
                          }).toList(),
                          rows: targetsData
                              .map<DataRow>((Map<String, dynamic> rowData) {
                            return DataRow(
                              cells: rowData.keys
                                  .map<DataCell>((String columnName) {
                                final cellValue =
                                    rowData[columnName].toString();
                                return DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(cellValue),
                                  ),
                                );
                              }).toList(),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
