
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  void subirPost() async {
    //-----------------------INICIO DE SUBIR IMAGEN--------
    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

// Create a reference to "mountains.jpg"
    String rutaEnNube=
        "posts/"+FirebaseAuth.instance.currentUser!.uid+"/imgs/"+
            DateTime.now().millisecondsSinceEpoch.toString()+".jpg";
    print("RUTA DONDE VA A GUARDARSE LA IMAGEN: "+rutaEnNube);
    
    final rutaAFicheroEnNube = storageRef.child(rutaEnNube);
    // Create the file metadata
    final metadata = SettableMetadata(contentType: "image/jpeg");
    try {
      await rutaAFicheroEnNube.putFile(_imagePreview,metadata);

    } on FirebaseException catch (e) {
      print("ERROR AL SUBIR IMAGEN: "+e.toString());
      // ...
    }

    print("SE HA SUBIDO LA IMAGEN");

    String imgUrl=await rutaAFicheroEnNube.getDownloadURL();

    print("URL DE DESCARGA: "+imgUrl);

    //-----------------------FIN DE SUBIR IMAGEN--------

    //-----------------------INICIO DE SUBIR POST--------

    FbPost postNuevo=new FbPost(
        titulo: tecTitulo.text,
        cuerpo: tecCuerpo.text,
        sUrlImg: imgUrl);
    DataHolder().insertPostEnFB(postNuevo);

    //-----------------------POST DE SUBIR POST--------
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
              subirPost();


              /**/

            }, child: Text("Postear"))
          ],

        ),
      ),
    );

  }
}