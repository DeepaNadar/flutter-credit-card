import 'package:credit_card_project/credit_cards_page.dart';
import 'package:credit_card_project/screens/login_screen.dart';
import 'package:credit_card_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  final AuthService authService;
  const Home({required this.authService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
          onPressed: () async {
            await authService.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen(authService: authService)),
                );
          },
          icon: Icon(Icons.logout_rounded,color: Colors.black,)
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Home Page",style: GoogleFonts.poppins(fontSize: 20,color: Colors.black),),
      ),
      body: CreditCardPage(authService: authService,),
    );
  }
}