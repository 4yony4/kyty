import 'package:cloud_firestore/cloud_firestore.dart';

class FbUsuario{

  final String nombre;
  final int edad;
  final double altura;

  FbUsuario ({
    required this.nombre,
    required this.edad,
    required this.altura,
  });

  factory FbUsuario.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbUsuario(
      nombre: data?['nombre'],
      edad: data?['edad'],
      altura: data?['altura'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "nombre": nombre,
      if (edad != null) "edad": edad,
      if (altura != null) "altura": altura,
    };
  }

}