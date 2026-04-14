import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../services/auth_service.dart';
import 'login_page.dart';

class Compra {
  final String fecha;
  final String proveedor;
  final String producto;
  final int cantidad;
  final int total;
  final String estado;

  Compra({
    required this.fecha,
    required this.proveedor,
    required this.producto,
    required this.cantidad,
    required this.total,
    required this.estado,
  });
}

class AdminComprasPage extends StatefulWidget {
  const AdminComprasPage({super.key});

  @override
  State<AdminComprasPage> createState() => _AdminComprasPageState();
}

class _AdminComprasPageState extends State<AdminComprasPage> {
  String search = "";

  List<Compra> compras = [
    Compra(
        fecha: "2024-04-08",
        proveedor: "Hilos SA",
        producto: "Hilo de Algodón 100m",
        cantidad: 50,
        total: 450000,
        estado: "Completado"),
    Compra(
        fecha: "2024-04-07",
        proveedor: "Maderas Del Valle",
        producto: "Cuentas de Madera",
        cantidad: 200,
        total: 180000,
        estado: "Completado"),
    Compra(
        fecha: "2024-04-06",
        proveedor: "Textiles Premium",
        producto: "Cordón Macramé 5mm",
        cantidad: 30,
        total: 320000,
        estado: "Pendiente"),

    /// 🔥 NUEVOS PRODUCTOS AGREGADOS
    Compra(
        fecha: "2024-04-05",
        proveedor: "Hilos SA",
        producto: "Hilo de Yute",
        cantidad: 25,
        total: 150000,
        estado: "Completado"),
    Compra(
        fecha: "2024-04-04",
        proveedor: "Accesorios Artesanales",
        producto: "Anillos Metálicos",
        cantidad: 100,
        total: 95000,
        estado: "En Proceso"),
  ];

  List<Compra> get filtered => compras.where((c) {
        return c.producto.toLowerCase().contains(search.toLowerCase());
      }).toList();

  Future<void> logout() async {
    await AuthService.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  Widget estadoChip(String estado) {
    Color color;

    switch (estado) {
      case "Completado":
        color = Colors.green;
        break;
      case "Pendiente":
        color = Colors.orange;
        break;
      default:
        color = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        estado,
        style: TextStyle(color: color, fontSize: 12),
      ),
    );
  }

  void showDetail(Compra c) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(c.producto),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Proveedor: ${c.proveedor}"),
            Text("Cantidad: ${c.cantidad}"),
            Text("Total: \$${c.total}"),
            Text("Estado: ${c.estado}"),
          ],
        ),
      ),
    );
  }

  void nuevaCompra() {
    final productoCtrl = TextEditingController();
    final proveedorCtrl = TextEditingController();
    final cantidadCtrl = TextEditingController();
    final totalCtrl = TextEditingController();

    String estado = "Pendiente";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nueva Compra"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _input(productoCtrl, "Producto"),
              _input(proveedorCtrl, "Proveedor"),
              _input(cantidadCtrl, "Cantidad"),
              _input(totalCtrl, "Total"),
              const SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: estado,
                items: ["Pendiente", "Completado", "En Proceso"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => estado = val!,
                decoration: const InputDecoration(labelText: "Estado"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    compras.add(
                      Compra(
                        fecha: DateTime.now().toString().substring(0, 10),
                        proveedor: proveedorCtrl.text,
                        producto: productoCtrl.text,
                        cantidad: int.tryParse(cantidadCtrl.text) ?? 0,
                        total: int.tryParse(totalCtrl.text) ?? 0,
                        estado: estado,
                      ),
                    );
                  });

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                ),
                child: const Text(
                  "Guardar",
                  style: TextStyle(color: Colors.white), // 🔥 TEXTO BLANCO
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE9),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "NUDO | Studio",
          style: TextStyle(color: AppColors.primaryGreen),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.primaryGreen),
            onPressed: logout,
          )
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Gestión de Compras",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen)),
                ElevatedButton.icon(
                  onPressed: nuevaCompra,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text("Nueva Compra",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                  ),
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (v) => setState(() => search = v),
              decoration: InputDecoration(
                hintText: "Buscar compras...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final c = filtered[i];

                return GestureDetector(
                  onTap: () => showDetail(c),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(c.producto,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            estadoChip(c.estado),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text("Proveedor: ${c.proveedor}"),
                        Text("Fecha: ${c.fecha}"),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Cant: ${c.cantidad}"),
                            Text("\$${c.total}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}