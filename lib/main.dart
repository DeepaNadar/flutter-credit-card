import 'dart:io';
import 'package:credit_card_project/screens/authentication_wrapper.dart';
import 'package:credit_card_project/screens/onboard_screen.dart';
import 'package:credit_card_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';



int? isViewed;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs=await SharedPreferences.getInstance();
  AuthService authService = AuthService();
  isViewed=prefs.getInt('SliderLayout');
  runApp(MyApp(authService: authService,));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  const MyApp({required this.authService});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: 
      Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark
    ));
    return MaterialApp(
      title: "",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        platform: TargetPlatform.iOS
      ),
      home: isViewed !=0 ? onBoardScreen(authService: authService,) : AuthenticationWrapper(),
    );
  }
}
