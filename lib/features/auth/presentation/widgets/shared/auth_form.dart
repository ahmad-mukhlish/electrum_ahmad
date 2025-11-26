import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../viewmodel/notifiers/auth_notifier.dart';

class AuthForm extends HookConsumerWidget {
  const AuthForm({super.key, this.isWebView = false});

  final bool isWebView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePassword = useState(true);
    final isRegisterMode = useState(false);
    final authState = ref.watch(authProvider);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    _setupAuthListener(ref, context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(colorScheme, textTheme, isRegisterMode.value),
        const SizedBox(height: 16),
        if (!isRegisterMode.value) ...[
          _buildSubtitle(colorScheme, textTheme),
          const SizedBox(height: 16),
        ],
        if (isRegisterMode.value) ...[
          _buildNameField(textTheme, nameController),
          const SizedBox(height: 16),
        ],
        _buildEmailField(textTheme, emailController),
        const SizedBox(height: 16),
        _buildPasswordField(textTheme, passwordController, obscurePassword),
        const SizedBox(height: 24),
        _buildActionButton(
          colorScheme,
          authState,
          isRegisterMode.value,
          () => _handleAuth(
            ref,
            emailController.text,
            passwordController.text,
            nameController.text,
            isRegisterMode.value,
          ),
        ),
        const SizedBox(height: 24),
        _buildToggleLink(colorScheme, textTheme, isRegisterMode),
      ],
    );
  }

  void _handleAuth(
    WidgetRef ref,
    String email,
    String password,
    String displayName,
    bool isRegister,
  ) {
    if (isRegister) {
      ref.read(authProvider.notifier).register(email, password, displayName);
    } else {
      ref.read(authProvider.notifier).login(email, password);
    }
  }

  void _setupAuthListener(WidgetRef ref, BuildContext context) {
    ref.listen(authProvider, (_, next) {
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

  Widget _buildHeader(
    ColorScheme colorScheme,
    TextTheme textTheme,
    bool isRegister,
  ) {
    final titleStyle = isWebView
        ? textTheme.headlineLarge
        : textTheme.bodyLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          isRegister ? 'Create Account' : 'Your Next Ride',
          style: titleStyle?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        Text(
          isRegister ? 'Join Electrum' : 'Starts Here',
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
            hintText: 'Insert your password',
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

  Widget _buildActionButton(
    ColorScheme colorScheme,
    AsyncValue<dynamic> authState,
    bool isRegister,
    VoidCallback onAction,
  ) {
    return FilledButton(
      onPressed: authState.maybeWhen(
        loading: () => null,
        orElse: () => onAction,
      ),
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: authState.when(
        data: (_) => Text(isRegister ? 'Sign up' : 'Sign in'),
        loading: () => const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
        ),
        error: (_, _) => Text(isRegister ? 'Sign up' : 'Sign in'),
      ),
    );
  }

  Widget _buildToggleLink(
    ColorScheme colorScheme,
    TextTheme textTheme,
    ValueNotifier<bool> isRegisterMode,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isRegisterMode.value
              ? "Already have an account? "
              : "No account? ",
          style: textTheme.bodyMedium,
        ),
        GestureDetector(
          onTap: () => isRegisterMode.value = !isRegisterMode.value,
          child: Text(
            isRegisterMode.value ? 'Sign in' : 'Sign up',
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
