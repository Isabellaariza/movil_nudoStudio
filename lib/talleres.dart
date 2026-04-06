import 'package:flutter/material.dart';

// --- PANTALLA DE TALLERES (Adaptada para la navegación principal) ---
class TalleresPage extends StatelessWidget {
  const TalleresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                const Text(
                  'Talleres Disponibles', 
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1B3022))
                ),
                const SizedBox(height: 4),
                Container(width: 40, height: 3, color: const Color(0xFFB68D14)),
                const SizedBox(height: 10),
                const Text(
                  'Aprende nuevas técnicas artesanales con expertos', 
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey)
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          
          // ESTADÍSTICAS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard('8', 'Disponibles', Icons.calendar_today, const Color(0xFF384E3D)),
              _buildStatCard('1', 'Inscritos', Icons.check_circle_outline, const Color(0xFFB68D14)),
              _buildStatCard('3', 'Completados', Icons.people_outline, const Color(0xFF384E3D)),
            ],
          ),
          
          const SizedBox(height: 30),
          
          // TARJETA DE TALLER
          _buildWorkshopCard(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // --- TUS MISMOS WIDGETS DE SOPORTE ---
  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(15), 
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
        ]
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildWorkshopCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  'https://images.unsplash.com/photo-1515516089376-88db1e26e9c0?q=80&w=500',
                  height: 180, width: double.infinity, fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10, left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: const Text('Principiante', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Introducción al Macramé', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B3022))),
                const SizedBox(height: 8),
                const Text('Aprende las técnicas básicas del macramé y crea tu primera pieza decorativa.', style: TextStyle(color: Colors.grey, height: 1.4)),
                const SizedBox(height: 20),
                _buildInfoRow(Icons.calendar_today_outlined, '15 Abril 2026'),
                _buildInfoRow(Icons.access_time, '14:00 - 17:00 (3 horas)'),
                _buildInfoRow(Icons.people_outline, '5 cupos disponibles de 12'),
                _buildInfoRow(Icons.location_on_outlined, 'Instructora: María González'),
                const Divider(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Inversión', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        Text('\$65.000', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFB68D14))),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const InscripcionScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF384E3D),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Inscribirse', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: const Color(0xFFF9F8F4), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 18, color: const Color(0xFFB68D14)),
          ),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(color: Color(0xFF384E3D), fontSize: 14)),
        ],
      ),
    );
  }
}

// --- PÁGINA DE INSCRIPCIÓN (Se mantiene igual) ---
class InscripcionScreen extends StatelessWidget {
  const InscripcionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.edit_note, size: 80, color: Color(0xFFB68D14)),
            const SizedBox(height: 20),
            const Text(
              'Formulario de Inscripción',
              style: TextStyle(fontSize: 24, color: Color(0xFF384E3D), fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Aquí puedes agregar los campos de nombre, correo, etc.', textAlign: TextAlign.center),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF384E3D)),
              child: const Text('Volver a Talleres', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}