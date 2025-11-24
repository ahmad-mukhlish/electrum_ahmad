import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../viewmodel/notifiers/auth_notifier.dart';

class LoginForm extends HookConsumerWidget {
  const LoginForm({super.key, this.isWebView = false});

  final bool isWebView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        _buildEmailField(textTheme, emailController),
        const SizedBox(height: 16),
        _buildPasswordField(textTheme, passwordController, obscurePassword),
        const SizedBox(height: 24),
        _buildSignInButton(
          colorScheme,
          authState,
          () =>
              _handleLogin(ref, emailController.text, passwordController.text),
        ),
        const SizedBox(height: 24),
        _buildSignUpLink(colorScheme, textTheme),
      ],
    );
  }

  void _handleLogin(WidgetRef ref, String email, String password) =>
      ref.read(authProvider.notifier).login(email, password);

  void _setupAuthListener(WidgetRef ref, BuildContext context) {
    ref.listen<AsyncValue<bool>>(authProvider, (_, next) {
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
    final titleStyle = isWebView
        ? textTheme.headlineLarge
        : textTheme.bodyLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Your Next Ride',
          style: titleStyle?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        Text(
          'Starts Here',
          style: titleStyle?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle(ColorScheme colorScheme, TextTheme textTheme) {
    final subtitleStyle = isWebView
        ? textTheme.headlineSmall
        : textTheme.bodyMedium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Explore Electrum bikes.',
          style: subtitleStyle?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Hit the road fully charged ⚡',
          style: subtitleStyle?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
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
            hintText: 'At least 5 characters',
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

  Widget _buildSignInButton(
    ColorScheme colorScheme,
    AsyncValue<bool> authState,
    VoidCallback onLogin,
  ) {
    return FilledButton(
      onPressed: authState.maybeWhen(
        loading: () => null,
        orElse: () => onLogin,
      ),
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: authState.when(
        data: (_) => const Text('Sign in'),
        loading: () => const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
        ),
        error: (_, _) => const Text('Sign in'),
      ),
    );
  }

  Widget _buildSignUpLink(ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No account? ", style: textTheme.bodyMedium),
        GestureDetector(
          onTap: () {
            // TODO: Navigate to sign up
            debugPrint('Sign up tapped');
          },
          child: Text(
            'Sign up',
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
