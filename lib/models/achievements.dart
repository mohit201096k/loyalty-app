class Achievement {
  final String saleFrom;
  final String description;
  final String actualSales;
  final String saleTo;

  Achievement({
    required this.saleFrom,
    required this.description,
    required this.actualSales,
    required this.saleTo,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      saleFrom: json['Sale From'],
      description: json['Description'],
      actualSales: json['Actual Sales'],
      saleTo: json['Sale To'],
    );
  }
}
