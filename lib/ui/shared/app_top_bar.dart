import 'package:flutter/material.dart';
import 'package:merceria_app/theme/theme_mode_controller.dart';

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
          padding: const EdgeInsets.only(right: 12),
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
                    isDark ? const Color(0xFF1F2937) : const Color(0xFFF1F5F9),
              ),
              child: const Icon(Icons.account_circle_outlined),
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
