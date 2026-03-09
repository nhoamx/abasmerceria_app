import 'package:flutter/material.dart';

class PreferentialPage extends StatelessWidget {
  const PreferentialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cliente preferencial'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FAFC), Color(0xFFEFF6FF)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A0F172A),
                    blurRadius: 24,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.workspace_premium,
                size: 56,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Proximamente',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Estamos preparando beneficios exclusivos para clientes preferenciales.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
