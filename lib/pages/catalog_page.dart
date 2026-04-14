import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../utils/colors.dart';
import 'cart_page.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String selectedCategory = "Todos";
  String search = "";

  final List<Product> products = [
    Product(
      id: 1,
      name: "Macramé Decorativo Grande",
      category: "Macramé",
      price: 45000,
      image: "assets/macrame.jpg",
      stock: 5,
    ),
    Product(
      id: 2,
      name: "Pulsera Textil Bohemio",
      category: "Joyería",
      price: 28000,
      image: "assets/joyeria.jpg",
      stock: 12,
    ),
  ];

  List<Product> get filteredProducts {
    return products.where((p) {
      final matchCategory =
          selectedCategory == "Todos" || p.category == selectedCategory;

      final matchSearch =
          p.name.toLowerCase().contains(search.toLowerCase());

      return matchCategory && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return SafeArea(
      child: Column(
        children: [

          const SizedBox(height: 10),

          ///  HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "NUDO",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),

                ///  CARRITO
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CartPage()),
                        );
                      },
                    ),

                    if (cart.count > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            cart.count.toString(),
                            style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white),
                          ),
                        ),
                      )
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Nuestro Catálogo",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),

          const SizedBox(height: 10),

          ///  BUSCADOR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                setState(() => search = value);
              },
              decoration: InputDecoration(
                hintText: "Buscar productos...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          ///  FILTROS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              filter("Todos"),
              filter("Macramé"),
              filter("Joyería"),
            ],
          ),

          const SizedBox(height: 10),

          Text("${filteredProducts.length} productos encontrados"),

          const SizedBox(height: 10),

          ///  GRID
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: filteredProducts.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 260,
              ),
              itemBuilder: (_, i) {
                final product = filteredProducts[i];
                return ProductCard(product: product);
              },
            ),
          )
        ],
      ),
    );
  }

  ///  FILTRO
  Widget filter(String text) {
    final active = selectedCategory == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = text;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(
            horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: active
              ? AppColors.primaryGreen
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

///  TARJETA DE PRODUCTO
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ///  IMAGEN
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20)),
            child: Image.asset(
              product.image,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(product.name,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis),

                const SizedBox(height: 5),

                Text(
                  "\$${product.price}",
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      cart.add(product);

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content:
                              Text("Agregado al carrito"),
                        ),
                      );
                    },
                    child: const Text("Agregar"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}