import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Response.dart';

// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// final CollectionReference _Collection = _firestore.collection('usuarios');

// final CollectionReference _Collection =
//     FirebaseFirestore.instance.collection('Persona');

final _Collection = FirebaseFirestore.instance.collection('usuarios');

class FirebaseCrud {
//CRUD method here

// *******CREATE*********
  static Future<Response> addPersona({required String nombre}) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    Map<String, String> data = <String, String>{
      "nombre": nombre,
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  // static Future addPersona({required String nombre}) async {
  //   await FirebaseFirestore.instance
  //       .collection('/usuarios')
  //       .add({'nombre': nombre});
  // }

// *******READ*********

  static Stream<QuerySnapshot> readPersona() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }

// *******UPDATE*********

  static Future<Response> updatePersona({
    required String nombre,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "nombre": nombre,
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Se actualizo la Persona";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

// *******DELETE*********

  static Future<Response> deletePersona({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Eliminacion de persona Completada";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
