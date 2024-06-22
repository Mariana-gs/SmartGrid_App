import 'package:flutter/material.dart';

class AddPainelScreen extends StatefulWidget {
  @override
  _AddPainelScreenState createState() => _AddPainelScreenState();
}

class _AddPainelScreenState extends State<AddPainelScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  String _descricao = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Gaveta'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome do bucket';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nome = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Descricao do compartimento';
                  }
                  return null;
                },
                onSaved: (value) {
                  _descricao = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Adicionar Gaveta: $_nome')),
                    );
                
                  }
                },
                child: Text('Salvar Gaveta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}