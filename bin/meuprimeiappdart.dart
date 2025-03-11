import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  while (true) {
    print('\n===== MENU DE DESAFIOS =====');
    print('1 - Simulador de Conta Bancária');
    print('2 - Relógio Digital');
    print('3 - Pedra, Papel e Tesoura');
    print('4 - Consumindo API Pública');
    print('5 - Gerenciamento de Estado (Carrinho de Compras)');
    print('6 - Jogo de Adivinhação');
    print('7 - Simulador de Sorteio');
    print('8 - Calculadora de IMC');
    print('9 - Conversão de Moeda');
    print('10 - Gerador de Senha');
    print('0 - Sair');
    stdout.write('Escolha uma opção: ');
    String? opcao = stdin.readLineSync();

    if (opcao == null) {
      print('Erro ao ler a entrada!');
      continue;
    }

    switch (opcao) {
      case '1':
        simuladorContaBancaria();
        break;
      case '2':
        relogioDigital();
        break;
      case '3':
        pedraPapelTesoura();
        break;
      case '4':
        consumirAPI();
        break;
      case '5':
        gerenciarCarrinho();
        break;
      case '6':
        jogoAdivinhacao();
        break;
      case '7':
        simuladorSorteio();
        break;
      case '8':
        calculadoraIMC();
        break;
      case '9':
        conversaoMoeda();
        break;
      case '10':
        geradorSenha();
        break;
      case '0':
        print('Saindo...');
        exit(0);
      default:
        print('Opção inválida!');
    }
  }
}

// 1. Simulador de Conta Bancária
class ContaBancaria {
  String titular;
  double saldo;

  ContaBancaria(this.titular, this.saldo);

  void depositar(double valor) {
    saldo += valor;
    print('Depósito de R\$ ${valor.toStringAsFixed(2)} realizado. Saldo atual: R\$ ${saldo.toStringAsFixed(2)}');
  }

  void sacar(double valor) {
    if (valor <= saldo) {
      saldo -= valor;
      print('Saque de R\$ ${valor.toStringAsFixed(2)} realizado. Saldo atual: R\$ ${saldo.toStringAsFixed(2)}');
    } else {
      print('Saldo insuficiente! Operação cancelada.');
    }
  }

  void consultarSaldo() {
    print('Saldo atual de $titular: R\$ ${saldo.toStringAsFixed(2)}');
  }
}

void simuladorContaBancaria() {
  print('Bem-vindo ao Simulador de Conta Bancária!');
  stdout.write('Digite o nome do titular da conta: ');
  String? titular = stdin.readLineSync();

  if (titular == null || titular.isEmpty) {
    print('Nome do titular inválido!');
    return;
  }

  ContaBancaria conta = ContaBancaria(titular, 0.0);

  while (true) {
    print('\n1 - Depositar');
    print('2 - Sacar');
    print('3 - Consultar Saldo');
    print('4 - Voltar ao menu');
    stdout.write('Escolha uma opção: ');
    String? opcao = stdin.readLineSync();

    if (opcao == '1') {
      stdout.write('Digite o valor do depósito: ');
      double? valor = double.tryParse(stdin.readLineSync() ?? '');
      if (valor != null && valor > 0) {
        conta.depositar(valor);
      } else {
        print('Valor inválido!');
      }
    } else if (opcao == '2') {
      stdout.write('Digite o valor do saque: ');
      double? valor = double.tryParse(stdin.readLineSync() ?? '');
      if (valor != null && valor > 0) {
        conta.sacar(valor);
      } else {
        print('Valor inválido!');
      }
    } else if (opcao == '3') {
      conta.consultarSaldo();
    } else if (opcao == '4') {
      return;
    } else {
      print('Opção inválida!');
    }
  }
}

// 2. Relógio Digital
void relogioDigital() {
  print('Relógio Digital (Ctrl+C para sair):');
  Timer.periodic(Duration(seconds: 1), (Timer t) {
    print('\x1B[2J\x1B[0;0H'); // Limpa o terminal
    print(DateTime.now());
  });
}

// 3. Pedra, Papel e Tesoura
void pedraPapelTesoura() {
  final random = Random();
  final opcoes = ['Pedra', 'Papel', 'Tesoura'];

  while (true) {
    print('\n1 - Pedra\n2 - Papel\n3 - Tesoura\n4 - Voltar ao menu');
    stdout.write('Escolha sua jogada: ');
    String? opcao = stdin.readLineSync();

    if (opcao == '4') return;

    int escolhaUsuario = int.tryParse(opcao ?? '') ?? 0;

    if (escolhaUsuario < 1 || escolhaUsuario > 3) {
      print('Opção inválida!');
      continue;
    }

    int escolhaComputador = random.nextInt(3);
    print('Você: ${opcoes[escolhaUsuario - 1]} | Computador: ${opcoes[escolhaComputador]}');

    if (escolhaUsuario - 1 == escolhaComputador) {
      print('Empate!');
    } else if ((escolhaUsuario == 1 && escolhaComputador == 2) ||
        (escolhaUsuario == 2 && escolhaComputador == 3) ||
        (escolhaUsuario == 3 && escolhaComputador == 1)) {
      print('Você perdeu!');
    } else {
      print('Você venceu!');
    }
  }
}

// 4. Consumindo API Pública
void consumirAPI() async {
  print('Consumindo API Pública...');
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> posts = jsonDecode(response.body);
      print('\nÚltimos 5 posts:');
      for (var i = 0; i < 5; i++) {
        print('${i + 1} - ${posts[i]['title']}');
      }
    } else {
      print('Erro ao carregar os posts. Código: ${response.statusCode}');
    }
  } catch (e) {
    print('Erro de conexão: $e');
  }
}

// 5. Gerenciamento de Estado (Carrinho de Compras)
class CarrinhoDeCompras {
  List<String> itens = [];

  void adicionarItem(String item) {
    itens.add(item);
    print('Item "$item" adicionado.');
  }

  void removerItem(String item) {
    if (itens.remove(item)) {
      print('Item "$item" removido.');
    } else {
      print('Item "$item" não encontrado.');
    }
  }

  void listarItens() {
    if (itens.isEmpty) {
      print('Carrinho vazio.');
    } else {
      print('Itens no carrinho: ${itens.join(", ")}');
    }
  }
}

void gerenciarCarrinho() {
  CarrinhoDeCompras carrinho = CarrinhoDeCompras();

  while (true) {
    print('\n1 - Adicionar item\n2 - Remover item\n3 - Listar itens\n4 - Voltar ao menu');
    stdout.write('Escolha: ');
    String? opcao = stdin.readLineSync();

    if (opcao == '1') {
      stdout.write('Nome do item: ');
      String? item = stdin.readLineSync();
      if (item != null && item.isNotEmpty) carrinho.adicionarItem(item);
    } else if (opcao == '2') {
      stdout.write('Nome do item: ');
      String? item = stdin.readLineSync();
      if (item != null && item.isNotEmpty) carrinho.removerItem(item);
    } else if (opcao == '3') {
      carrinho.listarItens();
    } else if (opcao == '4') {
      return;
    } else {
      print('Opção inválida.');
    }
  }
}

// 6. Jogo de Adivinhação
void jogoAdivinhacao() {
  int numeroSecreto = Random().nextInt(100) + 1;
  bool acertou = false;

  print('Jogo de Adivinhação (1-100)');

  while (!acertou) {
    stdout.write('Digite seu palpite: ');
    int? palpite = int.tryParse(stdin.readLineSync() ?? '');

    if (palpite == null) {
      print('Entrada inválida!');
      continue;
    }

    if (palpite == numeroSecreto) {
      print('Acertou!');
      acertou = true;
    } else if (palpite < numeroSecreto) {
      print('É maior!');
    } else {
      print('É menor!');
    }
  }
}

// 7. Simulador de Sorteio
void simuladorSorteio() {
  List<String> nomes = [];

  print('Digite nomes para o sorteio ("sair" para finalizar):');
  while (true) {
    stdout.write('Nome: ');
    String? entrada = stdin.readLineSync();

    if (entrada == null || entrada.toLowerCase() == 'sair') break;
    if (entrada.isNotEmpty) nomes.add(entrada);
  }

  if (nomes.isEmpty) {
    print('Nenhum participante.');
    return;
  }

  String sorteado = nomes[Random().nextInt(nomes.length)];
  print('Participantes: ${nomes.join(", ")}');
  print('Sorteado: $sorteado');
}

// 8. Calculadora de IMC
void calculadoraIMC() {
  stdout.write('Digite seu peso (kg): ');
  double? peso = double.tryParse(stdin.readLineSync() ?? '');
  stdout.write('Digite sua altura (m): ');
  double? altura = double.tryParse(stdin.readLineSync() ?? '');

  if (peso == null || altura == null || peso <= 0 || altura <= 0) {
    print('Dados inválidos.');
    return;
  }

  double imc = peso / (altura * altura);
  print('Seu IMC: ${imc.toStringAsFixed(2)}');

  if (imc < 18.5)
    print('Baixo peso');
  else if (imc < 24.9)
    print('Peso normal');
  else if (imc < 29.9)
    print('Sobrepeso');
  else
    print('Obesidade');
}

// 9. Conversão de Moeda
void conversaoMoeda() {
  const taxaDolar = 5.00;
  const taxaEuro = 5.50;

  stdout.write('Digite o valor em Reais (BRL): ');
  double? reais = double.tryParse(stdin.readLineSync() ?? '');

  if (reais == null || reais <= 0) {
    print('Valor inválido.');
    return;
  }

  print('USD: ${(reais / taxaDolar).toStringAsFixed(2)}');
  print('EUR: ${(reais / taxaEuro).toStringAsFixed(2)}');
}

// 10. Gerador de Senha
void geradorSenha() {
  stdout.write('Tamanho da senha: ');
  int? tamanho = int.tryParse(stdin.readLineSync() ?? '');

  if (tamanho == null || tamanho <= 0) {
    print('Tamanho inválido.');
    return;
  }

  String senha = gerarSenha(tamanho);
  print('Senha gerada: $senha');
}

String gerarSenha(int tamanho) {
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+-=[]{}|;:,.<>?';
  Random random = Random();
  return List.generate(tamanho, (_) => chars[random.nextInt(chars.length)]).join();
}
