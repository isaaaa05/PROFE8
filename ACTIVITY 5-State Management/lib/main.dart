import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/todo_provider.dart';
import '../models/reservation.dart';
import 'views/splash_screen.dart';
import 'views/home_screen.dart';
import 'views/about_screen.dart';
import 'views/contact_screen.dart';
import 'views/login_screen.dart';
import 'views/registration_screen.dart';
import 'views/reservation_screen.dart';
import 'views/payment_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // COMPONENT 1 & 2: Provider with ChangeNotifier for cart
        ChangeNotifierProvider(create: (_) => CartProvider()),
        // COMPONENT 4: Theme switcher using Provider
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        // COMPONENT 5: To-do list using Provider
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: const TicketMasterLiveApp(),
    ),
  );
}

class TicketMasterLiveApp extends StatelessWidget {
  const TicketMasterLiveApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // COMPONENT 3: Using context.watch() to listen to theme changes
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'TicketMaster Live',
      debugShowCheckedModeBanner: false,
      // COMPONENT 4: Theme changes based on Provider state
      theme: themeProvider.isDarkMode ? _darkTheme() : _lightTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/about': (context) => const AboutScreen(),
        '/contact': (context) => const ContactScreen(),
        '/login': (context) => const LoginScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/reservation': (context) => const ReservationScreen(),
        '/payment': (context) {
          // Extract the required reservation argument from route settings
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is! Reservation) {
            // Fallback or error handling if no reservation provided
            // For now, throwing an error; in production, you might redirect or show an error screen
            throw ArgumentError(
                'Reservation argument is required for PaymentScreen');
          }
          return PaymentScreen(reservation: args);
        }, // Payment screen is accessed via direct navigation from cart/reservation screens
      },
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF2196F3),
      scaffoldBackgroundColor: const Color(0xFFF5F5DC),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2196F3),
        secondary: const Color(0xFFF5F5DC),
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF2196F3),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2196F3),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF2196F3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF2196F3), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2),
        ),
      ),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF64B5F6),
      scaffoldBackgroundColor: const Color(0xFF1E1E1E),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF64B5F6),
        brightness: Brightness.dark,
        primary: const Color(0xFF64B5F6),
        secondary: const Color(0xFFD4A574),
        surface: const Color(0xFF2C2C2C),
      ),
      cardColor: const Color(0xFF2C2C2C),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF2C2C2C),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Color(0xFFE0E0E0)),
        titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: Colors.white),
        labelLarge: TextStyle(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF64B5F6),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        labelStyle: const TextStyle(color: Color(0xFFE0E0E0)),
        hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF64B5F6)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF424242), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF64B5F6), width: 2),
        ),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF64B5F6)),
      listTileTheme: const ListTileThemeData(
        textColor: Colors.white,
        iconColor: Color(0xFF64B5F6),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color(0xFF2C2C2C),
      ),
    );
  }
}
