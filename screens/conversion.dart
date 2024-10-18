class Conversion {
  final int id;
  final String consultationCode;
  final double realValue;
  final double dollarValue;
  final String date;

  Conversion({
    required this.id,
    required this.consultationCode,
    required this.realValue,
    required this.dollarValue,
    required this.date,
  });

  // Para mapear do banco de dados para o objeto Conversion
  factory Conversion.fromMap(Map<String, dynamic> map) {
    return Conversion(
      id: map['id'],
      consultationCode: map['consultationCode'],
      realValue: map['realValue'],
      dollarValue: map['dollarValue'],
      date: map['date'],
    );
  }

  // Para mapear do objeto Conversion para o banco de dados
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'consultationCode': consultationCode,
      'realValue': realValue,
      'dollarValue': dollarValue,
      'date': date,
    };
  }
}