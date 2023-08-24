import 'package:credit_card_project/model/onboard_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class onBoardItem extends StatelessWidget {
  const onBoardItem(this.index);
final int index;

  @override
  Widget build(BuildContext context) {
    var mq=MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: mq.height*.6,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(boardArrayList[index].img)
            ),
          ),
        ),
        Text(boardArrayList[index].heading,style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w500),),
        Text(boardArrayList[index].description,style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w300),textAlign: TextAlign.center,),
        SizedBox(height: 10,)
      ],
    );
  }
}