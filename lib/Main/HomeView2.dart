
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:kyty/Custom/KTTextField.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';

import '../Custom/BottomMenu.dart';
import '../Custom/PostCellView.dart';
import '../Custom/PostGridCellView.dart';


class HomeView2 extends StatefulWidget {


  @override
  State<HomeView2> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView2>{

  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> posts = [];
  bool bIsList=false;
  String eve="Hola";
  final _advancedDrawerController = AdvancedDrawerController();


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
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Advanced Drawer Example'),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: Center(
          child: celdasOLista(bIsList),
        ),
        bottomNavigationBar: BottomMenu(onBotonesClicked: this.onBottonMenuPressed),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/flutter_logo.png',
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Profile'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.favorite),
                  title: Text('Favourites'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  void onItemListClicked(int index){
    print("EL ELEMENTO DE LA LISTA QUE ACABA DE TOCARSE ES> "+index.toString());
  }


  Widget? creadorDeItemLista(BuildContext context, int index){
    return PostCellView(sText: posts[index].titulo,
      dFontSize: 30,
      iColorCode: 0,
      iPosicion: index,
      onItemListClickedFun: onItemListClicked,
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