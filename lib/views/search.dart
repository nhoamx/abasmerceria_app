import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:merceria_app/config/api_endpoints.dart';
import 'package:merceria_app/model/product.dart';
import 'package:merceria_app/ui/card-store.dart';
import 'package:merceria_app/ui/shared/app_placeholders.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? _valueSearchBar;
  var msgController = TextEditingController();
  final List<Product> _emptyList = [];

  //Fetch data from api
  Future<List<Product>> getProducts(String name) async {
    final query = name.trim();
    if (query.isEmpty || query == 'null') {
      return _emptyList;
    }

    http.Response response;
    response = await http.get(ApiEndpoints.searchProducts(query: query),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> data = jsonResponse['data'] as List<dynamic>? ?? [];

      if (data.isEmpty) {
        return _emptyList;
      } else {
        return data
            .map((jsonResponse) => Product.fromJson(jsonResponse))
            .toList();
      }
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Search input in the top bar keeps this screen aligned with Stitch flow.
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.black),
                    onPressed: () {
                      /* Clear the search field */
                      msgController.clear();
                    },
                  ),
                  hintText: 'Buscar articulo...',
                  border: InputBorder.none),
              controller: msgController,
              onSubmitted: (value) => {
                setState(() {
                  _valueSearchBar = value;
                })
              },
            ),
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Product>>(
          future: _valueSearchBar == null
              ? Future.value(_emptyList)
              : getProducts(_valueSearchBar.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> producto = snapshot.data!;
              // debugPrint(producto.toString());
              if (producto.isNotEmpty) {
                return ListView.builder(
                  itemCount: producto.length,
                  itemBuilder: (context, index) {
                    // return CardScan(
                    //     id: producto[index].id,
                    //     name: producto[index].name,
                    //     description: producto[index].description,
                    //     image: producto[index].image,
                    //     price: producto[index].price,
                    //     sku: producto[index].sku,
                    //     opcion: "0");
                    return CardStore(
                        id: producto[index].id,
                        lista1: producto[index].lista1,
                        lista2: producto[index].lista2,
                        lista3: producto[index].lista3,
                        desc: producto[index].desc,
                        numero: producto[index].numero,
                        tamano: producto[index].tamano,
                        colores: producto[index].colores,
                        unidad: producto[index].unidad,
                        empaque: producto[index].empaque,
                        sku: producto[index].sku,
                        opcion: "0");
                    // return buildCard(
                    //     producto[index].id,
                    //     producto[index].name,
                    //     producto[index].description,
                    //     producto[index].image.toString(),
                    //     producto[index].price,
                    //     producto[index].sku);
                    // return Container(
                    //   padding: const EdgeInsets.only(right: 15.0),
                    //   width: MediaQuery.of(context).size.width - 30.0,
                    //   height: MediaQuery.of(context).size.height - 50.0,
                    //   child: GridView.count(
                    //     crossAxisCount: 2,
                    //     primary: false,
                    //     crossAxisSpacing: 10.0,
                    //     mainAxisSpacing: 15.0,
                    //     childAspectRatio: 0.8,
                    //     children: <Widget>[
                    //       buildSearchCard(
                    //           producto[index].name,
                    //           producto[index].price,
                    //           producto[index].image,
                    //           false,
                    //           false,
                    //           context)
                    //     ],
                    //   ),
                    // );
                  },
                );
              }

              return const EmptyStatePlaceholder(
                title: 'Sin resultados',
                message: 'Escribe un SKU o nombre para buscar productos.',
              );
            } else if (snapshot.hasError) {
              return ErrorPlaceholder(
                message:
                    'Algo salio mal, intenta buscar el producto nuevamente. Error: ${snapshot.error}',
                onRetry: () => setState(() {}),
              );
            }
            return const LoadingPlaceholder(label: 'Buscando productos...');
          },
        ),
      ),
    );
  }
}
