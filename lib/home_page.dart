import 'package:flutter/material.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Definimos los colores aquí para que el archivo sea independiente
    const Color primaryGreen = Color(0xFF384E3D);
    const Color accentGold = Color(0xFFB68D14);
    const Color cardColor = Colors.white;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),

          // TARJETA DE BIENVENIDA
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "Creaciones",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: primaryGreen,
                  ),
                ),
                const Text(
                  "Únicas",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: accentGold,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  "Descubre el arte del macramé y tejido textil. Cada pieza cuenta una historia, cada nudo abraza la tradición con un toque contemporáneo.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, height: 1.5),
                ),

                const SizedBox(height: 25),

                // BADGE DE ARTESANAL
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F8F4),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: accentGold, size: 20),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("100% Artesanal",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Text("Hecho a mano con amor",
                              style: TextStyle(fontSize: 11, color: Colors.grey)),
                        ],
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // BOTONES SIMPLES (Sin depender de archivos externos)
                _buildSimpleButton(
                  text: "Explorar Catálogo",
                  color: primaryGreen,
                  textColor: Colors.white,
                  onTap: () {
                    // Aquí puedes añadir lógica para cambiar de pestaña
                  },
                ),
                
                const SizedBox(height: 12),

                _buildSimpleButton(
                  text: "Ver Talleres",
                  color: Colors.transparent,
                  textColor: primaryGreen,
                  isOutlined: true,
                  onTap: () {
                    // Aquí también
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para no repetir código de botones
  Widget _buildSimpleButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
    bool isOutlined = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: isOutlined ? 0 : 2,
          side: isOutlined ? const BorderSide(color: Color(0xFF384E3D)) : null,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}