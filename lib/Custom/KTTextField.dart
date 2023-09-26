import 'package:flutter/material.dart';

class KTTextField extends StatelessWidget{

  String sHint;
  TextEditingController tecController;

  KTTextField({Key? key,this.sHint="",required this.tecController}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Row row = Row(
      children: [
        Image.asset("resources/logo_kyty2.png",width: 50, height: 50),
        Flexible(
            child: TextFormField(
              decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: sHint,
            ))
        ),
        Image.asset("resources/logo_kyty2.png",width: 50, height:50),
      ],
    );
    return row;
  }

}