class FilterOption<T> {
  const FilterOption({
    required this.value,
    required this.label,
    required this.description,
    this.semanticLabel,
  });

  final T value;
  final String label;
  final String description;
  final String? semanticLabel;
}
