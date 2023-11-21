import 'package:cloud_firestore/cloud_firestore.dart';

class FbUsuario{

  final String nombre;
  final int edad;
  final double altura;
  final String colorPelo;
  final GeoPoint geoloc;

  FbUsuario ({
    required this.nombre,
    required this.edad,
    required this.altura,
    required this.colorPelo,
    required this.geoloc
  });

  factory FbUsuario.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbUsuario(
      nombre: data?['nombre'] ? data!['nombre'] : "",
      edad: data?['edad'] != null ? data!['edad'] : 0,
      altura: data?['altura'] != null ? data!['altura'] : 0,
      colorPelo:data?['colorPelo'] != null ? data!['colorPelo'] : "",
      geoloc:data?['geoloc'] != null ? data!['geoloc'] : GeoPoint(0, 0)
        
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "nombre": nombre,
      if (edad != null) "edad": edad,
      if (altura != null) "altura": altura,
      if (colorPelo != null) "colorPelo": colorPelo,
      if (geoloc != null) "geoloc": geoloc,
    };
  }

}