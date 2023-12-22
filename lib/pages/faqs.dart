// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:pb_apps/api_url/api_url.dart';
// import 'package:pb_apps/widget/My_app_bar.dart';
// import 'package:http/http.dart' as http;
// import 'package:pb_apps/widget/drawer.dart';
// import '../models/faqs_model.dart';
// class Faqs extends StatefulWidget {
//   const Faqs({Key? key}) : super(key: key);
//   @override
//   State<Faqs> createState() => _FaqsState();
// }
// class _FaqsState extends State<Faqs> {
//   List<FAQItem> faqs = [];
//   final storage = const FlutterSecureStorage();
//   @override
//   void initState() {
//     super.initState();
//     fetchFAQs();
//   }
//   Future<void> fetchFAQs() async {
//     try {
//       String? value = await storage.read(key: 'token');
//       final response = await http.get(
//         Uri.parse('${Constants.BASE_URL}/api/v1/faqs'),
//         headers: {
//           'Authorization': value.toString(),
//           'Content-Type': 'application/json',
//         },
//       );
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         setState(() {
//           faqs = data.map((item) => FAQItem.fromJson(item)).toList();
//         });
//       } else {
//         ('Response body: ${response.body}');
//       }
//     } catch (error) {
//      ('Error fetching FAQs: $error');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const MyAppBar(),
//       body: ListView.builder(
//         itemCount: faqs.length,
//         itemBuilder: (context, index) {
//           final faq = faqs[index];
//           return FAQExpansionTile(faq, index + 1);
//         },
//       ),
//       drawer: const MyDrawer(),
//     );
//   }
// }
// class FAQExpansionTile extends StatelessWidget {
//   final FAQItem faqItem;
//   final int questionNumber;
//   const FAQExpansionTile(this.faqItem, this.questionNumber, {Key? key})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ExpansionTile(
//         title: Text('$questionNumber. ${faqItem.query}'),
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(faqItem.response),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pb_apps/api_url/api_url.dart';
import 'package:pb_apps/widget/My_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:pb_apps/widget/drawer.dart';
import '../models/faqs_model.dart';
class Faqs extends StatefulWidget {
  const Faqs({Key? key}) : super(key: key);
  @override
  State<Faqs> createState() => _FaqsState();
}
class _FaqsState extends State<Faqs> {
  List<FAQItem> faqs = [];
  final storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
  }
  Future<List<FAQItem>> fetchFAQs() async {
    try {
      String? value = await storage.read(key: 'token');
      final response = await http.get(
        Uri.parse('${Constants.BASE_URL}/api/v1/faqs'),
        headers: {
          'Authorization': value.toString(),
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => FAQItem.fromJson(item)).toList();
      } else {
        ('Response body: ${response.body}');
        return [];
      }
    } catch (error) {
      ('Error fetching FAQs: $error');
      return [];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: FutureBuilder<List<FAQItem>>(
        future: fetchFAQs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching FAQs: ${snapshot.error}'),
            );
          } else {
            faqs = snapshot.data ?? [];
            return ListView.builder(
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                final faq = faqs[index];
                return FAQExpansionTile(faq, index + 1);
              },
            );
          }
        },
      ),
      drawer: const MyDrawer(),
    );
  }
}
class FAQExpansionTile extends StatelessWidget {
  final FAQItem faqItem;
  final int questionNumber;
  const FAQExpansionTile(this.faqItem, this.questionNumber, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text('$questionNumber. ${faqItem.query}'),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(faqItem.response),
          ),
        ],
      ),
    );
  }
}
