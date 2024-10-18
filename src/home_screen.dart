import 'package:flutter/material.dart';
import 'dart:async'; // Para usar o Timer
import '../services/api_service.dart'; // Serviço da API de Tempo

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TimeService _timeService = TimeService(); // Instância do TimeService
  String currentTime = "Carregando..."; // Variável para armazenar o horário atual
  Timer? _timer; // Timer para atualização automática
  final List<Map<String, String>> _usuarios = []; // Lista para armazenar usuários

  @override
  void initState() {
    super.initState();
    _fetchCurrentTime(); // Busca o horário atual na inicialização
    _startAutoUpdateTime(); // Inicia a atualização automática do horário
  }

  // Função para buscar o horário atual da API
  void _fetchCurrentTime() async {
    try {
      String time = await _timeService.fetchCurrentTime();
      setState(() {
        currentTime = time;
      });
    } catch (e) {
      setState(() {
        currentTime = "Erro ao carregar horário";
      });
    }
  }

  // Atualização automática do horário a cada minuto
  void _startAutoUpdateTime() {
    _timer = Timer.periodic(const Duration(seconds: 60), (Timer t) {
      _fetchCurrentTime(); // Chama a função para buscar o horário atual
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela o timer ao sair da tela
    super.dispose();
  }

  // Função para abrir o formulário de cadastro
  void _showCadastroForm() {
    String nome = '';
    String data = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cadastrar Usuário', style: TextStyle(color: Colors.pink)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(color: Colors.pink),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                ),
                onChanged: (value) {
                  nome = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Data',
                  labelStyle: TextStyle(color: Colors.pink),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                ),
                onChanged: (value) {
                  data = value;
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent, // Cor do botão estilo festa
              ),
              onPressed: () {
                if (nome.isNotEmpty && data.isNotEmpty) {
                  setState(() {
                    _usuarios.add({'nome': nome, 'data': data});
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Cadastrar Aniversário'),
            ),
          ],
        );
      },
    );
  }

  // Função para excluir um usuário
  void _excluirUsuario(int index) {
    setState(() {
      _usuarios.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100, // Fundo da tela com tom alegre
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lista de Aniversários 🎉',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Horário Atual: $currentTime', // Exibe o horário atual no AppBar
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        backgroundColor: Colors.pink, // Cor do AppBar em um tom rosa
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent.shade200, // Botão estilo festa
              ),
              onPressed: _showCadastroForm,
              icon: const Icon(Icons.cake, color: Colors.white), // Ícone de bolo
              label: const Text(
                'Cadastrar Aniversariante',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _usuarios.length,
                itemBuilder: (context, index) {
                  final usuario = _usuarios[index];
                  return Card(
                    color: Colors.lightGreen.shade100, // Card com cor leve e alegre
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.purple),
                      title: Text(
                        'Nome: ${usuario['nome']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      subtitle: Text(
                        'Data: ${usuario['data']} 🎂',
                        style: const TextStyle(fontSize: 16, color: Colors.pink),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _excluirUsuario(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}