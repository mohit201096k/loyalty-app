//
// import 'package:flutter/material.dart';
// import 'package:pb_apps/pages/help_desk.dart';
// import 'package:pb_apps/pages/home_page.dart';
// import 'package:pb_apps/redeem_rewards/redeem_rewards.dart';
// class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
//   const MyAppBar({Key? key}) : super(key: key);
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
//   @override
//   MyAppBarState createState() => MyAppBarState();
// }
// class MyAppBarState extends State<MyAppBar> {
//   int _selectedIconIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       iconTheme: const IconThemeData(
//         color: Colors.black,
//       ),
//       backgroundColor: Colors.white,
//       elevation: 0,
//       titleSpacing: 0,
//       actions: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildIcon(0, 'assets/icons/home-icon.png'),
//               const SizedBox(width: 42),
//               _buildIcon(1, 'assets/icons/program-icon.png'),
//               const SizedBox(width: 42),
//               _buildIcon(2, 'assets/icons/my-account.png'),
//               const SizedBox(width: 42),
//               _buildIcon(3, 'assets/icons/rewards-icon.png'),
//               const SizedBox(width: 42),
//               _buildIcon(4, 'assets/icons/notification-icon.png'),
//               const SizedBox(width: 20),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//   Widget _buildIcon(int index, String imagePath) {
//     return InkWell(
//       onTap: () {
//         // setState(() {
//         //   _selectedIconIndex = index;
//         // });
//         if (index == 0) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) =>const HomePage()),
//           );
//         } else if (index == 1) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const HelpDesk()),
//           );
//         }
//         else if (index == 3){
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) =>const RedeemRewards()),
//           );
//         }
//         setState(() {
//           _selectedIconIndex = index;
//         });
//       },
//       child: ColorFiltered(
//         colorFilter: ColorFilter.mode(
//           _selectedIconIndex == index ? Colors.teal : Colors.black,
//           BlendMode.srcIn,
//         ),
//         child: Image.asset(
//           imagePath,
//           height: 24,
//           width: 24,
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:pb_apps/pages/about_program.dart';
import 'package:pb_apps/pages/notification.dart';
import 'package:pb_apps/pages/points_history.dart';
import 'package:provider/provider.dart';
import 'package:pb_apps/pages/home_page.dart';
import 'package:pb_apps/redeem_rewards/redeem_rewards.dart';
import '../provider/index_provider.dart';
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final selectedIndexProvider = Provider.of<SelectedIndexProvider>(context);
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIcon(0, 'assets/icons/home-icon.png', context,
                  selectedIndexProvider),
              const SizedBox(width: 42),
              _buildIcon(1, 'assets/icons/program-icon.png', context,
                  selectedIndexProvider),
              const SizedBox(width: 42),
              _buildIcon(2, 'assets/icons/my-account.png', context,
                  selectedIndexProvider),
              const SizedBox(width: 42),
              _buildIcon(3, 'assets/icons/rewards-icon.png', context,
                  selectedIndexProvider),
              const SizedBox(width: 42),
              _buildIcon(4, 'assets/icons/notification-icon.png', context,
                  selectedIndexProvider),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildIcon(int index, String imagePath, BuildContext context,
      SelectedIndexProvider provider) {
    final selectedIndexProvider = provider.selectedIndex;
    Color iconColor = Colors.black;
    if (selectedIndexProvider == index) {
      iconColor = Colors.teal;
    }
    return InkWell(
      onTap: () {
        provider.setSelectedIndex(index);
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutProgram()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PointHistory()),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RedeemRewards()),
          );
        }
        else if (index == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationPage()),
          );
        }
      },
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          iconColor,
          BlendMode.srcIn,
        ),
        child: Image.asset(
          imagePath,
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}