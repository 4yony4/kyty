
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';
import 'package:kyty/Singletone/DataHolder.dart';

class PostView extends StatefulWidget{
  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late FbPost selectedPost;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();

    setState(() async {
      selectedPost=await DataHolder().loadCachedFbPost();
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