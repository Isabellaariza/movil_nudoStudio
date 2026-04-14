class Workshop {
  final int id;
  final String title;
  final String description;
  final String date;
  final String time;
  final int capacity;
  int enrolled;
  final String instructor;

  Workshop({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.capacity,
    required this.enrolled,
    required this.instructor,
  });
}