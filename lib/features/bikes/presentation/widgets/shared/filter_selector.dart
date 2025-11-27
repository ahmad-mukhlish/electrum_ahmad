import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../viewmodel/states/filter_option.dart';

class FilterSelector<T> extends StatelessWidget {
  final T? selected;
  final ValueChanged<T?> onChanged;
  final List<FilterOption<T>> options;

  const FilterSelector({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options
          .map(
            (option) => _buildOption(
              option: option,
              colorScheme: colorScheme,
              textTheme: textTheme,
            ),
          )
          .toList(),
    );
  }

  Widget _buildOption({
    required FilterOption<T> option,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    final isSelected = selected == option.value;

    final child = InkWell(
      onTap: () => isSelected ? onChanged(null) : onChanged(option.value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            _buildSelectionIndicator(colorScheme, isSelected),
            const SizedBox(width: 8),
            Expanded(
              child: _buildTextSection(
                option: option,
                colorScheme: colorScheme,
                textTheme: textTheme,
                isSelected: isSelected,
              ),
            ),
          ],
        ),
      ),
    );

    return option.semanticLabel != null
        ? Semantics(label: option.semanticLabel, child: child)
        : child;
  }

  Widget _buildSelectionIndicator(
    ColorScheme colorScheme,
    bool isSelected,
  ) =>
      Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.onSecondary.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        child: isSelected
            ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.primary,
                  ),
                ),
              )
            : null,
      );

  Widget _buildTextSection({
    required FilterOption<T> option,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
    required bool isSelected,
  }) {
    final textThemeSizeLabel = kIsWeb? textTheme.titleMedium : textTheme.bodyLarge;
    final textThemeSizeDesc = kIsWeb? textTheme.titleSmall: textTheme.bodySmall;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          option.label,
          style: textThemeSizeLabel?.copyWith(
            color: colorScheme.onSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          option.description,
          style: textThemeSizeDesc?.copyWith(
            color: colorScheme.onSecondary.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

}
