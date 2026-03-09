import 'package:flutter/material.dart';
import 'package:merceria_app/navigation/app_routes.dart';
import 'package:merceria_app/theme/app_theme.dart';
import 'package:merceria_app/ui/shared/app_bottom_nav.dart';
import 'package:merceria_app/ui/shared/app_buttons.dart';
import 'package:merceria_app/ui/shared/app_card_base.dart';
import 'package:merceria_app/ui/shared/app_top_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onBottomTap(int index) {
    if (index == 0) return;

    if (index == 1) {
      Navigator.pushNamed(context, AppRoutes.search);
      return;
    }

    Navigator.pushNamed(context, AppRoutes.preferential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Abastecedora de mercerias'),
      bottomNavigationBar: AppBottomNav(currentIndex: 0, onTap: _onBottomTap),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          child: ListView(
            children: [
              Text(
                'Inicio rapido',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Busca articulos por escaner o por nombre/SKU.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              AppCardBase(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.inventory_2_outlined,
                            color: AppColors.accent,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Buscar producto',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Selecciona como quieres consultar el producto.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    AppPrimaryButton(
                      label: 'Escanear',
                      icon: Icons.qr_code_scanner,
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.scan),
                    ),
                    const SizedBox(height: 10),
                    AppSecondaryButton(
                      label: 'Busqueda manual',
                      icon: Icons.search,
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.search),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              AppCardBase(
                onTap: () => Navigator.pushNamed(context, AppRoutes.support),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.support_agent,
                          color: AppColors.warning),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Centro de ayuda',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              AppCardBase(
                onTap: () => Navigator.pushNamed(context, AppRoutes.cart),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.shopping_cart_outlined,
                          color: Colors.red),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Carrito final',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
