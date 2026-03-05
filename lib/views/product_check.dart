import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:merceria_app/model/product.dart';
import 'package:merceria_app/ui/card-store.dart';
import 'package:merceria_app/ui/card.dart';

class ProductCheck extends StatefulWidget {
  const ProductCheck({Key? key}) : super(key: key);

  @override
  State<ProductCheck> createState() => _ProductCheckState();
}

class _ProductCheckState extends State<ProductCheck> {
  String? scanResult;

  //Fetch data from api
  Future fetchData(String sku) async {
    http.Response response;
    response = await http.get(
        Uri.parse('https://abamerceria.clustermx.com/busqueda-sku?sku=$sku'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse.toString() == "[]") {
      } else {
        return Product.fromJson(jsonResponse[0]);
      }
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
    } on PlatformException {
      scanResult = "Failed to get platform Version";
    }
    if (!mounted) return;

    setState(() => this.scanResult = scanResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Escanear producto"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder<dynamic>(
                future: fetchData('$scanResult'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // return CardScan(
                    //     id: snapshot.data!.id,
                    //     name: snapshot.data!.name,
                    //     description: snapshot.data!.description,
                    //     image: snapshot.data!.image,
                    //     price: snapshot.data!.price,
                    //     sku: snapshot.data!.sku,
                    //     opcion: "0");
                    return CardStore(
                        id: snapshot.data!.id,
                        lista1: snapshot.data!.lista1,
                        lista2: snapshot.data!.lista2,
                        lista3: snapshot.data!.lista3,
                        desc: snapshot.data!.desc,
                        numero: snapshot.data!.numero,
                        tamano: snapshot.data!.tamano,
                        colores: snapshot.data!.colores,
                        unidad: snapshot.data!.unidad,
                        empaque: snapshot.data!.empaque,
                        sku: snapshot.data!.sku,
                        opcion: "0");
                    // return buildCard(
                    //     snapshot.data!.id,
                    //     snapshot.data!.name,
                    //     snapshot.data!.description,
                    //     snapshot.data!.image.toString(),
                    //     snapshot.data!.price,
                    //     snapshot.data!.sku);

                    // return Text(snapshot.data!.name.toString());
                  } else if (snapshot.hasError) {
                    return Text(
                        'Algo salio mal, intenta escanear de nuevo o buscar el producto manualmente. Error: ${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  // return const CircularProgressIndicator();
                  return Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: const Center(
                        child: Text(
                      "Escanea un producto, si no lo encuentras, puedes dar clic en la segunda opción de nuestro menu.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    )),
                  );
                }),
            Container(
              margin: const EdgeInsets.only(top: 25.0),
              child: ElevatedButton(
                onPressed: () {
                  scanBarCode();
                },
                child: const Text('Escanea un producto'),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 60),
                    backgroundColor: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
