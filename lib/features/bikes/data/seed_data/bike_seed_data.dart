import '../../domain/entities/bike.dart';

/// Seed data for 10 Electrum bikes.
/// Replace photoUrl values with your real Google Drive direct links.
const _placeholderImage =
    'https://via.placeholder.com/600x400.png?text=Electrum+Bike';

final List<Bike> bikeSeedData = [
  Bike(
    id: 'electrum-h1-city',
    model: 'Electrum H1 City',
    photoUrl: _placeholderImage,
    rangeKm: 70,
    isAvailable: true,
    pricePerDay: 20000,
    pickupAreas: ['SCBD', 'Kuningan', 'Kemang'],
  ),
  Bike(
    id: 'electrum-h1-plus',
    model: 'Electrum H1 Plus',
    photoUrl: _placeholderImage,
    rangeKm: 80,
    isAvailable: true,
    pricePerDay: 25000,
    pickupAreas: ['SCBD', 'Kuningan'],
  ),
  Bike(
    id: 'electrum-h2-commuter',
    model: 'Electrum H2 Commuter',
    photoUrl: _placeholderImage,
    rangeKm: 90,
    isAvailable: true,
    pricePerDay: 30000,
    pickupAreas: ['Kuningan', 'Kemang', 'Tebet'],
  ),
  Bike(
    id: 'electrum-h2-long-range',
    model: 'Electrum H2 Long Range',
    photoUrl: _placeholderImage,
    rangeKm: 110,
    isAvailable: true,
    pricePerDay: 40000,
    pickupAreas: ['SCBD', 'Kelapa Gading'],
  ),
  Bike(
    id: 'electrum-h3-cargo',
    model: 'Electrum H3 Cargo',
    photoUrl: _placeholderImage,
    rangeKm: 85,
    isAvailable: false,
    pricePerDay: 45000,
    pickupAreas: ['SCBD', 'Sudirman'],
  ),
  Bike(
    id: 'electrum-h3-pro',
    model: 'Electrum H3 Pro',
    photoUrl: _placeholderImage,
    rangeKm: 120,
    isAvailable: true,
    pricePerDay: 50000,
    pickupAreas: ['SCBD', 'Kuningan', 'Kelapa Gading'],
  ),
  Bike(
    id: 'electrum-urban-lite',
    model: 'Electrum Urban Lite',
    photoUrl: _placeholderImage,
    rangeKm: 60,
    isAvailable: true,
    pricePerDay: 18000,
    pickupAreas: ['Kemang', 'Tebet'],
  ),
  Bike(
    id: 'electrum-urban-go',
    model: 'Electrum Urban Go',
    photoUrl: _placeholderImage,
    rangeKm: 75,
    isAvailable: true,
    pricePerDay: 22000,
    pickupAreas: ['SCBD', 'Kuningan'],
  ),
  Bike(
    id: 'electrum-supercharged',
    model: 'Electrum Supercharged',
    photoUrl: _placeholderImage,
    rangeKm: 130,
    isAvailable: true,
    pricePerDay: 60000,
    pickupAreas: ['SCBD', 'Kuningan', 'Kelapa Gading'],
  ),
  Bike(
    id: 'electrum-night-owl',
    model: 'Electrum Night Owl',
    photoUrl: _placeholderImage,
    rangeKm: 95,
    isAvailable: false,
    pricePerDay: 35000,
    pickupAreas: ['SCBD', 'Kemang'],
  ),
];
