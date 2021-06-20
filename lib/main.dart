import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightControleer = TextEditingController();
  TextEditingController heightControleer = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infotext = "";

  void _resetFields() {
    weightControleer.text = "";
    heightControleer.text = "";

    setState(() {
      _infotext = "";
    });
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightControleer.text);
      double height = double.parse(heightControleer.text) / 100;
      double imc = weight / (height * height);

      if (imc <= 18.5) {
        _infotext = "Abaixo do peso: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 18.5 || imc <= 24.9) {
        _infotext = "Peso normal: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 25 || imc <= 29) {
        _infotext = "Sobrepeso: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 30 || imc <= 34.9) {
        _infotext = "Obesidade Grau 1: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 35 || imc <= 39.9) {
        _infotext = "Obesidade Grau 2: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 40) {
        _infotext = "Obesidade Móbida: ${imc.toStringAsPrecision(3)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculador de IMC'),
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
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Icon(
                  Icons.person,
                  size: 150,
                  color: Colors.green,
                ),
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Digite seu peso (kg):',
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 20.0),
                  controller: weightControleer,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Digite seu peso!";
                    }
                  }),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Digite sua altura (cm):',
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 20.0),
                  controller: heightControleer,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Digite sua altura!";
                    }
                  }),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        calculate();
                      }
                    },
                    child: Text(
                      'Calcular',
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      textStyle: TextStyle(fontSize: 23),
                    ),
                  ),
                ),
              ),
              Text(
                _infotext,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 23),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
