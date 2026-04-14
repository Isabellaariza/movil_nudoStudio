import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/colors.dart';
import '../widgets/profile_actions.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Map<String, String> user = {};

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    final data = await AuthService.getUserData();
    setState(() => user = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE9),

      body: SafeArea(
        child: user.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [

                    /// TÍTULO
                    const SizedBox(height: 10),
                    const Text(
                      "Mi Perfil",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// CARD PRINCIPAL
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryGreen,
                            AppColors.primaryGreen.withOpacity(0.7)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        children: [

                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Text(
                                  user["name"]?.substring(0, 1) ?? "U",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: AppColors.primaryGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 15),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user["name"] ?? "Usuario",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    user["email"] ?? "",
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),

                          const SizedBox(height: 20),

                          /// STATS
                          Row(
                            children: [
                              _statCard("Compras", "12"),
                              const SizedBox(width: 10),
                              _statCard("Talleres", "3"),
                            ],
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// CONTACTO
                    _section(
                      title: "Información de Contacto",
                      children: [
                        _infoTile(Icons.email, user["email"] ?? ""),
                        _infoTile(Icons.phone, user["phone"] ?? "Sin teléfono"),
                        _infoTile(Icons.location_on, user["address"] ?? "Sin dirección"),
                      ],
                    ),

                    /// 🔥 BOTONES (AQUÍ SE APLICA COLOR GLOBAL)
                    Theme(
                      data: Theme.of(context).copyWith(
                        elevatedButtonTheme: ElevatedButtonThemeData(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, // 🔥 TEXTO BLANCO
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: ProfileActions(),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
      ),
    );
  }

  /// STATS
  Widget _statCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.white70)),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// SECCIÓN
  Widget _section({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  /// INFO TILE
  Widget _infoTile(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryGreen),
      title: Text(text),
    );
  }
}