
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Custom/KTTextField.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';

import '../Custom/BottomMenu.dart';
import '../Custom/PostCellView.dart';
import '../Custom/PostGridCellView.dart';


class HomeView extends StatefulWidget {


  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>{

  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> posts = [];
  bool bIsList=false;
  String eve="Hola";


  void onBottonMenuPressed(int indice) {
    // TODO: implement onBottonMenuPressed
    print("------>>>> HOME!!!!!!"+indice.toString()+"---->>> ");
    setState(() {
      if(indice == 0){
        bIsList=true;
      }
      else if(indice==1){
        bIsList=false;
      }
      else if(indice==2){
        exit(0);
      }
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    descargarPosts();

  }

  void descargarPosts() async{
    CollectionReference<FbPost> ref=db.collection("Posts")
        .withConverter(fromFirestore: FbPost.fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore(),);


    QuerySnapshot<FbPost> querySnapshot=await ref.get();
    for(int i=0;i<querySnapshot.docs.length;i++){
      setState(() {
        posts.add(querySnapshot.docs[i].data());
      });

    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("KYTY"),),
      body: Center(
        child: celdasOLista(bIsList),
      ),
      bottomNavigationBar: BottomMenu(onBotonesClicked: this.onBottonMenuPressed),
      //drawer: ,
      /*body: ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: posts.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,
      ),*/
    );
  }

  /**
   *
   */
  Widget? creadorDeItemLista(BuildContext context, int index){
    return PostCellView(sText: posts[index].titulo,
      dFontSize: 30,
      iColorCode: 0,
    );
  }

  Widget? creadorDeItemMatriz(BuildContext context, int index){
    return PostGridCellView(sText: posts[index].titulo,
      dFontSize: 28,
      iColorCode: 0,
      dHeight: 300,
    );
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    //return Divider(thickness: 5,);
    return Column(
      children: [
        Divider(),
        //CircularProgressIndicator(),
        //Image.network("https://media.tenor.com/zBc1XhcbTSoAAAAC/nyan-cat-rainbow.gif")
      ],
    );
  }

  Widget celdasOLista(bool isList) {
    if (isList) {
      return ListView.separated(
          padding: EdgeInsets.all(8),
          itemCount: posts.length,
          itemBuilder: creadorDeItemLista,
          separatorBuilder: creadorDeSeparadorLista,
        );
    } else {
      return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
            itemCount: posts.length,
            itemBuilder: creadorDeItemMatriz
        );
    }
  }



}