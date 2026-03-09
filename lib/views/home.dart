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
    final Color surface = Theme.of(context).cardColor;
    final Color textSecondary = Theme.of(context).textTheme.bodyMedium?.color ??
        (isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475467));

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
              const SizedBox(height: 32),
              Text(
                'Acceso rapido',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                    ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: AppCardBase(
                      onTap: () => Navigator.pushNamed(context, AppRoutes.support),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0x1F3B82F6)
                                  : const Color(0xFFEFF6FF),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.support_agent, color: AppColors.accent),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Centro de ayuda',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppCardBase(
                      onTap: () => Navigator.pushNamed(context, AppRoutes.preferential),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0x33B54708)
                                  : const Color(0xFFFFF4ED),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.workspace_premium, color: AppColors.warning),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Cliente preferencial',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: surface,
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    const Icon(Icons.help_center_outlined, color: AppColors.accent),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Centro de ayuda  Asistencia y soporte',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
