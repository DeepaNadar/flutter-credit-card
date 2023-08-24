import 'package:credit_card_project/model/onboard_model.dart';
import 'package:credit_card_project/screens/authentication_wrapper.dart';
import 'package:credit_card_project/services/auth_service.dart';
import 'package:credit_card_project/widgets/onboard_item.dart';
import 'package:credit_card_project/widgets/slide_dots.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderLayout extends StatefulWidget {
  final AuthService authService;
  const SliderLayout({required this.authService});

  @override
  State<SliderLayout> createState() => _SliderLayoutState();
}

class _SliderLayoutState extends State<SliderLayout> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  _storeOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('SliderLayout', isViewed);
  }

  @override
  Widget build(BuildContext context) => topSliderLayout();

  Widget topSliderLayout() => Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: boardArrayList.length,
                itemBuilder: (context, i) => onBoardItem(i),
              ),
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10, bottom: 10),
                      child: TextButton(
                          onPressed: () async {
                            if (_currentPage == boardArrayList.length - 1) {
                              await _storeOnBoardInfo();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AuthenticationWrapper()));
                            }
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut);
                          },
                          child: Text(
                            "Next",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10, bottom: 10),
                      child: TextButton(
                        onPressed: () async {
                          await _storeOnBoardInfo();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AuthenticationWrapper()));
                        },
                        child: Text(
                          "Skip",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 9, 138, 244),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.bottomCenter,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < boardArrayList.length; i++)
                            if (i == _currentPage)
                              SlideDots(true)
                            else
                              SlideDots(false)
                        ]),
                  )
                ],
              ),
            ],
          ),
        ),
      );
}
