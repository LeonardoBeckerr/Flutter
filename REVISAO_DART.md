# Revisão de Dart antes do Flutter

Material de revisão para Leandro — seções 4 a 9, aulas 12 a 68 das imagens enviadas.

Este guia acompanha os assuntos do índice mostrado nas imagens. Os exemplos são próprios: não são transcrições dos vídeos. Os complementos estão identificados, principalmente programação assíncrona, que aparece mais adiante no curso.

## Como estudar

Leia os exemplos tentando prever a saída. Depois, responda ao questionário no final sem consultar o texto. Marque uma alternativa por questão, substituindo `[ ]` por `[x]`. O gabarito fica recolhido depois das perguntas.

Os blocos são independentes. Trechos com apenas instruções devem ser colocados dentro de `void main() { ... }`; declarações de classes e funções ficam fora dele, salvo indicação contrária. Não cole todos os exemplos juntos: alguns reutilizam nomes. Linhas comentadas como erro mostram o que não fazer.

Para praticar Dart puro, não precisa iniciar o emulador: use o DartPad ou execute `dart run exemplo.dart` no terminal.

## Mapa da revisão

| Parte | Aulas das imagens | Conteúdo |
|---|---|---|
| Seção 4 | 12–23 | Programa, DartPad, variáveis, operadores, condições e laços |
| Seção 5 | 24–32 | Funções, parâmetros, null safety, funções anônimas e escopo |
| Seção 6 | 33–44 | Dynamic, listas, documentação, mapas e JSON |
| Seção 7 | 45–50 | Exceções, enums, final/const e cascatas |
| Seção 8 | 51–59 | Classes, métodos, construtores, acesso, static, late e referências |
| Seção 9 | 60–68 | Herança, polimorfismo, override, super, cast, abstração e interfaces |
| Complemento | Preparação para Flutter | Future, async/await, callbacks e coleções em interfaces |

As aulas de finalização encerram os módulos; não exigem um conceito de sintaxe separado.

## 1. Seção 4 — Dart básico

### Programa e DartPad — aulas 12 e 13

Um programa executa instruções. Em Dart, `main` é o ponto de entrada; blocos usam chaves e instruções normalmente terminam com ponto e vírgula. DartPad é um ambiente de execução no navegador, útil para exemplos pequenos.

```dart
void main() {
  // Comentário de uma linha.
  print('Olá, Dart!');
}
```

`void` informa que a função não fornece um valor de retorno utilizável. Comentários maiores podem usar `/* ... */`; `///` documenta uma declaração.

### Variáveis e strings — aula 14

```dart
String nome = 'Leandro';
int quantidade = 3;
double preco = 19.90;
bool ativo = true;
num medida = 10; // Aceita int e double.
medida = 10.5;

print('$nome comprou $quantidade itens');
print('Total: ${quantidade * preco}');
```

`$variavel` insere um valor no texto; `${expressao}` permite uma expressão. Aspas simples e duplas criam strings. Aspas triplas permitem texto multilinha.

Conversões comuns:

```dart
int idade = int.parse('25');
int? tentativa = int.tryParse('abc'); // null, sem FormatException.
double valor = double.parse('12.5');
String texto = idade.toString();
int inteiro = 12.9.toInt(); // 12: trunca a parte decimal.
```

### Operadores aritméticos — aula 15

| Operador | Exemplo | Resultado |
|---|---|---|
| `+`, `-`, `*` | `3 * 4` | `12` |
| `/` | `7 / 2` | `3.5`, divisão com resultado double |
| `~/` | `7 ~/ 2` | `3`, divisão truncada |
| `%` | `7 % 2` | `1`, módulo |
| `+=`, `-=` | `total += 2` | Atualiza a variável |
| `++`, `--` | `contador++` | Incrementa/decrementa |

`i++` produz o valor anterior e depois incrementa; `++i` incrementa antes de produzir o valor. Quando usados sozinhos, ambos aumentam `i` em um.

### Decisões, lógica e if/else — aulas 16–18

Comparações: `==`, `!=`, `<`, `>`, `<=`, `>=`. Lógica: `&&` (e), `||` (ou), `!` (negação). Uma condição precisa ser `bool`: números e strings não viram verdadeiro/falso automaticamente.

```dart
int idade = 20;
bool temIngresso = true;

if (idade >= 18 && temIngresso) {
  print('Entrada permitida');
} else if (!temIngresso) {
  print('Falta ingresso');
} else {
  print('Idade insuficiente');
}
```

`&&` e `||` têm curto-circuito: o segundo lado só é avaliado quando necessário. `=` atribui; `==` compara.

### Ternário e switch — aulas 19 e 20

```dart
int nota = 8;
String resultado = nota >= 7 ? 'Aprovado' : 'Revisar';

String comando = 'salvar';
switch (comando) {
  case 'salvar':
    print('Salvando');
    break;
  case 'abrir':
    print('Abrindo');
    break;
  default:
    print('Comando desconhecido');
}
```

O ternário produz um valor. No Dart 3, casos não vazios do `switch` não precisam de `break` ao final; o estilo acima continua válido e ajuda a acompanhar aulas antigas.

Complemento de Dart 3: uma expressão switch também produz um valor.

```dart
String comando = 'salvar';
final mensagem = switch (comando) {
  'salvar' => 'Salvando',
  'abrir' => 'Abrindo',
  _ => 'Comando desconhecido',
};
```

### While, do/while e for — aulas 21–23

```dart
int tentativas = 0;
while (tentativas < 3) {
  tentativas++;
}

do {
  print('Executa pelo menos uma vez');
} while (false);

for (int i = 0; i < 3; i++) {
  print(i); // 0, 1, 2.
}

for (final nome in ['Ana', 'Bia']) {
  print(nome);
}
```

`while` verifica antes; `do/while` verifica depois. `break` encerra o laço; `continue` passa à próxima iteração. Para percorrer itens sem precisar do índice, `for-in` costuma ser suficiente.

## 2. Seção 5 — Funções e null safety

### Declaração, retorno e parâmetros — aulas 24–26 e 29

```dart
int somar(int a, int b) {
  return a + b;
}

int dobrar(int numero) => numero * 2;

void mostrar(String mensagem) {
  print(mensagem);
}
```

A declaração informa o tipo do retorno, o nome, os parâmetros e o corpo. `return` encerra a função. `=> expressao` é uma forma curta para um corpo de uma expressão; não coloque um bloco de instruções depois da seta.

| Forma | Declaração | Chamada |
|---|---|---|
| Posicional obrigatório | `int somar(int a, int b)` | `somar(2, 3)` |
| Posicional opcional | `String saudar(String nome, [String prefixo = 'Olá'])` | `saudar('Ana')` |
| Nomeado opcional | `void listar({int limite = 10})` | `listar(limite: 5)` |
| Nomeado obrigatório | `void salvar({required String nome})` | `salvar(nome: 'Ana')` |

As declarações da tabela são apenas assinaturas: precisam de corpo quando implementadas.

```dart
String saudar(String nome, [String prefixo = 'Olá']) {
  return '$prefixo, $nome';
}

void cadastrar({
  required String nome,
  int idade = 18,
  String? apelido,
}) {
  print('$nome / $idade / ${apelido ?? "sem apelido"}');
}

void main() {
  print(saudar('Ana'));
  cadastrar(idade: 25, nome: 'Leandro');
}
```

Parâmetros nomeados são identificados pelo nome, não pela posição. O valor padrão deve ser constante de compilação. Uma função pode ter posicionais obrigatórios seguidos de nomeados ou de posicionais opcionais; não combine os dois grupos opcionais na mesma declaração.

**`required` e nullable são independentes.** `required String? nome` exige que o argumento seja informado, mas aceita `nome: null`.

### Null safety — aulas 27, 28 e 31

`String` não aceita null. `String?` aceita texto ou null. Null representa ausência de valor; não é string vazia, zero ou false.

```dart
String nome = 'Ana';
String? apelido;
// nome = null; // Erro de análise.
print(apelido); // null.
```

| Sintaxe | Finalidade | Exemplo |
|---|---|---|
| `Tipo?` | Permitir null | `String? nome` |
| `objeto?.membro` | Acessar somente se o objeto não for null | `nome?.length` |
| `a ?? b` | Usar b se a for null | `nome ?? 'Visitante'` |
| `a ??= b` | Atribuir b se a estiver null | `nome ??= 'Visitante'` |
| `valor!` | Afirmar que não é null | `nome!.length` |

`!` não preenche nem corrige um valor: lança erro em execução se ele for null. Prefira tratar a ausência.

```dart
int tamanhoSeguro(String? texto) {
  return texto?.length ?? 0;
}

void mostrarMaiusculas(String? texto) {
  if (texto != null) {
    print(texto.toUpperCase()); // Aqui o Dart sabe que é String.
  }
}

int? converter(String texto) => int.tryParse(texto);
```

O teste promove a variável local para um tipo não anulável naquele caminho. Em campos mutáveis de objetos, capture em uma variável local antes de verificar, pois nem todo campo pode ser promovido.

### Funções anônimas, callbacks e escopo — aulas 30 e 32

Funções podem ser armazenadas e passadas como argumentos. Um callback é uma função entregue a outro código para que ele a execute.

```dart
void executar(void Function() acao) {
  acao();
}

void salvar() {
  print('Salvo');
}

void main() {
  executar(salvar); // Passa a função, sem executá-la aqui.
  executar(() => print('Outra ação'));

  final triplicar = (int valor) => valor * 3;
  print(triplicar(4)); // 12.

  int contador = 0;
  void incrementar() {
    contador++; // Acessa o escopo externo: closure.
  }
  incrementar();
  print(contador); // 1.
}
```

`salvar` é a função; `salvar()` é sua execução. Essa diferença explica callbacks como `onPressed` no Flutter. Uma variável declarada dentro de um bloco não fica disponível fora dele.

## 3. Seção 6 — Coleções e JSON

### Var, dynamic e Object — aula 33

```dart
var nome = 'Ana'; // Inferido como String.
nome = 'Bia';
// nome = 10; // Erro: o tipo continua String.

dynamic dado = 10;
dado = 'texto'; // Permitido.
// dado.metodoInexistente(); // Passa pela análise, falha em execução.

Object valor = 'texto';
if (valor is String) {
  print(valor.toUpperCase());
}
```

`var` com inicializador infere o tipo. `dynamic` adia verificações para execução. `Object` aceita objetos não nulos, mas exige verificar/converter para acessar operações específicas. `Object?` também aceita null. Evite `var dado;` sem inicializador quando pretende manter um tipo específico: nesse caso o tipo será dynamic.

### Listas e operações — aulas 34, 36–38

```dart
final nomes = <String>['Ana', 'Bia'];
nomes.add('Caio');
nomes.addAll(['Duda', 'Eva']);
nomes.insert(0, 'Zeca');
nomes[1] = 'Alice';
nomes.remove('Bia');
nomes.removeAt(0);

print(nomes.length);
print(nomes.contains('Caio'));
print(nomes.isEmpty);
print(nomes.first); // Requer lista não vazia.
```

Os índices começam em zero. Acessar um índice inexistente causa erro. `remove` procura um valor; `removeAt` usa um índice. `clear` remove todos os itens. Não altere estruturalmente uma lista enquanto a percorre; para remoção condicional, use `removeWhere`.

```dart
final numeros = [1, 2, 3, 4];
final dobrados = numeros.map((n) => n * 2).toList();
final pares = numeros.where((n) => n.isEven).toList();
final total = numeros.fold<int>(0, (soma, n) => soma + n);

print(dobrados); // [2, 4, 6, 8]
print(pares); // [2, 4]
print(total); // 10
print(numeros.any((n) => n > 3)); // true
print(numeros.every((n) => n > 0)); // true

for (final numero in numeros) {
  print(numero);
}
numeros.forEach((n) => print(n));
```

`map` transforma; `where` filtra; `forEach` executa uma ação e retorna void. `map` e `where` produzem Iterables preguiçosos: o trabalho acontece ao percorrer. `toList()` percorre e materializa uma nova lista. Essas operações não modificam automaticamente a lista original.

```dart
final valores = [3, 1, 2];
valores.sort(); // Muda a própria lista; retorna void.
print(valores); // [1, 2, 3]

final copia = [...valores];
copia.sort((a, b) => b.compareTo(a));
print(copia); // [3, 2, 1]
```

`firstWhere` procura o primeiro correspondente; sem resultado e sem `orElse`, lança erro. `orElse` deve fornecer um valor compatível com o tipo dos elementos.

### Como ler documentação — aula 35

Confira o tipo de retorno, os parâmetros, se há valores opcionais, se o método altera a coleção e quais erros pode lançar. Por exemplo: `where` retorna Iterable, `toList` retorna List e `sort` retorna void. Essa leitura evita tentar guardar o resultado de `sort` como se fosse outra lista.

### Listas e null safety — aula 39

| Tipo | A lista pode ser null? | Um item pode ser null? |
|---|---|---|
| `List<String>` | Não | Não |
| `List<String?>` | Não | Sim |
| `List<String>?` | Sim | Não |
| `List<String?>?` | Sim | Sim |

```dart
List<String?> nomes = ['Ana', null];
print(nomes[1]?.toUpperCase() ?? 'Sem nome');

List<String>? carregados;
print(carregados?.length ?? 0);
```

### Mapas — aulas 40–42

```dart
final precos = <String, double>{
  'Café': 8.0,
  'Suco': 10.0,
};

precos['Água'] = 4.0;
precos.update('Café', (preco) => preco + 1);
precos.remove('Suco');

print(precos.keys);
print(precos.values);
print(precos.containsKey('Café'));

for (final entrada in precos.entries) {
  print('${entrada.key}: ${entrada.value}');
}
```

Mesmo em `Map<String, double>`, `precos['Inexistente']` é `double?`: a chave pode estar ausente. Use `??`, uma verificação ou, apenas quando garantido, `!`.

`Map<String, int?>` admite valores null; `Map<String, int>?` admite que o mapa inteiro seja null. Se valores null são permitidos, `mapa[chave] == null` não distingue chave ausente de chave presente com null; `containsKey` distingue.

### JSON — aulas 43 e 44

JSON é um formato de texto. `Map` e `List` são objetos em memória. `jsonDecode` interpreta o texto; `jsonEncode` produz texto JSON.

```dart
import 'dart:convert';

void main() {
  const texto = '{"nome":"Ana","idade":25,"ativo":true}';
  final dados = jsonDecode(texto) as Map<String, dynamic>;

  final nome = dados['nome'] as String;
  final idade = dados['idade'] as int;
  print('$nome tem $idade anos');

  final saida = jsonEncode({'nome': nome, 'idade': idade + 1});
  print(saida);
}
```

Os casts acima pressupõem esse formato conhecido. Dados externos podem conter tipos/chaves diferentes e precisam de validação. JSON também pode representar listas e valores simples, então nem todo `jsonDecode` retorna um mapa. Chaves de objetos JSON são strings; strings JSON usam aspas duplas. `mapa.toString()` não substitui `jsonEncode(mapa)`.

## 4. Seção 7 — Recursos essenciais

### Exceptions e try/catch — aulas 45 e 46

```dart
void main() {
  try {
    final numero = int.parse('abc');
    print(numero);
  } on FormatException catch (erro) {
    print('Texto inválido: ${erro.message}');
  } catch (erro, pilha) {
    print('Outro problema: $erro');
    print(pilha);
  } finally {
    print('Fim da tentativa');
  }
}
```

`throw` lança; `on` seleciona um tipo; `catch` recebe o objeto e opcionalmente a pilha; `finally` executa ao sair do try/catch, inclusive se houver erro ou return. Dentro de catch, `rethrow` propaga o erro original preservando a pilha.

```dart
class SaldoInsuficiente implements Exception {
  final double saldo;
  SaldoInsuficiente(this.saldo);

  @override
  String toString() => 'Saldo insuficiente: $saldo';
}

void validarSaque(double saldo, double valor) {
  if (valor > saldo) {
    throw SaldoInsuficiente(saldo);
  }
}
```

Uma exceção personalizada permite distinguir problemas do domínio. Não use catch vazio para esconder falhas. Para uma conversão que normalmente pode falhar, `tryParse` pode ser mais simples.

### Enumeradores — aula 47

```dart
enum StatusPedido { pendente, enviado, entregue }

void main() {
  final status = StatusPedido.enviado;
  print(status.name); // enviado
  print(StatusPedido.values); // Todos os valores.
  print(status == StatusPedido.enviado); // true
}
```

Enum restringe o valor a opções conhecidas e evita erros de digitação em strings. O índice depende da ordem da declaração; evite usá-lo como identificador persistente se a ordem puder mudar.

### Var, final e const — aula 48

| Declaração | Reatribuição | Observação |
|---|---|---|
| `var nome = 'Ana'` | Sim, com tipo compatível | Tipo inferido |
| `final agora = DateTime.now()` | Não, após inicialização | Pode ser calculado em execução |
| `const limite = 10` | Não | Valor constante de compilação |

```dart
final numeros = [1, 2];
numeros.add(3); // Pode modificar o objeto.
// numeros = [4]; // Não pode trocar a referência.

const fixos = [1, 2];
// fixos.add(3); // Falha em execução: lista constante é imutável.

final instante = DateTime.now();
// const instante = DateTime.now(); // Não é constante de compilação.
```

`final` não congela um objeto mutável: impede reatribuir a variável. `const` produz valores constantes imutáveis. Um campo de instância pode ser final; uma constante da classe é declarada `static const`.

### Cascatas — aula 49

```dart
final nomes = <String>[]
  ..add('Bia')
  ..add('Ana')
  ..sort();

print(nomes); // [Ana, Bia]
```

A cascata `..` mantém o objeto original como alvo, mesmo quando um método retorna void. `nomes.add('Ana').sort()` não funcionaria, pois `add` retorna void.

`?..` inicia uma cascata que só executa se o alvo não for null:

```dart
void preencher(List<String>? nomes) {
  nomes
    ?..add('Ana')
    ..sort();
}
```

## 5. Seção 8 — Classes e objetos

### Classes, atributos, métodos e construtores — aulas 51–53

```dart
class Pessoa {
  String nome;
  int idade;

  Pessoa(this.nome, this.idade);

  Pessoa.recemNascida(this.nome) : idade = 0;

  void fazerAniversario() {
    idade++;
  }
}

void main() {
  final pessoa = Pessoa('Ana', 25);
  pessoa.fazerAniversario();
  print(pessoa.idade); // 26

  final bebe = Pessoa.recemNascida('Bia');
  print(bebe.idade); // 0
}
```

A classe define a estrutura; cada objeto é uma instância. Atributos guardam estado; métodos representam operações. `this.nome` no construtor recebe o parâmetro e inicializa o campo diretamente. A lista depois de `:` inicializa campos antes do corpo. Construtor não declara tipo de retorno.

Não confunda **construtor nomeado** (`Pessoa.recemNascida`) com **parâmetro nomeado** (`nome: 'Ana'`). Eles podem aparecer juntos.

```dart
class Produto {
  final String nome;
  final double preco;

  const Produto({required this.nome, required this.preco});
}

void main() {
  const produto = Produto(nome: 'Caderno', preco: 12.0);
  print(produto.nome);
}
```

Um construtor const permite construir objetos constantes quando argumentos e contexto permitem. Ele também pode ser chamado sem const com valores de execução; declarar o construtor const não transforma toda chamada em constante.

### Getters, setters e atributos nullable — aulas 54 e 55

```dart
class Conta {
  double _saldo = 0;
  String? apelido;

  double get saldo => _saldo;

  set saldo(double valor) {
    if (valor < 0) {
      throw ArgumentError('Saldo não pode ser negativo');
    }
    _saldo = valor;
  }
}

void main() {
  final conta = Conta();
  conta.saldo = 50; // Executa o setter.
  print(conta.saldo); // Executa o getter, sem ().
  print(conta.apelido ?? 'Conta principal');
}
```

O prefixo `_` restringe o acesso à biblioteca Dart, não à classe. Arquivos separados normalmente são bibliotecas separadas; arquivos ligados por `part` compartilham uma biblioteca. Um getter pode calcular um valor sem armazená-lo.

### Static — aula 56

```dart
class Configuracao {
  static const versao = '1.0';
  static int acessos = 0;

  static void registrar() {
    acessos++;
  }
}

void main() {
  Configuracao.registrar();
  print(Configuracao.acessos); // 1
}
```

Membros static pertencem à classe. Campos comuns pertencem a cada instância. Métodos static não têm `this` e não acessam campos de instância sem um objeto.

### Late e acesso seguro — aulas 57 e 58

```dart
class Sessao {
  late final String token;
  String? apelido;

  void iniciar(String valor) {
    token = valor;
  }
}

void main() {
  final sessao = Sessao();
  sessao.iniciar('abc');
  print(sessao.token);
  print(sessao.apelido?.toUpperCase() ?? 'SEM APELIDO');
}
```

`late` transfere para execução a responsabilidade de inicializar antes de ler. Ler antes da atribuição provoca `LateInitializationError`. `late final` aceita uma única inicialização. Não use late apenas para silenciar um erro se não consegue garantir essa ordem.

Complemento: `late final resultado = calcular();` adia o cálculo até o primeiro acesso.

### Passagem de referência — aula 59

O nome da aula costuma gerar confusão: em Dart, os argumentos são passados por valor; para objetos, esse valor é uma referência ao objeto. Alterar o objeto compartilhado é diferente de reatribuir a variável local.

```dart
void adicionar(List<int> itens) {
  itens.add(3); // Modifica o objeto compartilhado.
}

void substituir(List<int> itens) {
  itens = [99]; // Só muda o parâmetro local.
}

void main() {
  final original = [1, 2];
  final alias = original;

  adicionar(alias);
  substituir(original);
  print(original); // [1, 2, 3]

  final copia = [...original];
  copia.add(4);
  print(original); // Continua [1, 2, 3].
}
```

A cópia de lista acima é superficial: copia a coleção, mas objetos mutáveis dentro dela ainda podem ser compartilhados.

## 6. Seção 9 — Herança e polimorfismo

### Herança, reescrita e super — aulas 60–63

```dart
class Animal {
  final String nome;
  Animal(this.nome);

  void dormir() {
    print('Dormiu');
  }

  @override
  String toString() => 'Animal: $nome';
}

class Cachorro extends Animal {
  Cachorro(String nome) : super(nome);

  @override
  void dormir() {
    super.dormir();
    print('Roncando muito');
  }

  void latir() {
    print('Au au');
  }
}

void main() {
  Animal animal = Cachorro('Rex');
  animal.dormir(); // Dormiu / Roncando muito.
  print(animal); // Animal: Rex.
}
```

`extends` cria uma relação de subtipo e permite reutilizar implementação. O objeto acima é um Cachorro, ainda que a variável seja declarada Animal: sua implementação de dormir é a executada. Isso é polimorfismo.

Use herança quando a relação “é um” fizer sentido. Para “tem um”, composição — guardar outro objeto como campo — costuma expressar melhor a relação.

### O que @override faz — revisão da dúvida da aula

**A anotação não ativa a sobrescrita.** Declarar um membro de instância compatível com o herdado já o sobrescreve. `@override` registra a intenção e permite ao analisador avisar quando não há membro correspondente.

| Método do exemplo | Origem | Anotação |
|---|---|---|
| `Cachorro.dormir()` | Já existe em Animal | Recomendada, mas opcional |
| `Animal.toString()` | Já existe em Object | Recomendada, mas opcional |
| `Cachorro.latir()` | Não existe em Animal nem Object | Não cabe override |

Retirar só `@override` não altera a saída. Escrever `dormi()` por engano cria outro método; com a anotação, o analisador sinaliza a intenção incorreta. Mesmo sem a anotação, uma assinatura incompatível de um membro que realmente sobrescreve outro continua sujeita às regras de tipos.

Uma classe comum sem `extends` explícito herda de Object. Portanto, Animal também tem uma classe mãe. `String toString()` significa “método chamado toString, sem argumentos, que retorna texto”. `print(objeto)` usa essa representação; isso não altera o objeto nem gera JSON automaticamente.

`super.dormir()` chama a implementação da classe mãe. Sem essa chamada, o corpo da mãe não é executado automaticamente. O construtor `super(nome)` inicializa a parte herdada. A escrita `Cachorro(super.nome);` é uma abreviação moderna para encaminhar esse parâmetro.

### Cast e verificação de tipos — aula 64

```dart
void inspecionar(Animal animal) {
  if (animal is Cachorro) {
    animal.latir(); // Promovido para Cachorro neste bloco.
  }
}
```

`is` verifica; `is!` verifica que não é; `as` faz um cast com checagem em execução. Cast não transforma um Animal genérico em Cachorro. `animal as Cachorro` falha se o objeto não for compatível. Para conversão de texto em número, use parse/tryParse, não as.

### Classes abstratas — aula 65

```dart
abstract class Forma {
  double area(); // Contrato sem corpo.

  void descrever() {
    print('Área: ${area()}');
  }
}

class Quadrado extends Forma {
  final double lado;
  Quadrado(this.lado);

  @override
  double area() => lado * lado;
}

void main() {
  final forma = Quadrado(4);
  forma.descrever(); // Área: 16.0.
  // Forma(); // Erro: classe abstrata não pode ser instanciada.
}
```

Uma classe abstrata pode combinar membros implementados com contratos sem corpo. Uma subclasse concreta precisa fornecer os membros abstratos que ainda não têm implementação.

### Interfaces e outro uso para interfaces — aulas 66 e 67

```dart
abstract class Repositorio {
  String buscarNome();
}

class RepositorioMemoria implements Repositorio {
  @override
  String buscarNome() => 'Ana';
}

class RepositorioTeste implements Repositorio {
  @override
  String buscarNome() => 'Usuário de teste';
}

void mostrarUsuario(Repositorio repositorio) {
  print(repositorio.buscarNome());
}

void main() {
  mostrarUsuario(RepositorioMemoria());
  mostrarUsuario(RepositorioTeste());
}
```

`implements` exige cumprir o contrato; não copia os corpos dos métodos da classe usada como interface. O código consumidor pode trabalhar com o contrato e receber implementações diferentes, inclusive uma de teste.

Classes comuns definem interfaces implícitas para seus membros de instância. Em Dart 3, `abstract interface class Repositorio` é uma opção para declarar explicitamente esse papel, com restrições adicionais para herança fora da biblioteca. O exemplo usa a forma tradicional para acompanhar o curso.

| Recurso | O que oferece |
|---|---|
| `extends` | Herança de uma classe, com reutilização de implementação |
| `implements` | Contratos, inclusive múltiplos; exige implementação dos membros |
| `super` | Acesso à implementação/construtor da classe mãe |
| `@override` | Intenção de sobrescrever ou implementar membro de um supertipo |

Complemento: `with` aplica mixins para reutilizar comportamento. Não é necessário dominar mixins para revisar as aulas listadas.

## 7. Complemento — Future, async e await

Esta parte é uma introdução para o que vem depois do módulo 9. Pode estudar gradualmente junto às aulas de Flutter.

`Future<T>` representa uma operação que pode completar com um valor T ou com erro. `Future<void>` permite aguardar a conclusão sem obter um resultado útil. `async` permite usar await; `await` suspende a continuação daquela função enquanto aguarda o resultado, permitindo outro trabalho no loop de eventos. Não cria uma thread nem torna cálculos pesados automaticamente paralelos.

```dart
Future<String> buscarNome() async {
  await Future<void>.delayed(const Duration(milliseconds: 100));
  return 'Leandro';
}

Future<void> main() async {
  print('Carregando');
  try {
    final nome = await buscarNome();
    print(nome);
  } catch (erro) {
    print('Falha: $erro');
  } finally {
    print('Tentativa concluída');
  }
}
```

```dart
// Dentro de uma função async:
final operacao = buscarNome(); // Future<String>.
final nome = await operacao; // String.
```

O await é importante também para que o try/catch capture o erro assíncrono. Evite descartar Futures sem decidir como tratar sua conclusão.

Operações independentes podem ser iniciadas antes de esperar todas:

```dart
Future<int> obter(int valor) async => valor;

Future<void> main() async {
  final resultados = await Future.wait([obter(1), obter(2)]);
  print(resultados); // [1, 2].
}
```

Não use `lista.forEach((item) async { ... })` esperando que o forEach aguarde os callbacks. Para sequência, use `for` com await; para operações independentes, considere Future.wait. Streams representam vários eventos ao longo do tempo e ficam para um próximo estudo.

## 8. Ligando a sintaxe ao Flutter

O trecho abaixo é ilustrativo de Flutter, não um programa Dart puro completo:

```dart
ElevatedButton(
  onPressed: () {
    print('Clicou');
  },
  child: const Text('Salvar'),
)
```

Você está lendo uma chamada de construtor, parâmetros nomeados, uma função anônima e um objeto constante. Em `onPressed: salvar`, você passa um callback; em `onPressed: salvar()`, você executa a função naquele momento e tenta usar seu retorno.

Complementos de coleções muito usados em interfaces:

```dart
bool mostrarExtra = true;
final extras = ['Ajuda', 'Contato'];
final itens = [
  'Início',
  if (mostrarExtra) 'Configurações',
  ...extras,
  for (int i = 1; i <= 2; i++) 'Página $i',
];
```

`...` inclui itens de outra coleção; `...?` tolera coleção null. `if` e `for` dentro de literais constroem os itens. Complemento: `Set<int> ids = {1, 2, 2};` guarda valores únicos; uma literal `{}` sem contexto é um Map, não um Set vazio.

### Núcleo para conferir antes de avançar

- [ ] Diferencio var, final, const e dynamic.
- [ ] Consigo declarar e chamar parâmetros nomeados com required.
- [ ] Sei tratar null sem colocar ! por tentativa.
- [ ] Transformo e filtro listas com map, where e toList.
- [ ] Distingo uma função de sua execução.
- [ ] Crio classes com construtores e campos inicializados.
- [ ] Distingo extends, implements, super e override.
- [ ] Entendo inicialmente Future e await — complemento, não pré-requisito de domínio total agora.

## Referências para consulta

O índice veio das imagens fornecidas. Para detalhes de linguagem, consulte a documentação oficial:

- [Variáveis, late, final e const](https://dart.dev/language/variables)
- [Funções e parâmetros](https://dart.dev/language/functions)
- [Null safety](https://dart.dev/null-safety/understanding-null-safety)
- [Coleções](https://dart.dev/language/collections)
- [Operadores](https://dart.dev/language/operators)
- [Construtores](https://dart.dev/language/constructors)
- [Herança e sobrescrita](https://dart.dev/language/extend)
- [Classes e interfaces implícitas](https://dart.dev/language/classes)
- [Programação assíncrona](https://dart.dev/libraries/async/async-await)

## 9. Questionário — marque uma alternativa por questão

As questões 1–27 revisam os módulos; 28–30 são do complemento assíncrono. Não execute os trechos antes de tentar prever o resultado. As caixas são Markdown: caso o visualizador não permita clicar, edite `[ ]` para `[x]` no arquivo.

### 1. O que acontece em `var nome = 'Ana'; nome = 10;`?

- [ ] A. Funciona porque var aceita qualquer tipo.
- [ ] B. Há erro de análise porque nome foi inferido como String.
- [ ] C. O número é convertido automaticamente para texto.
- [ ] D. Nome se torna null.

### 2. Qual é válida para obter a data/hora durante a execução?

- [ ] A. `const agora = DateTime.now();`
- [ ] B. `const DateTime agora = DateTime.now();`
- [ ] C. `final agora = DateTime.now();`
- [ ] D. Nenhuma variável pode guardar esse valor.

### 3. Qual é a saída?

```dart
final valores = [1, 2];
valores.add(3);
print(valores);
```

- [ ] A. [1, 2, 3].
- [ ] B. Erro porque final congela a lista.
- [ ] C. [3].
- [ ] D. [1, 2].

### 4. Qual é o resultado de `7 ~/ 2`?

- [ ] A. 3.5.
- [ ] B. 4.
- [ ] C. 1.
- [ ] D. 3.

### 5. Qual laço executa o corpo pelo menos uma vez?

- [ ] A. while.
- [ ] B. do/while.
- [ ] C. for-in.
- [ ] D. Todos, independentemente da condição.

### 6. Considere `void salvar({required String nome, int idade = 18}) {}`. Qual chamada é válida?

- [ ] A. `salvar('Ana');`
- [ ] B. `salvar(idade: 25);`
- [ ] C. `salvar(nome: 'Ana');`
- [ ] D. `salvar();`

### 7. O que significa `{required String? apelido}`?

- [ ] A. O argumento deve ser informado, mas pode ser null.
- [ ] B. O argumento é opcional e nunca pode ser null.
- [ ] C. O argumento deve ser uma String não nula.
- [ ] D. É uma declaração inválida.

### 8. Qual é a saída?

```dart
int tamanho(String? texto) => texto?.length ?? 0;
void main() {
  print(tamanho(null));
}
```

- [ ] A. null.
- [ ] B. Uma string vazia.
- [ ] C. Um erro de acesso a null.
- [ ] D. 0.

### 9. O que `valor!` faz quando valor é null?

- [ ] A. Cria um valor padrão.
- [ ] B. Provoca erro durante a execução.
- [ ] C. Retorna false.
- [ ] D. Ignora a instrução.

### 10. Para passar a função `void salvar() {}` como callback, usamos: - nao entendi a questao

- [ ] A. `salvar()`.
- [ ] B. `'salvar'`.
- [ ] C. `salvar`.
- [ ] D. `return salvar()`.

### 11. Qual arrow function retorna o dobro de um inteiro?

- [ ] A. `int dobro(int n) => n * 2;`
- [ ] B. `int dobro(int n) => { return n * 2; };`
- [ ] C. `int dobro(int n) = n * 2;`
- [ ] D. `void dobro(int n) { print(n * 2); }`

### 12. Qual é a saída?

```dart
final resultado = [1, 2, 3, 4]
    .where((n) => n.isEven)
    .map((n) => n * 10)
    .toList();
print(resultado);
```

- [ ] A. [10, 20, 30, 40].
- [ ] B. [2, 4].
- [ ] C. [1, 3].
- [ ] D. [20, 40].

### 13. O que map e where retornam em uma lista comum?

- [ ] A. Sempre uma nova List já materializada.
- [ ] B. Iterables; toList materializa uma lista.
- [ ] C. void, como forEach.
- [ ] D. A lista original modificada.

### 14. O que `List<String?>` permite?

- [ ] A. Apenas que a própria lista seja null.
- [ ] B. Nem lista nem elementos null.
- [ ] C. Elementos null, mas a própria lista não é null.
- [ ] D. Qualquer tipo de elemento.

### 15. Por que `mapa['idade']` pode ser null em `Map<String, int>`?

- [ ] A. Porque a chave pode não existir.
- [ ] B. Porque todo int aceita null.
- [ ] C. Porque mapas só guardam dynamic.
- [ ] D. Porque [] sempre converte valores para null.

### 16. Qual função transforma um mapa compatível em texto JSON?

- [ ] A. jsonDecode.
- [ ] B. toString, sempre.
- [ ] C. int.parse.
- [ ] D. jsonEncode.

### 17. Para que serve finally?

- [ ] A. Executar somente se não houve erro.
- [ ] B. Executar ao sair do try/catch, com ou sem erro.
- [ ] C. Converter exceções em null automaticamente.
- [ ] D. Repetir a tentativa até funcionar.

### 18. Considere `enum Status { aberto, fechado }`. Qual atribuição é correta?

- [ ] A. `Status estado = 'aberto';`
- [ ] B. `Status estado = 0;`
- [ ] C. `Status estado = Status.aberto;`
- [ ] D. `Status estado = Status();`

### 19. O que a cascata permite neste trecho?

```dart
final nomes = <String>[]..add('Bia')..add('Ana')..sort();
```

- [ ] A. Executar as operações na mesma lista e atribuí-la a nomes.
- [ ] B. Atribuir a nomes o retorno void de sort.
- [ ] C. Criar uma lista nova para cada chamada.
- [ ] D. Executar add somente se sort falhar.

### 20. `Pessoa.recemNascida(this.nome) : idade = 0;` é:

- [ ] A. Um parâmetro nomeado.
- [ ] B. Um getter.
- [ ] C. Uma função assíncrona.
- [ ] D. Um construtor nomeado com inicialização de campo.

### 21. Como se acessa `double get saldo => _saldo;` em uma instância conta?

- [ ] A. `conta.saldo()`.
- [ ] B. `conta.saldo`.
- [ ] C. `get conta.saldo`.
- [ ] D. Somente pela classe, nunca pela instância.

### 22. Um campo static pertence:

- [ ] A. A cada instância, com um valor separado obrigatório.
- [ ] B. Somente ao construtor.
- [ ] C. À classe.
- [ ] D. Ao arquivo JSON.

### 23. O que acontece ao ler um campo `late String nome;` antes de inicializá-lo?

- [ ] A. Ocorre LateInitializationError.
- [ ] B. Recebe automaticamente uma string vazia.
- [ ] C. Retorna null.
- [ ] D. O programa aguarda sua inicialização.

### 24. Qual é a saída?

```dart
void mudar(List<int> itens) {
  itens.add(2);
  itens = [99];
}
void main() {
  final lista = [1];
  mudar(lista);
  print(lista);
}
```

- [ ] A. [99].
- [ ] B. [1].
- [ ] C. [1, 2, 99].
- [ ] D. [1, 2].

### 25. Cachorro declara dormir com assinatura compatível com Animal.dormir, mas sem @override. O que ocorre?

- [ ] A. O método não sobrescreve o da mãe.
- [ ] B. A sobrescrita funciona; a anotação é opcional e ajuda na verificação.
- [ ] C. Os dois corpos sempre executam automaticamente.
- [ ] D. O programa não compila.

### 26. Em um dormir sobrescrito, qual instrução chama o corpo da classe mãe?

- [ ] A. `this.dormir();`
- [ ] B. `@override dormir();`
- [] C. `super.dormir();`
- [ ] D. `Object.dormir();`

### 27. Qual afirmação está correta?

- [ ] A. implements não herda os corpos; classes abstratas não são instanciadas diretamente; um cast as incompatível falha em execução.
- [ ] B. implements copia todos os métodos; abstract só impede herança.
- [ ] C. as transforma qualquer Animal em Cachorro.
- [ ] D. Todo método toString precisa de @override para funcionar.

### 28. [Complemento] Uma função retorna Future<String>. Como obter o texto dentro de uma função async?

- [ ] A. `String nome = buscarNome();`
- [ ] B. `String nome = buscarNome().toString();`, pois isso aguarda.
- [ ] C. `String nome = buscarNome() as String;`
- [ ] D. `String nome = await buscarNome();`

### 29. [Complemento] O que await faz?

- [ ] A. Cria sempre uma nova thread.
- [ ] B. Suspende a continuação da função enquanto aguarda o resultado.
- [ ] C. Converte automaticamente o resultado em String.
- [ ] D. Torna qualquer cálculo pesado não bloqueante.

### 30. [Complemento] Como aguardar várias operações em sequência, uma por item?

- [ ] A. `itens.forEach((item) async { await salvar(item); });`, pois forEach aguarda tudo.
- [ ] B. `itens.map(salvar);`, sem percorrer o resultado.
- [ ] C. `for (final item in itens) { await salvar(item); }`, dentro de uma função async.
- [ ] D. Adicionar @override à função.

## Gabarito comentado — abra depois de responder

<details>
<summary>Mostrar respostas e explicações</summary>

| Questão | Resposta | Motivo |
|---|---|---|
| 1 | B | Var infere String a partir do inicializador. |
| 2 | C | DateTime.now depende da execução; final permite isso. |
| 3 | A | Final impede reatribuição, não a mutação da lista. |
| 4 | D | ~/ trunca o resultado da divisão. |
| 5 | B | A condição do do/while é verificada depois do corpo. |
| 6 | C | Nome é nomeado e obrigatório; idade tem padrão. |
| 7 | A | Obrigatoriedade do argumento e aceitação de null são independentes. |
| 8 | D | ?. produz null e ?? fornece 0. |
| 9 | B | ! exige em execução que o valor não seja null. |
| 10 | C | Sem parênteses, passa a função; com parênteses, executa. |
| 11 | A | Arrow recebe uma única expressão, cujo resultado é retornado. |
| 12 | D | Filtra 2 e 4; transforma em 20 e 40. |
| 13 | B | As transformações são percorridas/materializadas pelo toList. |
| 14 | C | O ? está no tipo do elemento, não depois da List. |
| 15 | A | A consulta também precisa representar chave ausente. |
| 16 | D | Encode produz texto; decode interpreta texto. |
| 17 | B | Finally executa ao sair da tentativa, inclusive com erro/return. |
| 18 | C | O valor pertence ao enum, não é string nem número. |
| 19 | A | A cascata mantém a lista como alvo e valor da expressão. |
| 20 | D | O nome vem depois da classe e : inicializa o campo. |
| 21 | B | Getter é acessado como propriedade, sem chamada com (). |
| 22 | C | Static pertence à classe e é acessado por ela. |
| 23 | A | Late não fornece um valor padrão; exige inicialização antes de ler. |
| 24 | D | Add altera a lista compartilhada; reatribuir itens só altera a variável local. |
| 25 | B | O método compatível sobrescreve mesmo sem a anotação. |
| 26 | C | Super acessa a implementação da mãe; this chamaria a versão atual novamente. |
| 27 | A | São as distinções entre contrato, abstração e cast. |
| 28 | D | Await obtém o resultado do Future ou propaga seu erro. |
| 29 | B | A função aguarda sem transformar o trabalho em paralelismo automático. |
| 30 | C | O laço espera cada operação; forEach não espera callbacks async. |

</details>

### Como usar o resultado

Conte os acertos de 1 a 27 separadamente do complemento. Como orientação de estudo, não como certificação: 23–27 acertos indicam boa base para avançar; 18–22 sugerem revisar os erros; abaixo disso, pratique mais exemplos antes de acumular conceitos de Flutter.

Preste atenção especial às questões 1–3, 6–15 e 20–27: elas cobrem o núcleo mais recorrente nos widgets. As questões 28–30 são diagnóstico inicial do complemento; errá-las agora não significa que você não aprendeu os módulos 4–9.

Para conferir aplicação prática, tente criar sem copiar uma classe Produto com nome e preço, filtrar uma lista por preço e imprimir os produtos usando toString. Depois explique por que seu @override pode ser retirado sem mudar a saída. Acertar alternativas ajuda; conseguir escrever e explicar esse pequeno programa dá uma evidência melhor de compreensão.
