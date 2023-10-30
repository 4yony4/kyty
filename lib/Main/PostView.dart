
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';
import 'package:kyty/Singletone/DataHolder.dart';

class PostView extends StatefulWidget{
  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  FbPost selectedPost = FbPost(cuerpo: "",sUrlImg: "",titulo: "");

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    cargarPostGuardadoEnCache();
    //setState(() async {
      //selectedPost=await DataHolder().loadCachedFbPost();
    //});

  }

  void cargarPostGuardadoEnCache() async{
    var temp1=await DataHolder().loadCachedFbPost();
    print("----------->>>>> "+temp1!.titulo);
    setState(() {
      selectedPost=temp1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          Text(selectedPost.titulo),
          Text(selectedPost.cuerpo),
          Image.network(selectedPost.sUrlImg),
          TextButton(onPressed: null, child: Text("Like"))
        ],

      ),
    );

  }
}