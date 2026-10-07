import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = "Informe seus dados!";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void calculate(){
    
    setState(() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);

      if (imc < 18.5) {
      _infoText = "Seu IMC é: ${imc.toStringAsFixed(2)} - Abaixo do peso";
    } else if (imc < 25) {
      _infoText = "Seu IMC é: ${imc.toStringAsFixed(2)} - Peso normal";
    } else if (imc < 30) {
      _infoText = "Seu IMC é: ${imc.toStringAsFixed(2)} - Sobrepeso";
    } else {
      _infoText = "Seu IMC é: ${imc.toStringAsFixed(2)} - Obesidade";
    }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.person_outline,
              size: 120.0,
              color: Colors.green,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Peso (kg)",
                labelStyle: TextStyle(color: Colors.green),
                hintText: "Digite seu peso",
              ),
              keyboardType: TextInputType.number,
              controller: weightController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu peso';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Altura (m)",
                labelStyle: TextStyle(color: Colors.green),
                hintText: "Digite sua altura",
              ),
              keyboardType: TextInputType.number,
              controller: heightController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira sua altura';
                }
                return null;
              },
            ),

            SizedBox(height: 20.0),
            
            ElevatedButton(
              onPressed: () {
                if (weightController.text.isNotEmpty && heightController.text.isNotEmpty) {
                  calculate();
                } else {
                  setState(() {
                    _infoText = "Por favor, preencha todos os campos!";
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: Text("Calcular"),
            ),

            SizedBox(height: 20.0),
            
            Text(
              _infoText,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            )

          ],
        ),
      ),
    );
  }
}