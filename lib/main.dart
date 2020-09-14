import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Racha Conta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // VARIAVEIS
  final _valorTotal = TextEditingController();
  final _qntPessoas = TextEditingController();
  var _infoText = "Informe seus dados!";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Racha Conta"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields(){
    _valorTotal.text = "";
    _qntPessoas.text = "";
    setState(() {
      _infoText = "Informe o valor da conta e a quantidade de pessoas!";
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Valor total da conta", _valorTotal),
              _editText("Quantidade de pessoas", _qntPessoas),

              _buttonCalcular(),
              _textInfo(),
            ],
          ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.teal,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.grey,
        ),
      ),
    );
  }


  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  // Widget button
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: RaisedButton(
        color: Colors.blueGrey,
        child:
        Text(
          "Calcular",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            _calculate();
          }
        },
      ),
    );
  }

  // CALCULA O VALOR DA CONTA PARA CADA PESSOA
  void _calculate(){
    setState(() {
      double valorConta = double.parse(_valorTotal.text);
      double qntPessoas = double.parse(_qntPessoas.text);
      double garcom = valorConta*0.1;
      double totalAtualizado = valorConta+garcom;
      double totalIndividual = (totalAtualizado)/qntPessoas;

      String totalAtualizadoStr = totalAtualizado.toStringAsPrecision(4);
      String valorServicoStr = garcom.toStringAsPrecision(4);
      String individualStr = totalIndividual.toStringAsPrecision(4);

      _infoText = "Taxa de serviço (R\u0024 $valorServicoStr)\n"
          "Valor total atualizado (R\u0024 $totalAtualizadoStr)\n"
          "Cada um pagará (R\u0024 $individualStr)";

    });
  }

  // // Widget text
  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.teal, fontSize: 22.0),
    );
  }
}