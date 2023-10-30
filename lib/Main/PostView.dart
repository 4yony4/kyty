
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';
import 'package:kyty/Singletone/DataHolder.dart';

class PostView extends StatefulWidget{
  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  FbPost _datosPost = FbPost(cuerpo: "NAN",sUrlImg: "NAN",titulo: "NAN");
  bool blPostLoaded=false;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    cargarPostGuardadoEnCache();
  }

  void cargarPostGuardadoEnCache() async{
    var temp1=await DataHolder().loadFbPost();
    //print("----------->>>>> "+temp1!.titulo);
    setState(() {

      _datosPost=temp1!;
      blPostLoaded=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: blPostLoaded ? Column(
        children: [
          Text(_datosPost.titulo),
          Text(_datosPost.cuerpo),
          Image.network(_datosPost.sUrlImg),
          TextButton(onPressed: null, child: Text("Like"))
        ],

      )
      :
      CircularProgressIndicator(),
    );

  }
}