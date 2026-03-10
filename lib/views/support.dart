import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:merceria_app/model/correo.dart';
import 'package:merceria_app/navigation/app_routes.dart';
import 'package:merceria_app/theme/app_theme.dart';
import 'package:merceria_app/ui/shared/app_bottom_nav.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  static const String _phone = '+52 55 1234 5678';
  static const String _email = 'soporte@merceria.com';

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;
  bool _sent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _onBottomTap(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, AppRoutes.home);
      return;
    }
    if (index == 1) {
      Navigator.pushNamed(context, AppRoutes.search);
      return;
    }
    Navigator.pushNamed(context, AppRoutes.preferential);
  }

  Future<void> _copyAndNotify(String value, String message) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _handleQuickAction(String action) {
    if (action == 'call') {
      _copyAndNotify(_phone, 'Telefono copiado. Puedes pegarlo para llamar.');
      return;
    }
    if (action == 'whatsapp') {
      _copyAndNotify(_phone, 'Numero copiado para WhatsApp.');
      return;
    }
    _copyAndNotify(_email, 'Correo copiado.');
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      await sendEmail(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _phoneController.text.trim(),
        _messageController.text.trim(),
      );

      if (!mounted) return;

      setState(() {
        _sent = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Solicitud enviada correctamente.')),
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo enviar la solicitud.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Widget _contactRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.accent, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).dividerColor),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: iconColor ?? AppColors.accent),
              const SizedBox(height: 10),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      filled: true,
      fillColor: Theme.of(context).cardColor,
      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 16,
            color: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.color
                ?.withValues(alpha: 0.7),
          ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Theme.of(context).dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.accent, width: 1.2),
      ),
    );
  }

  Widget _sectionCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Theme.of(context).dividerColor),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Centro de ayuda',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      bottomNavigationBar: AppBottomNav(currentIndex: 2, onTap: _onBottomTap),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        children: [
          _sectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informacion de contacto',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Estamos aqui para ayudarte con tu pedido mayorista.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 16,
                              height: 1.35,
                            ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: Theme.of(context).dividerColor),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 4),
                  child: Column(
                    children: [
                      _contactRow(
                        icon: Icons.call,
                        title: _phone,
                        subtitle: 'Linea gratuita nacional',
                      ),
                      _contactRow(
                        icon: Icons.mail,
                        title: _email,
                        subtitle: 'Respuesta en 24 hrs',
                      ),
                      _contactRow(
                        icon: Icons.schedule,
                        title: 'Lun - Vie: 9:00 AM - 6:00 PM',
                        subtitle: 'Sabados: 10:00 AM - 2:00 PM',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _quickAction(
                icon: Icons.phone_in_talk,
                label: 'Llamar',
                onTap: () => _handleQuickAction('call'),
              ),
              const SizedBox(width: 12),
              _quickAction(
                icon: Icons.forum,
                label: 'WhatsApp',
                iconColor: const Color(0xFF16A34A),
                onTap: () => _handleQuickAction('whatsapp'),
              ),
              const SizedBox(width: 12),
              _quickAction(
                icon: Icons.send,
                label: 'Correo',
                onTap: () => _handleQuickAction('email'),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _sectionCard(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Envianos un mensaje',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 20),
                    _fieldLabel('Nombre completo'),
                    TextFormField(
                      controller: _nameController,
                      decoration: _inputDecoration('Ej. Juan Perez'),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Ingresa tu nombre'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    _fieldLabel('Correo electronico'),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration('juan@ejemplo.com'),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                      validator: (v) {
                        final value = (v ?? '').trim();
                        if (value.isEmpty) return 'Ingresa tu correo';
                        if (!value.contains('@')) return 'Correo invalido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _fieldLabel('Telefono'),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: _inputDecoration('10 digitos'),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Ingresa tu telefono'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    _fieldLabel('Mensaje'),
                    TextFormField(
                      controller: _messageController,
                      minLines: 4,
                      maxLines: 4,
                      decoration: _inputDecoration(
                        'Describe tu consulta o problema con detalle...',
                      ),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Ingresa tu mensaje'
                          : null,
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: _isSubmitting ? null : _submit,
                        icon: _isSubmitting
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.arrow_forward),
                        label: Text(
                            _sent ? 'Solicitud enviada' : 'Enviar solicitud'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          disabledBackgroundColor: AppColors.accent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<Correo> sendEmail(
  String nombre,
  String correo,
  String telefono,
  String sugerencia,
) async {
  final response = await http.post(
    Uri.parse('https://abamerceria.clustermx.com/enviar-mensaje'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'nombre': nombre,
      'correo': correo,
      'telefono': telefono,
      'sugerencia': sugerencia,
    }),
  );

  if (response.statusCode == 200) {
    return Correo.fromJson(jsonDecode(response.body));
  }

  throw Exception('Error al enviar el correo.');
}
