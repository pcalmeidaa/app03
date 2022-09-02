// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IMC',
      home: TelaPrincipal(),
    ),
  );
}

//
// TELA PRINCIPAL
// Stateful => stf + TAB
class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  //ATRIBUTOS
  var txtPeso = TextEditingController();
  var txtAltura = TextEditingController();
  var formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //BARRA DE TÍTULO
      appBar: AppBar(
        title: Text('Calculadora IMC'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      backgroundColor: Colors.grey.shade200,
      //CORPO
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Icon(
                  Icons.calculate_outlined,
                  size: 120,
                  color: Colors.blue.shade900,
                ),
                campoTexto('Peso', txtPeso),
                campoTexto('Altura', txtAltura),
                botao('Calcular'),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
  //
  //CAMPO DE TEXTO
  //

  campoTexto(rotulo, variavel){
    return Container(
      margin: EdgeInsets.fromLTRB(0,10,0,10),
      child: TextFormField(
        controller: variavel,
        style: TextStyle(
          fontSize: 32,
          color: Colors.blue.shade900,
        ),
        decoration: InputDecoration(
          labelText: rotulo,
          labelStyle: TextStyle(
            fontSize: 22,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        //
        //VALIDAÇÃO
        //
        validator: (value) {
          value = value!.replaceFirst(',', '.');
          if(double.tryParse(value) == null){
            //o usuário NÃO digitou um valor númerico
            return 'Entre com um valor numérico';
          }else {
            //o usuário digitou um valor númerico
            return null;
          }
        },
      ),
    );
  }
  //
  //BOTÃO
  //ElevatedButton
  //OutlinedButton
  //TextButton

  botao(rotulo){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200, 50),
        primary: Colors.blue.shade900,
        shape: StadiumBorder(),
      ),

      //COMPORTAMENTO
      onPressed: () {
        //
        //VALIDAR OS CAMPOS DE TEXTO
        //

        if (formKey.currentState!.validate()){
          double peso = double.parse(txtPeso.text.replaceFirst(',', '.'));
          double Altura = double.parse(txtAltura.text.replaceFirst(',', '.'));
          double imc = peso / pow(Altura, 2);
          print('O valor do IMC é: ${imc.toStringAsFixed(2)}');
          caixaDialogo('O valor do IMC é: ${imc.toStringAsFixed(2)}');
        }

      },

      //CONTEÚDO
      child:  Text(
        rotulo,
        style: TextStyle(
          fontSize: 26,

        ),
      ),
    );

  }
  //
  //CAIXA DE DIÁLOGO
  //
    caixaDialogo(msg) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Calculadora'),
          content: Text(
            msg,
            style: TextStyle(fontSize: 32),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  txtPeso.clear();
                  txtAltura.clear();
                });
              },
              child: Text('fechar'),
            )
          ],
        );
      },
    );
  }
}
