import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merceria_app/card.dart';
import 'package:merceria_app/productos_data.dart';

import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter_barcode_scanner_plus/flutter_barcode_scanner_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? scanResult;
  String? stringResponse;
  List<Map<String, dynamic>> value = [];

  @override
  void initState() {
    super.initState();
  }

  //Fetch data from api
  Future fetchData() async {
    http.Response response;
    response = await http.get(
        Uri.parse('https://abamerceria.clustermx.com/busqueda-sku?sku=823134'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      jsonDecode(response.body);
      // var userData = Product.fromJson(jsonResponse[0]);
    } else {
      // debugPrint("Error");
    }
  }

  //Scan Bar code
  Future scanBarCode() async {
    String scanResult;

    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          "#FF6666", "Cancelar", true, ScanMode.BARCODE);
      // debugPrint(scanResult);
    } on PlatformException {
      scanResult = "Failed to get platform Version";
    }

    if (!mounted) return;

    setState(() => this.scanResult = scanResult);
  }

  @override
  Widget build(BuildContext context) {
    var productoData = ProductoData.getData;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Escanea tus precios'),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      scanBarCode();
                    },
                    icon: const Icon(Icons.scanner)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.help))
              ],
            ),
            body: ListView.builder(
              itemCount: productoData.length,
              itemBuilder: (context, index) {
                return CardLayout(
                    titulo: productoData[index]["producto"].toString(),
                    subtitulo: productoData[index]["descripcion"].toString(),
                    precio: productoData[index]["precio"].toString());
              },
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  // Add your onPressed code here!
                  fetchData();
                  // double sum = productoData.fold(
                  //     0,
                  //     (sum, element) =>
                  //         sum + double.parse(element['precio'].toString()));
                  // debugPrint(sum.toStringAsFixed(2));
                },
                backgroundColor: Colors.green,
                child: const Icon(Icons.payment))));
  }
}
