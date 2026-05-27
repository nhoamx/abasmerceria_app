import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:merceria_app/card.dart';
import 'package:merceria_app/config/api_endpoints.dart';
import 'package:merceria_app/productos_data.dart';
import 'package:merceria_app/views/barcode_scanner_page.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
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
    response = await http.get(ApiEndpoints.searchProductBySku(sku: '823134'),
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
    final navigator = _navigatorKey.currentState;
    if (navigator == null) return;

    final scanResult = await navigator.push<String>(
      MaterialPageRoute(
        builder: (_) => const BarcodeScannerPage(),
      ),
    );

    if (!mounted || scanResult == null) return;

    setState(() => this.scanResult = scanResult);
  }

  @override
  Widget build(BuildContext context) {
    var productoData = ProductoData.getData;

    return MaterialApp(
        navigatorKey: _navigatorKey,
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
