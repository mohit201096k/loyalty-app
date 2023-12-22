import 'package:flutter/material.dart';
import 'package:pb_apps/widget/Big_text.dart';
import 'package:pb_apps/widget/drawer.dart';
import '../widget/My_app_bar.dart';
class PointHistory extends StatefulWidget {
  const PointHistory({Key? key}) : super(key: key);
  @override
  State<PointHistory> createState() => _PointHistoryState();
}
class _PointHistoryState extends State<PointHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
      ),
      body: Column(
      mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration:  BoxDecoration(
                color: Colors.teal.shade400,
                borderRadius: const BorderRadius.only(
                    topLeft:Radius.circular(5),topRight:Radius.circular(5)
                )
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      _buildColoredImage('assets/icons/my-account.png', ),
                      const SizedBox(width: 10,),
                      Column(
                        children: [
                          BigText(text: '250783',color: Colors.white,),
                          const SizedBox(width: 10,),
                          const Text('Total Points Credited',
                            style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w200),)
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      _buildColoredImage('assets/icons/my-account.png', ),
                      const SizedBox(width: 10,),
                      Column(
                        children: [
                          BigText(text: '86088',color: Colors.white,),
                          const SizedBox(width: 10,),
                          const Text('Total Points Debited',
                            style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w200),)
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildColoredImage('assets/icons/my-account.png', ),
                      const SizedBox(width: 10,),
                      Column(
                        children: [
                          BigText(text: '164695',color: Colors.white,),
                          const SizedBox(width: 10,),
                         const Text('Available Balance',
                           style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w200),)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50,),
          Image.asset('assets/images/points-history-image.png',width: 300,)
        ],
      ),
      drawer: const MyDrawer(),
    );
  }
}
Widget _buildColoredImage(String imagePath,  ) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top:2),
        child: ColorFiltered(
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          child: Image.asset(imagePath,height: 35, ),
        ),
      ),
    ],
  );
}