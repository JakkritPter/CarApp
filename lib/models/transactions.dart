class Transactions {
  int? keyID;
  final String name;
  final double price;
  final String brand;
  final String model;
  final int year;
  final String color;
  final DateTime date;

  Transactions({
    this.keyID,
    required this.name,
    required this.price,
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
    required this.date,
    
  });
}