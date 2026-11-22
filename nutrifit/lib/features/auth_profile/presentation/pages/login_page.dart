import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/app_settings.dart';
import '../../../../core/utils/body_metrics.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../domain/body_profile_input.dart';
import '../providers/auth_providers.dart';
import '../widgets/register_body_fields.dart';

/// Email/password login + register. Navigates to /home on session.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _name = TextEditingController();
  final _weight = TextEditingController();
  final _height = TextEditingController();
  final _goalWeight = TextEditingController();
  String _goal = 'maintain';
  bool _isRegister = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _name.dispose();
    _weight.dispose();
    _height.dispose();
    _goalWeight.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final controller = ref.read(authControllerProvider.notifier);
    final bool ok;
    if (_isRegister) {
      // The validators already guaranteed these parse to valid numbers.
      final weight = roundToTenth(parseDecimal(_weight.text)!);
      final goalWeight = _goal == 'maintain'
          ? weight
          : roundToTenth(parseDecimal(_goalWeight.text)!);
      ok = await controller.signUp(
        email: _email.text.trim(),
        password: _password.text,
        name: _name.text.trim().isEmpty ? null : _name.text.trim(),
        body: BodyProfileInput(
          weightKg: weight,
          heightCm: roundToTenth(parseDecimal(_height.text)!),
          goal: _goal,
          goalWeightKg: goalWeight,
        ),
      );
    } else {
      ok = await controller.signIn(
        email: _email.text.trim(),
        password: _password.text,
      );
    }
    // Navigate on the result of the action, not on a session stream event:
    // when a session was already restored the id does not change and a
    // stream based navigation would never fire.
    if (ok && mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(stringsProvider);
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(strings.login)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Center(child: AppLogo(height: 120)),
            const SizedBox(height: 16),
            AppCard(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (_isRegister)
                      TextFormField(
                        controller: _name,
                        decoration: InputDecoration(
                          labelText: strings.displayName,
                        ),
                      ),
                    TextFormField(
                      controller: _email,
                      decoration: InputDecoration(labelText: strings.email),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => (v == null || !v.contains('@'))
                          ? strings.invalidEmail
                          : null,
                    ),
                    TextFormField(
                      controller: _password,
                      decoration: InputDecoration(
                        labelText: strings.password,
                        suffixIcon: IconButton(
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          tooltip: strings.togglePasswordVisibility,
                        ),
                      ),
                      obscureText: _obscurePassword,
                      validator: (v) => (v == null || v.length < 6)
                          ? strings.passwordTooShort
                          : null,
                    ),
                    if (_isRegister) ...[
                      TextFormField(
                        controller: _confirmPassword,
                        decoration: InputDecoration(
                          labelText: strings.confirmPassword,
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                              () => _obscureConfirm = !_obscureConfirm,
                            ),
                            icon: Icon(
                              _obscureConfirm
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            tooltip: strings.togglePasswordVisibility,
                          ),
                        ),
                        obscureText: _obscureConfirm,
                        validator: (v) => v != _password.text
                            ? strings.passwordsDoNotMatch
                            : null,
                      ),
                      RegisterBodyFields(
                        weight: _weight,
                        height: _height,
                        goalWeight: _goalWeight,
                        goal: _goal,
                        onGoalChanged: (g) => setState(() => _goal = g),
                      ),
                    ],
                    const SizedBox(height: 16),
                    AppButton(
                      label: _isRegister ? strings.register : strings.signIn,
                      onPressed: authState.isLoading ? null : _submit,
                    ),
                    if (authState.hasError)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          strings.authError,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () => setState(() {
                _isRegister = !_isRegister;
                _formKey.currentState?.reset();
              }),
              child: Text(
                _isRegister ? strings.haveAccount : strings.needAccount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
