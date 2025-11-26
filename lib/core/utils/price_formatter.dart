import 'package:intl/intl.dart';

/// Format price to Rupiah with K suffix
/// Examples:
/// - 100000 -> "Rp. 100K"
/// - 500000 -> "Rp. 500K"
/// - 1500000 -> "Rp. 1.500K"
/// - 2750000 -> "Rp. 2.750K"
String formatPriceToRupiahK(int price) {
  // Convert to thousands
  final priceInThousands = price / 1000;

  // Format with Indonesian locale (dot as thousand separator)
  final formatter = NumberFormat('#,##0', 'id_ID');
  final formattedPrice = formatter.format(priceInThousands);

  return 'Rp. ${formattedPrice}K';
}

/// Format price to full Rupiah without K suffix
/// Examples:
/// - 100000 -> "Rp. 100.000"
/// - 1500000 -> "Rp. 1.500.000"
String formatPriceToRupiah(int price) {
  final formatter = NumberFormat('#,##0', 'id_ID');
  final formattedPrice = formatter.format(price);

  return 'Rp. $formattedPrice';
}
