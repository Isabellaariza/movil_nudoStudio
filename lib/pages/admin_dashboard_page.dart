import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/colors.dart';
import '../services/auth_service.dart';

import 'admin_roles_page.dart';
import 'admin_compras_page.dart';
import 'admin_ventas_page.dart';
import 'login_page.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {

  int currentIndex = 0;
  int selectedChart = 0;

  late final List<Widget> pages = [
    _dashboardContent(),
    const AdminRolesPage(),
    const AdminComprasPage(),
    const AdminVentasPage(),
  ];

  void navigate(int index) {
    setState(() => currentIndex = index);
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

      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: navigate,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Roles"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Compras"),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: "Ventas"),
        ],
      ),
    );
  }

  Widget _dashboardContent() {
    return SafeArea(
      child: Column(
        children: [

          /// HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("NUDO",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        SizedBox(width: 6),
                        Text("| Studio",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    Text("Panel de Administración",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),

                GestureDetector(
                  onTap: logout,
                  child: CircleAvatar(
                    backgroundColor: AppColors.primaryGreen,
                    child: const Icon(Icons.logout, color: Colors.white),
                  ),
                )
              ],
            ),
          ),

          const Divider(),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  /// MÉTRICAS
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _card("Ventas Totales", "\$8,450,000", "+12.5%"),
                            const SizedBox(width: 10),
                            _card("Productos", "156", "+8"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _card("Clientes", "2,340", "+45"),
                            const SizedBox(width: 10),
                            _card("Pedidos", "89", "-3"),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// GRÁFICAS
                  _section(
                    "Ventas",
                    child: Column(
                      children: [
                        chartSelector(),
                        const SizedBox(height: 10),
                        chartByType(),
                      ],
                    ),
                  ),

                  /// VENTAS
                  _section(
                    "Ventas Recientes",
                    child: Column(
                      children: [
                        _sale("María González", "Tapiz Macramé Grande", "\$250,000", "Entregado"),
                        _sale("Carlos Ramírez", "Collar Textil Bohemio", "\$120,000", "En Proceso"),
                        _sale("Ana Torres", "Cortina Decorativa", "\$180,000", "Entregado"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget chartSelector() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _btn("Semana", 0),
          _btn("Mes", 1),
          _btn("Año", 2),
        ],
      );

  Widget _btn(String text, int index) {
    final active = selectedChart == index;

    return GestureDetector(
      onTap: () => setState(() => selectedChart = index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.primaryGreen : Colors.white,
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

  Widget chartByType() {
    return SizedBox(
      height: 180,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              spots: _getSpots(),
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> _getSpots() {
    if (selectedChart == 0) {
      return [
        FlSpot(0, 3),
        FlSpot(1, 5),
        FlSpot(2, 4),
        FlSpot(3, 7),
        FlSpot(4, 6),
      ];
    }

    if (selectedChart == 1) {
      return [
        FlSpot(0, 10),
        FlSpot(1, 20),
        FlSpot(2, 15),
        FlSpot(3, 25),
      ];
    }

    return [
      FlSpot(0, 50),
      FlSpot(1, 80),
      FlSpot(2, 70),
      FlSpot(3, 100),
    ];
  }

  /// 🔥 CARD CON COLOR DINÁMICO (+ VERDE / - ROJO)
  Widget _card(String t, String v, String c) {

    Color changeColor = Colors.grey;

    if (c.contains("+")) {
      changeColor = Colors.green;
    } else if (c.contains("-")) {
      changeColor = Colors.red;
    }

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t, style: const TextStyle(color: Colors.grey)),
            Text(v, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(
              c,
              style: TextStyle(
                color: changeColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, {required Widget child}) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGreen)),
          const SizedBox(height: 10),
          child
        ],
      ),
    );
  }

  Widget _sale(String name, String product, String price, String status) {
    final color = status == "Entregado"
        ? Colors.green
        : status == "En Proceso"
            ? Colors.orange
            : Colors.grey;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(product, style: const TextStyle(color: Colors.grey)),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price,
                  style: const TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold)),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: color, fontSize: 12),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}