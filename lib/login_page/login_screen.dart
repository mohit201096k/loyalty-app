// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart';
// import 'package:pb_apps/pages/home_page.dart';
// import 'package:provider/provider.dart';
// import '../api_url/api_url.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../provider/index_provider.dart';
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//  TextEditingController mobileController = TextEditingController();
//  TextEditingController passwordController= TextEditingController();
// class _LoginScreenState extends State<LoginScreen> {
//   var _isVisible=false;
//   int resCode = 0;
//   // Future<String>
//   Future<Object> login(String username, password)async{
//     Response response= await post(
//         Uri.parse('${Constants.BASE_URL}/login'),
//         body: {
//           "username": username,
//           "password": password,
//           "type":"web"
//         }
//     );
//     if(response.statusCode==200){
//       resCode = 200;
//       var token=response.headers["authorization"];
//       await storage.write(key: 'token', value:token);
//       return response.statusCode.toString();
//
//     }else{
//       return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text("Error"),
//             content: const Text(" You Entered Incorrect Username or Password Please Try Again",
//               style: TextStyle(color: Colors.redAccent),),
//             actions: [
//               TextButton(
//                 child: const Text("OK"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//       // return "Failed to fetch data";
//     }
//   }
//   final storage = const FlutterSecureStorage();
//   String? bearerToken;
//   Future<void> getToken() async {
//     bearerToken = await storage.read(key: 'token');
//   }
//   @override
//   void initState() {
//     super.initState();
//     getToken();
//   }
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
//                     fit: BoxFit.fill)),
//           ),
//           SafeArea(
//               child: SingleChildScrollView(
//                   child: Column(
//                       children: [
//                         const SizedBox(height: 100,),
//                 Center(
//                   child: Image.asset(
//                     'assets/icons/img.png',
//                     height: 150,
//                     width: 200,
//                   ),
//                 ),
//                     const SizedBox(
//                   height: 50,
//                 ),
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             border: Border.all(color: Colors.white),
//                             borderRadius: BorderRadius.circular(12)),
//                         child: TextField(
//                           textAlign: TextAlign.center,
//                           controller: mobileController,
//                           inputFormatters: <TextInputFormatter>[
//                             FilteringTextInputFormatter.digitsOnly,
//                             LengthLimitingTextInputFormatter(10)
//                           ],
//                           keyboardType: TextInputType.number,
//                           decoration:  InputDecoration(
//                             border: InputBorder.none,
//                             hintText: AppLocalizations.of(context)!.username,
//                             suffixIcon: const Icon(Icons.account_circle_rounded)
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10,),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             border: Border.all(color: Colors.white),
//                             borderRadius: BorderRadius.circular(12)),
//                         child: TextField(
//                           textAlign: TextAlign.center,
//                           controller: passwordController,
//                           obscureText:_isVisible ?false:true,
//                           // keyboardType: TextInputType.text,
//                           decoration: InputDecoration(
//                             suffixIcon: IconButton(
//                               onPressed: (){
//                                 setState(() {
//                                   _isVisible= !_isVisible;
//                                 });
//                               },
//                               icon: Icon(
//                                 _isVisible
//                                     ?Icons.visibility
//                                     :Icons.visibility_off,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             border: InputBorder.none,
//                             hintText:AppLocalizations.of(context)!.password,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 25),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             elevation: 4,
//                             // primary: const Color(0xFFd82128),
//                             primary: const Color(0xFF008080),
//                             alignment: Alignment.center,
//                             minimumSize: const Size.fromHeight(45),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12.0)),
//                           ),
//                           onPressed:() async {
//                             var res = await login(mobileController.text, passwordController.text.toString());
//                             if (res=="200") {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder:(context)=> HomePage(),
//                                 ),
//                               );
//                               final selectedIndexProvider = Provider.of<SelectedIndexProvider>(context, listen: false);
//                               selectedIndexProvider.setSelectedIndex(0);
//                             }else{
//                               "Username or Password is invalid";
//                             }
//                           },
//                           child:  Text(
//                             AppLocalizations.of(context)!.login,
//                             style: const TextStyle(fontSize: 20),
//                           ),
//                         )
//                     ),
//                   ],
//                 ),
//                         const SizedBox(height: 50,),
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
//                               child:  Text(
//                                 AppLocalizations.of(context)!.singUp,
//                                 style: const TextStyle(fontSize: 20),
//                               ),
//                             )
//                         ),
//                      ]
//                   )
//               )
//           )
//         ])
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:pb_apps/pages/home_page.dart';
import 'package:provider/provider.dart';
import '../api_url/api_url.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../provider/index_provider.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  var _isVisible = false;
  int resCode = 0;
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<Object> login(String username, password) async {
    Response response = await post(
      Uri.parse('${Constants.BASE_URL}/login'),
      body: {
        "username": username,
        "password": password,
        "type": "web",
      },
    );
    if (response.statusCode == 200) {
      resCode = 200;
      var token = response.headers["authorization"];
      await storage.write(key: 'token', value: token);
      return response.statusCode.toString();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text(
              "You Entered Incorrect Username or Password. Please Try Again",
              style: TextStyle(color: Colors.redAccent),
            ),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return "Failed to fetch data";
    }
  }
  final storage = const FlutterSecureStorage();
  String? bearerToken;
  Future<void> getToken() async {
    bearerToken = await storage.read(key: 'token');
  }
  @override
  void initState() {
    super.initState();
    getToken();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/bg-logo.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    Image.asset(
                      'assets/icons/img.png',
                      height: 150,
                      width: 200,
                    ),
                    const SizedBox(height: 50),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: mobileController,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!.username,
                                suffixIcon: const Icon(Icons.account_circle_rounded),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: passwordController,
                              obscureText: !_isVisible ? false : true,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isVisible = !_isVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
                                border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!.password,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 4,
                              primary: const Color(0xFF008080),
                              alignment: Alignment.center,
                              minimumSize: const Size(300, 50), // Adjusted button size
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            onPressed: () async {
                              var res = await login(
                                  mobileController.text, passwordController.text.toString());
                              if (res == "200") {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                                final selectedIndexProvider =
                                Provider.of<SelectedIndexProvider>(context, listen: false);
                                selectedIndexProvider.setSelectedIndex(0);
                              } else {
                                // Handle login failure
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 4,
                          primary: const Color(0xFF008080),
                          alignment: Alignment.center,
                          minimumSize: const Size(300, 50), // Adjusted button size
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () {
                          // Handle sign-up action
                        },
                        child: Text(
                          AppLocalizations.of(context)!.singUp,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
