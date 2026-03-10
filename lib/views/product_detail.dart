import 'package:flutter/material.dart';
import 'package:merceria_app/model/product.dart';
import 'package:merceria_app/theme/app_theme.dart';
import 'package:merceria_app/variables.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;

  double _priceValue(String raw) {
    return double.tryParse(raw.trim().replaceAll(',', '.')) ?? 0;
  }

  String _money(double value) => '\$${value.toStringAsFixed(2)}';

  void _addToCart() {
    final exists = productosDatos
        .any((item) => (item['id'] ?? '').toString() == widget.product.id);

    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El producto ya esta en el carrito.')),
      );
      return;
    }

    final productoDato = {
      'id': widget.product.id,
      'lista1': widget.product.lista1,
      'lista2': widget.product.lista2,
      'lista3': widget.product.lista3,
      'desc': widget.product.desc,
      'numero': widget.product.numero,
      'tamano': widget.product.tamano,
      'colores': widget.product.colores,
      'unidad': widget.product.unidad,
      'empaque': widget.product.empaque,
      'sku': widget.product.sku,
      'cantidad': _quantity,
      'opcion': '0',
    };

    setState(() {
      productosDatos.add(productoDato);
      productsLength = productosDatos.length.toString();
      totalProductos += _priceValue(widget.product.lista2) * _quantity;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Producto agregado al carrito.')),
    );
  }

  Widget _specRow(IconData icon, String label, String value) {
    final showValue = value.trim().isEmpty ? '-' : value.trim();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withValues(alpha: 0.9),
                ),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            showValue,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final unitPrice = _priceValue(p.lista1);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detalle de Producto',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border(
                        bottom:
                            BorderSide(color: Theme.of(context).dividerColor),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 64,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SKU: ${p.sku.isEmpty ? '-' : p.sku}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          p.desc.isEmpty ? 'Producto sin descripcion' : p.desc,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: 22,
                                    height: 1.15,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Theme.of(context).dividerColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Precio unitario',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    _money(unitPrice),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontSize: 44,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.accent,
                                          height: 0.98,
                                        ),
                                  ),
                                  const SizedBox(width: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 7),
                                    child: Text(
                                      '/ unidad',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          'Especificaciones',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Theme.of(context).dividerColor),
                          ),
                          child: Column(
                            children: [
                              _specRow(Icons.tag, 'Numero', p.numero),
                              Divider(
                                height: 1,
                                color: Theme.of(context).dividerColor,
                              ),
                              _specRow(Icons.straighten, 'Talla', p.tamano),
                              Divider(
                                height: 1,
                                color: Theme.of(context).dividerColor,
                              ),
                              _specRow(
                                  Icons.palette_outlined, 'Colores', p.colores),
                              Divider(
                                height: 1,
                                color: Theme.of(context).dividerColor,
                              ),
                              _specRow(
                                  Icons.category_outlined, 'Unidad', p.unidad),
                              Divider(
                                height: 1,
                                color: Theme.of(context).dividerColor,
                              ),
                              _specRow(
                                Icons.inventory_2_outlined,
                                'Empaque',
                                p.empaque,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  top: BorderSide(color: Theme.of(context).dividerColor),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: _quantity > 1
                              ? () => setState(() => _quantity--)
                              : null,
                          icon: const Icon(Icons.remove),
                        ),
                        SizedBox(
                          width: 28,
                          child: Text(
                            '$_quantity',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        IconButton(
                          onPressed: () => setState(() => _quantity++),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: _addToCart,
                        icon: const Icon(Icons.shopping_cart_outlined),
                        label: const Text(
                          'Agregar al carrito',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
