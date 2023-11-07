
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';
import 'package:kyty/Singletone/DataHolder.dart';

import '../Custom/KTTextField.dart';

class PostCreateView extends StatefulWidget{

  @override
  State<PostCreateView> createState() => _PostCreateViewState();
}

class _PostCreateViewState extends State<PostCreateView> {
  TextEditingController tecTitulo=TextEditingController();

  TextEditingController tecCuerpo=TextEditingController();

  ImagePicker _picker=ImagePicker();

  File _imagePreview=File("");

  void onGalleryClicked() async{
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      setState(() {
        _imagePreview=File(image.path);
      });
    }
  }

  void onCameraClicked() async{
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if(image!=null){
      setState(() {
        _imagePreview=File(image.path);
      });
    }

  }

  void subirImagen() async {
    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

// Create a reference to "mountains.jpg"
    final rutaAFicheroEnNube = storageRef.child("imgs/mountains.jpg");

    try {
      await rutaAFicheroEnNube.putFile(_imagePreview);
    } on FirebaseException catch (e) {
      // ...
    }
    print("SE HA SUBIDO LA IMAGEN");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: KTTextField(tecController: tecTitulo,
                  sHint:'Escribe un titulo'),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: KTTextField(tecController: tecCuerpo,
                  sHint:'Escribe un cuerpo'),
            ),
            Image.file(_imagePreview,width: 400,height: 400,),
            Row(
              children: [
                TextButton(onPressed: onGalleryClicked, child: Text("Galeria")),
                TextButton(onPressed: onCameraClicked, child: Text("Camara")),
              ],
            ),
            TextButton(onPressed: () {
              subirImagen();


              /*FbPost postNuevo=new FbPost(
                  titulo: tecTitulo.text,
                  cuerpo: tecCuerpo.text,
                  sUrlImg: "");
              DataHolder().insertPostEnFB(postNuevo);*/

            }, child: Text("Postear"))
          ],

        ),
      ),
    );

  }
}