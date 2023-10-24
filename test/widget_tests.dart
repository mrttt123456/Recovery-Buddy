import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stretchsafe/views/home_view.dart';
import 'package:stretchsafe/views/stretch_view.dart';
import 'package:stretchsafe/views/profile_view.dart';

void main() {
  testWidgets('HomeView should display the app bar with title', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.widgetWithText(AppBar, 'StretchSafe'), findsOneWidget);
  });

  testWidgets('BottomNavigationBar navigation', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Verify that HomeView is displayed initially
    expect(find.byType(HomeView), findsOneWidget);

    // Tap on the 'Stretches' tab
    await tester.tap(find.text('Stretches'));
    await tester.pumpAndSettle();

    // Verify that StretchView is displayed
    expect(find.byType(StretchView), findsOneWidget);

    // Tap on the 'Profile' tab
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    // Verify that ProfileView is displayed
    expect(find.byType(ProfileView), findsOneWidget);

    // Tap back on the 'Home' tab
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    // Verify that HomeView is displayed again
    expect(find.byType(HomeView), findsOneWidget);
  });
}
