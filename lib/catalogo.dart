import 'package:flutter/material.dart';

class CatalogoPage extends StatelessWidget {
  const CatalogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Colores consistentes con Nudo Studio
    const Color primaryGreen = Color(0xFF2D4438);
    const Color accentGold = Color(0xFFB58D1E);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            // TÍTULO DE SECCIÓN
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
                    color: accentGold,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 25),

            // BARRA DE BÚSQUEDA
            TextField(
              decoration: InputDecoration(
                hintText: "Buscar productos...",
                prefixIcon: const Icon(Icons.search, color: primaryGreen),
                suffixIcon: const Icon(Icons.tune, color: primaryGreen),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // CATEGORÍAS (Horizontal)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip("Todos", isSelected: true),
                  const SizedBox(width: 10),
                  _buildCategoryChip("Macramé"),
                  const SizedBox(width: 10),
                  _buildCategoryChip("Joyería"),
                  const SizedBox(width: 10),
                  _buildCategoryChip("Decoración"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "8 productos encontrados",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            
            const SizedBox(height: 15),

            // GRID DE PRODUCTOS
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
                  imageUrl: "https://images.unsplash.com/photo-1515516089376-88db1e26e9c0?q=80&w=500",
                ),
                ProductCard(
                  title: "Collar Textil Bohemio",
                  price: "28.000",
                  tag: "Joyería",
                  stock: "12",
                  imageUrl: "https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?q=80&w=500",
                ),
                ProductCard(
                  title: "Espejo Circular Macramé",
                  price: "35.000",
                  tag: "Macramé",
                  stock: "3",
                  imageUrl: "https://images.unsplash.com/photo-1617233331420-5627f677027b?q=80&w=500",
                ),
                ProductCard(
                  title: "Anillo Artesanal",
                  price: "15.000",
                  tag: "Joyería",
                  stock: "20",
                  imageUrl: "https://images.unsplash.com/photo-1605100804763-247f67b3557e?q=80&w=500",
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2D4438) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: isSelected ? null : Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey.shade600,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}

// --- TARJETA DE PRODUCTO (Se mantiene igual pero optimizada) ---
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
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8, left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFF2D4438), borderRadius: BorderRadius.circular(8)),
                    child: Text(tag, style: const TextStyle(color: Colors.white, fontSize: 9)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$$price", style: const TextStyle(color: Color(0xFFB58D1E), fontWeight: FontWeight.bold)),
                    const Icon(Icons.add_circle, color: Color(0xFF2D4438), size: 20),
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