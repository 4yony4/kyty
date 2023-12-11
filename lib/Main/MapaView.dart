import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kyty/FirestoreObjects/FbUsuario.dart';
import 'package:kyty/Singletone/DataHolder.dart';

class MapaView extends StatefulWidget {
  @override
  State<MapaView> createState() => MapaViewState();
}

class MapaViewState extends State<MapaView> {
  //Completer<GoogleMapController> _controller = Completer();

  late GoogleMapController _controller;
  Set<Marker> marcadores = Set();
  late CameraPosition _kUser;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final Map<String,FbUsuario> tablaUsuarios = Map();

  @override
  void initState() {
    // TODO: implement initState

    _kUser = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(DataHolder().usuario!.geoloc.latitude,
            DataHolder().usuario!.geoloc.longitude),
        tilt: 59.440717697143555,
        zoom: 15.151926040649414);

    suscribirADescargaUsuarios();
    super.initState();
  }

  void suscribirADescargaUsuarios() async{
    CollectionReference<FbUsuario> ref=db.collection("Usuarios")
        .withConverter(fromFirestore: FbUsuario
        .fromFirestore,
      toFirestore: (FbUsuario post, _) => post.toFirestore(),);
    ref.snapshots().listen(usuariosDescargados, onError: descargaUsuariosError,);
  }

  void usuariosDescargados(QuerySnapshot<FbUsuario> usuariosDescargados) {
    print("NUMERO DE USUARIOS ACTUALIZADOS>>>> " +
        usuariosDescargados.docChanges.length.toString());

    Set<Marker> marcTemp = Set();

    for (int i = 0; i < usuariosDescargados.docChanges.length; i++) {
      FbUsuario temp = usuariosDescargados.docChanges[i].doc.data()!;
      tablaUsuarios[usuariosDescargados.docChanges[i].doc.id] = temp;

      Marker marcadorTemp= Marker(
        markerId: MarkerId(usuariosDescargados.docChanges[i].doc.id),
        position: LatLng(temp.geoloc.latitude,temp.geoloc.longitude),
        infoWindow: InfoWindow(
          title: temp.nombre,
          snippet:temp.edad.toString(),
        ), // InfoWindow
      );
      marcTemp.add(marcadorTemp);
    }

    setState(() {
      marcadores.addAll(marcTemp);
    });

  }

  void descargaUsuariosError(error){
    print("Listen failed: $error");
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.satellite,
        initialCameraPosition: _kUser,
        onMapCreated: (GoogleMapController controller) {
          _controller=controller;
          //_controller.complete(controller);
        },
        markers: marcadores,
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),*/
    );
  }


  Future<void> _goToTheLake() async {
    //final GoogleMapController controller = await _controller.future;


    _controller.animateCamera(CameraUpdate.newCameraPosition(_kUser));

    Marker marcador= Marker(
      markerId: MarkerId(FirebaseAuth.instance.currentUser!.uid),
      position: LatLng(DataHolder().usuario!.geoloc.latitude,
          DataHolder().usuario!.geoloc.longitude),
      infoWindow: InfoWindow(
        title: DataHolder().usuario!.nombre,
        snippet: DataHolder().usuario!.colorPelo,
      ), // InfoWindow
    );

    setState(() {
      marcadores.add(marcador);
    });

    //mapaVisible.markers.add(marcador);
  }
}