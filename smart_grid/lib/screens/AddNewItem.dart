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
        setState(() {
          _selectedDrawer = 0;
        });

        // Mostre um diálogo ou uma mensagem de sucesso ao usuário
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sucesso', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
              content: Text('Novo item adicionado com sucesso!', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
              backgroundColor: Color(0xFF1B1B1D),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context); // Feche a tela de adicionar item
                  },
                  child: Text('OK', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
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
              title: Text('Erro', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
              content: Text('Ocorreu um erro ao adicionar o item. Tente novamente mais tarde.', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
              backgroundColor: Color(0xFF1B1B1D),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
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
            title: Text('Atenção', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
            content: Text('Por favor, preencha todos os campos e selecione a gaveta.', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
            backgroundColor: Color(0xFF1B1B1D),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
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
      backgroundColor: Color(0xFF1B1B1D),
      appBar: AppBar(
        title: Text('Adicionar Item', style: TextStyle(fontFamily: 'Inter', color: Colors.white)),
        backgroundColor: Color(0xFF1B1B1D),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
  controller: _nameController,
  style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
  decoration: InputDecoration(
    labelText: 'Nome do Item',
    labelStyle: TextStyle(color: Colors.white, fontFamily: 'Inter'),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(24.0), // Arredonda a borda em 24 graus
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFA988F9)),
      borderRadius: BorderRadius.circular(24.0), // Arredonda a borda em 24 graus
    ),
  ),
),
SizedBox(height: 16.0),
TextField(
  controller: _descriptionController,
  style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
  decoration: InputDecoration(
    labelText: 'Descrição do Item',
    labelStyle: TextStyle(color: Colors.white, fontFamily: 'Inter'),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(24.0), // Arredonda a borda em 24 graus
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFA988F9)),
      borderRadius: BorderRadius.circular(24.0), // Arredonda a borda em 24 graus
    ),
  ),
  maxLines: 3,
),
            SizedBox(height: 16.0),
           ElevatedButton(
  onPressed: () {
    // Exiba o popup para selecionar a gaveta
    _showDrawerSelectionPopup(context);
  },
  child: Text(
    _selectedDrawer > 0 ? 'Gaveta $_selectedDrawer Selecionada' : 'Selecionar Gaveta',
    style: TextStyle(fontFamily: 'Inter', color: Colors.black),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFFF4EFE9),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
),
SizedBox(height: 16.0),
ElevatedButton(
  onPressed: _addItem,
  child: Text(
    'Adicionar Item',
    style: TextStyle(fontFamily: 'Inter', color: Colors.black),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFFF4EFE9),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
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
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF1B1B1D),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Inter'),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          textStyle: TextStyle(fontSize: 16.0, fontFamily: 'Inter'),
                        ),
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
