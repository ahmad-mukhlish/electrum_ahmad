import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/header_web.dart';
import '../../../../core/widgets/primary_app_bar.dart';
import '../../domain/entities/rent.dart';
import '../viewmodel/states/rent_history_item_state.dart';

class RentDetailScreen extends StatelessWidget {
  const RentDetailScreen({
    super.key,
    required this.rent,
  });

  final Rent rent;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final rentState = RentHistoryItemState.fromEntity(rent);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: kIsWeb ? null : PrimaryAppBar(title: 'Rent Details'),
      body: Column(
        children: [
          if (kIsWeb)
            Padding(
              padding: const EdgeInsets.all(24),
              child: HeaderWeb(title: 'Rent Details'),
            ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(kIsWeb ? 32 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, colorScheme, textTheme, rentState),
                  const SizedBox(height: 24),
                  _buildPhoto(colorScheme),
                  const SizedBox(height: 24),
                  _buildDateSection(context, colorScheme, textTheme),
                  const SizedBox(height: 20),
                  _buildLocationSection(context, colorScheme, textTheme),
                  const SizedBox(height: 20),
                  _buildContactSection(context, colorScheme, textTheme),
                  const SizedBox(height: 20),
                  _buildPriceSection(context, colorScheme, textTheme, rentState),
                  const SizedBox(height: 20),
                  _buildFooter(context, colorScheme, textTheme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
    RentHistoryItemState rentState,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            rent.bikeModel,
            style: kIsWeb
                ? textTheme.displaySmall?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  )
                : textTheme.headlineMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
          ),
        ),
        const SizedBox(width: 12),
        _buildStatusBadge(colorScheme, textTheme, rentState),
      ],
    );
  }

  Widget _buildStatusBadge(
    ColorScheme colorScheme,
    TextTheme textTheme,
    RentHistoryItemState rentState,
  ) {
    final statusColor = rentState.getStatusColor(colorScheme);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kIsWeb ? 20 : 12,
        vertical: kIsWeb ? 10 : 6,
      ),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        rentState.statusLabel,
        style: kIsWeb
            ? textTheme.titleMedium?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w600,
              )
            : textTheme.bodyMedium?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w600,
              ),
      ),
    );
  }

  Widget _buildPhoto(ColorScheme colorScheme) {
    if (rent.photoUrl == null) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: rent.photoUrl!,
        width: double.infinity,
        height: kIsWeb ? 300 : 200,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: double.infinity,
          height: kIsWeb ? 300 : 200,
          color: colorScheme.surfaceContainerHighest,
          child: Center(
            child: CircularProgressIndicator(color: colorScheme.primary),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: double.infinity,
          height: kIsWeb ? 300 : 200,
          color: colorScheme.surfaceContainerHighest,
          child: Icon(
            Icons.electric_bike,
            size: kIsWeb ? 80 : 60,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildDateSection(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Rental Period', colorScheme, textTheme),
        const SizedBox(height: 8),
        _buildInfoRow(
          icon: Icons.calendar_today,
          label: 'From',
          value: _formatDateTime(rent.fromDate),
          colorScheme: colorScheme,
          textTheme: textTheme,
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          icon: Icons.event,
          label: 'To',
          value: _formatDateTime(rent.toDate),
          colorScheme: colorScheme,
          textTheme: textTheme,
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          icon: Icons.access_time,
          label: 'Duration',
          value: '${rent.totalDays} days',
          colorScheme: colorScheme,
          textTheme: textTheme,
        ),
      ],
    );
  }

  Widget _buildLocationSection(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Pickup Location', colorScheme, textTheme),
        const SizedBox(height: 8),
        _buildInfoRow(
          icon: Icons.location_on,
          label: 'Area',
          value: rent.pickupText,
          colorScheme: colorScheme,
          textTheme: textTheme,
        ),
      ],
    );
  }

  Widget _buildContactSection(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Contact Information', colorScheme, textTheme),
        const SizedBox(height: 8),
        _buildInfoRow(
          icon: Icons.person,
          label: 'Name',
          value: rent.contactName,
          colorScheme: colorScheme,
          textTheme: textTheme,
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          icon: Icons.phone,
          label: 'Phone',
          value: rent.contactPhone,
          colorScheme: colorScheme,
          textTheme: textTheme,
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          icon: Icons.email,
          label: 'Email',
          value: rent.contactEmail,
          colorScheme: colorScheme,
          textTheme: textTheme,
        ),
      ],
    );
  }

  Widget _buildPriceSection(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
    RentHistoryItemState rentState,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Payment Details', colorScheme, textTheme),
        const SizedBox(height: 8),
        _buildPriceRow(
          label: 'Price per day',
          value: 'Rp ${NumberFormat('#,##0', 'id_ID').format(rent.pricePerDay)}',
          colorScheme: colorScheme,
          textTheme: textTheme,
        ),
        const SizedBox(height: 8),
        _buildPriceRow(
          label: 'Total days',
          value: '${rent.totalDays} days',
          colorScheme: colorScheme,
          textTheme: textTheme,
        ),
        const SizedBox(height: 12),
        Divider(color: colorScheme.outlineVariant),
        const SizedBox(height: 12),
        _buildTotalPrice(rentState.formattedPrice, colorScheme, textTheme),
      ],
    );
  }

  Widget _buildFooter(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Container(
      padding: EdgeInsets.all(kIsWeb ? 20 : 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            size: kIsWeb ? 24 : 20,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Requested on ${_formatDate(rent.createdAt)}',
              style: kIsWeb
                  ? textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    )
                  : textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    String title,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Text(
      title,
      style: kIsWeb
          ? textTheme.headlineSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            )
          : textTheme.titleLarge?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: kIsWeb ? 24 : 20,
          color: colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: kIsWeb
                    ? textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      )
                    : textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: kIsWeb
                    ? textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      )
                    : textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow({
    required String label,
    required String value,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: kIsWeb
              ? textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                )
              : textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
        ),
        Text(
          value,
          style: kIsWeb
              ? textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                )
              : textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
        ),
      ],
    );
  }

  Widget _buildTotalPrice(
    String price,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total Amount',
          style: kIsWeb
              ? textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                )
              : textTheme.titleLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
        ),
        Text(
          price,
          style: kIsWeb
              ? textTheme.headlineSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                )
              : textTheme.titleLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final dateFormat = DateFormat('dd MMM yyyy, HH:mm');
    return dateFormat.format(dateTime);
  }

  String _formatDate(DateTime dateTime) {
    final dateFormat = DateFormat('dd MMMM yyyy');
    return dateFormat.format(dateTime);
  }
}
