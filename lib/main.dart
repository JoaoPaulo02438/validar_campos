import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validações'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            //CAMPO CPF
            TextFormField(
              inputFormatters: [CPFMask()],
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CPF',
              ),
            ),
            SizedBox(height: 10),
            //CAMPO EMAIL
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (text){
                if(!RegExp(r'[a-zA-Z0-9-_]+@[a-zA-Z0-9-_]+\..+' ).hasMatch(text ?? '')){
                  return 'Digite um email válido!';
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'EMAIL'
              ),
            ),
            SizedBox(height: 10),
            // CAMPO MOEDA
            TextFormField(
              inputFormatters: [RealMask()],
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'REAL'
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CEP'
              ),
            ),
            SizedBox(height: 10),
            //CAMPO DATA
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'DATA'
              ),
            ),
            SizedBox(height: 10),
            //CAMPO TELEFONE
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'TELEFONE'
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      )
    );
  }
}
class CPFMask extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var cpf = newValue.text;

    if(cpf.length < 14 || !RegExp(r'^([\d-.]+)?$').hasMatch(cpf)){
      return oldValue;
    }
    cpf = cpf.replaceAll(RegExp(r'\D'), '');
    final characteres = cpf.characters.toList();
    var formatted = '';
    for(var i = 0; i < characteres.length; i++){
      if( [3, 6, 9].contains(i)){
        formatted += i == 9 ? '-' : '.';
        formatted += characteres[i];
      }
        formatted += characteres[i];
    }
    return newValue.copyWith(text: formatted,
    selection: TextSelection.fromPosition(TextPosition(offset: formatted.length),
    ));
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
