import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostCellView extends StatelessWidget{

  final String sText;
  final int iColorCode;
  final double dFontSize;

  const PostCellView({super.key,
    required this.sText,
    required this.iColorCode,
    required this.dFontSize});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.amber[iColorCode],
      child: Row(
        children: [
          Image.asset("resources/logo_kyty2.png",width: 70,
              height: 70),
          Text(sText,style: TextStyle(fontSize: dFontSize)),
          TextButton(onPressed: null, child: Text("+",style: TextStyle(fontSize: dFontSize)))
        ],
      )
      
    );
  }



}