import 'package:flutter/material.dart';

class OnBoardModel{
  String img;
  String text;
  String desc;
  Color bg;
  Color button;

OnBoardModel({
  required this.img,
  required this.text,
  required this.desc,
  required this.bg,
  required this.button,
});
}

List<OnBoardModel> screens=<OnBoardModel>[
OnBoardModel(
  img: "assets/images/onBoarding1.png", 
  text: "Your Wallet's New Best Friend.", 
  desc: "Welcome to a smarter way to handle your finances.", 
  bg: const Color.fromARGB(255, 179,189,196), 
  button: Colors.black
  ),
  OnBoardModel(
    img: "assets/images/onBoarding2.png", 
  text: "Elevate Your Financial Strategy.", 
  desc: "Simplify Money Management and Financial Wellness at Your Fingertips", 
  bg: const Color.fromARGB(255, 217,191,199), 
  button: Colors.black
  ),
  OnBoardModel(
    img: "assets/images/onBoarding3.png", 
  text: "Experience Financial Harmony.", 
  desc: "Revolutionize Your Money Journey and Step into a Brighter Financial Future.", 
  bg: const Color.fromARGB(255, 170,203,210), 
  button: Colors.black
  ),
];

