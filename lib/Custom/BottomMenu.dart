import 'package:flutter/material.dart';

import '../Interfaces/BottomMenuEvents.dart';

class BottomMenu extends StatelessWidget{

  BottomMenuEvents events;

  BottomMenu({Key? key,required this.events
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () => events.onBottonMenuPressed(0), child: Icon(Icons.list,color: Colors.pink,)),
          TextButton(onPressed: () => events.onBottonMenuPressed(1), child: Icon(Icons.grid_view,color: Colors.pink,)),
          IconButton(onPressed: () => events.onBottonMenuPressed(2), icon: Image.asset("resources/logo_kyty.png"))
    ]
    );
  }

  void boton1Pressed(){
    botonesClick(0);
  }
  void boton2Pressed(){
    botonesClick(1);
  }
  void boton3Pressed(){
    botonesClick(2);
  }


        void botonesClick(int indice){
          print(indice.toString());
        }
}