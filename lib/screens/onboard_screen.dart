import 'package:credit_card_project/services/auth_service.dart';
import 'package:credit_card_project/user_interface/slider_layout.dart';
import 'package:flutter/material.dart';


class onBoardScreen extends StatefulWidget {
  final AuthService authService;
  const onBoardScreen({required this.authService});

  @override
  State<onBoardScreen> createState() => _onBoardScreenState();
}

class _onBoardScreenState extends State<onBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: onBoardingBody(),
    );
  }
Widget onBoardingBody() => Container(
child: SliderLayout(authService: widget.authService,),
);
}