import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kyty/Singletone/DataHolder.dart';

class MapaView extends StatefulWidget {
  @override
  State<MapaView> createState() => MapaViewState();
}

class MapaViewState extends State<MapaView> {
  //Completer<GoogleMapController> _controller = Completer();

  late GoogleMapController _controller;
  Set<Marker> marcadores = Set();


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.satellite,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller=controller;
          //_controller.complete(controller);
        },
        markers: marcadores,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }


  Future<void> _goToTheLake() async {
    //final GoogleMapController controller = await _controller.future;
    CameraPosition _kUser = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(DataHolder().usuario.geoloc.latitude,
            DataHolder().usuario.geoloc.longitude),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    _controller.animateCamera(CameraUpdate.newCameraPosition(_kUser));

    Marker marcador= Marker(
      markerId: MarkerId(FirebaseAuth.instance.currentUser!.uid),
      position: LatLng(DataHolder().usuario.geoloc.latitude,
          DataHolder().usuario.geoloc.longitude),
      infoWindow: InfoWindow(
        title: DataHolder().usuario.nombre,
        snippet: DataHolder().usuario.colorPelo,
      ), // InfoWindow
    );

    setState(() {
      marcadores.add(marcador);
    });

    //mapaVisible.markers.add(marcador);
  }
}