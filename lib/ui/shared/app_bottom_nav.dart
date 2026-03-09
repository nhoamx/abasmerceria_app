import 'package:flutter/material.dart';
import 'package:merceria_app/theme/app_theme.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color activeColor = Theme.of(context).colorScheme.primary;
    final Color inactiveColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkSurface.withValues(alpha: 0.95)
            : AppColors.lightSurface.withValues(alpha: 0.95),
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            _BottomItem(
              index: 0,
              currentIndex: currentIndex,
              onTap: onTap,
              label: 'Inicio',
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
            _BottomItem(
              index: 1,
              currentIndex: currentIndex,
              onTap: onTap,
              label: 'Busqueda',
              icon: Icons.search,
              activeIcon: Icons.search,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
            _BottomItem(
              index: 2,
              currentIndex: currentIndex,
              onTap: onTap,
              label: 'Cliente preferencial',
              icon: Icons.star_border,
              activeIcon: Icons.star,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final Color activeColor;
  final Color inactiveColor;

  const _BottomItem({
    required this.index,
    required this.currentIndex,
    required this.onTap,
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool active = index == currentIndex;
    final Color color = active ? activeColor : inactiveColor;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onTap(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(active ? activeIcon : icon, color: color, size: 19),
              const SizedBox(height: 1),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
