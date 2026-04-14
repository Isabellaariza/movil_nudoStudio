import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../services/auth_service.dart';
import '../pages/login_page.dart';
import '../pages/edit_profile_page.dart';
import '../pages/change_password_page.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        /// ✏️ EDITAR INFORMACIÓN
        ProfileActionItem(
          icon: Icons.edit_outlined,
          color: AppColors.primaryGreen,
          title: "Editar Información",
          subtitle: "Actualiza tus datos personales",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const EditProfilePage(),
              ),
            );
          },
        ),

        const SizedBox(height: 12),

        /// 🔐 CAMBIAR CONTRASEÑA
        ProfileActionItem(
          icon: Icons.lock_outline,
          color: AppColors.accentGold,
          title: "Cambiar Contraseña",
          subtitle: "Actualiza tu contraseña de acceso",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ChangePasswordPage(),
              ),
            );
          },
        ),

        const SizedBox(height: 12),

        /// 🗑 ELIMINAR CUENTA
        ProfileActionItem(
          icon: Icons.delete_outline,
          color: Colors.red,
          title: "Eliminar Cuenta",
          subtitle: "Elimina permanentemente tu cuenta",
          onTap: () {
            _confirmDelete(context);
          },
        ),

        const SizedBox(height: 25),

        /// 🚪 CERRAR SESIÓN
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text("Cerrar Sesión"),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () async {
              await AuthService.logout();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ),
      ],
    );
  }

  /// 🔥 CONFIRMAR ELIMINACIÓN
  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Eliminar Cuenta"),
        content: const Text(
          "¿Estás seguro? Esta acción no se puede deshacer.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.logout();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text(
              "Eliminar",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔹 ITEM REUTILIZABLE (CARD BONITA)
class ProfileActionItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileActionItem({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
            )
          ],
        ),
        child: Row(
          children: [

            /// 🔹 ICONO
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color),
            ),

            const SizedBox(width: 15),

            /// 🔹 TEXTO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            /// 🔹 FLECHA
            const Icon(Icons.arrow_forward_ios, size: 16)
          ],
        ),
      ),
    );
  }
}