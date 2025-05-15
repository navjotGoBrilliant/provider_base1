import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/routes/route_generator.dart';
import 'common/custom_colors.dart';
import 'features/authentication/provider/auth_provider.dart';
import 'features/dashboard/provider/bottom_navigation_provider.dart';
import 'features/shopping/provider/cart_provider.dart';
import 'features/shopping/provider/favorite_provider.dart';
import 'features/shopping/provider/product_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      // light: ThemeData.light(useMaterial3: true),
      // dark: ThemeData.dark(useMaterial3: true),
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        /// Define custom colors for light theme
        extensions: <ThemeExtension<dynamic>>[
          CustomColors(
            buttonColor: Colors.blue[800],
            buttonTextColor: Colors.white,
            primaryColor: Colors.blue[800],
            backgroundColor: Colors.white,
            primaryTextColor: Colors.black,
            secondaryTextColor: Colors.grey[700], // Example of a lighter shade
            hintColor: Colors.grey[400],
            iconColor: Colors.blue[800],
            // ... other custom colors for light theme
          ),
        ],
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        /// Define custom colors for dark theme
        extensions: <ThemeExtension<dynamic>>[
          CustomColors(
            buttonColor: Colors.grey[800],
            buttonTextColor:  Colors.white60,
            primaryColor: Colors.black45,
            backgroundColor: Colors.black12,
            primaryTextColor: Colors.white,
            secondaryTextColor: Colors.grey[300],  // Example for dark theme
            hintColor: Colors.grey[600],
            iconColor:  Colors.grey[800],
            // ... other custom colors for dark theme
          ),
        ],
      ),
      debugShowFloatingThemeButton: true,
      initial: AdaptiveThemeMode.dark,
      builder:
          (theme, darkTheme) => MaterialApp.router(
            title: 'Provider Base 1', // Keep the same title
            debugShowCheckedModeBanner: false,
            theme: theme,
            routerConfig: RouteGenerator.router,
          ),
    );
  }
}
