import 'dart:io';

void main() {
  print('Bem-vindo à Calculadora de IMC!');

  stdout.write('Por favor, insira seu peso em kg: ');
  var pesoEntrada = stdin.readLineSync();
  var peso = double.tryParse(pesoEntrada ?? '');

  if (peso == null || peso <= 0) {
    print('Peso inválido. Por favor, reinicie o programa e insira um valor válido.');
    return;
  }

  stdout.write('Por favor, insira sua altura em metros (exemplo: 1.75): ');
  var alturaEntrada = stdin.readLineSync();
  var altura = double.tryParse(alturaEntrada ?? '');

  if (altura == null || altura <= 0) {
    print('Altura inválida. Por favor, reinicie o programa e insira um valor válido.');
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