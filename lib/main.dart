
import 'package:flutter/material.dart';
import 'package:pb_apps/login_page/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pb_apps/provider/cart_provider.dart';
import 'package:pb_apps/provider/index_provider.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Locale systemLocale = WidgetsBinding.instance.window.locale;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => SelectedIndexProvider()),
        // Add other providers if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PB apps',
        locale: systemLocale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
          Locale('hi'),
          // Add more locales here
        ],
        theme: ThemeData(
          primarySwatch: Colors.teal,
          // primaryIconTheme: const IconThemeData(color: Colors.black)
        ),
        home:  const LoginScreen(),
      ),
    );
  }
}
