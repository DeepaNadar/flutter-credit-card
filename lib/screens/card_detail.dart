import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDetail extends StatelessWidget {
  final String cardNumber;
  final String cardHolder;
  final String cardExpiration;
  final String category;
  final String name;

  CardDetail({
    required this.cardNumber,
    required this.cardHolder,
    required this.cardExpiration,
    required this.category,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Card Details",
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "Name : ",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w400), 
                ),
                Text(
                  "$name",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w300),maxLines: 2,
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text(
                  "Card Holder : ",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  "$cardHolder",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w300),maxLines: 2,
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text(
                  "Card Expiration : ",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  "$cardExpiration",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w300),maxLines: 2,
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text(
                  "Card Number : ",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  "$cardNumber",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w300),maxLines: 2,
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text(
                  "Category : ",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  "$category",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w300),maxLines: 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
