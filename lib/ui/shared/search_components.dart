import 'package:flutter/material.dart';
import 'package:merceria_app/theme/app_theme.dart';

class SearchInputCard extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;
  final VoidCallback onScan;

  const SearchInputCard({
    Key? key,
    required this.controller,
    required this.onSubmit,
    required this.onScan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.search,
              color:
                  isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => onSubmit(),
              decoration: const InputDecoration(
                hintText: 'Buscar por SKU o Nombre...',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                filled: false,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          IconButton(
            onPressed: onScan,
            visualDensity: VisualDensity.compact,
            tooltip: 'Escanear',
            icon: Icon(
              Icons.qr_code_scanner,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchResultCard extends StatelessWidget {
  final String title;
  final String sku;
  final double price;
  final double? oldPrice;
  final IconData imageIcon;
  final VoidCallback onDetail;

  const SearchResultCard({
    Key? key,
    required this.title,
    required this.sku,
    required this.price,
    this.oldPrice,
    required this.imageIcon,
    required this.onDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      constraints: const BoxConstraints(minHeight: 150),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(
            color: isDark ? const Color(0xFF334155) : const Color(0xFFD4DCE7)),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: isDark ? const Color(0x16000000) : const Color(0x10000000),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkSurfaceMuted
                  : AppColors.lightSurfaceMuted,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(imageIcon,
                size: 36,
                color:
                    isDark ? const Color(0xFF64748B) : const Color(0xFFCBD5E1)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  'SKU: $sku',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                      ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (oldPrice != null && oldPrice! > price) ...[
                      Text(
                        '\$${oldPrice!.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color
                                  ?.withValues(alpha: 0.75),
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accent,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: onDetail,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 9),
                      backgroundColor: AppColors.accent.withValues(alpha: 0.12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      'Ver detalle',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.accent,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
