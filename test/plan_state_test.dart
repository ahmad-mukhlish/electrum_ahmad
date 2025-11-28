import 'package:flutter_test/flutter_test.dart';
import 'package:electrum_ahmad/features/home/domain/entities/plan/plan.dart';
import 'package:electrum_ahmad/features/home/domain/entities/plan/plan_period.dart';
import 'package:electrum_ahmad/features/home/presentation/viewmodel/states/plan_state.dart';

void main() {
  group('PlanState Presentation Logic Tests', () {
    // Helper function to create a test Plan
    Plan createTestPlan({
      int id = 1,
      String name = 'Basic Plan',
      String tagline = 'Great for beginners',
      int pricePerDay = 50000,
      int pricePerWeek = 300000,
      int pricePerMonth = 1200000,
      String bestFor = 'Daily commuters',
      List<String> terms = const [],
      String hexColor = 'FFFFFFFF',
    }) {
      return Plan(
        id: id,
        name: name,
        tagline: tagline,
        pricePerDay: pricePerDay,
        pricePerWeek: pricePerWeek,
        pricePerMonth: pricePerMonth,
        bestFor: bestFor,
        terms: terms,
        hexColor: hexColor,
      );
    }

    group('fromPlan factory constructor', () {
      test('should create PlanState with correct weekly discount calculation', () {
        // Arrange
        // pricePerDay: 50,000
        // pricePerWeek: 300,000
        // Expected weekly discount: ((50,000 * 7) - 300,000) / (50,000 * 7) * 100
        // = (350,000 - 300,000) / 350,000 * 100 = 14.285714...%
        final plan = createTestPlan(
          pricePerDay: 50000,
          pricePerWeek: 300000,
        );

        // Act
        final planState = PlanState.fromPlan(plan);

        // Assert
        expect(planState.plan, plan);
        expect(planState.percentagePlanDiscountWeekly, closeTo(14.285714, 0.00001));
      });

      test('should create PlanState with correct monthly discount calculation', () {
        // Arrange
        // pricePerDay: 50,000
        // pricePerMonth: 1,200,000
        // Expected monthly discount: ((50,000 * 30) - 1,200,000) / (50,000 * 30) * 100
        // = (1,500,000 - 1,200,000) / 1,500,000 * 100 = 20%
        final plan = createTestPlan(
          pricePerDay: 50000,
          pricePerMonth: 1200000,
        );

        // Act
        final planState = PlanState.fromPlan(plan);

        // Assert
        expect(planState.plan, plan);
        expect(planState.percentagePlanDiscountMonthly, 20.0);
      });

      test('should handle zero discount when weekly price equals daily price × 7', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 50000,
          pricePerWeek: 350000, // 50,000 * 7 = 350,000 (no discount)
        );

        // Act
        final planState = PlanState.fromPlan(plan);

        // Assert
        expect(planState.percentagePlanDiscountWeekly, 0.0);
      });

      test('should handle zero discount when monthly price equals daily price × 30', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 50000,
          pricePerMonth: 1500000, // 50,000 * 30 = 1,500,000 (no discount)
        );

        // Act
        final planState = PlanState.fromPlan(plan);

        // Assert
        expect(planState.percentagePlanDiscountMonthly, 0.0);
      });

      test('should handle zero pricePerDay gracefully', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 0,
          pricePerWeek: 300000,
          pricePerMonth: 1200000,
        );

        // Act
        final planState = PlanState.fromPlan(plan);

        // Assert
        expect(planState.percentagePlanDiscountWeekly, 0.0);
        expect(planState.percentagePlanDiscountMonthly, 0.0);
      });

      test('should calculate 50% weekly discount correctly', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 100000,
          pricePerWeek: 350000, // 50% discount: (100,000 * 7 = 700,000)
        );

        // Act
        final planState = PlanState.fromPlan(plan);

        // Assert
        expect(planState.percentagePlanDiscountWeekly, 50.0);
      });

      test('should calculate 50% monthly discount correctly', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 100000,
          pricePerMonth: 1500000, // 50% discount: (100,000 * 30 = 3,000,000)
        );

        // Act
        final planState = PlanState.fromPlan(plan);

        // Assert
        expect(planState.percentagePlanDiscountMonthly, 50.0);
      });

      test('should clamp negative discount to 0 when discounted price is higher', () {
        // Arrange - weekly price is higher than daily × 7 (negative discount)
        final plan = createTestPlan(
          pricePerDay: 50000,
          pricePerWeek: 400000, // Higher than 350,000 (negative discount)
        );

        // Act
        final planState = PlanState.fromPlan(plan);

        // Assert
        expect(planState.percentagePlanDiscountWeekly, 0.0);
      });
    });

    group('getPriceForPeriod', () {
      test('should return daily price when period is daily', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 50000,
          pricePerWeek: 300000,
          pricePerMonth: 1200000,
        );
        final planState = PlanState.fromPlan(plan);

        // Act
        final price = planState.getPriceForPeriod(PlanPeriod.daily);

        // Assert
        expect(price, 50000);
      });

      test('should return weekly price when period is weekly', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 50000,
          pricePerWeek: 300000,
          pricePerMonth: 1200000,
        );
        final planState = PlanState.fromPlan(plan);

        // Act
        final price = planState.getPriceForPeriod(PlanPeriod.weekly);

        // Assert
        expect(price, 300000);
      });

      test('should return monthly price when period is monthly', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 50000,
          pricePerWeek: 300000,
          pricePerMonth: 1200000,
        );
        final planState = PlanState.fromPlan(plan);

        // Act
        final price = planState.getPriceForPeriod(PlanPeriod.monthly);

        // Assert
        expect(price, 1200000);
      });
    });

    group('getDiscountForPeriod', () {
      test('should return 0 discount for daily period', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 50000,
          pricePerWeek: 300000,
          pricePerMonth: 1200000,
        );
        final planState = PlanState.fromPlan(plan);

        // Act
        final discount = planState.getDiscountForPeriod(PlanPeriod.daily);

        // Assert
        expect(discount, 0.0);
      });

      test('should return weekly discount for weekly period', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 50000,
          pricePerWeek: 300000, // ~14.29% discount
        );
        final planState = PlanState.fromPlan(plan);

        // Act
        final discount = planState.getDiscountForPeriod(PlanPeriod.weekly);

        // Assert
        expect(discount, closeTo(14.285714, 0.00001));
      });

      test('should return monthly discount for monthly period', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 50000,
          pricePerMonth: 1200000, // 20% discount
        );
        final planState = PlanState.fromPlan(plan);

        // Act
        final discount = planState.getDiscountForPeriod(PlanPeriod.monthly);

        // Assert
        expect(discount, 20.0);
      });
    });

    group('getOriginalPriceForPeriod', () {
      test('should return daily price for daily period (same as actual price)', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 50000,
          pricePerWeek: 300000,
          pricePerMonth: 1200000,
        );
        final planState = PlanState.fromPlan(plan);

        // Act
        final originalPrice = planState.getOriginalPriceForPeriod(PlanPeriod.daily);

        // Assert
        expect(originalPrice, 50000);
      });

      test('should return daily price × 7 for weekly period', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 50000,
          pricePerWeek: 300000,
        );
        final planState = PlanState.fromPlan(plan);

        // Act
        final originalPrice = planState.getOriginalPriceForPeriod(PlanPeriod.weekly);

        // Assert
        expect(originalPrice, 350000); // 50,000 * 7
      });

      test('should return daily price × 30 for monthly period', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 50000,
          pricePerMonth: 1200000,
        );
        final planState = PlanState.fromPlan(plan);

        // Act
        final originalPrice = planState.getOriginalPriceForPeriod(PlanPeriod.monthly);

        // Assert
        expect(originalPrice, 1500000); // 50,000 * 30
      });
    });

    group('Edge Cases and Real-World Scenarios', () {
      test('should handle large price values', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 1000000, // 1 million per day
          pricePerWeek: 6000000, // ~14.29% discount
          pricePerMonth: 24000000, // 20% discount
        );

        // Act
        final planState = PlanState.fromPlan(plan);

        // Assert
        expect(planState.getPriceForPeriod(PlanPeriod.daily), 1000000);
        expect(planState.getPriceForPeriod(PlanPeriod.weekly), 6000000);
        expect(planState.getPriceForPeriod(PlanPeriod.monthly), 24000000);
        expect(planState.getDiscountForPeriod(PlanPeriod.weekly), closeTo(14.285714, 0.00001));
        expect(planState.getDiscountForPeriod(PlanPeriod.monthly), 20.0);
      });

      test('should handle small price values', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 1000,
          pricePerWeek: 6000,
          pricePerMonth: 24000,
        );

        // Act
        final planState = PlanState.fromPlan(plan);

        // Assert
        expect(planState.getPriceForPeriod(PlanPeriod.daily), 1000);
        expect(planState.getDiscountForPeriod(PlanPeriod.weekly), closeTo(14.285714, 0.00001));
        expect(planState.getDiscountForPeriod(PlanPeriod.monthly), 20.0);
      });

      test('should correctly calculate savings example', () {
        // Arrange - Scenario: User wants to know savings
        // Daily: 75,000
        // Weekly: 450,000 (75,000 * 7 = 525,000, saves 75,000 = 14.29%)
        // Monthly: 1,800,000 (75,000 * 30 = 2,250,000, saves 450,000 = 20%)
        final plan = createTestPlan(
          pricePerDay: 75000,
          pricePerWeek: 450000,
          pricePerMonth: 1800000,
        );
        final planState = PlanState.fromPlan(plan);

        // Act & Assert - Weekly
        final weeklyOriginal = planState.getOriginalPriceForPeriod(PlanPeriod.weekly);
        final weeklyActual = planState.getPriceForPeriod(PlanPeriod.weekly);
        final weeklySavings = weeklyOriginal - weeklyActual;

        expect(weeklyOriginal, 525000);
        expect(weeklyActual, 450000);
        expect(weeklySavings, 75000);
        expect(planState.getDiscountForPeriod(PlanPeriod.weekly), closeTo(14.285714, 0.00001));

        // Act & Assert - Monthly
        final monthlyOriginal = planState.getOriginalPriceForPeriod(PlanPeriod.monthly);
        final monthlyActual = planState.getPriceForPeriod(PlanPeriod.monthly);
        final monthlySavings = monthlyOriginal - monthlyActual;

        expect(monthlyOriginal, 2250000);
        expect(monthlyActual, 1800000);
        expect(monthlySavings, 450000);
        expect(planState.getDiscountForPeriod(PlanPeriod.monthly), 20.0);
      });

      test('should handle 100% discount (free weekly)', () {
        // Arrange
        final plan = createTestPlan(
          pricePerDay: 50000,
          pricePerWeek: 0, // Free!
        );

        // Act
        final planState = PlanState.fromPlan(plan);

        // Assert
        expect(planState.getDiscountForPeriod(PlanPeriod.weekly), 100.0);
        expect(planState.getPriceForPeriod(PlanPeriod.weekly), 0);
      });
    });
  });
}
