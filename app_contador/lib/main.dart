// ============ Importação dos widgets do Material Design ============
import 'package:flutter/material.dart';

// ============ Inicialização do aplicativo ============
// runApp coloca o widget MyApp na raiz da interface.
void main() {
  runApp(const MyApp());
}

// ============ Configuração geral do aplicativo ============
// Define a tela inicial e oculta a faixa de debug.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// ============ Tela inicial ============
// StatelessWidget descreve uma interface sem estado mutável próprio.
class HomePage extends StatefulWidget {
  // Construtor: recebe a key opcional e a encaminha à classe mãe.
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ============ Funções chamadas pelos botões ============
  // Por enquanto, apenas exibem mensagens no console; não alteram o contador.
  
  int counter = 0;
  
  void decrement() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
    print(counter);    
  }

  void increment() {
    setState(() {
      counter++;
    });
    print(counter);
    
  }

  bool get isEmpty => counter == 0;
  bool get isFull => counter >= 20;

  // ============ Construção da interface ============
  // Implementa build, declarado em StatelessWidget, e retorna a tela.

  @override
  Widget build(BuildContext context) {
    // ============ Estrutura da página ============
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // ============ Imagem de fundo ============
      // AssetImage carrega a imagem registrada nos assets do projeto.
      // BoxFit.cover preenche a área, podendo recortar parte da imagem.
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/image.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        // ============ Organização vertical do conteúdo ============
        // Centraliza o conjunto de textos e botões no eixo vertical.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ============ Mensagem de entrada ============
            Text(
              isFull ? "Lotado!" : "Pode entrar!",
              style: TextStyle(fontSize: 30, color: isFull ? Colors.red : Colors.green),
            ),
            // ============ Quantidade de pessoas ============
            // O zero ainda é um texto fixo, sem ligação com uma variável.
            Text(counter.toString(), style: const TextStyle(fontSize: 50, color: Colors.white)),

            // Espaço vertical entre o contador e os botões.
            SizedBox(height: 20),

            // ============ Organização horizontal dos botões ============
            // Centraliza os botões no eixo horizontal.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ============ Botão de saída ============
                // onPressed recebe a função para executá-la ao clicar.
                TextButton(
                  onPressed: isEmpty ? null : decrement,
                  // Define fundo, espaçamento interno, tamanho e cor de interação.
                  style: TextButton.styleFrom(
                    backgroundColor: isEmpty ? Colors.grey : Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    fixedSize: const Size(100, 50),
                    foregroundColor: Colors.red,
                  ),
                  child: Text("Saiu", style: TextStyle(color: Colors.red)),
                ),

                // Espaço horizontal entre os dois botões.
                SizedBox(width: 20),

                // ============ Botão de entrada ============
                // Passa increment sem parênteses para executar somente ao clicar.
                TextButton(
                  onPressed: isFull ? null : increment,
                  style: TextButton.styleFrom(
                    backgroundColor: isFull ? Colors.grey : Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    fixedSize: const Size(100, 50),
                    foregroundColor: Colors.blue,
                  ),
                  child: Text("Entrou", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
