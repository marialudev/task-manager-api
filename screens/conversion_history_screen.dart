import 'package:flutter/material.dart';
import '../services/db_service.dart';
import '../screens/conversion.dart';

class ConversionHistoryScreen extends StatefulWidget {
  @override
  _ConversionHistoryScreenState createState() =>
      _ConversionHistoryScreenState();
}

class _ConversionHistoryScreenState extends State<ConversionHistoryScreen> {
  late Future<List<Conversion>> _conversions;

  @override
  void initState() {
    super.initState();
    _loadConversions();
  }

  Future<void> _loadConversions() async {
    setState(() {
      _conversions = DatabaseService().getConversions();
    });
  }

  Future<void> _deleteConversion(int id) async {
    await DatabaseService().deleteConversion(id);
    _loadConversions(); // Atualiza a lista após a exclusão
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Conversões'),
      ),
      body: FutureBuilder<List<Conversion>>(
        future: _conversions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar conversões'));
          } else if (snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma conversão registrada'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final conversion = snapshot.data![index];
                return ListTile(
                  title: Text('Data: ${conversion.date}'),
                  subtitle: Text(
                      'R\$ ${conversion.realValue} -> \$ ${conversion.dollarValue}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteConversion(conversion.id),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}