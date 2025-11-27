class FilterOption<T> {
  const FilterOption({
    required this.value,
    required this.label,
    required this.description,
  });

  final T value;
  final String label;
  final String description;
}
