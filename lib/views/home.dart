import 'package:flutter/material.dart';
import 'package:merceria_app/variables.dart';
import 'package:merceria_app/views/preferential.dart';
import 'package:merceria_app/views/product_check.dart';
import 'package:merceria_app/views/search.dart';
import 'package:merceria_app/views/shopping_cart.dart';
import 'package:merceria_app/views/support.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _openPage(BuildContext context, Widget page) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );

    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Merceria Costura',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Selecciona una opcion para continuar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF475569),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 380;
                      final crossAxisCount = isNarrow ? 1 : 2;
                      final cardAspectRatio = isNarrow ? 2.2 : .78;

                      return GridView.count(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: cardAspectRatio,
                        children: [
                          _MenuCard(
                            icon: Icons.qr_code_scanner_rounded,
                            title: 'Escanear producto',
                            description:
                                'Escanea el codigo de barras y revisa el precio al instante.',
                            accent: const Color(0xFF0EA5E9),
                            onTap: () =>
                                _openPage(context, const ProductCheck()),
                          ),
                          _MenuCard(
                            icon: Icons.manage_search_rounded,
                            title: 'Busqueda manual',
                            description:
                                'Escribe el nombre o SKU del producto en la barra de busqueda.',
                            accent: const Color(0xFF10B981),
                            onTap: () => _openPage(context, const SearchPage()),
                          ),
                          _MenuCard(
                            icon: Icons.workspace_premium,
                            title: 'Cliente preferencial',
                            description: 'Beneficios exclusivos y promociones.',
                            badgeText: 'Proximamente',
                            accent: const Color(0xFFF59E0B),
                            onTap: () =>
                                _openPage(context, const PreferentialPage()),
                          ),
                          _MenuCard(
                            icon: Icons.shopping_cart_checkout_rounded,
                            title: 'Carrito',
                            description:
                                'Productos agregados con precio de venta para el cliente.',
                            badgeText: productosDatos.isEmpty
                                ? null
                                : '${productosDatos.length}',
                            accent: const Color(0xFFEF4444),
                            onTap: () =>
                                _openPage(context, const ShoppingCart()),
                          ),
                          _MenuCard(
                            icon: Icons.support_agent_rounded,
                            title: 'Ayuda',
                            description:
                                'Contactanos para resolver dudas y recibir soporte.',
                            accent: const Color(0xFF6366F1),
                            onTap: () =>
                                _openPage(context, const SupportPage()),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? badgeText;
  final Color accent;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.accent,
    required this.onTap,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 150;

        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          elevation: 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(compact ? 12 : 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: accent.withOpacity(.20), width: 1.2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x140F172A),
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: compact ? 36 : 44,
                        height: compact ? 36 : 44,
                        decoration: BoxDecoration(
                          color: accent.withOpacity(.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child:
                            Icon(icon, color: accent, size: compact ? 20 : 24),
                      ),
                      const Spacer(),
                      if (badgeText != null)
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: accent.withOpacity(.12),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                badgeText!,
                                style: TextStyle(
                                  color: accent,
                                  fontWeight: FontWeight.w700,
                                  fontSize: compact ? 10 : 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: compact ? 8 : 14),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: compact ? 15 : 18,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: compact ? 6 : 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: compact ? 11 : 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF475569),
                      height: 1.3,
                    ),
                    maxLines: compact ? 3 : 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
