import 'package:flutter/material.dart';
import 'package:merceria_app/navigation/app_routes.dart';
import 'package:merceria_app/theme/app_theme.dart';
import 'package:merceria_app/theme/theme_mode_controller.dart';
import 'package:merceria_app/variables.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const AppTopBar({Key? key, required this.title, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color surface = Theme.of(context).scaffoldBackgroundColor;
    final Color border = Theme.of(context).dividerColor;

    return AppBar(
      toolbarHeight: 64,
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 16,
      title: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      ),
      backgroundColor: surface,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Stack(
            children: [
              IconButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
                tooltip: 'Carrito',
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              if (productosDatos.isNotEmpty)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    constraints:
                        const BoxConstraints(minWidth: 16, minHeight: 14),
                    child: Text(
                      '${productosDatos.length}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: PopupMenuButton<String>(
            tooltip: 'Opciones',
            onSelected: (value) {
              if (value == 'theme') {
                ThemeModeController.toggle();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'theme',
                child: Text(
                  isDark ? 'Cambiar a tema claro' : 'Cambiar a tema oscuro',
                ),
              ),
            ],
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isDark ? AppColors.darkLayer : AppColors.lightSurfaceMuted,
              ),
              child: Icon(
                Icons.account_circle_outlined,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
          ),
        ),
        if (actions != null) ...actions!,
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, thickness: 1, color: border),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
