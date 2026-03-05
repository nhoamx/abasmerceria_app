import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merceria_app/model/correo.dart';
import 'package:merceria_app/ui/alert.dart';
import 'package:merceria_app/ui/card.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Contáctanos"),
        backgroundColor: Colors.black,
      ),
      body: const SingleChildScrollView(child: ContactForm()),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  String? _nombre;
  String? _correo;
  String? _telefono;
  String? _mensaje;
  TextStyle style = const TextStyle(fontSize: 25.0);
  Future<Correo>? _futureMail;
  bool _visibilityForm = true;
  bool _visibilityBuilder = false;

  @override
  Widget build(BuildContext context) {
    final nameField = Container(
      margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: .5)),
      child: Center(
        child: TextField(
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              hintText: 'Nombre',
              border: InputBorder.none),
          onSubmitted: (value) => {
            setState(() {
              _nombre = value;
            }),
          },
          onChanged: (value) => setState(() {
            _nombre = value;
          }),
        ),
      ),
    );

    final emailField = Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: .5)),
      child: Center(
        child: TextField(
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              hintText: 'Correo',
              border: InputBorder.none),
          onSubmitted: (value) => {
            setState(() {
              _correo = value;
            })
          },
          onChanged: (value) => setState(() {
            _correo = value;
          }),
        ),
      ),
    );

    final phoneField = Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: .5)),
      child: Center(
        child: TextField(
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.black,
              ),
              hintText: 'Teléfono',
              border: InputBorder.none),
          onSubmitted: (value) => {
            setState(() {
              _correo = value;
            })
          },
          onChanged: (value) => setState(() {
            _telefono = value;
          }),
        ),
      ),
    );

    final messageField = Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: .5)),
      child: Center(
        child: TextField(
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.message,
                color: Colors.black,
              ),
              hintText: 'Sugerencia',
              border: InputBorder.none),
          maxLines: null,
          onSubmitted: (value) => {
            setState(() {
              _mensaje = value;
            }),
          },
          onChanged: (value) => setState(() {
            _mensaje = value;
          }),
        ),
      ),
    );

    final _enviarInfo = Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        onPressed: () {
          // debugPrint("$_nombre, $_correo, $_telefono, $_mensaje");
          setState(() {
            if (_nombre == null) {
              buildAlert(context, "nombre");
            } else if (_correo == null) {
              buildAlert(context, "correo");
            } else if (_telefono == null) {
              buildAlert(context, "teléfono");
            } else if (_mensaje == null) {
              buildAlert(context, "sugerencia");
            } else {
              _visibilityBuilder = true;
              _visibilityForm = false;
              _futureMail = sendEmail(_nombre.toString(), _correo.toString(),
                  _telefono.toString(), _mensaje.toString());
            }
          });
        },
        child: const Text('Enviar sugerencia'),
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(300, 60), backgroundColor: Colors.black54),
      ),
    );

    final _titulo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Queremos escucharte".toUpperCase(),
            style: const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        const Text(
          "Compartenos tus sugerencias",
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54),
        )
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Column(
        children: [
          Visibility(
            visible: _visibilityForm,
            child: Column(children: <Widget>[
              _titulo,
              nameField,
              emailField,
              phoneField,
              messageField,
              _enviarInfo
            ]),
          ),
          Center(
            child: Visibility(
              visible: _visibilityBuilder,
              child: FutureBuilder<Correo>(
                future: _futureMail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          "Sugerencia enviada con éxito.",
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Tu sugerencia se envió con éxito. ¡Gracias por tu confianza!",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        children: <Widget>[
                          Text('${snapshot.error}'),
                        ],
                      ),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black45,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future<Correo> sendEmail(String nombre, correo, telefono, sugerencia) async {
  final response = await http.post(
    Uri.parse('https://abamerceria.clustermx.com/enviar-mensaje'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'nombre': nombre,
      'correo': correo,
      'telefono': telefono,
      'sugerencia': sugerencia,
    }),
  );

  if (response.statusCode == 200) {
    // debugPrint(response.body.toString());

    return Correo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error al enviar el correo.');
  }
}
