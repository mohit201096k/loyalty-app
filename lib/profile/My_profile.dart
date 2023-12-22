import 'package:flutter/material.dart';
import 'package:pb_apps/widget/My_app_bar.dart';
import 'package:pb_apps/widget/drawer.dart';
import '../widget/Big_text.dart';
class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);
  @override
  State<MyProfile> createState() => _MyProfileState();
}
class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: Colors.teal.shade400,
                height: 120,
                width: double.infinity,
              ),
              Positioned(
                top: 15,
                left: 15,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Image.asset("assets/icons/img.png",filterQuality: FilterQuality.high,), // White background color
                ),
              ),
              Positioned(
                  top: 40,
                  left: 225,
                  child: Column(
                    children: const [
                      Text("750056",style: TextStyle(color: Colors.white),),
                      Text("Available points",style: TextStyle(color: Colors.white),)
                    ],
                  )
              ),
              Positioned(
                  top: 40,
                  left: 340,
                  child: Image.asset("assets/icons/coin-red-banner.png",height: 35,width: 25,)
              ),
              Positioned(
                top: 30,
                left: 105, // Adjust as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: "WELCOME", color: Colors.white,),
                    BigText(text: "MOHIT Testing",color: Colors.white,),
                    // Add more Text widgets as needed
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          BigText(text: 'Personal Detail',color: Colors.teal,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name*',
                border: OutlineInputBorder(
                    borderRadius:BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
    );
  }
}
