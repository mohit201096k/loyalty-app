// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// class AskOtp extends StatefulWidget {
//   const AskOtp({Key? key}) : super(key: key);
//   @override
//   State<AskOtp> createState() => _AskOtpState();
// }
// final _otpController = TextEditingController();
// class _AskOtpState extends State<AskOtp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         resizeToAvoidBottomInset: false,
//         body: Stack(children: [
//           Container(
//             decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage("assets/icons/bg-logo.png"),
//                     fit: BoxFit.fill)
//             ),
//           ),
//           SafeArea(
//               child: SingleChildScrollView(
//                   child: Column(
//                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     // crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Container(
//                         //   padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
//                         //   alignment: Alignment.topCenter,
//                         //   child: Image.asset(
//                         //     'assets/icons/login-merino-logow.png',
//                         //     height: 100,
//                         //     width: 100,
//                         //   ),
//                         // ),
//                         const SizedBox(height: 200,),
//                         Center(
//                           child: Image.asset(
//                             'assets/icons/Brand-logo.png',
//                             height: 150,
//                             width: 200,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 50,
//                         ),
//                         Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.grey[200],
//                                     border: Border.all(color: Colors.white),
//                                     borderRadius: BorderRadius.circular(12)),
//                                 child: TextField(
//                                   textAlign: TextAlign.center,
//                                   controller: _otpController,
//                                   inputFormatters: <TextInputFormatter>[
//                                     FilteringTextInputFormatter.digitsOnly,
//                                     LengthLimitingTextInputFormatter(6)
//                                   ],
//                                   // inputFormatters: [
//                                   //   LengthLimitingTextInputFormatter(10),
//                                   // ],
//                                   keyboardType: TextInputType.number,
//                                   decoration: const InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: 'Enter OTP',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                           ],
//                         ),
//                         Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 25),
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 elevation: 4,
//                                 // primary: const Color(0xFFd82128),
//                                 primary: const Color(0xFF008080),
//                                 alignment: Alignment.center,
//                                 minimumSize: const Size.fromHeight(45),
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12.0)),
//                               ),
//                               onPressed: () {},
//                               child: const Text(
//                                 "Sign In",
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                             )
//                         ),
//                         SizedBox(height: 20,),
//                         const TextButton(
//                             onPressed: (null),
//                             child: Text("Resend OTP",style: TextStyle(color: Colors.blue,),
//                         ),
//                         )
//                       ])
//               )
//           )
//         ])
//     );
//   }
// }
