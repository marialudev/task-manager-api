import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'A senha não pode estar vazia';

    final passwordRules = {
      'A senha deve ter pelo menos 8 caracteres': value.length >= 8,
      'A senha deve ter pelo menos uma letra maiúscula':
          RegExp(r'[A-Z]').hasMatch(value),
      'A senha deve ter pelo menos uma letra minúscula':
          RegExp(r'[a-z]').hasMatch(value),
      'A senha deve ter pelo menos um número': RegExp(r'[0-9]').hasMatch(value),
      'A senha deve ter pelo menos um caractere especial':
          RegExp(r'[!@#\$&*~]').hasMatch(value),
    };

    for (var rule in passwordRules.entries) {
      if (!rule.value) return rule.key;
    }
    return null;
  }

  void handleSignUp() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login de Aniversário 🎉'),
        backgroundColor: Colors.pinkAccent, // Cor festiva para o AppBar
        foregroundColor: Colors.white, // Cor do texto da AppBar
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 177), // Fundo vibrante e festivo
          image: DecorationImage(
            image: AssetImage('assets/party_background.png'), // Imagem de fundo festiva
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView( // Para evitar overflow
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  // Ícone festivo de balão de festa
                  const Icon(
                    Icons.cake,
                    color: Colors.pinkAccent,
                    size: 100,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nome de Usuário',
                      labelStyle: const TextStyle(color: Colors.pinkAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(Icons.person, color: Colors.pink),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9), // Fundo claro para o campo
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'O nome de usuário não pode estar vazio';
                      }
                      return null;
                    },
                    onSaved: (value) => username = value,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: const TextStyle(color: Colors.pinkAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Colors.pink),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9), // Fundo claro para o campo
                    ),
                    validator: validatePassword,
                    onSaved: (value) => password = value,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.pushNamed(context, '/home_page');
                      }
                    },
                    child: const Text('Login'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      primary: Colors.pinkAccent, // Cor do botão festivo
                      onPrimary: Colors.white, // Cor do texto do botão
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: handleSignUp,
                    child: const Text('Cadastrar'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      primary: Colors.purpleAccent, // Cor clara para o botão festivo
                      onPrimary: Colors.white, // Cor do texto do botão
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}