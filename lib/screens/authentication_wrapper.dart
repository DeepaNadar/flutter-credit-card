import 'package:credit_card_project/home.dart';
import 'package:credit_card_project/screens/login_screen.dart';
import 'package:credit_card_project/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  late AuthService authService;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    authService = AuthService();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    final token = await authService.getToken();
    setState(() {
      isLoggedIn = token != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return Home(authService: authService,);
    } else {
      return LoginScreen(authService: authService);
    }
  }
}