import 'package:flutter/material.dart';

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
        isDark ? const Color(0xFF94A3B8) : const Color(0xFF667085);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xF21A202C) : const Color(0xF2FFFFFF),
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 22),
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
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(active ? activeIcon : icon, color: color, size: 20),
              const SizedBox(height: 2),
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
