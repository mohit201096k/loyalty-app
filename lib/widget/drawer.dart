import 'package:flutter/material.dart';
import 'package:pb_apps/Detail/enrolment.dart';
import 'package:pb_apps/login_page/login_screen.dart';
import 'package:pb_apps/pages/about_program.dart';
import 'package:pb_apps/pages/faqs.dart';
import 'package:pb_apps/pages/help_desk.dart';
import 'package:pb_apps/pages/order_history.dart';
import 'package:pb_apps/redeem_rewards/redeem_rewards.dart';
import 'package:pb_apps/widget/Big_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../provider/index_provider.dart';
class MyDrawer extends StatefulWidget {
   const MyDrawer({Key? key}) : super(key: key);
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}
class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding:EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child:UserAccountsDrawerHeader(
                accountName:const Text('PB apps'),
                accountEmail: const Text('Username:'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.teal.shade50,
                  backgroundImage: const AssetImage('assets/icons/img.png'),
                ),
              ),
            ),
            ListTile(
              leading: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>const AboutProgram())
                  );
                  final selectedIndexProvider = Provider.of<SelectedIndexProvider>(context, listen: false);
                  selectedIndexProvider.setSelectedIndex(1);
                },
                child: BigText(text:AppLocalizations.of(context)!.aboutProgram ,color: Colors.black,),
              ),
            ),
            const Divider(thickness: 2,),
            ListTile(
              leading: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>const RedeemRewards())
                  );
                  final selectedIndexProvider = Provider.of<SelectedIndexProvider>(context, listen: false);
                  selectedIndexProvider.setSelectedIndex(3);
                },
                child: BigText(text: AppLocalizations.of(context)!.redeemRewards,color: Colors.black,),
              ),
            ),
            const Divider(thickness: 2,),
            ListTile(
              leading: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>const OrderHistory())
                  );
                  final selectedIndexProvider = Provider.of<SelectedIndexProvider>(context, listen: false);
                  selectedIndexProvider.resetSelectedIndex();
                },
                child: BigText(text:'My Redemption',color: Colors.black,
                // AppLocalizations.of(context)!.myOrder,color: Colors.black,
                ),
              ),
            ),
            const Divider(thickness: 2,),
            ListTile(
              leading: TextButton(
                onPressed: () {  },
                child: BigText(text: AppLocalizations.of(context)!.myAccount,color: Colors.black,),
              ),
            ),
            const Divider(thickness: 2,),
            ListTile(
              leading: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>const Faqs()));
                  final selectedIndexProvider = Provider.of<SelectedIndexProvider>(context, listen: false);
                  selectedIndexProvider.resetSelectedIndex();
                },
                child: BigText(text: AppLocalizations.of(context)!.faqs,color: Colors.black,),
              ),
            ),
            const Divider(thickness: 2,),
            ListTile(
              leading: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>const Enrolment())
                  );
                  final selectedIndexProvider = Provider.of<SelectedIndexProvider>(context, listen: false);
                  selectedIndexProvider.resetSelectedIndex();
                },
                child: BigText(text: 'Enrollment',color: Colors.black,),
              ),
            ),
            const Divider(thickness: 2,),
            ListTile(
              leading: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>const HelpDesk())
                  );
                  final selectedIndexProvider = Provider.of<SelectedIndexProvider>(context, listen: false);
                  selectedIndexProvider.resetSelectedIndex();
                },
                child: BigText(text: AppLocalizations.of(context)!.helpdesk,color: Colors.black,),
              ),
            ),
            const Divider(thickness: 2,),
            ListTile(
              leading: TextButton(
                onPressed: () {  },
                child: BigText(text: AppLocalizations.of(context)!.termsAndCondition,color: Colors.black,),
              ),
            ),
            const Divider(thickness: 2,),
            ListTile(
              leading: TextButton(
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context)=>const Enrolment())
                  // );
                },
                child: BigText(text: AppLocalizations.of(context)!.privacyPolicy,color: Colors.black,),
              ),
            ),
            // const Divider(thickness: 2,),
            // ListTile(
            //   leading: TextButton(
            //     onPressed: () {  },
            //     child: BigText(text: AppLocalizations.of(context)!.disclaimer,color: Colors.black,),
            //   ),
            // ),
            const Divider(thickness: 2,),
            ListTile(
              leading: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>const LoginScreen())
                  );
                },
                child: BigText(text: AppLocalizations.of(context)!.logout,color: Colors.black,),
              ),
            ),
            const Divider(thickness: 2,),
            ListTile(
              leading: TextButton(
                onPressed: () {  },
                child: BigText(text: AppLocalizations.of(context)!.deleteMyAccount,color: Colors.black,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
