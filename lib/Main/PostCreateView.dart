
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';
import 'package:kyty/Singletone/DataHolder.dart';

import '../Custom/KTTextField.dart';

class PostCreateView extends StatelessWidget{
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController tecTitulo=TextEditingController();
  TextEditingController tecCuerpo=TextEditingController();

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
          TextButton(onPressed: () {
            FbPost postNuevo=new FbPost(
                titulo: tecTitulo.text,
                cuerpo: tecCuerpo.text,
                sUrlImg: "");

              CollectionReference<FbPost> postsRef = db.collection("Posts")
              .withConverter(
              fromFirestore: FbPost.fromFirestore,
              toFirestore: (FbPost post, _) => post.toFirestore(),
              );

              postsRef.add(postNuevo);
          }, child: Text("Postear"))
        ],

      ),
    );

  }


}