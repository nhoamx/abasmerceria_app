import 'package:flutter/material.dart';
import 'package:merceria_app/navigation/app_routes.dart';
import 'package:merceria_app/ui/shared/app_bottom_nav.dart';

class PreferentialPage extends StatelessWidget {
  const PreferentialPage({Key? key}) : super(key: key);

  void _onBottomTap(BuildContext context, int index) {
    if (index == 2) return;
    if (index == 0) {
      Navigator.pushNamed(context, AppRoutes.home);
      return;
    }
    Navigator.pushNamed(context, AppRoutes.search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cliente Preferencial',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 2,
        onTap: (index) => _onBottomTap(context, index),
      ),
      body: Container(
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            const Spacer(flex: 3),
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.workspace_premium,
                  size: 260,
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withValues(alpha: 0.08),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              'Próximamente',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Text(
                'Podras acceder con tu cuenta preferencial.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      height: 1.45,
                    ),
              ),
            ),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}
