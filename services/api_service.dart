import 'package:http/http.dart' as http;
import 'dart:convert';

class TimeService {
  Future<String> fetchCurrentTime() async {
    // URL da API World Time para o fuso horário de São Paulo
    final response = await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/America/Sao_Paulo'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String dateTime = data['datetime'];
      // Retorna apenas a hora e minutos formatados (HH:MM)
      return dateTime.substring(11, 16);
    } else {
      throw Exception('Falha ao carregar horário atual');
    }
  }
}