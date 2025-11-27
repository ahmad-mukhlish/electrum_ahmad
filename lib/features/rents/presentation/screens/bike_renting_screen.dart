import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickalert/quickalert.dart';

import '../../../../core/widgets/primary_app_bar.dart';
import '../../../bikes/domain/entities/bike.dart';
import '../viewmodel/notifiers/submit/rent_submit_provider.dart';
import '../widgets/mobile/rent_form_mobile.dart';
import '../widgets/web/rent_form_web.dart';

class BikeRentingScreen extends ConsumerWidget {
  const BikeRentingScreen({
    super.key,
    required this.bike,
  });

  /// Bike instance passed from navigation
  final Bike bike;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    // Listen to submit provider for success/error handling
    ref.listen<AsyncValue<void>>(
      rentSubmitProvider,
      (previous, next) {
        next.whenOrNull(
          data: (_) => _showSuccessAlert(context),
          error: (error, _) => _showErrorAlert(context, error),
        );
      },
    );

    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      appBar: kIsWeb
          ? null
          : const PrimaryAppBar(title: "Rent the bike"),
      body: Column(
        children: [
          Expanded(
            child: kIsWeb
                ? RentFormWeb(bike: bike)
                : RentFormMobile(bike: bike),
          ),
        ],
      ),
    );
  }

  void _showSuccessAlert(BuildContext context) {
    QuickAlert.show(
      width: 400,
      context: context,
      type: QuickAlertType.success,
      title: 'Request Sent!',
      text: "We've received your rental request. \nWe'll contact you soon.",
      confirmBtnText: 'OK',
      onConfirmBtnTap: () async {
        // Close the alert first
        Navigator.of(context, rootNavigator: true).pop();
        // Wait a moment for the dialog to close
        await Future.delayed(const Duration(milliseconds: 100));
        // Navigate to homepage
        if (context.mounted) {
          context.go('/');
        }
      },
    );
  }

  void _showErrorAlert(BuildContext context, Object error) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops!',
      text: 'Failed to send request. Please try again.',
      confirmBtnText: 'OK',
    );
  }
}
