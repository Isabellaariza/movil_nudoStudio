import 'package:flutter/material.dart';

class EnrollmentProvider extends ChangeNotifier {
  final Set<int> _enrolledWorkshops = {};

  Set<int> get enrolled => _enrolledWorkshops;

  void enroll(int workshopId) {
    _enrolledWorkshops.add(workshopId);
    notifyListeners();
  }

  void cancel(int workshopId) {
    _enrolledWorkshops.remove(workshopId);
    notifyListeners();
  }

  bool isEnrolled(int workshopId) {
    return _enrolledWorkshops.contains(workshopId);
  }
}