import 'dart:developer' as developer;
import 'package:credit_card_project/model/card_model.dart';
import 'package:credit_card_project/screens/card_detail.dart';
import 'package:credit_card_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class CreditCardPage extends StatefulWidget {
  final AuthService authService;

  CreditCardPage({required this.authService});

  @override
  _CreditCardPageState createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  final ImagePicker _imagePicker = ImagePicker();
  @override
  void initState() {
    super.initState();
    fetchCardData();
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(child: StackCard()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    final image = await _imagePicker.pickImage(
                        source: ImageSource.camera);

                    if (image == null) {
                      return;
                    }
                    CardModel cardDataForApi = CardModel.newCardForApi(
                      name: "Deepa's HDFC Card",
                      cardExpiration: "3/2023",
                      cardHolder: "DEEPA NADAR",
                      cardNumber: "9876 5432 1234 5678",
                      category: "MC",
                    );

                    await widget.authService.sendDataToAPI(cardDataForApi);
                    _showSuccessSnackBar('Card created successfully!');
                  } catch (e) {
                    developer.log("Error picking image: $e");
                  }
                },
                child: Text(
                  '+ Add Card',
                  style: GoogleFonts.poppins(
                      fontSize: 16, letterSpacing: 0.5, color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 14)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchCardData() async {
    try {
      final cardData = await widget.authService.getCardData();
      final results = cardData['results'] as List<dynamic>;

      final List<CardModel> cards = results
          .map((cardJson) =>
              CardModel.fromJson(cardJson as Map<String, dynamic>))
          .toList();

      setState(() {
        cardList = cards;
      });
    } catch (e) {
      // Handle errors
      developer.log('Error fetching card data: $e');
    }
  }
}

class StackCard extends StatefulWidget {
  const StackCard({Key? key});

  @override
  State<StackCard> createState() => _StackCardState();
}

List<CardModel> cardList = [];

class _StackCardState extends State<StackCard> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemWidth: 350,
      itemHeight: 220,
      itemCount: cardList.length,
      layout: SwiperLayout.STACK,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final cardData = cardList[index];
        return _buildCreditCard(
            color: Color.fromARGB(255, 44, 44, 44),
            cardNumber: cardData.cardNumber,
            cardHolder: cardData.cardHolder,
            cardExpiration: cardData.cardExpiration,
            index: index);
      },
    );
  }

  Card _buildCreditCard(
      {required Color color,
      required String cardNumber,
      required String cardHolder,
      required String cardExpiration,
      required int index}) {
    return Card(
        elevation: 10.0,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CardDetail(
                  cardNumber: cardNumber,
                  cardHolder: cardHolder,
                  cardExpiration: cardExpiration,
                  category: cardList[index].category,
                  name: cardList[index].name,
                ),
              ),
            );
          },
          child: Container(
            height: 200,
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildLogosBlock(index),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    '$cardNumber',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontFamily: 'CourrierPrime'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildDetailsBlock(
                      label: 'CARDHOLDER',
                      value: cardHolder,
                    ),
                    _buildDetailsBlock(
                        label: 'VALID THRU', value: cardExpiration),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Row _buildLogosBlock(int index) {
    final cardData = cardList[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/images/contact_less.png",
          height: 20,
          width: 18,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            cardData.category,
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        )
      ],
    );
  }
}
