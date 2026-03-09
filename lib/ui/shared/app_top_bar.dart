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

    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: ThemeModeController.toggle,
          tooltip: isDark ? 'Cambiar a tema claro' : 'Cambiar a tema oscuro',
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
        ),
        if (actions != null) ...actions!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
