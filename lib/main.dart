import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//  AUTH
import 'services/auth_service.dart';

// PÁGINAS
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'package:movil_nudostudio/pages/admin_dashboard_page.dart';

// PROVIDERS
import 'providers/cart_provider.dart';
import 'providers/workshop_provider.dart';
import 'providers/enrollment_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        /// CARRITO
        ChangeNotifierProvider(
          create: (_) => CartProvider()..loadCart(),
        ),

        /// TALLERES
        ChangeNotifierProvider(
          create: (_) => WorkshopProvider(),
        ),

        /// MATRÍCULAS
        ChangeNotifierProvider(
          create: (_) => EnrollmentProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// OBTENER ROL
  Future<String?> getRole() async {
    return await AuthService.getRole();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: FutureBuilder<String?>(
        future: getRole(),
        builder: (context, snapshot) {

          /// CARGANDO
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final role = snapshot.data;

          ///  ADMIN → DASHBOARD
          if (role == "admin") {
            return const AdminDashboardPage();
          }

          ///  USER → APP NORMAL
          if (role == "user") {
            return const HomePage();
          }

          /// NO LOGIN
          return const LoginPage();
        },
      ),
    );
  }
}