import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/animated_button.dart';
import '../utils/page_transition.dart';
import 'catalog_page.dart';
import 'talleres_page.dart';
import 'perfil_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _fade = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _slide = Tween(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(_controller);

    _controller.forward();
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _getPage() {
    switch (_selectedIndex) {
      case 1:
        return const CatalogPage();
      case 2:
        return const TalleresPage();
      case 3:
        return const PerfilPage();
      default:
        return FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: _homeContent(),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: _getPage(),

      // 🔻 BOTTOM NAV COMPLETO
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Inicio"),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded), label: "Catálogo"),
          BottomNavigationBarItem(
              icon: Icon(Icons.school_outlined), label: "Talleres"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Perfil"),
        ],
      ),
    );
  }

  Widget _homeContent() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "NUDO Studio",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen),
                ),
                Row(
                  children: [
                    Stack(
                      children: [
                        const Icon(Icons.notifications_none),
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: AppColors.accentGold,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              "3",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 10),
                    const CircleAvatar(
                      backgroundColor: AppColors.primaryGreen,
                      child: Text("I", style: TextStyle(color: Colors.white)),
                    )
                  ],
                )
              ],
            ),

            const SizedBox(height: 30),

            // TARJETA
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  const Text(
                    "Creaciones",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen),
                  ),
                  const Text(
                    "Únicas",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentGold),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Descubre el arte del macramé y tejido textil. Cada pieza cuenta una historia. Cada pieza cuenta una historia, cada nudo abraza la tradición cun un toque contemporáneo.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textDark),
                  ),

                  const SizedBox(height: 20),

                  // BADGE
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.star, color: AppColors.accentGold),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("100% Artesanal",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Hecho a mano con amor",
                                style: TextStyle(fontSize: 12)),
                          ],
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // BOTÓN PRINCIPAL
                  AnimatedButton(
                    text: "Explorar Catálogo",
                    onTap: () {
                      Navigator.push(
                        context,
                        FadeRoute(page: const CatalogPage()),
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  // BOTÓN SECUNDARIO
                  AnimatedButton(
                    text: "Ver Talleres",
                    filled: false,
                    onTap: () {
                      Navigator.push(
                        context,
                        FadeRoute(page: const TalleresPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}