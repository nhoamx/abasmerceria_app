import 'package:flutter/material.dart';
import 'package:merceria_app/views/home.dart';
import 'package:merceria_app/views/preferential.dart';
import 'package:merceria_app/views/product_check.dart';
import 'package:merceria_app/views/search.dart';
import 'package:merceria_app/views/shopping_cart.dart';
import 'package:merceria_app/views/splash.dart';
import 'package:merceria_app/views/support.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String search = '/search';
  static const String scan = '/scan';
  static const String cart = '/cart';
  static const String support = '/support';
  static const String preferential = '/preferential';
  static const String productDetail = '/product-detail';
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(builder: (_) => const SplashPage());
    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => const HomePage());
    case AppRoutes.search:
      return MaterialPageRoute(builder: (_) => const SearchPage());
    case AppRoutes.scan:
      return MaterialPageRoute(builder: (_) => const ProductCheck());
    case AppRoutes.cart:
      return MaterialPageRoute(builder: (_) => const ShoppingCart());
    case AppRoutes.support:
      return MaterialPageRoute(builder: (_) => const SupportPage());
    case AppRoutes.preferential:
      return MaterialPageRoute(builder: (_) => const PreferentialPage());
    case AppRoutes.productDetail:
      return MaterialPageRoute(
          builder: (_) => const _ProductDetailPlaceholderPage());
    default:
      return MaterialPageRoute(builder: (_) => const HomePage());
  }
}

class _ProductDetailPlaceholderPage extends StatelessWidget {
  const _ProductDetailPlaceholderPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de producto')),
      body: const Center(
        child: Text('Pantalla de detalle en construccion (Fase E).'),
      ),
    );
  }
}
