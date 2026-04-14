import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../utils/colors.dart';
import '../services/auth_service.dart';

import 'login_page.dart';

class AdminVentasPage extends StatefulWidget {
  const AdminVentasPage({super.key});

  @override
  State<AdminVentasPage> createState() => _AdminVentasPageState();
}

class _AdminVentasPageState extends State<AdminVentasPage> {
  int currentIndex = 3;

  List ventas = [];
  List ventasFiltradas = [];

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadVentas();
    searchController.addListener(filtrarVentas);
  }

  Future<void> loadVentas() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("ventas");

    if (data != null) {
      ventas = jsonDecode(data);
    } else {
      ventas = [
        {"fecha":"2024-04-10","cliente":"María González","producto":"Tapiz Macramé Grande","cantidad":1,"total":250000,"estado":"Entregado"},
        {"fecha":"2024-04-10","cliente":"Carlos Ramírez","producto":"Collar Textil Bohemio","cantidad":2,"total":120000,"estado":"En Proceso"},
        {"fecha":"2024-04-09","cliente":"Ana Torres","producto":"Cortina Decorativa","cantidad":1,"total":180000,"estado":"Entregado"},
        {"fecha":"2024-04-09","cliente":"Luis Martínez","producto":"Set Macramé Hogar","cantidad":1,"total":350000,"estado":"Entregado"},
        {"fecha":"2024-04-08","cliente":"Sofia Herrera","producto":"Pulseras Artesanales","cantidad":3,"total":90000,"estado":"Pendiente"},
      ];
    }

    ventasFiltradas = List.from(ventas);
    setState(() {});
  }

  Future<void> saveVentas() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("ventas", jsonEncode(ventas));
  }

  void filtrarVentas() {
    final q = searchController.text.toLowerCase();

    setState(() {
      ventasFiltradas = ventas.where((v) =>
          v["cliente"].toLowerCase().contains(q) ||
          v["producto"].toLowerCase().contains(q)).toList();
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

  Future<void> generarPDF(Map venta) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("FACTURA", style: pw.TextStyle(fontSize: 22)),
            pw.SizedBox(height: 20),
            pw.Text("Cliente: ${venta['cliente']}"),
            pw.Text("Producto: ${venta['producto']}"),
            pw.Text("Cantidad: ${venta['cantidad']}"),
            pw.Text("Fecha: ${venta['fecha']}"),
            pw.Text("Estado: ${venta['estado']}"),
            pw.SizedBox(height: 10),
            pw.Text("TOTAL: \$${venta['total']}"),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  void showDetalle(Map venta) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF4EFE9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Detalle de Venta",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white24,
                        child: Icon(Icons.close, size: 16, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _box("Información del Cliente", [
                        _item("Nombre", venta['cliente']),
                        _item("Teléfono", "+57 315 234 5678"),
                        _item("Dirección", "Av 10 #12-45, Cali"),
                      ]),
                      _box("Detalles del Producto", [
                        _item("Producto", venta['producto']),
                        _item("Cantidad", "${venta['cantidad']}"),
                        _item("Fecha", venta['fecha']),
                        _item("Estado", venta['estado']),
                      ]),
                      _box("Información de Pago", [
                        _item("Método", "Efectivo"),
                        _item("Comprobante", "COMP-${venta['fecha']}"),
                        _item("Total", "\$${venta['total']}"),
                      ]),
                      _box("Notas", [
                        const Text("Sin observaciones",
                            style: TextStyle(color: Colors.grey))
                      ]),

                      const SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        value: venta['estado'],
                        decoration: InputDecoration(
                          labelText: "Cambiar estado",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: ["Pendiente","En Proceso","Entregado"]
                            .map((e)=>DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) async {
                          venta['estado'] = v!;
                          await saveVentas();
                          setState(() {});
                        },
                      ),

                      const SizedBox(height: 15),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => generarPDF(venta),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryGreen,
                              ),
                              child: const Text(
                                "Imprimir",
                                style: TextStyle(color: Colors.white), // ✅ FIX
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _box(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...children
        ],
      ),
    );
  }

  Widget _item(String l, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(l, style: const TextStyle(color: Colors.grey)),
          Text(v, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget estadoChip(String estado) {
    Color color;

    switch (estado) {
      case "Entregado":
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE9),

      appBar: AppBar(
        title: const Text("Gestión de Ventas"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          )
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Buscar ventas...",
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

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ventasFiltradas.length,
              itemBuilder: (_, i) {
                final v = ventasFiltradas[i];

                return Container(
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
                            child: Text(
                              v["producto"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          estadoChip(v["estado"]),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Text("Cliente: ${v["cliente"]}"),
                      Text("Fecha: ${v["fecha"]}"),

                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Cant: ${v["cantidad"]}"),
                          Text("\$${v["total"]}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () => showDetalle(v),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryGreen,
                          ),
                          child: const Text("Ver más",
                              style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
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