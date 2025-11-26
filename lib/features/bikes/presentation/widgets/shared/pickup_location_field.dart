import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/services/location_service.dart';
import '../../viewmodel/notifiers/rent_form_provider.dart';

class PickupLocationField extends ConsumerStatefulWidget {
  const PickupLocationField({super.key});

  @override
  ConsumerState<PickupLocationField> createState() =>
      _PickupLocationFieldState();
}

class _PickupLocationFieldState extends ConsumerState<PickupLocationField> {
  bool _isLoadingLocation = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final formState = ref.watch(rentFormProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pickup Location',
          style: (kIsWeb ? textTheme.headlineSmall : textTheme.titleLarge)
              ?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: kIsWeb ? 16 : 12),
        TextField(
          controller: TextEditingController(text: formState.pickupText)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: formState.pickupText.length),
            ),
          onChanged: (value) {
            ref.read(rentFormProvider.notifier).setPickupText(value);
          },
          style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
              ?.copyWith(color: colorScheme.onSecondary),
          decoration: InputDecoration(
            hintText: 'Enter pickup location',
            hintStyle: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
                ?.copyWith(
              color: colorScheme.onSecondary.withValues(alpha: 0.5),
            ),
            prefixIcon: Icon(
              Icons.location_on,
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
        ),
        SizedBox(height: kIsWeb ? 12 : 8),
        OutlinedButton.icon(
          onPressed: _isLoadingLocation ? null : _useMyLocation,
          icon: _isLoadingLocation
              ? SizedBox(
                  width: kIsWeb ? 18 : 16,
                  height: kIsWeb ? 18 : 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colorScheme.primary,
                  ),
                )
              : Icon(
                  Icons.my_location,
                  size: kIsWeb ? 20 : 18,
                ),
          label: Text(
            _isLoadingLocation ? 'Getting location...' : 'Use my location',
            style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium),
          ),
        ),
      ],
    );
  }

  Future<void> _useMyLocation() async {
    setState(() => _isLoadingLocation = true);

    try {
      final locationService = ref.read(locationServiceProvider);

      // Get current position
      final position = await locationService.getCurrentPosition();

      if (position == null) {
        if (mounted) {
          _showError('Unable to get your location. Please enable location services.');
        }
        return;
      }

      // Reverse geocode to get address
      final address = await locationService.getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (address == null) {
        if (mounted) {
          _showError('Unable to get address. Please enter manually.');
        }
        return;
      }

      // Update form with location data
      ref.read(rentFormProvider.notifier).setLocation(
            position.latitude,
            position.longitude,
            address,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Location set: $address'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        _showError('Failed to get location. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingLocation = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
