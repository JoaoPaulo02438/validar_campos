import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VALIDAÇÕES'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
                children: [
                  TextFormField(
                    inputFormatters: [CPFMask()],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CPF',
                    ),),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CEP'
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'DATA'
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'TELEFONE'
                    ),
                  ),
                  SizedBox(height: 10),
                ]
            ),
          ),
        ),
      ),
    );
  }
}

class CPFMask extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    //var cpf = newValue.text;

    if(newValue.text.length > 14 || !RegExp(r'^([\d-.]+)?$').hasMatch(newValue.text)){
      return oldValue;
    }
    var cpf = newValue.text.replaceAll(RegExp(r'\D'), '');
    final characteres = cpf.characters.toList();
    var formatted = '';
    for(var i = 0; i < characteres.length; i++) {
      if ([3, 6, 9].contains(i)) {
        formatted += i == 9 ? '-' : '.';
      }
      formatted += characteres[i];
    }
    return oldValue.copyWith(text: formatted,
      selection: TextSelection.fromPosition(TextPosition(offset: formatted.length),
      ),);
  }
}
class RealMask extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var value = newValue.text.replaceAll(RegExp(r'\D'), '');
    value = value.split('').reversed.join();

    final listCharacters = [];
    var decimalCount = 0;

    for(var i = 0; i < value.length; i++){
      if(i == 2){
        listCharacters.insert(0, ',');
      }
      if(i > 2){
        decimalCount++;
      }
      if(decimalCount == 3){
        listCharacters.insert(0, '.');
        decimalCount = 0;
      }
      listCharacters.insert(0, value[i]);
    }
    listCharacters.insert(0, r'R$ ');
    var formatted = listCharacters.join();

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.fromPosition(TextPosition(offset: formatted.length),
      ),
    );
  }
}

