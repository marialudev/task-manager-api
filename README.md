Aniversário Reminder App:
Este é um aplicativo Flutter desenvolvido em Dart que permite ao usuário armazenar e gerenciar datas de aniversário. Com ele, é possível adicionar, editar e excluir aniversários, facilitando o controle dessas informações de forma rápida e prática. O app também utiliza uma API de horário que exibe a data e hora em que o usuário acessa o aplicativo.

Propósito:
O objetivo deste aplicativo é ajudar o usuário a organizar e lembrar datas importantes de aniversários. As informações são armazenadas localmente utilizando o banco de dados SQLite através do pacote sqflite, garantindo que o app funcione mesmo sem conexão com a internet. Além disso, ele exibe a última vez que o usuário acessou o aplicativo, fornecida por uma API externa de horário.

Funcionalidades:
- Adicionar aniversários: O usuário pode adicionar o nome do aniversariante e a data do aniversário.
- Listar aniversários: Os aniversários são exibidos em uma lista organizada.
- Editar aniversários: O usuário pode alterar as informações de aniversários já cadastrados.
- Excluir aniversários: O usuário pode remover aniversários da lista.
- Exibição da última data de acesso: O app exibe a data e hora da última vez que o usuário acessou o aplicativo.

Tecnologias Utilizadas:
Frontend:

Flutter: Framework para criação da interface do usuário multiplataforma.
Dart: Linguagem de programação utilizada para o desenvolvimento do aplicativo.

Banco de Dados:

Sqflite: Biblioteca utilizada para manipulação de banco de dados SQLite no Flutter.
API: API de horário: Uma API externa é usada para obter e exibir a data e hora em que o usuário acessa o app.
