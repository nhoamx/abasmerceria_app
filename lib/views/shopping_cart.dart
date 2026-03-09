import 'package:flutter/material.dart';
import 'package:merceria_app/navigation/app_routes.dart';
import 'package:merceria_app/ui/shared/app_bottom_nav.dart';
import 'package:merceria_app/ui/shared/cart_components.dart';
import 'package:merceria_app/variables.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final TextEditingController _promoController = TextEditingController();
  final Map<String, int> _quantities = {};

  @override
  void initState() {
    super.initState();
    for (final item in productosDatos) {
      final id = (item['id'] ?? '').toString();
      if (id.isNotEmpty) {
        _quantities[id] = (item['cantidad'] as int?) ?? 1;
      }
    }
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  double _priceValue(dynamic raw) {
    final text = (raw ?? '').toString().trim().replaceAll(',', '.');
    return double.tryParse(text) ?? 0;
  }

  int _quantityFor(String id) => _quantities[id] ?? 1;

  void _increaseQty(String id) {
    setState(() {
      _quantities[id] = _quantityFor(id) + 1;
    });
  }

  void _decreaseQty(String id) {
    final current = _quantityFor(id);
    if (current <= 1) return;
    setState(() {
      _quantities[id] = current - 1;
    });
  }

  void _removeItem(String id) {
    setState(() {
      productosDatos.removeWhere((item) => (item['id'] ?? '').toString() == id);
      _quantities.remove(id);
    });
  }

  double get _subtotal {
    double sum = 0;
    for (final item in productosDatos) {
      final id = (item['id'] ?? '').toString();
      final qty = _quantityFor(id);
      final price = _priceValue(item['lista2']);
      sum += price * qty;
    }
    return sum;
  }

  double get _total {
    return _subtotal;
  }

  int get _itemsCount {
    int count = 0;
    for (final item in productosDatos) {
      final id = (item['id'] ?? '').toString();
      count += _quantityFor(id);
    }
    return count;
  }

  void _onBottomTap(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, AppRoutes.home);
      return;
    }
    if (index == 1) {
      Navigator.pushNamed(context, AppRoutes.search);
      return;
    }
    Navigator.pushNamed(context, AppRoutes.preferential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Carrito'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 4),
            child: Icon(Icons.inventory_2_outlined),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(currentIndex: 0, onTap: _onBottomTap),
      body: productosDatos.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_cart_outlined, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      'Carrito vacio',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Escanea un producto o buscalo para agregarlo al carrito.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    children: [
                      ...productosDatos.map((item) {
                        final id = (item['id'] ?? '').toString();
                        final title = (item['desc'] ?? 'Producto sin descripcion').toString();
                        final ref = (item['sku'] ?? '-').toString();
                        final finalPrice = _priceValue(item['lista2']);
                        final originalPrice =
                          finalPrice == 0 ? 0.0 : (finalPrice * 1.2).toDouble();

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CartItemCard(
                            title: title,
                            reference: ref,
                            originalPrice: originalPrice,
                            finalPrice: finalPrice,
                            quantity: _quantityFor(id),
                            onRemove: () => _removeItem(id),
                            onDecrease: () => _decreaseQty(id),
                            onIncrease: () => _increaseQty(id),
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 4),
                      PromoCodeCard(
                        controller: _promoController,
                        onApply: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Codigo promocional aplicado proximamente.'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                CartSummaryCard(
                  itemCount: _itemsCount,
                  subtotal: _subtotal,
                  total: _total,
                ),
              ],
            ),
    );
  }
}
