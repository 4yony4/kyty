import 'package:flutter/material.dart';


class BottomMenu extends StatelessWidget{

  Function(int indice)? onBotonesClicked;
  Function(String nombre)? onPressed=null;

  BottomMenu({Key? key,required this.onBotonesClicked
  }) : super(key: key);

  void fNombre1(String nombre){
    print("DAM1 --->>>"+nombre);
  }

  void fNombre2(String nombre){
    print("DAM2 --->>>"+nombre);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    onPressed=fNombre1;
    onPressed!("Yony");//=fNombre1("Yony")
    onPressed=fNombre2;
    onPressed!("Marco");//=fNombre2("Marco")
    onPressed!("Elena");//=fNombre2("Elena")
    onPressed=fNombre1;
    onPressed!("Carlos");//=fNombre1("Carlos")
    onPressed!("David");//=fNombre1("David")

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () => onBotonesClicked!(0), child: Icon(Icons.list,color: Colors.pink,)),
          TextButton(onPressed: () => onBotonesClicked!(1), child: Icon(Icons.grid_view,color: Colors.pink,)),
          IconButton(onPressed: () => onBotonesClicked!(2), icon: Image.asset("resources/logo_kyty.png"))
    ]
    );
  }
}