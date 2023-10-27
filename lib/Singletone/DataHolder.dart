import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FirestoreObjects/FbPost.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();

  String sNombre="Kyty DataHolder";
  late String sPostTitle;
  late FbPost selectedPost;
  FirebaseFirestore db = FirebaseFirestore.instance;

  DataHolder._internal() {

  }

  void initDataHolder(){

    sPostTitle="Titulo de Post";
    //loadCachedFbPost();
  }

  factory DataHolder(){
    return _dataHolder;

  }

  void insertPostEnFB(FbPost postNuevo){
    CollectionReference<FbPost> postsRef = db.collection("Posts")
        .withConverter(
      fromFirestore: FbPost.fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore(),
    );

    postsRef.add(postNuevo);
  }

  void saveSelectedPostInCache() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fbpost_titulo', selectedPost.titulo);
    prefs.setString('fbpost_cuerpo', selectedPost.cuerpo);
    prefs.setString('fbpost_surlimg', selectedPost.sUrlImg);
  }

  Future<FbPost> loadCachedFbPost() async{
    if(selectedPost!=null) return selectedPost;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fbpost_titulo = prefs.getString('fbpost_titulo');
    fbpost_titulo ??= "";
    String? fbpost_cuerpo = prefs.getString('fbpost_cuerpo');
    if(fbpost_cuerpo==null){
      fbpost_cuerpo="";
    }
    String? fbpost_surlimg = prefs.getString('fbpost_surlimg');
    if(fbpost_surlimg==null){
      fbpost_surlimg="";
    }
    print("SHARED PREFERENCES!!!  ----->>>>> "+fbpost_titulo);
    selectedPost=FbPost(titulo: fbpost_titulo, cuerpo: fbpost_cuerpo, sUrlImg: fbpost_surlimg);
    return selectedPost;
  }
}