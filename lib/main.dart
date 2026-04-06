import 'package:flutter/material.dart';

import 'home_page.dart';    // El archivo de Inicio que acabamos de arreglar
import 'catalogo.dart';     // El archivo del catálogo
import 'talleres.dart';     // El archivo de talleres

void main() => runApp(const NudoApp());

class NudoApp extends StatelessWidget {
  const NudoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nudo Studio',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F8F4),
        // Aplicamos un estilo de letra limpio
        fontFamily: 'sans-serif', 
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const MainNavigationControl(),
    );
  }
}

class MainNavigationControl extends StatefulWidget {
  const MainNavigationControl({super.key});

  @override
  State<MainNavigationControl> createState() => _MainNavigationControlState();
}

class _MainNavigationControlState extends State<MainNavigationControl> {
  int _selectedIndex = 0;

  // Lista de las pantallas unificadas
  // Asegúrate de que los nombres de las clases (InicioPage, etc.) 
  // sean los mismos que están dentro de los archivos.
  final List<Widget> _screens = [
    const InicioPage(),     // Clase dentro de home_page.dart
    const CatalogoPage(),   // Clase dentro de catalogo.dart
    const TalleresPage(),   // Clase dentro de talleres.dart
    const Center(child: Text('Perfil en construcción')), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Este AppBar es el Header fijo para todas las secciones
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'N U D O',
              style: TextStyle(
                color: Color(0xFF384E3D), 
                fontWeight: FontWeight.bold, 
                letterSpacing: 2,
              ),
            ),
            Container(
              width: 1, 
              height: 20, 
              color: Colors.grey.shade300, 
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            const Text(
              'Studio', 
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
        actions: [
          // Icono de notificaciones con el punto ámbar de Nudo
          Stack(
            alignment: Alignment.center,
            children: [
              const Icon(Icons.notifications_none, color: Color(0xFF384E3D)),
              Positioned(
                right: 0,
                top: 15,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Color(0xFFB68D14),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "3",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          // Avatar con la inicial
          const CircleAvatar(
            backgroundColor: Color(0xFF384E3D),
            radius: 15,
            child: Text(
              'I', 
              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      
      // IndexedStack mantiene el estado de las páginas al cambiar
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF384E3D),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), 
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined), 
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Catálogo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined), 
            activeIcon: Icon(Icons.school),
            label: 'Talleres',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), 
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}