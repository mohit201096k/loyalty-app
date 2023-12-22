import 'package:flutter/material.dart';
import 'package:pb_apps/widget/Big_text.dart';
import 'package:pb_apps/widget/My_app_bar.dart';
import 'package:pb_apps/widget/drawer.dart';
class HelpDesk extends StatelessWidget {
  const HelpDesk({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BigText(text: 'Helpdesk Number & Support ID',color: Colors.teal,),
           const SizedBox(height: 50,),
           Padding(
             padding: const EdgeInsets.only(left: 20,right: 20),
             child: Container(
               height: 280,
               width: double.infinity,
               decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(10)),
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 20),
                     child: Image.asset('assets/icons/helpdesk-phone.png',height: 80,),
                   ),
                   const SizedBox(height: 20,),
                   BigText(text: '8279396233'),
                   const SizedBox(height: 20,),
                   BigText(text: 'HELPDESK TIMINGS',color: Colors.teal,),
                   const Text('Monday - Friday'),
                   const Text('10:00 AM - 06:30 PM'),
                 ],
               ),
             ),
           ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
              child: Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Image.asset('assets/icons/helpdesk-mail.png',height: 40,),
                    ),
                    const SizedBox(height: 20,),
                    const Text('support@pbapps.com')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
