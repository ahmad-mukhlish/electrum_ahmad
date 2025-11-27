import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../viewmodel/notifiers/rent_form_provider.dart';

class ContactFields extends ConsumerWidget {
  const ContactFields({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final formState = ref.watch(rentFormProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: (kIsWeb ? textTheme.headlineSmall : textTheme.titleLarge)
              ?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: kIsWeb ? 16 : 12),
        _buildTextField(
          context,
          label: 'Name',
          value: formState.contactName,
          onChanged: (value) =>
              ref.read(rentFormProvider.notifier).setContactName(value),
          icon: Icons.person,
          keyboardType: TextInputType.name,
        ),
        SizedBox(height: kIsWeb ? 16 : 12),
        _buildTextField(
          context,
          label: 'Phone',
          value: formState.contactPhone,
          onChanged: (value) =>
              ref.read(rentFormProvider.notifier).setContactPhone(value),
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: kIsWeb ? 16 : 12),
        _buildTextField(
          context,
          label: 'Email',
          value: formState.contactEmail,
          onChanged: (value) =>
              ref.read(rentFormProvider.notifier).setContactEmail(value),
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    required IconData icon,
    required TextInputType keyboardType,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return TextField(
      controller: TextEditingController(text: value)
        ..selection = TextSelection.fromPosition(
          TextPosition(offset: value.length),
        ),
      onChanged: onChanged,
      keyboardType: keyboardType,
      style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
          ?.copyWith(color: colorScheme.onSecondary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
            ?.copyWith(color: colorScheme.onSecondary.withValues(alpha: 0.7)),
        hintText: 'Enter your $label',
        hintStyle: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
            ?.copyWith(color: colorScheme.onSecondary.withValues(alpha: 0.5)),
        prefixIcon: Icon(
          icon,
          color: colorScheme.primary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colorScheme.onSecondary.withValues(alpha: 0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colorScheme.onSecondary.withValues(alpha: 0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}
