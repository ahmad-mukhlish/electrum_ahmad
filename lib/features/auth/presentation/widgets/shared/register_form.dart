import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../viewmodel/notifiers/auth_notifier.dart';

class RegisterForm extends HookConsumerWidget {
  const RegisterForm({super.key, this.isWebView = false});

  final bool isWebView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePassword = useState(true);
    final authState = ref.watch(authProvider);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    _setupAuthListener(ref, context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(colorScheme, textTheme),
        const SizedBox(height: 16),
        _buildSubtitle(colorScheme, textTheme),
        const SizedBox(height: 16),
        _buildNameField(textTheme, nameController),
        const SizedBox(height: 16),
        _buildEmailField(textTheme, emailController),
        const SizedBox(height: 16),
        _buildPasswordField(textTheme, passwordController, obscurePassword),
        const SizedBox(height: 24),
        _buildSignUpButton(
          colorScheme,
          authState,
          () => _handleRegister(
            ref,
            emailController.text,
            passwordController.text,
            nameController.text,
          ),
        ),
        const SizedBox(height: 24),
        _buildSignInLink(colorScheme, textTheme, context),
      ],
    );
  }

  void _handleRegister(
    WidgetRef ref,
    String email,
    String password,
    String displayName,
  ) =>
      ref.read(authProvider.notifier).register(email, password, displayName);

  void _setupAuthListener(WidgetRef ref, BuildContext context) {
    ref.listen<AsyncValue<dynamic>>(authProvider, (_, next) {
      next.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(error.toString()),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });
  }

  Widget _buildHeader(ColorScheme colorScheme, TextTheme textTheme) {
    final titleStyle =
        isWebView ? textTheme.headlineLarge : textTheme.bodyLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Create Account',
          style: titleStyle?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        Text(
          'Join Electrum',
          style: titleStyle?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle(ColorScheme colorScheme, TextTheme textTheme) {
    final subtitleStyle =
        isWebView ? textTheme.headlineSmall : textTheme.bodyMedium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Start your journey with',
          style: subtitleStyle?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'electric bikes today ⚡',
          style: subtitleStyle?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildNameField(
    TextTheme textTheme,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Name',
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: 'Your full name',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(
    TextTheme textTheme,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Email',
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Example@email.com',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(
    TextTheme textTheme,
    TextEditingController controller,
    ValueNotifier<bool> obscurePassword,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Password',
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscurePassword.value,
          decoration: InputDecoration(
            hintText: 'At least 6 characters',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword.value ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                obscurePassword.value = !obscurePassword.value;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton(
    ColorScheme colorScheme,
    AsyncValue<dynamic> authState,
    VoidCallback onRegister,
  ) {
    return FilledButton(
      onPressed: authState.maybeWhen(
        loading: () => null,
        orElse: () => onRegister,
      ),
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: authState.when(
        data: (_) => const Text('Sign up'),
        loading: () => const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
        ),
        error: (_, _) => const Text('Sign up'),
      ),
    );
  }

  Widget _buildSignInLink(
    ColorScheme colorScheme,
    TextTheme textTheme,
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account? ", style: textTheme.bodyMedium),
        GestureDetector(
          onTap: () => context.go('/login'),
          child: Text(
            'Sign in',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
