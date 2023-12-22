import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pb_apps/api_url/api_url.dart';
import 'package:pb_apps/widget/My_app_bar.dart';
import 'package:pb_apps/widget/drawer.dart';
import 'package:http/http.dart' as http;
class Kpi extends StatefulWidget {
  const Kpi({Key? key}) : super(key: key);
  @override
  State<Kpi> createState() => _KpiState();
}
class _KpiState extends State<Kpi> {
  final storage = const FlutterSecureStorage();
  List<Map<String, dynamic>> kpiData = [];
  @override
  void initState() {
    super.initState();
    fetchKpi().then((fetchedKpi) {
      setState(() {
        kpiData = fetchedKpi;
      });
    });
  }
  Future<List<Map<String, dynamic>>> fetchKpi() async {
    String? value = await storage.read(key: 'token');
    final response = await http.get(
        Uri.parse('${Constants.BASE_URL}/api/v1/performances/kpi/me'),
        headers: {
          'Authorization': value.toString(),
          'Content-Type': 'application/json',
        });
    if(response.statusCode==200){
      final List<dynamic> jsonList= json.decode(response.body);
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
      body: Column(),
      drawer: const MyDrawer(),
    );
  }
}