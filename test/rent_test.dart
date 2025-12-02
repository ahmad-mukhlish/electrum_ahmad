import 'package:flutter_test/flutter_test.dart';
import 'package:electrum_ahmad/features/rents/domain/helpers/rent_calculator.dart';

void main() {
  group('RentCalculator Business Logic Tests', () {
    group('calculateTotalDays', () {
      test('should calculate 1 day for same date (inclusive)', () {
        // Arrange
        final fromDate = DateTime(2025, 1, 1);
        final toDate = DateTime(2025, 1, 1);

        // Act
        final result = RentCalculator.calculateTotalDays(fromDate, toDate);

        // Assert
        expect(result, 1);
      });

      test('should calculate 2 days for consecutive dates', () {
        // Arrange
        final fromDate = DateTime(2025, 1, 1);
        final toDate = DateTime(2025, 1, 2);

        // Act
        final result = RentCalculator.calculateTotalDays(fromDate, toDate);

        // Assert
        expect(result, 2);
      });

      test('should calculate 7 days for one week rental', () {
        // Arrange
        final fromDate = DateTime(2025, 1, 1);
        final toDate = DateTime(2025, 1, 7);

        // Act
        final result = RentCalculator.calculateTotalDays(fromDate, toDate);

        // Assert
        expect(result, 7);
      });

      test('should calculate 30 days for one month rental', () {
        // Arrange
        final fromDate = DateTime(2025, 1, 1);
        final toDate = DateTime(2025, 1, 30);

        // Act
        final result = RentCalculator.calculateTotalDays(fromDate, toDate);

        // Assert
        expect(result, 30);
      });

      test('should handle month boundary correctly', () {
        // Arrange
        final fromDate = DateTime(2025, 1, 30);
        final toDate = DateTime(2025, 2, 2);

        // Act
        final result = RentCalculator.calculateTotalDays(fromDate, toDate);

        // Assert
        expect(result, 4); // Jan 30, Jan 31, Feb 1, Feb 2 = 4 days
      });
    });

    group('calculateTotalAmount', () {
      test('should calculate correct amount for 1 day', () {
        // Arrange
        final fromDate = DateTime(2025, 1, 1);
        final toDate = DateTime(2025, 1, 1);
        const pricePerDay = 50000;

        // Act
        final result = RentCalculator.calculateTotalAmount(
          fromDate: fromDate,
          toDate: toDate,
          pricePerDay: pricePerDay,
        );

        // Assert
        expect(result, 50000);
      });

      test('should calculate correct amount for 7 days', () {
        // Arrange
        final fromDate = DateTime(2025, 1, 1);
        final toDate = DateTime(2025, 1, 7);
        const pricePerDay = 50000;

        // Act
        final result = RentCalculator.calculateTotalAmount(
          fromDate: fromDate,
          toDate: toDate,
          pricePerDay: pricePerDay,
        );

        // Assert
        expect(result, 350000); // 7 days × 50,000 = 350,000
      });

      test('should calculate correct amount for 30 days', () {
        // Arrange
        final fromDate = DateTime(2025, 1, 1);
        final toDate = DateTime(2025, 1, 30);
        const pricePerDay = 50000;

        // Act
        final result = RentCalculator.calculateTotalAmount(
          fromDate: fromDate,
          toDate: toDate,
          pricePerDay: pricePerDay,
        );

        // Assert
        expect(result, 1500000); // 30 days × 50,000 = 1,500,000
      });

      test('should handle different price per day', () {
        // Arrange
        final fromDate = DateTime(2025, 1, 1);
        final toDate = DateTime(2025, 1, 5);
        const pricePerDay = 75000;

        // Act
        final result = RentCalculator.calculateTotalAmount(
          fromDate: fromDate,
          toDate: toDate,
          pricePerDay: pricePerDay,
        );

        // Assert
        expect(result, 375000); // 5 days × 75,000 = 375,000
      });

      test('should handle zero price per day', () {
        // Arrange
        final fromDate = DateTime(2025, 1, 1);
        final toDate = DateTime(2025, 1, 5);
        const pricePerDay = 0;

        // Act
        final result = RentCalculator.calculateTotalAmount(
          fromDate: fromDate,
          toDate: toDate,
          pricePerDay: pricePerDay,
        );

        // Assert
        expect(result, 0);
      });
    });

    group('isValidRentalPeriod', () {
      test('should return true when toDate equals fromDate', () {
        // Arrange
        final fromDate = DateTime(2025, 1, 1);
        final toDate = DateTime(2025, 1, 1);

        // Act
        final result = RentCalculator.isValidRentalPeriod(fromDate, toDate);

        // Assert
        expect(result, true);
      });

      test('should return true when toDate is after fromDate', () {
        // Arrange
        final fromDate = DateTime(2025, 1, 1);
        final toDate = DateTime(2025, 1, 5);

        // Act
        final result = RentCalculator.isValidRentalPeriod(fromDate, toDate);

        // Assert
        expect(result, true);
      });

      test('should return false when toDate is before fromDate', () {
        // Arrange
        final fromDate = DateTime(2025, 1, 5);
        final toDate = DateTime(2025, 1, 1);

        // Act
        final result = RentCalculator.isValidRentalPeriod(fromDate, toDate);

        // Assert
        expect(result, false);
      });

      test('should return false when toDate is one day before fromDate', () {
        // Arrange
        final fromDate = DateTime(2025, 1, 2);
        final toDate = DateTime(2025, 1, 1);

        // Act
        final result = RentCalculator.isValidRentalPeriod(fromDate, toDate);

        // Assert
        expect(result, false);
      });
    });

    group('Edge Cases', () {
      test('should handle leap year correctly', () {
        // Arrange
        final fromDate = DateTime(2024, 2, 28); // Leap year
        final toDate = DateTime(2024, 3, 1);

        // Act
        final totalDays = RentCalculator.calculateTotalDays(fromDate, toDate);

        // Assert
        expect(totalDays, 3); // Feb 28, Feb 29, Mar 1 = 3 days
      });

      test('should handle year boundary correctly', () {
        // Arrange
        final fromDate = DateTime(2024, 12, 30);
        final toDate = DateTime(2025, 1, 2);

        // Act
        final totalDays = RentCalculator.calculateTotalDays(fromDate, toDate);

        // Assert
        expect(totalDays, 4); // Dec 30, Dec 31, Jan 1, Jan 2 = 4 days
      });

      test('should handle large rental periods', () {
        // Arrange
        final fromDate = DateTime(2025, 1, 1);
        final toDate = DateTime(2025, 12, 31);
        const pricePerDay = 50000;

        // Act
        final totalDays = RentCalculator.calculateTotalDays(fromDate, toDate);
        final totalAmount = RentCalculator.calculateTotalAmount(
          fromDate: fromDate,
          toDate: toDate,
          pricePerDay: pricePerDay,
        );

        // Assert
        expect(totalDays, 365); // Full year
        expect(totalAmount, 18250000); // 365 days × 50,000
      });
    });
  });
}
