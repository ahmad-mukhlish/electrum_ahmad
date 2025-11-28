import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:electrum_ahmad/core/utils/snackbar_helper.dart';
import 'package:electrum_ahmad/features/rents/data/repositories/location/location_repository_impl.dart';
import '../../viewmodel/notifiers/form/rent_form_provider.dart';

class PickupLocationField extends HookConsumerWidget {
  const PickupLocationField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final formState = ref.watch(rentFormProvider);
    final isLoading = useState(false);
    final controller = useTextEditingController(text: formState.pickupText);

    useEffect(() {
      controller.text = formState.pickupText;
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
      return null;
    }, [formState.pickupText, controller]);


    Future<void> handleUseMyLocation() async {
      if (isLoading.value) return;
      isLoading.value = true;

      try {
        final locationRepository = ref.read(locationRepositoryProvider);
        final resolved = await locationRepository.resolveCurrentLocation();

        if (resolved == null) {
          if (context.mounted) {
            SnackbarHelper.showError(
              context,
              'Unable to get your location. Please enable location services.',
            );
          }
          return;
        }

        ref
            .read(rentFormProvider.notifier)
            .setLocation(
              resolved.latitude,
              resolved.longitude,
              resolved.address,
            );

        if (context.mounted) {
          SnackbarHelper.showSuccess(
            context,
            'Location set: ${resolved.address}',
            semanticsLabel: 'Location success',
          );
        }
      } catch (e) {
        if (context.mounted) {
          SnackbarHelper.showError(
            context,
            'Failed to get location. Please try again.',
          );
        }
      } finally {
        isLoading.value = false;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(textTheme, colorScheme),
        SizedBox(height: kIsWeb ? 16 : 12),
        _buildMobileTextField(
          controller,
          colorScheme,
          textTheme,
          (value) => ref.read(rentFormProvider.notifier).setPickupText(value),
        ),
        SizedBox(height: kIsWeb ? 12 : 8),
        _buildLocationButton(
          colorScheme: colorScheme,
          textTheme: textTheme,
          isLoading: isLoading.value,
          onTap: handleUseMyLocation,
          isWeb: false,
        ),
      ],
    );
  }

  Widget _buildTitle(TextTheme textTheme, ColorScheme colorScheme) => Text(
    'Pickup Location',
    style: (kIsWeb ? textTheme.headlineSmall : textTheme.titleLarge)?.copyWith(
      fontWeight: FontWeight.bold,
      color: colorScheme.onSecondary,
    ),
  );

  Widget _buildMobileTextField(
    TextEditingController controller,
    ColorScheme colorScheme,
    TextTheme textTheme,
    ValueChanged<String> onChanged,
  ) => TextField(
    controller: controller,
    onChanged: onChanged,
    style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSecondary),
    decoration: InputDecoration(
      hintText: 'Enter pickup location',
      hintStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSecondary.withValues(alpha: 0.5),
      ),
      prefixIcon: Icon(Icons.location_on, color: colorScheme.primary),
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
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
    ),
  );

  Widget _buildLocationButton({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
    required bool isLoading,
    required VoidCallback onTap,
    required bool isWeb,
  }) => OutlinedButton.icon(
    onPressed: isLoading ? null : onTap,
    icon: isLoading
        ? SizedBox(
            width: isWeb ? 18 : 16,
            height: isWeb ? 18 : 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colorScheme.primary,
            ),
          )
        : Icon(
            Icons.my_location,
            size: isWeb ? 20 : 18,
            color: colorScheme.primary,
          ),
    label: Text(
      isLoading ? 'Getting location...' : 'Use my location',
      style: (isWeb ? textTheme.bodyLarge : textTheme.bodyMedium)?.copyWith(
        color: colorScheme.onSecondary,
        fontWeight: isWeb ? FontWeight.w600 : FontWeight.w500,
      ),
    ),
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: colorScheme.primary),
      padding: EdgeInsets.symmetric(vertical: isWeb ? 36 : 14, horizontal: kIsWeb ? 24 : 16),
    ),
  );
}
