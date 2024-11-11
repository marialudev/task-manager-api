import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  group('API Tests', () {
    test('Deve retornar status 200 na chamada da API', () async {
      // URL da API que você quer testar
      final url = Uri.parse('https://api.hgbrasil.com/finance?key=c729b147');

      // Faz a requisição GET
      final response = await http.get(url);

      // Verifica se o status code é 200
      expect(response.statusCode, 200);
    });

    test('Deve conter dados no body da resposta', () async {
      final url = Uri.parse('https://api.hgbrasil.com/finance?key=c729b147');
      final response = await http.get(url);

      // Verifica se o corpo da resposta contém dados
      expect(response.body.isNotEmpty, true);
    });
  });
}
