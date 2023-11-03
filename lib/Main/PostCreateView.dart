
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';
import 'package:kyty/Singletone/DataHolder.dart';

import '../Custom/KTTextField.dart';

class PostCreateView extends StatelessWidget{

  TextEditingController tecTitulo=TextEditingController();
  TextEditingController tecCuerpo=TextEditingController();
  ImagePicker _picker=ImagePicker();

  void onGalleryClicked() async{
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  }

  void onCameraClicked() async{
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: KTTextField(tecController: tecTitulo,
            sHint:'Escribe un titulo'),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: KTTextField(tecController: tecCuerpo,
                sHint:'Escribe un cuerpo'),
          ),
          Image.network(""),
          Row(
            children: [
              TextButton(onPressed: onGalleryClicked, child: Text("Galeria")),
              TextButton(onPressed: onCameraClicked, child: Text("Camara")),
            ],
          ),
          TextButton(onPressed: () {
            FbPost postNuevo=new FbPost(
                titulo: tecTitulo.text,
                cuerpo: tecCuerpo.text,
                sUrlImg: "");
            DataHolder().insertPostEnFB(postNuevo);

          }, child: Text("Postear"))
        ],

      ),
    );

  }


}