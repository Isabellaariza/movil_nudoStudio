import 'package:flutter/material.dart';

void main() => runApp(const NudoApp());

class NudoApp extends StatelessWidget {
  const NudoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F9F7), // Fondo hueso
        primaryColor: const Color(0xFF2D4438),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    const Center(child: Text('Inicio')),
    const CatalogoPage(),
    const TalleresPage(),
    const Center(child: Text('Perfil')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2D4438),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_mall),
            label: 'Catálogo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            label: 'Talleres',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

// --- CUERPO DEL CATÁLOGO ---
class CatalogoPage extends StatelessWidget {
  const CatalogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- CUADRO DEL HEADER ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Color(0xFF2D4438),
                      ),
                      children: [
                        TextSpan(text: 'N U D O '),
                        TextSpan(
                          text: '| Studio',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          const Icon(Icons.notifications_none, size: 28),
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: Color(0xFFB58D1E),
                                shape: BoxShape.circle,
                              ),
                              child: const Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 15),
                      const CircleAvatar(
                        backgroundColor: Color(0xFF2D4438),
                        radius: 18,
                        child: Text('I', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          "Nuestro Catálogo",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0A2E2E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 40,
                          height: 3,
                          color: const Color(0xFFB58D1E),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Buscar productos...",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: const Icon(Icons.tune),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildCategoryChip("Todos", isSelected: true),
                      const SizedBox(width: 10),
                      _buildCategoryChip("Macramé"),
                      const SizedBox(width: 10),
                      _buildCategoryChip("Joyería"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "8 productos encontrados",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 15),

                  // --- GRID DE PRODUCTOS ---
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    children: const [
                      ProductCard(
                        title: "Macramé Decorativo Grande",
                        price: "45.000",
                        tag: "Macramé",
                        stock: "5",
                        imageUrl:
                            "https://images.unsplash.com/photo-1515516089376-88db1e26e9c0?q=80&w=500",
                      ),
                      ProductCard(
                        title: "Collar Textil Bohemio",
                        price: "28.000",
                        tag: "Joyería",
                        stock: "12",
                        imageUrl:
                            "https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?q=80&w=500",
                      ),
                      ProductCard(
                        title: "Espejo Circular Macramé",
                        price: "35.000",
                        tag: "Macramé",
                        stock: "3",
                        imageUrl:
                            "https://images.unsplash.com/photo-1617233331420-5627f677027b?q=80&w=500",
                      ),
                      ProductCard(
                        title: "Pulsera de Hilos Plata",
                        price: "15.000",
                        tag: "Joyería",
                        stock: "20",
                        imageUrl:
                            "https://images.unsplash.com/photo-1611591637522-523ad5878595?q=80&w=500",
                      ),
                      ProductCard(
                        title: "Lámpara Colgante Boho",
                        price: "60.000",
                        tag: "Macramé",
                        stock: "2",
                        imageUrl:
                            "https://images.unsplash.com/photo-1540932239986-30128078f3c5?q=80&w=500",
                      ),
                      ProductCard(
                        title: "Pendientes de Cristal",
                        price: "22.000",
                        tag: "Joyería",
                        stock: "8",
                        imageUrl:
                            "https://images.unsplash.com/photo-1535132001153-6a568019e072?q=80&w=500",
                      ),
                      ProductCard(
                        title: "Tapiz de Pared 'Hojas'",
                        price: "38.000",
                        tag: "Macramé",
                        stock: "4",
                        imageUrl:
                            "https://images.unsplash.com/photo-1620662693330-86c2e391b65e?q=80&w=500",
                      ),
                      ProductCard(
                        title: "Anillo Ajustable Artesanal",
                        price: "18.000",
                        tag: "Joyería",
                        stock: "15",
                        imageUrl:
                            "https://images.unsplash.com/photo-1605100804763-247f67b3557e?q=80&w=500",
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2D4438) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: isSelected ? null : Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// --- TARJETA DE PRODUCTO ---
class ProductCard extends StatelessWidget {
  final String title, price, tag, stock, imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.tag,
    required this.stock,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          ),
                        ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D4438),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Stock: $stock",
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$$price",
                      style: const TextStyle(
                        color: Color(0xFFB58D1E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D4438),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TalleresPage extends StatelessWidget {
  const TalleresPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Talleres",
          style: TextStyle(
            color: Color(0xFF2D4438),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(child: Text("Sección de Talleres en construcción")),
    );
  }
}


