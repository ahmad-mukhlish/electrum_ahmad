import 'package:flutter/material.dart';

import '../../../../../core/utils/snackbar_helper.dart';
import '../../../domain/entities/promotion/promotion.dart';

class PromotionCard extends StatelessWidget {
  final Promotion promotion;
  final Color backgroundColor;

  const PromotionCard({
    super.key,
    required this.promotion,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Color textColor = backgroundColor == colorScheme.secondary
        ? colorScheme.onSecondary
        : colorScheme.onPrimary;

    return Semantics(
      label: "Promo card",
      child: InkWell(
        onTap: () {
          SnackbarHelper.showInfo(
            context,
            'TBA (Out of Scope)',
            semanticsLabel: 'Plan subscribe info',
          );
        },
        child: Card(
          elevation: 4,
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(textTheme, textColor),
                const SizedBox(height: 12),
                _buildShortCopy(textTheme, textColor),
                const SizedBox(height: 16),
                _buildValidity(textTheme, textColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(TextTheme textTheme, Color textColor) {
    return Text(
      promotion.title,
      style: textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildShortCopy(TextTheme textTheme, Color textColor) {
    return Text(
      promotion.shortCopy,
      style: textTheme.bodyMedium?.copyWith(
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildValidity(TextTheme textTheme, Color textColor) {
    return Text(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      "Validity : ${promotion.validity}",
      style: textTheme.bodySmall?.copyWith(color: textColor),
    );
  }
}
