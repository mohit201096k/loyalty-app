import 'package:flutter/material.dart';
import '../widget/Big_text.dart';
import '../widget/My_app_bar.dart';
import '../widget/drawer.dart';
class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}
class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Card(child:
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: BigText(text:'There is no Notification yet to show',color: Colors.teal,),
              ))
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}


