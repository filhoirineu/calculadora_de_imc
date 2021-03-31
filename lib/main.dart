import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoIMC = "INSIRA SEUS DADOS";
  double resultIMC = 0.0;

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";

    setState(() {
      _infoIMC = "INSIRA SEUS DADOS";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculaIMC() {
    setState(() {
      double peso = double.parse(weightController.text);
      double altura = double.parse(heightController.text) / 100;

      resultIMC = peso / (altura * altura);

      if (resultIMC < 18.5) {
        _infoIMC = "MAGREZA - IMC: ${resultIMC.toStringAsPrecision(4)}";
      } else if (resultIMC >= 18.5 && resultIMC <= 24.9) {
        _infoIMC = "NORMAL - IMC: ${resultIMC.toStringAsPrecision(4)}";
      } else if (resultIMC >= 25 && resultIMC <= 29.9) {
        _infoIMC = "SOBREPESO - IMC: ${resultIMC.toStringAsPrecision(4)}";
      } else if (resultIMC >= 30 && resultIMC <= 39.9) {
        _infoIMC = "OBESIDADE - IMC: ${resultIMC.toStringAsPrecision(4)}";
      } else if (resultIMC >= 40) {
        _infoIMC = "OBESIDADE GRAVE - IMC: ${resultIMC.toStringAsPrecision(4)}";
      }
    });
  }

  String _validaPeso(String value) {
    String text;

    if (value.isEmpty) {
      text = "Digite o Peso";
    }
    return text;
  }

  String _validaAltura(String value) {
    String text;

    if (value.isEmpty) {
      text = "Digite a Altura";
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CALCULADORA DE IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 75,
                    color: Colors.green,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "PESO (KG)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    controller: weightController,
                    validator: (peso) {
                      return _validaPeso(peso.trim());
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: heightController,
                    decoration: InputDecoration(
                        labelText: "ALTURA (CM)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    validator: (altura) {
                      return _validaAltura(altura.trim());
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    child: Container(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculaIMC();
                          }
                        },
                        child: Text(
                          "CALCULAR",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    _infoIMC,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )
                ])),
      ),
    );
  }
}
