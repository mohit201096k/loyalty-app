
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pb_apps/widget/Big_text.dart';
import 'package:pb_apps/widget/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import '../api_url/api_url.dart';
import '../widget/My_app_bar.dart';
class AboutProgram extends StatefulWidget {
  const AboutProgram({Key? key}) : super(key: key);
  @override
  State<AboutProgram> createState() => _AboutProgramState();
}
class _AboutProgramState extends State<AboutProgram> {
  final storage = const FlutterSecureStorage();
  String htmlContent = '';
  String imageUrl = '';
  String linkUrl = '';
  @override
  void initState() {
    super.initState();
    fetchHtmlContent();
  }
  Future<void> fetchHtmlContent() async {
    try {
      String? value = await storage.read(key: 'token');
      final response = await http.get(
        Uri.parse('${Constants.BASE_URL}/api/v1/configs/.by.name/about.program'),
        headers: {
          'Authorization': value.toString(),
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final valueData = jsonData['value'] ?? '';
        imageUrl = extractImageUrl(valueData);
        final htmlWithoutEmbeddedImage = removeEmbeddedImage(valueData);
        linkUrl = extractLinkUrl(valueData);
        setState(() {
          htmlContent = htmlWithoutEmbeddedImage;
        });
      } else {
        throw Exception('Failed to load HTML content');
      }
    } catch (error) {
      ('Error: $error');
    }
  }
  String extractImageUrl(String html) {
    final RegExp regex = RegExp('<img[^>]+src="([^">]+)"');
    final match = regex.firstMatch(html);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    } else {
      return '';
    }
  }
  String extractLinkUrl(String html) {
    // '<a[^>]+href="([^">]+)"'
    final RegExp regex = RegExp('<img[^>]+src="([^">]+)" href="([^">]+)"');
    final match = regex.firstMatch(html);
    if (match != null && match.groupCount >= 2) {
      return match.group(2)!;
    } else {
      return '';
    }
  }
  String removeEmbeddedImage(String html) {
    return html.replaceAllMapped(
      RegExp('<img[^>]+src="[^"]+"[^>]*>'),
          (match) => '',
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10,bottom: 10),
          child: Column(
            children: [
              if(htmlContent.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(left:165, top: 10,bottom: 10),
                  child: Column(
                    children:  [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 10,),
                      BigText(text: 'Loading...',color: Colors.grey.shade500,)
                    ],
                  ),
                ),
              if (imageUrl.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    if (linkUrl.isNotEmpty) {
                      launch(linkUrl);
                    }
                  },
                  child: Container(
                    height: 150,
                    width: 250,
                    color: Colors.white,
                    child: Image.network(
                      imageUrl,
                      width: 200,
                      height: 120,
                    ),
                  ),
                ),
              if (htmlContent.isNotEmpty)
                Html(
                  data: htmlContent,
                  style: {
                    'h1': Style(color: Colors.teal, fontSize: FontSize.xLarge),
                    'h2': Style(color: Colors.teal),
                    'p': Style(color: Colors.black87, fontSize: FontSize.medium),
                    // 'ul': Style(margin: const EdgeInsets.symmetric(vertical: 20)),
                  },
                ),
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
