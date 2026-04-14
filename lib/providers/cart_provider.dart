import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  Map<String, dynamic> toJson() => {
        'id': product.id,
        'name': product.name,
        'price': product.price,
        'image': product.image,
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product(
        id: json['id'],
        name: json['name'],
        category: '',
        price: json['price'],
        image: json['image'],
        stock: 0,
      ),
      quantity: json['quantity'],
    );
  }
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get count =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  double get total => _items.fold(
      0,
      (sum, item) =>
          sum + (item.product.price * item.quantity));

  ///  AGREGAR (SIN DUPLICAR)
  void add(Product product) {
    final index =
        _items.indexWhere((e) => e.product.id == product.id);

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }

    saveCart();
    notifyListeners();
  }

  ///  AUMENTAR
  void increase(Product product) {
    final index =
        _items.indexWhere((e) => e.product.id == product.id);

    if (index >= 0) {
      _items[index].quantity++;
      saveCart();
      notifyListeners();
    }
  }

  ///  DISMINUIR
  void decrease(Product product) {
    final index =
        _items.indexWhere((e) => e.product.id == product.id);

    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }

      saveCart();
      notifyListeners();
    }
  }

  ///  ELIMINAR
  void remove(Product product) {
    _items.removeWhere((e) => e.product.id == product.id);
    saveCart();
    notifyListeners();
  }

  /// LIMPIAR
  void clear() {
    _items.clear();
    saveCart();
    notifyListeners();
  }

  ///  GUARDAR
  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();

    final data =
        _items.map((e) => e.toJson()).toList();

    prefs.setString("cart", jsonEncode(data));
  }

  ///  CARGAR
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString("cart");

    if (data != null) {
      final decoded = jsonDecode(data) as List;

      _items.clear();
      _items.addAll(
          decoded.map((e) => CartItem.fromJson(e)));

      notifyListeners();
    }
  }
}