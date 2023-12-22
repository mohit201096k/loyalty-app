import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pb_apps/pages/achievements_page.dart';
import 'package:pb_apps/pages/kpi.dart';
import 'package:pb_apps/pages/targets.dart';
import 'package:pb_apps/profile/My_profile.dart';
import 'package:pb_apps/widget/Big_text.dart';
import 'package:pb_apps/widget/My_app_bar.dart';
import 'package:pb_apps/widget/drawer.dart';
import '../api_url/api_url.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  var points=4500;
  List<String> imageUrls = [
  ];
  final storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    fetchImageUrls();
  }
  Future<void> fetchImageUrls() async {
    try {
      String? value = await storage.read(key: 'token');
      final response = await http.get(
        Uri.parse('${Constants.BASE_URL}/api/v1/dashboard/slider'),
        headers: {
          'Authorization': value.toString(),
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<String> fetchedImageUrls = responseData.map((data) {
          final String imageId = data["title"];
          return '${Constants.BASE_URL}/api/v1/media/stream/$imageId';
        }).toList();
        setState(() {
          imageUrls = fetchedImageUrls;
        });
      } else {
        throw Exception('Failed to load images from API');
      }
    } catch (error) {
      ('Error fetching images: $error');
    }
  }
  File? imageFile;
  _getFromGallery() async {
    PickedFile? pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.gallery,
      // maxWidth: 100,
      // maxHeight: 100,
    )
    ) as PickedFile?;
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
  Widget _getImageBasedOnPoints(int points) {
    if (points < 4000 && points>2000) {
      return Image.asset('assets/images/silver.gif');
    } else if (points<1100 ) {
      return Image.asset('assets/images/pb_apps.png');
    }
    else if (points >= 2000 && points <= 5000) {
      return Image.asset('assets/images/gold.gif');
    } else {
      return Image.asset('assets/images/platinum.gif');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 210,
                width: double.infinity,
                decoration:  BoxDecoration(
                    color: Colors.teal.shade400,
                    borderRadius: const BorderRadius.only(
                        topLeft:Radius.circular(5),topRight:Radius.circular(5)
                    )
                ),
              ),
              Positioned(
                top: 15,
                left: 15,
                child: GestureDetector(
                    onTap: (){
                      _getFromGallery();
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child:imageFile==null? Image.asset("assets/icons/img.png",filterQuality: FilterQuality.high,fit: BoxFit.cover,)
                          :Image.file(imageFile!,
                        fit: BoxFit.fitHeight,filterQuality: FilterQuality.high,width: 50,), // White background color
                    )
                ),
              ),
              // Positioned(
              //   top: 15,
              //   left: 15,
              //   child: GestureDetector(
              //     onTap: (){
              //       _getFromGallery();
              //     },
              //     child: imageFile == null ?CircleAvatar(
              //       radius: 50,
              //       backgroundColor: Colors.white,
              //       child: Image.asset("assets/icons/img.png",filterQuality: FilterQuality.high,fit: BoxFit.cover,), // White background color
              //     ):CircleAvatar(
              //       backgroundColor: Colors.white,
              //       radius: 50,
              //       child: Image.file(imageFile!,
              //         fit: BoxFit.fitHeight,filterQuality: FilterQuality.high,width: 50,),
              //     )
              //   ),
              // ),
              Positioned(
                top: 35,
                  left: 250,
                  child: SizedBox(
                    height: 50,
                    width: 120,
                    child: _getImageBasedOnPoints(points),
                    // child: Image.asset("assets/images/silver.gif",fit: BoxFit.fitWidth,filterQuality: FilterQuality.high,),
                  )
              ),
              Positioned(
                top: 25,
                left: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: "WELCOME", color: Colors.white,),
                    BigText(text: "To",color: Colors.white,),
                    BigText(text: "PB apps",color: Colors.white),
                  ],
                ),
              ),
              Positioned(
                top: 135,
                left: 10,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 110,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)
                          )
                      ),
                      child: Column(
                        children: const [
                          SizedBox(height: 3,),
                          Text("257865",style: TextStyle(color: Colors.teal,),),
                          SizedBox(height: 5,),
                          Text('POINTS EARNED',style:TextStyle(fontSize: 12,),),
                          SizedBox(height: 3,),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      height: 50,
                      width: 125,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)
                          )
                      ),
                      child: Column(
                        children: const [
                          SizedBox(height: 3,),
                          Text("25006",style: TextStyle(color: Colors.teal),),
                          SizedBox(height: 5,),
                          Text('POINTS REDEEMED',style:TextStyle(fontSize: 12,),),
                          SizedBox(height: 3,),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      height: 50,
                      width: 125,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)
                          )
                      ),
                      child: Column(
                        children: const [
                          SizedBox(height: 3,),
                          Text("182500",style: TextStyle(color: Colors.teal,),),
                          SizedBox(height: 5,),
                          Text('AVAILABLE POINTS',style: TextStyle(fontSize:12,),),
                          SizedBox(height: 3,),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          CarouselSlider(
            items: imageUrls.map((imageUrl) {
              return SizedBox(
                height: 350,
                width: double.infinity,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                ),
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              viewportFraction: 1
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Container(
                  color: Colors.white,
                  height: 110,
                  width: 110,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder:(context)=>const MyProfile())
                            );
                          },
                            child: _buildColoredImage("assets/icons/profile.png",height: 50,)),
                      ),
                      const SizedBox(height: 10,),
                      const Text("MY PROFILE",)
                    ],
                  ),
                ),
                const SizedBox(width: 10,),
                Container(
                  color: Colors.white,
                  height: 110,
                  width: 110,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: _buildColoredImage("assets/icons/help.png",height: 50,),
                      ),
                      const SizedBox(height: 10,),
                      const Text("HELP",)
                    ],
                  ),
                ),
                const SizedBox(width: 10,),
                Container(
                  color: Colors.white,
                  height: 110,
                  width: 110,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder:(context)=>const Targets())
                            );
                          },
                            child: _buildColoredImage("assets/icons/target.png",height: 50,)),
                      ),
                      const SizedBox(height: 10,),
                      const Text("TARGETS",)
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Container(
                  color: Colors.white,
                  height: 110,
                  width: 110,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>const AchievementsPage()));
                          },
                            child: _buildColoredImage("assets/icons/achievements.png", height: 70,)),
                      ),
                      const SizedBox(height: 10,),
                      const Text("Achievements",),
                    ],
                  ),
                ),
                const SizedBox(width: 10,),
                Container(
                  color: Colors.white,
                  height: 110,
                  width: 110,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: _buildColoredImage("assets/icons/points.png",height: 60,),
                      ),
                      const SizedBox(height: 10,),
                      const Text("POINTS",),
                    ],
                  ),
                ),
                const SizedBox(width: 10,),
                Container(
                  color: Colors.white,
                  height: 110,
                  width: 110,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>const Kpi()));
                          },
                            child: _buildColoredImage("assets/icons/kpi.png",height: 70,)),
                      ),
                      const SizedBox(height: 10,),
                      const Text("KPI",),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      drawer: const MyDrawer(),
    );
  }
}
Widget _buildColoredImage(String imagePath, {required int height,} ) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top:2),
          child: ColorFiltered(
            colorFilter: const ColorFilter.mode(Colors.teal, BlendMode.srcIn),
            child: Image.asset(imagePath, height: 50,),
          ),
        ),
      ],
    ),
  );
}

