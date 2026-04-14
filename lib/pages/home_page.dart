import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/colors.dart';

import 'catalog_page.dart';
import 'talleres_page.dart';
import 'perfil_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String role = "user";

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      HomeContent(onNavigate: _onItemTapped, role: role),
      const CatalogPage(),
      const TalleresPage(),
      const PerfilPage(),
    ];

    loadRole();
  }

  void loadRole() async {
    final r = await AuthService.getRole();
    setState(() {
      role = r ?? "user";
      _pages[0] = HomeContent(onNavigate: _onItemTapped, role: role);
    });
  }

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE9),

      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Catálogo"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Talleres"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final Function(int) onNavigate;
  final String role;

  const HomeContent({
    super.key,
    required this.onNavigate,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [

            /// HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text("NUDO",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2)),
                      SizedBox(width: 6),
                      Text("| Studio", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          const Icon(Icons.notifications_none),
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                  color: Colors.orange, shape: BoxShape.circle),
                              child: const Text("3",
                                  style: TextStyle(fontSize: 10)),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 10),
                      const CircleAvatar(child: Text("J"))
                    ],
                  )
                ],
              ),
            ),

            const Divider(),

            /// HERO
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color(0xFFF2ECE4),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  const Text("Creaciones",
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryGreen)),
                  const Text("Únicas",
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentGold)),

                  const SizedBox(height: 10),

                  const Text(
                    "Descubre el arte del macramé y tejido textil. Cada pieza cuenta una historia.",
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 5)
                      ],
                    ),
                    child: const Column(
                      children: [
                        Text("⭐ 100% Artesanal"),
                        Text("Hecho a mano con amor",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// BOTÓN VERDE
                  ElevatedButton(
                    onPressed: () => onNavigate(1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 16),
                    ),
                    child: const Text(
                      "Explorar Catálogo",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 10),

                  OutlinedButton(
                    onPressed: () => onNavigate(2),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text("Ver Talleres"),
                  ),
                ],
              ),
            ),

            /// SECCIONES
            _section("¿Por Qué Elegirnos?"),
            _card("Artesanía Única", "Cada pieza es creada a mano con dedicación"),
            _card("Diseño Personalizado", "Creamos piezas únicas adaptadas a ti"),
            _card("Talleres & Aprendizaje", "Aprende con nuestros expertos"),

            _section("Testimonios"),
            _testimonio("María González", "Las piezas son hermosas"),
            _testimonio("Carlos Ramírez", "Excelente calidad"),
            _testimonio("Ana Torres", "Experiencia única"),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _section(String t) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(t,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }

  Widget _card(String t, String d) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: AppColors.primaryGreen),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(d, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _testimonio(String name, String text) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.brown.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.person, color: AppColors.primaryGreen),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(text, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}