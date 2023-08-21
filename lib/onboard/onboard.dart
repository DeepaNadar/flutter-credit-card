import 'package:credit_card_project/credit_cards_page.dart';
import 'package:credit_card_project/onboard/onboardModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnBoard extends StatefulWidget {
  const OnBoard({Key? key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentIndex % 2 == 0
          ? Colors.white
          : const Color.fromARGB(255, 247, 190, 221),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemCount: screens.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20,),
                      Image.asset(screens[index].img),
                      Column(
                        children: [
                          Text(
                            screens[index].text,
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                           Text(
                        screens[index].desc,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                        ],
                      ),
                     
                          Container(
                            height: 10.0,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: screens.length,
                                itemBuilder: (_, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 3.0),
                                        width: currentIndex == index ? 25.0 : 8.0,
                                        height: 8,
                                        decoration: BoxDecoration(
                                            color: currentIndex == index
                                                ? const Color.fromARGB(
                                                    255, 105, 18, 55)
                                                : const Color.fromARGB(
                                                    255, 164, 41, 95),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () async {
                              await _storeOnBoardInfo();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreditCardsPage()));
                            },
                            child: Text(
                              "Skip",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: const Color.fromARGB(255, 9, 138, 244),fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(onPressed: () async {
                               if (index == screens.length - 1) {
                                  await _storeOnBoardInfo();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CreditCardsPage()));
                                }
                                _pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeOut);
                            }, child: Text("Next",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),)),
                          )
                        ],
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
