import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merceria_app/config/api_endpoints.dart';
import 'package:merceria_app/navigation/app_routes.dart';
import 'package:merceria_app/model/product.dart';
import 'package:merceria_app/ui/shared/app_bottom_nav.dart';
import 'package:merceria_app/ui/shared/app_placeholders.dart';
import 'package:merceria_app/ui/shared/search_components.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<Product>>? _searchFuture;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<Product>> _getProducts(String text) async {
    final query = text.trim();
    if (query.isEmpty || query == 'null') {
      return const [];
    }

    final response = await http.get(ApiEndpoints.searchProducts(query: query),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> data = jsonResponse['data'] as List<dynamic>? ?? [];

      return data
          .map((jsonResponse) =>
              Product.fromJson(jsonResponse as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  void _startSearch([String? value]) {
    final query = (value ?? _searchController.text).trim();
    if (query.isEmpty) return;

    setState(() {
      _searchController.text = query;
      _searchFuture = _getProducts(query);
    });
  }

  double _price(String raw) {
    return double.tryParse(raw.replaceAll(',', '.')) ?? 0;
  }

  void _onBottomTap(int index) {
    if (index == 1) return;
    if (index == 0) {
      Navigator.pushNamed(context, AppRoutes.home);
      return;
    }
    Navigator.pushNamed(context, AppRoutes.preferential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Busqueda de Productos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.filter_list),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(currentIndex: 1, onTap: _onBottomTap),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        children: [
          SearchInputCard(
            controller: _searchController,
            onSubmit: _startSearch,
            onScan: () => Navigator.pushNamed(context, AppRoutes.scan),
          ),
          const SizedBox(height: 24),
          if (_searchFuture == null)
            const EmptyStatePlaceholder(
              title: 'Busca productos por SKU o nombre',
              message: 'Escribe una consulta para ver resultados de productos.',
              icon: Icons.search,
            )
          else
            FutureBuilder<List<Product>>(
              future: _searchFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingPlaceholder(
                      label: 'Buscando productos...');
                }
                if (snapshot.hasError) {
                  return ErrorPlaceholder(
                    message: 'Algo salio mal. Intenta nuevamente.',
                    onRetry: _startSearch,
                  );
                }

                final products = snapshot.data ?? const <Product>[];
                if (products.isEmpty) {
                  return const EmptyStatePlaceholder(
                    title: 'Sin resultados',
                    message: 'No encontramos productos con esa busqueda.',
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resultados (${products.length})',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 14),
                    ...products.asMap().entries.map((entry) {
                      final i = entry.key;
                      final p = entry.value;
                      final price = _price(p.lista2);
                      final oldPrice = _price(p.lista1);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: SearchResultCard(
                          title: p.desc.isEmpty
                              ? 'Producto sin descripcion'
                              : p.desc,
                          sku: p.sku,
                          price: price,
                          oldPrice: oldPrice > 0 ? oldPrice : null,
                          imageIcon:
                              i.isEven ? Icons.inventory_2 : Icons.checkroom,
                          onDetail: () => Navigator.pushNamed(
                            context,
                            AppRoutes.productDetail,
                            arguments: p,
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
