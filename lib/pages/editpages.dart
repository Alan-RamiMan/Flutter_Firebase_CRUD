import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/listpages.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/models/Persona.dart';

import '../services/firebase_crud.dart';

class EditPage extends StatefulWidget {
  final Persona? persona;
  EditPage({this.persona});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditPage();
  }
}

class _EditPage extends State<EditPage> {
  final _persona_apellido = TextEditingController();
  final _persona_correo = TextEditingController();
  final _persona_direccion = TextEditingController();
  // final _persona_f_nacimiento = TextEditingController();
  // final _persona_genero = TextEditingController();
  final _persona_nombre = TextEditingController();
  final _persona_rut = TextEditingController();
  final _docid = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _docid.value = TextEditingValue(text: widget.persona!.uid.toString());
    _persona_nombre.value =
        TextEditingValue(text: widget.persona!.nombre.toString());
    _persona_apellido.value =
        TextEditingValue(text: widget.persona!.apellido.toString());
    _persona_rut.value = TextEditingValue(text: widget.persona!.rut.toString());
    _persona_correo.value =
        TextEditingValue(text: widget.persona!.correo.toString());
    _persona_direccion.value =
        TextEditingValue(text: widget.persona!.direccion.toString());
  }

  @override
  Widget build(BuildContext context) {
    final DocIDField = TextField(
        controller: _docid,
        readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final nombreField = TextFormField(
        controller: _persona_nombre,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Nombre",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final apellidoField = TextFormField(
        controller: _persona_apellido,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Apellido",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final rutField = TextFormField(
        controller: _persona_rut,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Rut",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final correoField = TextFormField(
        controller: _persona_correo,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Correo",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final direccionField = TextFormField(
        controller: _persona_direccion,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Direccion",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final viewListbutton = TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ListPage(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
        },
        child: const Text('Volver a Home'));

    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var response = await FirebaseCrud.updatePersona(
                nombre: _persona_nombre.text,
                docId: _docid.text,
                apellido: _persona_apellido.text,
                rut: _persona_rut.text,
                correo: _persona_correo.text,
                direccion: _persona_direccion.text);
            if (response.code != 200) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            }
          }
        },
        child: Text(
          "Update",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Editar Datos de la Persona'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DocIDField,
                  const SizedBox(height: 25.0),
                  nombreField,
                  const SizedBox(height: 35.0),
                  SaveButon,
                  const SizedBox(height: 15.0),
                  viewListbutton,
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
