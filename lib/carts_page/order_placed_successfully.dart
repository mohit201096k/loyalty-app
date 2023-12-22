import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pb_apps/widget/My_app_bar.dart';
import 'package:pb_apps/widget/drawer.dart';
import '../pages/home_page.dart';
class OrderPlacedSuccessfully extends StatelessWidget {
  const OrderPlacedSuccessfully({Key? key}) : super(key: key);
  void navigateToHomePage(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    navigateToHomePage(context);
    return  Scaffold(
      appBar: const MyAppBar(),
      // backgroundColor: Colors.green,
      body: Center(
        child:  Container(
          height: 250,
          width: 300,
          decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Image.asset(
                    'assets/icons/order.gif',height: 150,
                    // 'assets/icons/order_placed.png'
                ),
              ),
              const Text('Redeem Points Successfully 😊 !',style: TextStyle(color: Colors.green,fontSize:20),),
              const Text('Thank you',style: TextStyle(color: Colors.green,fontSize:20)),
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
