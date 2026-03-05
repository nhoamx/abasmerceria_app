import 'package:flutter/material.dart';
import 'package:merceria_app/ui/card-store.dart';
import 'package:merceria_app/variables.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: totalProductos == 0
            ? const Text("Carrito de compras")
            : Text("Carrito de compras | Total: \$$totalProductos"),
        backgroundColor: Colors.black,
      ),
      body: productosDatos.isEmpty
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Carrito vacio".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    "Escanea un producto o búscalo para agregarlo al carrito.",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: productosDatos.length,
              itemBuilder: (context, index) {
                // debugPrint(productosDatos[index].toString());
                // return CardScan(
                //     id: productosDatos[index]["id"],
                //     name: productosDatos[index]["name"],
                //     description: productosDatos[index]["description"],
                //     image: productosDatos[index]["image"],
                //     price: productosDatos[index]["price"],
                //     sku: productosDatos[index]["sku"],
                //     opcion: "1");
                return CardStore(
                    id: productosDatos[index]["id"],
                    lista1: productosDatos[index]["lista1"],
                    lista2: productosDatos[index]["lista2"],
                    lista3: productosDatos[index]["lista3"],
                    desc: productosDatos[index]["desc"],
                    numero: productosDatos[index]["numero"],
                    tamano: productosDatos[index]["tamano"],
                    colores: productosDatos[index]["colores"],
                    unidad: productosDatos[index]["unidad"],
                    empaque: productosDatos[index]["empaque"],
                    sku: productosDatos[index]["sku"],
                    opcion: "1");
              },
            ),
    );
  }
}
