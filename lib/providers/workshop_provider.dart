import 'package:flutter/material.dart';
import '../models/workshop.dart';

class WorkshopProvider extends ChangeNotifier {
  final List<Workshop> _workshops = [
    Workshop(
      id: 1,
      title: "Introducción al Macramé",
      description: "Aprende las técnicas básicas",
      date: "15 Abril 2026",
      time: "14:00 - 17:00",
      capacity: 12,
      enrolled: 5,
      instructor: "María González",
    ),
    Workshop(
      id: 2,
      title: "Joyería Textil Avanzada",
      description: "Diseños avanzados",
      date: "22 Abril 2026",
      time: "10:00 - 13:00",
      capacity: 8,
      enrolled: 2,
      instructor: "Carlos Ruiz",
    ),
  ];

  List<Workshop> get workshops => _workshops;

  void increaseEnrollment(int id) {
    final w = _workshops.firstWhere((w) => w.id == id);
    if (w.enrolled < w.capacity) {
      w.enrolled++;
      notifyListeners();
    }
  }

  void decreaseEnrollment(int id) {
    final w = _workshops.firstWhere((w) => w.id == id);
    if (w.enrolled > 0) {
      w.enrolled--;
      notifyListeners();
    }
  }
}