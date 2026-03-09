class Product {
  // final String id;
  // final String name;
  // final String description;
  // final String image;
  // final String price;
  // final String sku;
  final String id;
  final String lista1;
  final String lista2;
  final String lista3;
  final String desc;
  final String numero;
  final String tamano;
  final String colores;
  final String unidad;
  final String empaque;
  final String sku;

  Product({
    // required this.id,
    // required this.name,
    // required this.description,
    // required this.image,
    // required this.price,
    // required this.sku,
    required this.id,
    required this.lista1,
    required this.lista2,
    required this.lista3,
    required this.desc,
    required this.numero,
    required this.tamano,
    required this.colores,
    required this.unidad,
    required this.empaque,
    required this.sku,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final String color;
    if (json['colors'] == null && json['colores'] == null) {
      color = 'Sin color disponible';
    } else {
      color = (json['colors'] ?? json['colores']).toString();
    }

    return Product(
      // id: json['id'].toString(),
      // name: json['name'],
      // description: json['short_description'],
      // image: json["images"][0]["src"],
      // price: json['price'],
      // sku: json['sku'],
      id: json['id'].toString(),
      lista1: (json['price_list_1'] ?? json['lista1'] ?? '').toString(),
      lista2: (json['price_list_2'] ?? json['lista2'] ?? '').toString(),
      lista3: (json['price_list_3'] ?? json['lista3'] ?? '').toString(),
      desc: (json['description'] ?? json['desc'] ?? '').toString(),
      numero: (json['number'] ?? json['numero'] ?? '').toString(),
      tamano: (json['size'] ?? json['tamano'] ?? '').toString(),
      colores: color,
      unidad: (json['unit'] ?? json['unidad'] ?? '').toString(),
      empaque: (json['packaging'] ?? json['empaque'] ?? '').toString(),
      sku: (json['sku'] ?? '').toString(),
    );
  }
}
