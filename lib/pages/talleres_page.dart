import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workshop_provider.dart';
import '../providers/enrollment_provider.dart';
import '../models/workshop.dart';
import '../utils/colors.dart';

class TalleresPage extends StatelessWidget {
  const TalleresPage({super.key});

  @override
  Widget build(BuildContext context) {
    final workshops = Provider.of<WorkshopProvider>(context);
    final enroll = Provider.of<EnrollmentProvider>(context);

    final inscritos = enroll.enrolled.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE9),

      body: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 10),

            const Text(
              "Talleres Disponibles",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryGreen,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Aprende nuevas técnicas artesanales con expertos",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 15),

            /// STATS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _statCard("Disponibles",
                      workshops.workshops.length.toString(), Icons.event),
                  const SizedBox(width: 10),
                  _statCard("Inscritos",
                      inscritos.toString(), Icons.check_circle),
                  const SizedBox(width: 10),
                  _statCard("Completados", "3", Icons.groups),
                ],
              ),
            ),

            const SizedBox(height: 15),

            /// LISTA
            Expanded(
              child: ListView.builder(
                itemCount: workshops.workshops.length,
                itemBuilder: (_, i) {
                  final w = workshops.workshops[i];
                  final isEnrolled = enroll.isEnrolled(w.id);

                  return _workshopCard(
                      context, w, isEnrolled, enroll, workshops);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  /// CARD TALLER
  Widget _workshopCard(
    BuildContext context,
    Workshop w,
    bool isEnrolled,
    EnrollmentProvider enroll,
    WorkshopProvider workshops,
  ) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// IMAGEN
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              "assets/macrame.jpg",
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// TITULO
                Text(
                  w.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(w.description),

                const SizedBox(height: 15),

                /// INFO
                _info(Icons.calendar_today, w.date),
                _info(Icons.access_time, "${w.time} (3 horas)"),
                _info(Icons.people,
                    "${w.capacity - w.enrolled} cupos disponibles de ${w.capacity}"),
                _info(Icons.location_on, "Instructor: ${w.instructor}"),

                const Divider(),

                /// PRECIO + BOTÓN
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    const Text(
                      "\$65.000",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        foregroundColor: Colors.white, // 🔥 CLAVE
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: isEnrolled
                          ? null
                          : () {
                              enroll.enroll(w.id);
                              workshops.increaseEnrollment(w.id);
                            },
                      child: Text(
                        isEnrolled ? "Inscrito" : "Inscribirse",
                        style: const TextStyle(color: Colors.white), // 🔥
                      ),
                    )
                  ],
                ),

                /// CANCELAR
                if (isEnrolled)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        enroll.cancel(w.id);
                        workshops.decreaseEnrollment(w.id);
                      },
                      child: const Text(
                        "Cancelar inscripción",
                        style: TextStyle(color: Colors.red),
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

  /// ITEM INFO
  Widget _info(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.orange),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  /// STATS CARD
  Widget _statCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryGreen),
            const SizedBox(height: 5),
            Text(value,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            Text(title),
          ],
        ),
      ),
    );
  }
}