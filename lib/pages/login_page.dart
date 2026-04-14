import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../services/auth_service.dart';
import 'package:movil_nudostudio/pages/home_page.dart';
import 'register_page.dart';
import 'admin_dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  ///  LOGIN REAL
  Future<void> login() async {
  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Completa todos los campos")),
    );
    return;
  }

  setState(() => isLoading = true);

  final error = await AuthService.login(
    emailController.text,
    passwordController.text,
  );

  setState(() => isLoading = false);

  if (error != null) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(error)));
    return;
  }

  /// OBTENER ROL
  final role = await AuthService.getRole();

  Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) =>
        role == "admin"
            ? const AdminDashboardPage()
            : const HomePage(),
  ),
);

  ///  ADMIN → DASHBOARD
  if (role == "admin") {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (_) => const AdminDashboardPage()),
    );
    return;
  }

  ///  USER → HOME
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const HomePage()),
  );
}

  ///  RECUPERAR PASSWORD
  Future<void> recoverPassword() async {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ingresa tu correo")),
      );
      return;
    }

    final pass =
        await AuthService.recoverPassword(emailController.text);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Recuperar contraseña"),
        content: Text(
          pass != null
              ? "Tu contraseña es: $pass"
              : "Correo no encontrado",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE3D3),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [

                ///  LOGO
                const Text(
                  "NUDO | Studio",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),

                const SizedBox(height: 30),

                /// CARD LOGIN
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                      )
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// TITULO
                      const Center(
                        child: Text(
                          "Iniciar Sesión",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Center(
                        child: Text(
                          "Ingresa a tu cuenta",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// EMAIL
                      const Text("Correo Electrónico"),
                      const SizedBox(height: 5),

                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "tu@correo.com",
                          filled: true,
                          fillColor: Colors.grey[100],
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      /// PASSWORD
                      const Text("Contraseña"),
                      const SizedBox(height: 5),

                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "********",
                          filled: true,
                          fillColor: Colors.grey[100],
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: const Icon(Icons.visibility_off),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// RECUPERAR PASSWORD
                      GestureDetector(
                        onTap: recoverPassword,
                        child: const Text(
                          "¿Olvidaste tu contraseña?",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 13,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      ///  BOTÓN LOGIN
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryGreen,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Iniciar Sesión",
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      ///  REGISTRO
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RegisterPage(),
                              ),
                            );
                          },
                          child: const Text.rich(
                            TextSpan(
                              text: "¿No tienes cuenta? ",
                              children: [
                                TextSpan(
                                  text: "Regístrate",
                                  style: TextStyle(color: Colors.orange),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}