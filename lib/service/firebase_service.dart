import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> guardarCiudad(String nombre) async {
    if (nombre.isNotEmpty) {
      // Agregar nueva ciudad a la colección
      await _firestore.collection('Ciudad').add({
        'nombre': nombre,
        'status': 'activo', // Puedes cambiar esto según tus necesidades
      });
    }
  }

  Future<void> eliminarCiudad(String ciudadId) async {
    // Eliminar ciudad de la colección
    await _firestore.collection('Ciudad').doc(ciudadId).delete();
  }

  Future<void> actualizarCiudad(String ciudadId, String nuevoNombre) async {
    // Actualizar nombre de la ciudad en la colección
    await _firestore.collection('Ciudad').doc(ciudadId).update({
      'nombre': nuevoNombre,
    });
  }

  Stream<QuerySnapshot> obtenerCiudades() {
    // Obtener stream de ciudades
    return _firestore.collection('Ciudad').snapshots();
  }
}


//CONEXION DEL MOTORISTA


