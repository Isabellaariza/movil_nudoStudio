import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../utils/colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE9),

      /// 🔥 APPBAR ARREGLADO
      appBar: AppBar(
        title: const Text(
          "Mi Carrito",
          style: TextStyle(color: Colors.white), // 🔥 TEXTO BLANCO
        ),
        backgroundColor: AppColors.primaryGreen,
        iconTheme: const IconThemeData(
          color: Colors.white, // 🔥 FLECHA BLANCA
        ),
      ),

      body: cart.items.isEmpty
          ? const Center(
              child: Text("Tu carrito está vacío 🛒"),
            )
          : Column(
              children: [

                /// LISTA
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: cart.items.length,
                    itemBuilder: (_, i) {
                      final item = cart.items[i];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [

                            Image.asset(
                              item.product.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.product.name),
                                  Text("\$${item.product.price}"),
                                ],
                              ),
                            ),

                            /// CONTADOR
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    cart.decrease(item.product);
                                  },
                                ),
                                Text(item.quantity.toString()),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    cart.increase(item.product);
                                  },
                                ),
                              ],
                            ),

                            /// ELIMINAR
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                cart.remove(item.product);
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// TOTAL
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total"),
                          Text("\$${cart.total}"),
                        ],
                      ),

                      const SizedBox(height: 10),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryGreen,
                            foregroundColor: Colors.white, // 🔥 TEXTO BLANCO
                          ),
                          onPressed: () {
                            cart.clear();

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text("Compra realizada 🎉"),
                              ),
                            );

                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Finalizar Compra",
                            style: TextStyle(color: Colors.white),
                          ),
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