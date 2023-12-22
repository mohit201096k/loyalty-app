//
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:pb_apps/widget/Big_text.dart';
// import 'dart:convert';
// import '../api_url/api_url.dart';
// import 'package:pb_apps/models/achievements.dart';
// import 'package:pb_apps/widget/My_app_bar.dart';
// import 'package:pb_apps/widget/drawer.dart';
// class AchievementsPage extends StatefulWidget {
//   const AchievementsPage({Key? key}) : super(key: key);
//   @override
//   State<AchievementsPage> createState() => _AchievementsPageState();
// }
// class _AchievementsPageState extends State<AchievementsPage> {
//   List<Achievement> achievements = [];
//   final storage = const FlutterSecureStorage();
//   @override
//   void initState() {
//     super.initState();
//     fetchAchievements().then((fetchedAchievements) {
//       setState(() {
//         achievements = fetchedAchievements;
//       });
//     });
//   }
//   Future<List<Achievement>> fetchAchievements() async {
//     String? value = await storage.read(key: 'token');
//     final response = await http.get(
//       Uri.parse('${Constants.BASE_URL}/api/v1/performances/achievements/me'),
//       headers: {
//         'Authorization': value.toString(),
//         'Content-Type': 'application/json',
//       },
//     );
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonList = json.decode(response.body);
//       return jsonList.map((json) => Achievement.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load achievements');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const MyAppBar(),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.horizontal, // Enable horizontal scrolling
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 10,bottom: 10),
//               child: Center(child: BigText(text: 'Achievements',color: Colors.teal,)),
//             ),
//             Card(
//               child: DataTable(
//                 columnSpacing: 14.0,
//                 dataRowHeight: 40.0,
//                 columns:  [
//                   DataColumn(label: BigText(text: 'No',color: Colors.teal,)),
//                   DataColumn(label: BigText(text: 'SaleFrom',color: Colors.teal,)),
//                   DataColumn(label: BigText(text: 'SaleTo',color: Colors.teal,)),
//                   DataColumn(label: BigText(text: 'ActualSales',color: Colors.teal,)),
//                   DataColumn(label: BigText(text: 'Description',color: Colors.teal,)),
//                   // DataColumn(label: Text('Sale To')),
//                 ],
//                 // rows: achievements.map((achievement) {
//                 //   return DataRow(cells: [
//                 //     DataCell(
//                 //       Align(
//                 //         alignment: Alignment.center,
//                 //         child: Text(achievement.saleFrom.toString()),
//                 //       ),
//                 //     ),
//                 rows: achievements.asMap().entries.map((entry) {
//                   final index = entry.key + 1;
//                   final achievement = entry.value;
//                   return DataRow(cells: [
//                     DataCell(
//                       Align(
//                         alignment: Alignment.center,
//                         child: Text('${index.toString()}.'),
//                       ),
//                     ),
//                     DataCell(
//                           Align(
//                             alignment: Alignment.center,
//                             child: Text(achievement.saleFrom.toString()),
//                           ),
//                         ),
//                     DataCell(
//                       Align(
//                         alignment: Alignment.center,
//                         child: Text(achievement.saleTo.toString()),
//                       ),
//                     ),
//                     DataCell(
//                       Align(
//                         alignment: Alignment.center,
//                         child: Text(achievement.actualSales.toString()),
//                       ),
//                     ),
//                     DataCell(
//                       Align(
//                         alignment: Alignment.center,
//                         child: Text(achievement.description),
//                       ),
//                     ),
//                     // DataCell(Text(achievement.description)),
//                   ]);
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//       drawer: const MyDrawer(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pb_apps/widget/Big_text.dart';
import 'dart:convert';
import '../api_url/api_url.dart';
import 'package:pb_apps/widget/My_app_bar.dart';
import 'package:pb_apps/widget/drawer.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({Key? key}) : super(key: key);
  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}
class _AchievementsPageState extends State<AchievementsPage> {
  List<Map<String, dynamic>> achievementsData = [];
  final storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    fetchAchievements().then((fetchedAchievements) {
      setState(() {
        achievementsData = fetchedAchievements;
      });
    });
  }


  Future<List<Map<String, dynamic>>> fetchAchievements() async {
    String? value = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('${Constants.BASE_URL}/api/v1/performances/achievements/me'),
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
      throw Exception('Failed to load achievements');
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
            achievementsData.isEmpty
                ? Padding(
                  padding: const EdgeInsets.only(top: 10,left: 170),
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 10,),
                      Text('No data found')
                    ],
                  ),
                )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Center(
                            child: BigText(
                                text: 'Achievements', color: Colors.teal
                            )
                        ),
                      ),
                      Card(
                        child: DataTable(
                          columnSpacing: 15.0,
                          dataRowHeight: 30.0,
                          columns: achievementsData[0]
                              .keys
                              .map<DataColumn>((String columnName) {
                            return DataColumn(
                              label:
                                  BigText(text: columnName, color: Colors.teal),
                            );
                          }).toList(),
                          rows: achievementsData
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
