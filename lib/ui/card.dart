import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:merceria_app/variables.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CardScan extends StatefulWidget {
  final String id;
  final String name;
  final String description;
  final String image;
  final String price;
  final String sku;
  final String opcion;

  CardScan(
      {Key? key,
      required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.price,
      required this.sku,
      required this.opcion})
      : super(key: key);

  @override
  _CardScanState createState() => _CardScanState();
}

class _CardScanState extends State<CardScan> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        child: Container(
          margin: const EdgeInsets.only(top: 20.00, bottom: 20.00),
          padding: const EdgeInsets.all(10.00),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Precio: \$${widget.price}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text("SKU: ${widget.sku}"),
              ),
              Container(
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(16.0),
              //   alignment: Alignment.centerLeft,
              //   child: Text(name),
              // ),
              Container(
                padding: const EdgeInsets.all(6.0),
                margin: const EdgeInsets.only(top: 20.0),
                alignment: Alignment.centerLeft,
                child: ListTile(
                  title: Text(
                    widget.name,
                    style: const TextStyle(
                        fontSize: 20.00, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Html(data: widget.description),
                ),
              ),
              widget.price == ""
                  ? const Text("")
                  : widget.opcion == "0"
                      ? ButtonBar(
                          children: [
                            TextButton(
                              child: const Text("Agregar al carrito"),
                              onPressed: () {
                                //Aquí asignamos a la variable global para el carrito
                                Map<String, dynamic> productoDato = {
                                  'id': widget.id,
                                  'name': widget.name,
                                  'description': widget.description,
                                  'image': widget.image,
                                  'price': widget.price,
                                  'sku': widget.sku
                                };

                                setState(() {
                                  productosDatos.add(productoDato);
                                  productsLength =
                                      productosDatos.length.toString();

                                  //sumamos
                                  totalProductos += double.parse(widget.price);
                                  // debugPrint(totalProductos.toString());
                                });

                                //Sumamos y guardamos en variable global
                                // var precioProducto = productoDato;
                                // totalProductos = precioProducto.fold(
                                //     0, (sum, element) => sum + element);
                                // debugPrint(totalProductos.toString());
                                //mostramos el snackbar
                                final snackBar = SnackBar(
                                  content: Text(
                                      'El producto se agrego correctamente.'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                            ),
                          ],
                        )
                      : ButtonBar(
                          children: <Widget>[
                            TextButton(
                              child: const Text("Eliminar del carrito"),
                              onPressed: () {
                                //Aquí asignamos a la variable global para el carrito

                                setState(() {
                                  productosDatos.removeWhere(
                                      (item) => item["id"] == widget.id);

                                  productsLength =
                                      productosDatos.length.toString();
                                  // Navigator.of(context).pop(true);

                                  //restamos
                                  totalProductos -= double.parse(widget.price);
                                  // debugPrint(totalProductos.toString());

                                  final CurvedNavigationBarState? navBarState =
                                      bottomNavigationKey.currentState;
                                  navBarState?.setPage(0);
                                });

                                final snackBar = SnackBar(
                                  content: Text(
                                      'El producto se elimino correctamente correctamente.'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                            ),
                          ],
                        )
            ],
          ),
        ));
  }
}
