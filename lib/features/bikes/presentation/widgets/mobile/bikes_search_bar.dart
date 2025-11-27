import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../viewmodel/notifiers/filter/bike_filter_provider.dart';

class BikesSearchBar extends HookConsumerWidget {
  const BikesSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final searchQuery = ref.watch(
      bikeFilterProvider.select((state) => state.searchQuery),
    );
    final controller = useTextEditingController(text: searchQuery);

    useEffect(() {
      controller.text = searchQuery;
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
      return null;
    }, [searchQuery, controller]);

    return TextField(
      controller: controller,
      onChanged: (value) =>
          ref.read(bikeFilterProvider.notifier).setSearchQuery(value),
      style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSecondary),
      decoration: InputDecoration(
        hintText: 'Search your next ride',
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSecondary.withValues(alpha: 0.5),
        ),
        prefixIcon: Icon(Icons.search, color: colorScheme.primary),
        suffixIcon: searchQuery.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear, color: colorScheme.onSecondary),
                onPressed: () {
                  controller.clear();
                  ref.read(bikeFilterProvider.notifier).setSearchQuery('');
                },
              )
            : null,
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
  }
}
