import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../services/auth_service.dart';

import 'login_page.dart';

class AdminRolesPage extends StatefulWidget {
  const AdminRolesPage({super.key});

  @override
  State<AdminRolesPage> createState() => _AdminRolesPageState();
}

class _AdminRolesPageState extends State<AdminRolesPage> {
  List<Map<String, dynamic>> permissions = [
    {
      "id": "1",
      "name": "Ver Dashboard",
      "desc": "Acceso a métricas y estadísticas generales",
      "module": "Dashboard",
      "roles": ["Administrador"]
    },
    {
      "id": "2",
      "name": "Gestionar Compras",
      "desc": "Crear, editar y eliminar compras",
      "module": "Compras",
      "roles": ["Administrador"]
    },
    {
      "id": "3",
      "name": "Ver Compras",
      "desc": "Visualizar listado de compras",
      "module": "Compras",
      "roles": ["Administrador"]
    },
    {
      "id": "4",
      "name": "Gestionar Ventas",
      "desc": "Crear, editar y eliminar ventas",
      "module": "Ventas",
      "roles": ["Administrador"]
    },
    {
      "id": "5",
      "name": "Ver Ventas",
      "desc": "Visualizar listado de ventas",
      "module": "Ventas",
      "roles": ["Administrador"]
    },
    {
      "id": "7",
      "name": "Ver Productos",
      "desc": "Visualizar catálogo",
      "module": "Productos",
      "roles": ["Administrador", "Cliente"]
    },
    {
      "id": "9",
      "name": "Ver Talleres",
      "desc": "Visualizar talleres",
      "module": "Talleres",
      "roles": ["Administrador", "Cliente", "Estudiante", "Docente"]
    },
  ];

  List<Map<String, dynamic>> filteredPermissions = [];

  @override
  void initState() {
    super.initState();
    filteredPermissions = permissions;
  }

  void search(String query) {
    final results = permissions.where((p) {
      final text = (p["name"] + p["desc"] + p["module"]).toLowerCase();
      return text.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredPermissions = results;
    });
  }

  Future<void> logout() async {
    await AuthService.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE9),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "NUDO",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Panel de Administración",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: logout,
          )
        ],
      ),

      body: Column(
        children: [
          /// BUSCADOR
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: search,
              decoration: InputDecoration(
                hintText: "Buscar permisos...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          /// LISTA DE PERMISOS
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: filteredPermissions.length,
              itemBuilder: (context, index) {
                return _permissionCard(filteredPermissions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// CARD DE PERMISO (MEJORADA Y CONSISTENTE)
  Widget _permissionCard(Map<String, dynamic> p) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            p["name"],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            p["desc"],
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Text(
            "Módulo: ${p["module"]}",
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: (p["roles"] as List<String>).map((r) {
              return Chip(
                label: Text(r),
                backgroundColor: AppColors.primaryGreen.withOpacity(0.2),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}