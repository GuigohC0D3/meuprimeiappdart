import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  while (true) {
    print('\nEscolha um desafio para executar:');
    print('1 - Simulador de Conta Bancária');
    print('2 - Relógio Digital');
    print('3 - Pedra, Papel e Tesoura');
    print('4 - Consumindo API Pública');
    print('5 - Gerenciamento de Estado (Carrinho de Compras)');
    print('6 - Jogo de Adivinhação');
    print('7 - Simulador de Sorteio');
    print('8 - Conversor de Moedas');
    print('9 - Gerador de Senhas');
    print('10 - Calculadora IMC');
    print('11 - Sair');
    stdout.write('Opção: ');
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
        conversorMoedas();
        break;
      case '9':
        geradorSenhas();
        break;
      case '10':
        calculadoraIMC();
        break;
      case '11':
        print('Saindo...');
        return;
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
    print('Depósito de R\$ $valor realizado. Saldo atual: R\$ $saldo');
  }

  void sacar(double valor) {
    if (valor <= saldo) {
      saldo -= valor;
      print('Saque de R\$ $valor realizado. Saldo atual: R\$ $saldo');
    } else {
      print('Saldo insuficiente! Operação cancelada.');
    }
  }

  void consultarSaldo() {
    print('Saldo atual de $titular: R\$ $saldo');
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
    print('4 - Voltar');
    stdout.write('Opção: ');
    String? opcao = stdin.readLineSync();

    if (opcao == null) {
      print('Erro ao ler a entrada!');
      continue;
    }

    if (opcao == '1') {
      stdout.write('Digite o valor do depósito: ');
      String? input = stdin.readLineSync();
      if (input == null || input.isEmpty) {
        print('Entrada inválida!');
        continue;
      }
      double valor = double.tryParse(input) ?? 0.0;
      if (valor <= 0) {
        print('Valor inválido!');
        continue;
      }
      conta.depositar(valor);
    } else if (opcao == '2') {
      stdout.write('Digite o valor do saque: ');
      String? input = stdin.readLineSync();
      if (input == null || input.isEmpty) {
        print('Entrada inválida!');
        continue;
      }
      double valor = double.tryParse(input) ?? 0.0;
      if (valor <= 0) {
        print('Valor inválido!');
        continue;
      }
      conta.sacar(valor);
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
  print('Relógio Digital (Pressione Ctrl+C para sair):');
  Timer.periodic(Duration(seconds: 1), (Timer t) {
    // Limpa o console para atualizar o relógio
    print('\x1B[2J\x1B[0;0H'); // Código ANSI para limpar o console
    print(DateTime.now());
  });
}

// 3. Pedra, Papel e Tesoura
void pedraPapelTesoura() {
  final random = Random();
  final opcoes = ['Pedra', 'Papel', 'Tesoura'];

  while (true) {
    print('\nEscolha uma opção:');
    print('1 - Pedra');
    print('2 - Papel');
    print('3 - Tesoura');
    print('4 - Voltar');
    stdout.write('Opção: ');
    String? opcao = stdin.readLineSync();

    if (opcao == null) {
      print('Erro ao ler a entrada!');
      continue;
    }

    if (opcao == '4') {
      return;
    }

    int escolhaUsuario = int.tryParse(opcao) ?? 0;
    if (escolhaUsuario < 1 || escolhaUsuario > 3) {
      print('Opção inválida!');
      continue;
    }

    int escolhaComputador = random.nextInt(3) + 1;
    print('\nVocê escolheu: ${opcoes[escolhaUsuario - 1]}');
    print('Computador escolheu: ${opcoes[escolhaComputador - 1]}');

    if (escolhaUsuario == escolhaComputador) {
      print('Empate!');
    } else if ((escolhaUsuario == 1 && escolhaComputador == 3) ||
        (escolhaUsuario == 2 && escolhaComputador == 1) ||
        (escolhaUsuario == 3 && escolhaComputador == 2)) {
      print('Você venceu!');
    } else {
      print('Você perdeu!');
    }
  }
}

// 4. Consumindo API Pública
void consumirAPI() async {
  print('Consumindo API Pública...');
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> posts = jsonDecode(response.body);
    print('\nÚltimos 5 posts:');
    for (var i = 0; i < 5; i++) {
      print('Post ${i + 1}: ${posts[i]['title']}');
    }
  } else {
    print('Erro ao carregar os posts.');
  }
}

// 5. Gerenciamento de Estado (Carrinho de Compras)
class CarrinhoDeCompras {
  List<String> itens = [];

  void adicionarItem(String item) {
    itens.add(item);
    print('Item "$item" adicionado ao carrinho.');
  }

  void removerItem(String item) {
    if (itens.contains(item)) {
      itens.remove(item);
      print('Item "$item" removido do carrinho.');
    } else {
      print('Item "$item" não encontrado no carrinho.');
    }
  }

  void listarItens() {
    if (itens.isEmpty) {
      print('O carrinho está vazio.');
    } else {
      print('Itens no carrinho:');
      for (var item in itens) {
        print('- $item');
      }
    }
  }
}

void gerenciarCarrinho() {
  CarrinhoDeCompras carrinho = CarrinhoDeCompras();

  while (true) {
    print('\n1 - Adicionar item');
    print('2 - Remover item');
    print('3 - Listar itens');
    print('4 - Voltar');
    stdout.write('Opção: ');
    String? opcao = stdin.readLineSync();

    if (opcao == null) {
      print('Erro ao ler a entrada!');
      continue;
    }

    if (opcao == '1') {
      stdout.write('Digite o nome do item: ');
      String? item = stdin.readLineSync();
      if (item == null || item.isEmpty) {
        print('Nome do item inválido!');
        continue;
      }
      carrinho.adicionarItem(item);
    } else if (opcao == '2') {
      stdout.write('Digite o nome do item: ');
      String? item = stdin.readLineSync();
      if (item == null || item.isEmpty) {
        print('Nome do item inválido!');
        continue;
      }
      carrinho.removerItem(item);
    } else if (opcao == '3') {
      carrinho.listarItens();
    } else if (opcao == '4') {
      return;
    } else {
      print('Opção inválida!');
    }
  }
}

// 6. Jogo de Adivinhação
void jogoAdivinhacao() {
  var numeroSecreto = Random().nextInt(100) + 1;
  var acertou = false;

  print('Bem-vindo ao Jogo de Adivinhação!');
  print('Adivinhe o número secreto entre 1 e 100.');

  while (!acertou) {
    stdout.write('Digite um número: ');
    var entrada = stdin.readLineSync();

    if (entrada == null) {
      print('Por favor, insira um número válido.');
      continue;
    }

    var palpite = int.tryParse(entrada);

    if (palpite == null) {
      print('Por favor, insira um número válido.');
      continue;
    }

    if (palpite == numeroSecreto) {
      print('Parabéns! Você acertou o número secreto!');
      acertou = true;
    } else if (palpite < numeroSecreto) {
      print('O número secreto é maior. Tente novamente.');
    } else {
      print('O número secreto é menor. Tente novamente.');
    }
  }
}

// 7. Simulador de Sorteio
void simuladorSorteio() {
  List<String> nomes = [];

  print('Bem-vindo ao Simulador de Sorteio!');
  print('Digite os nomes para o sorteio (digite "sair" para finalizar):');

  while (true) {
    stdout.write('Digite um nome: ');
    var entrada = stdin.readLineSync();

    if (entrada == null || entrada.toLowerCase() == 'sair') {
      break;
    }

    if (entrada.isNotEmpty) {
      nomes.add(entrada);
    } else {
      print('O nome não pode estar vazio. Tente novamente.');
    }
  }

  if (nomes.isEmpty) {
    print('Nenhum nome foi inserido. Sorteio não pode ser realizado.');
    return;
  }

  var sorteado = nomes[Random().nextInt(nomes.length)];

  print('\nLista de participantes: ${nomes.join(", ")}');
  print('O nome sorteado é: $sorteado');
}

// 8. Conversor de Moedas
void conversorMoedas() {
  // Taxas de conversão simuladas
  const double taxaDolar = 5.00; // 1 USD = 5.00 BRL
  const double taxaEuro = 5.50; // 1 EUR = 5.50 BRL

  print('Conversor de Moedas');
  print('--------------------');

  stdout.write('Digite o valor em Reais (BRL): ');
  String? input = stdin.readLineSync();

  if (input != null && input.isNotEmpty) {
    double valorReais = double.parse(input);

    double valorEmDolar = valorReais / taxaDolar;
    double valorEmEuro = valorReais / taxaEuro;

    print('\n=== Conversão ===');
    print('R\$ ${valorReais.toStringAsFixed(2)} equivale a:');
    print('- ${valorEmDolar.toStringAsFixed(2)} USD');
    print('- ${valorEmEuro.toStringAsFixed(2)} EUR');
  } else {
    print('Valor inválido!');
  }
}

// 9. Gerador de Senhas
void geradorSenhas() {
  stdout.write('Digite o tamanho da senha (padrão: 12): ');
  String? input = stdin.readLineSync();
  int tamanho =
      input != null && input.isNotEmpty ? int.tryParse(input) ?? 12 : 12;

  String senha = gerarSenha(tamanho);

  print('\nSenha gerada: $senha');
}

String gerarSenha(int tamanho) {
  const String letrasMinusculas = 'abcdefghijklmnopqrstuvwxyz';
  const String letrasMaiusculas = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const String numeros = '0123456789';
  const String simbolos = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

  String todosCaracteres =
      letrasMinusculas + letrasMaiusculas + numeros + simbolos;

  Random random = Random();
  String senha = '';

  for (int i = 0; i < tamanho; i++) {
    int index = random.nextInt(todosCaracteres.length);
    senha += todosCaracteres[index];
  }

  return senha;
}

// 10. Calculadora IMC
void calculadoraIMC() {
  print('Bem-vindo à Calculadora de IMC!');

  stdout.write('Por favor, insira seu peso em kg: ');
  var pesoEntrada = stdin.readLineSync();
  var peso = double.tryParse(pesoEntrada ?? '');

  if (peso == null || peso <= 0) {
    print(
      'Peso inválido. Por favor, reinicie o programa e insira um valor válido.',
    );
    return;
  }

  stdout.write('Por favor, insira sua altura em metros (exemplo: 1.75): ');
  var alturaEntrada = stdin.readLineSync();
  var altura = double.tryParse(alturaEntrada ?? '');

  if (altura == null || altura <= 0) {
    print(
      'Altura inválida. Por favor, reinicie o programa e insira um valor válido.',
    );
    return;
  }

  // Cálculo do IMC
  var imc = peso / (altura * altura);

  String faixa;
  if (imc < 18.5) {
    faixa = 'Baixo peso';
  } else if (imc < 24.9) {
    faixa = 'Peso normal';
  } else if (imc < 29.9) {
    faixa = 'Sobrepeso';
  } else {
    faixa = 'Obesidade';
  }

  print('\nSeu IMC é: ${imc.toStringAsFixed(2)}');
  print('Classificação: $faixa');
}