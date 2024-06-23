import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _selectedDrawer = 0; // ID da gaveta selecionada

  DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  void _addItem() {
    String itemName = _nameController.text.trim();
    String itemDescription = _descriptionController.text.trim();
    
    if (itemName.isNotEmpty && itemDescription.isNotEmpty && _selectedDrawer > 0) {
      // Crie um novo nó no banco de dados Firebase com os dados do novo item
      _databaseReference.child('drawer/drawers/drawer_$_selectedDrawer/itens').push().set({
        'name': itemName,
        'description': itemDescription,
      }).then((_) {
        // Limpe os campos após adicionar o item com sucesso
        _nameController.clear();
        _descriptionController.clear();
        _selectedDrawer = 0;

        // Mostre um diálogo ou uma mensagem de sucesso ao usuário
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sucesso'),
              content: Text('Novo item adicionado com sucesso!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context); // Feche a tela de adicionar item
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }).catchError((error) {
        // Em caso de erro ao adicionar o item, exiba uma mensagem de erro
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text('Ocorreu um erro ao adicionar o item. Tente novamente mais tarde.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      });
    } else {
      // Caso algum campo esteja vazio ou a gaveta não tenha sido selecionada, exiba um aviso
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Atenção'),
            content: Text('Por favor, preencha todos os campos e selecione a gaveta.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome do Item'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descrição do Item'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Exiba o popup para selecionar a gaveta
                _showDrawerSelectionPopup(context);
              },
              child: Text(_selectedDrawer > 0 ? 'Gaveta $_selectedDrawer Selecionada' : 'Selecionar Gaveta'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addItem,
              child: Text('Adicionar Item'),
            ),
          ],
        ),
      ),
    );
  }

   void _selectDrawer(int drawerId) {
    setState(() {
      _selectedDrawer = drawerId;
    });
  }

  void _showDrawerSelectionPopup(BuildContext context) {
    // Implemente o método _showDrawerSelectionPopup conforme mostrado anteriormente
showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Selecione a Gaveta',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                children: List.generate(9, (index) {
                  int drawerId = index + 1;
                  return SizedBox(
                    height: 60.0,
                    width: 60.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _selectDrawer(drawerId);
                      },
                      child: Text('Gaveta $drawerId'),
                    ),
                  );
                }),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      );
    },
  );

  }
}
