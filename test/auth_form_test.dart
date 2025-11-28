import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:electrum_ahmad/features/auth/presentation/widgets/shared/auth_form.dart';
import 'package:electrum_ahmad/features/auth/presentation/viewmodel/notifiers/auth_notifier.dart';
import 'package:electrum_ahmad/features/auth/domain/entities/user.dart';

// Mock AuthNotifier using mocktail
class MockAuthNotifier extends Mock implements AuthNotifier {}

void main() {
  group('AuthForm Widget Tests', () {
    late MockAuthNotifier mockAuthNotifier;

    setUp(() {
      mockAuthNotifier = MockAuthNotifier();
    });

    // Helper function to create widget under test
    Widget createTestWidget({required AsyncValue<User?> authState}) {
      // Stub the state getter
      when(() => mockAuthNotifier.state).thenReturn(authState);

      return ProviderScope(
        overrides: [authProvider.overrideWith(() => mockAuthNotifier)],
        child: const MaterialApp(home: Scaffold(body: AuthForm())),
      );
    }

    group('Initial Rendering (Login Mode)', () {
      testWidgets('should display login mode UI by default', (tester) async {
        // Arrange & Act
        await tester.pumpWidget(
          createTestWidget(authState: const AsyncValue.data(null)),
        );

        // Assert - Check header text
        expect(find.text('Your Next Ride'), findsOneWidget);
        expect(find.text('Starts Here'), findsOneWidget);

        // Assert - Check subtitle (only in login mode)
        expect(find.text('Explore Electrum bikes.'), findsOneWidget);
        expect(find.text('Hit the road fully charged ⚡'), findsOneWidget);

        // Assert - Check fields
        expect(find.text('Email'), findsOneWidget);
        expect(find.text('Password'), findsOneWidget);
        expect(
          find.text('Name'),
          findsNothing,
        ); // Name field should NOT be visible

        // Assert - Check button text
        expect(find.text('Sign in'), findsOneWidget);

        // Assert - Check toggle link
        expect(find.text('No account? '), findsOneWidget);
        expect(find.text('Sign up'), findsOneWidget);
      });

      testWidgets('should have email and password fields', (tester) async {
        // Arrange & Act
        await tester.pumpWidget(
          createTestWidget(authState: const AsyncValue.data(null)),
        );

        // Assert
        final emailField = find.widgetWithText(TextField, 'Example@email.com');
        final passwordField = find.widgetWithText(
          TextField,
          'Insert your password',
        );

        expect(emailField, findsOneWidget);
        expect(passwordField, findsOneWidget);
      });

      testWidgets('should have password visibility toggle button', (
        tester,
      ) async {
        // Arrange & Act
        await tester.pumpWidget(
          createTestWidget(authState: const AsyncValue.data(null)),
        );

        // Assert - Should find visibility_off icon (password is hidden by default)
        expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      });
    });

    group('Toggle Between Login and Register', () {
      testWidgets('should switch to register mode when "Sign up" is tapped', (
        tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          createTestWidget(authState: const AsyncValue.data(null)),
        );

        // Act - Tap "Sign up" link
        await tester.tap(find.text('Sign up'));
        await tester.pumpAndSettle();

        // Assert - Header should change
        expect(find.text('Create Account'), findsOneWidget);
        expect(find.text('Join Electrum'), findsOneWidget);

        // Assert - Subtitle should disappear
        expect(find.text('Explore Electrum bikes.'), findsNothing);
        expect(find.text('Hit the road fully charged ⚡'), findsNothing);

        // Assert - Name field should appear
        expect(find.text('Name'), findsOneWidget);

        // Assert - Button text should change
        expect(
          find.text('Sign up'),
          findsAtLeastNWidgets(1),
        ); // Button + link text

        // Assert - Toggle link should change
        expect(find.text('Already have an account? '), findsOneWidget);
        expect(find.text('Sign in'), findsOneWidget);
      });

      testWidgets('should switch back to login mode when "Sign in" is tapped', (
        tester,
      ) async {
        // Arrange - Start in register mode
        await tester.pumpWidget(
          createTestWidget(authState: const AsyncValue.data(null)),
        );
        await tester.tap(find.text('Sign up'));
        await tester.pumpAndSettle();

        // Verify we're in register mode
        expect(find.text('Create Account'), findsOneWidget);

        // Act - Tap "Sign in" link
        await tester.tap(
          find.text('Sign in').last,
        ); // Use .last to get the link, not the button
        await tester.pumpAndSettle();

        // Assert - Should be back in login mode
        expect(find.text('Your Next Ride'), findsOneWidget);
        expect(find.text('Starts Here'), findsOneWidget);
        expect(find.text('Name'), findsNothing);
      });
    });

    group('Text Input', () {
      testWidgets('should accept email input', (tester) async {
        // Arrange
        await tester.pumpWidget(
          createTestWidget(authState: const AsyncValue.data(null)),
        );

        // Act - Find email field and enter text
        final emailField = find.widgetWithText(TextField, 'Example@email.com');
        await tester.enterText(emailField, 'test@example.com');
        await tester.pump();

        // Assert
        expect(find.text('test@example.com'), findsOneWidget);
      });

      testWidgets('should accept password input', (tester) async {
        // Arrange
        await tester.pumpWidget(
          createTestWidget(authState: const AsyncValue.data(null)),
        );

        // Act - Find password field and enter text
        final passwordField = find.widgetWithText(
          TextField,
          'Insert your password',
        );
        await tester.enterText(passwordField, 'secretPassword123');
        await tester.pump();

        // Assert - Text is entered (even though it's obscured in the UI)
        final textField = tester.widget<TextField>(passwordField);
        expect(textField.controller?.text, 'secretPassword123');
      });

      testWidgets('should accept name input in register mode', (tester) async {
        // Arrange - Switch to register mode
        await tester.pumpWidget(
          createTestWidget(authState: const AsyncValue.data(null)),
        );
        await tester.tap(find.text('Sign up'));
        await tester.pumpAndSettle();

        // Act - Find name field and enter text
        final nameField = find.widgetWithText(TextField, 'Your full name');
        await tester.enterText(nameField, 'John Doe');
        await tester.pump();

        // Assert
        expect(find.text('John Doe'), findsOneWidget);
      });
    });

    group('Password Visibility Toggle', () {
      testWidgets('should toggle password visibility when icon is tapped', (
        tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          createTestWidget(authState: const AsyncValue.data(null)),
        );

        // Initially should show visibility_off icon (password hidden)
        expect(find.byIcon(Icons.visibility_off), findsOneWidget);
        expect(find.byIcon(Icons.visibility), findsNothing);

        // Act - Tap the visibility toggle button
        await tester.tap(find.byIcon(Icons.visibility_off));
        await tester.pump();

        // Assert - Icon should change to visibility (password visible)
        expect(find.byIcon(Icons.visibility), findsOneWidget);
        expect(find.byIcon(Icons.visibility_off), findsNothing);

        // Act - Tap again to hide
        await tester.tap(find.byIcon(Icons.visibility));
        await tester.pump();

        // Assert - Back to visibility_off
        expect(find.byIcon(Icons.visibility_off), findsOneWidget);
        expect(find.byIcon(Icons.visibility), findsNothing);
      });
    });
  });
}
