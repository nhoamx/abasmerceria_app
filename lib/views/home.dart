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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textSecondary = Theme.of(context).textTheme.bodyMedium?.color ??
        (isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475467));
    final Color ctaBackground =
        isDark ? AppColors.darkLayer : const Color(0xFF0F172A);

    return Scaffold(
      appBar: const AppTopBar(title: 'Abastecedora'),
      bottomNavigationBar: AppBottomNav(currentIndex: 0, onTap: _onBottomTap),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
          child: ListView(
            children: [
              Text(
                'Hola, Bienvenido',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Selecciona una opcion para comenzar',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: textSecondary,
                    ),
              ),
              const SizedBox(height: 32),
              AppCardBase(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkLayer
                            : AppColors.lightSurfaceMuted,
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Theme.of(context).dividerColor),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code_scanner,
                              color: Theme.of(context).colorScheme.primary,
                              size: 34,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Placeholder escaner',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Buscar producto',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 22,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Encuentra al instante los precios y detalles de inventario buscando o escaneando el codigo de barras del articulo.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: textSecondary,
                            height: 1.35,
                          ),
                    ),
                    const SizedBox(height: 20),
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
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: isDark ? ctaBackground : ctaBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cliente preferencial',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Beneficios exclusivos',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: const Color(0xFFE2E8F0),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: AppColors.accent.withValues(alpha: 0.18),
                        border: Border.all(
                            color: AppColors.accent.withValues(alpha: 0.35)),
                      ),
                      child: const Text(
                        'Proximamente',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Descuentos exclusivos de mayoreo y servicios de entrega prioritaria se lanzaran el proximo mes. Mantente atento.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFFCBD5E1),
                            height: 1.35,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Accesos rapidos',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                    ),
              ),
              const SizedBox(height: 12),
              AppCardBase(
                onTap: () => Navigator.pushNamed(context, AppRoutes.support),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1E293B)
                            : const Color(0xFFF1F5F9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.help_center,
                          color: AppColors.accent),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Centro de ayuda',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Asistencia y soporte',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
