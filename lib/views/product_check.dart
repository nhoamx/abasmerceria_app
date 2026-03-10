import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner_plus/flutter_barcode_scanner_plus.dart';
import 'package:merceria_app/config/api_endpoints.dart';
import 'package:merceria_app/model/product.dart';
import 'package:merceria_app/ui/card-store.dart';

class ProductCheck extends StatefulWidget {
  const ProductCheck({Key? key}) : super(key: key);

  @override
  State<ProductCheck> createState() => _ProductCheckState();
}

class _ProductCheckState extends State<ProductCheck> {
  String? scanResult;
  bool _didAutoScan = false;

  @override
  void initState() {
    super.initState();

    // Open scanner immediately when entering this screen.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _didAutoScan) return;
      _didAutoScan = true;
      scanBarCode();
    });
  }

  //Fetch data from api
  Future fetchData(String sku) async {
    final value = sku.trim();
    if (value.isEmpty || value == 'null' || value == '-1') {
      return null;
    }

    http.Response response;
    response = await http.get(ApiEndpoints.searchProductBySku(sku: value),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> data = jsonResponse['data'] as List<dynamic>? ?? [];

      if (data.isEmpty) {
      } else {
        return Product.fromJson(data[0] as Map<String, dynamic>);
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF0EA5E9), width: 1.2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x140F172A),
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Como escanear',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '1. Coloca el codigo de barras frente a la camara.\n'
                    '2. Asegurate de tener buena luz y enfocar el codigo.\n'
                    '3. Al detectar el SKU se mostrara la informacion del producto.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF334155),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            FutureBuilder<dynamic>(
                future: fetchData('$scanResult'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
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
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Algo salio mal, intenta escanear de nuevo o buscar manualmente. Error: ${snapshot.error}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Presiona el boton para iniciar el escaneo de un producto.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF334155),
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                scanBarCode();
              },
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Escanear ahora'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                backgroundColor: const Color(0xFF0F172A),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
