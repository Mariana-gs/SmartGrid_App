import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smart_grid/screens/home_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class search extends StatefulWidget {
  //const search({super.key});

  final Function(String) addNotificationCallback; // Callback para adicionar notificação

  const search({Key? key, required this.addNotificationCallback}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {

  
  late DatabaseReference _databaseReference;
  String _searchQuery = '';
  List<Map<dynamic, dynamic>> _searchResults = [];
  int _searchCount = 0;

  @override
  void initState() {
    super.initState();
    // Inicialize a referência ao nó 'drawers'
    _databaseReference = FirebaseDatabase.instance.ref().child('drawer/drawers');
  }
  
  
 void _searchItems(String query) async {
  int searchCount = 0;
  final snapshot = await _databaseReference.get();
  if (snapshot.exists) {
    Map<dynamic, dynamic> drawers = snapshot.value as Map<dynamic, dynamic>;
    List<Map<dynamic, dynamic>> results = [];

    drawers.forEach((drawerKey, drawerData) {
      Map<dynamic, dynamic> items = drawerData['itens'] as Map<dynamic, dynamic>;
      items.forEach((itemId, itemData) {
        if (itemData['name'].toString().toLowerCase().contains(query.toLowerCase()) &&
            itemData['name'].isNotEmpty) {
          results.add({
            'drawerId': drawerData['drawer_id'], // Pegue o 'drawer_id'
            'drawerData': drawerData,
            'itemId': itemId,
            'itemData': itemData
          });
          searchCount++;
        }
      });
    });

    setState(() {
      _searchResults = results;
      _searchCount = searchCount;
    });
  }
}

  void _deleteItem(String itemName) async {
  DatabaseReference drawersRef = FirebaseDatabase.instance.ref().child('drawer/drawers');

  final snapshot = await drawersRef.get();
  if (snapshot.exists) {
    Map<dynamic, dynamic> drawers = snapshot.value as Map<dynamic, dynamic>;

    drawers.forEach((drawerKey, drawerData) {
      Map<dynamic, dynamic> items = drawerData['itens'] as Map<dynamic, dynamic>;

      items.forEach((itemId, itemData) {
        if (itemData['name'].toString().toLowerCase() == itemName.toLowerCase()) {
          drawersRef.child('$drawerKey/itens/$itemId').remove().then((_) {
            // Após a exclusão, atualize os resultados de pesquisa
            setState(() {
              _searchResults.removeWhere((result) => result['itemData']['name'].toString().toLowerCase() == itemName.toLowerCase());
            });
            _searchItems(_searchQuery);
          });
        }
      });
    });
  }
}


  void _updateDrawerId(int drawerId) async {
    DatabaseReference configRef = FirebaseDatabase.instance.ref().child('drawer/config');
    await configRef.update({'id_drawer': drawerId});
  }



  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Color(0xFF1B1B1D),
      body: Column(
        children: [
          Container(
            //Título
            //color: Colors.white,
            child: Align(
              alignment: Alignment.topLeft, // Alinha o conteúdo à esquerda
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 24, bottom: 24),
                child: Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      margin: EdgeInsets.only(right: 24),
                      child: IconButton(
                      onPressed: ((){
                        Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => HomeScreen()), // Direciona para a Home Page
                         );
                      }), 
                      icon: Icon(Icons.arrow_back_ios_new_rounded, ), padding: EdgeInsets.only(right: 3)),
                      decoration: BoxDecoration(
                        color: Color(0xFFF4EFE9),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Text(
                        _searchCount.toString() + ' Resultados',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFFF4EFE9),
                          fontFamily: 'Inter',
                        
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          Padding(
            padding: EdgeInsets.only(left: 50, right: 50, top:22),
            child: Container(child: TextField(
                  onChanged: (value){

                   setState(() {
                  _searchQuery = value;
                  _searchItems(_searchQuery);
                   });
                  },
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.search, color: Colors.black),
                    //contentPadding: EdgeInsets.only(top: 22, left: 500, right: 100, bottom: 22),
                   hintStyle: TextStyle(color: Colors.black, fontFamily: 'Inter'),
                   hintText: 'Search',
                    ),
                ),
                
              decoration: BoxDecoration(
              color: Color(0xFFA988F9),
              borderRadius: BorderRadius.circular(100),
            ), 
            ),
            ),
          
          
          /*Container(
            padding: EdgeInsets.all(23),
            height: 80,
            width: 312,
            child: Row(
              children: [
                
                /*Spacer(),
                Image.asset(
                  // Use Image.asset para carregar uma imagem local
                  'assets/images/search.png', // Caminho da imagem
                  width: 27, // Largura da imagem
                  height: 27, // Altura da imagem
                ),*/
                
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xFFA988F9),
              borderRadius: BorderRadius.circular(100),
            ),
          ),*/
         
           SizedBox(height: 16.0),
            


           Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  var result = _searchResults[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                    child: Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFF4E4E4E), width: 1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  result['itemData']['name'],
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Color(0xFF4E4E4E)),
                                  ),
                                  child: Text(
                                    'Gaveta ${result['drawerId']}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              result['itemData']['description'],
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            SizedBox(height: 16),
                            Divider(color: Colors.white), // Linha divisória branca
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton.icon(
                                  icon: Icon(Icons.search, color: Colors.white),
                                  label: Text('Achar', style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    // Ação ao clicar no botão de achar o item
                                     _updateDrawerId(result['drawerId']);
                                    print('Achar item: ${result['itemData']['name']}');
                                    widget.addNotificationCallback('Item ' + result['itemData']['name'] + ' encontrado em ${DateTime.now()}');
                                  },
                                ),
                                TextButton.icon(
                                  icon: Icon(Icons.edit, color: Colors.white),
                                  label: Text('Editar', style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    // Ação ao clicar no botão de editar o item
                                    print('Editar item: ${result['itemData']['name']}');
                                  },
                                ),
                                TextButton.icon(
                                  icon: Icon(Icons.delete, color: Colors.white),
                                  label: Text('Excluir', style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    // Ação ao clicar no botão de excluir o item
                                     _deleteItem(result['itemData']['name']);

                                    print('Excluir item: ${result['itemData']['name']}');
                                     widget.addNotificationCallback('Item ' + result['itemData']['name'] + ' excluído em ${DateTime.now()}');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ), // Expanded termina aqui
            
            
            
            /*Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width * .9,
                height: height * .7,
                child: ListView.builder(
                    itemCount: 5, //quantidade de itens
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 72,
                        width: 256,
                        margin: const EdgeInsets.only(top: 24, left: 24, right:24),
                        child: Stack(
                          children: [
                            Positioned(
                                top: 10,
                                right: 0,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.more_vert, color: Colors.white,)),
                                  decoration: BoxDecoration(
                                    //color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                )),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Image.asset('assets/images/presilhas.jpeg',
                                    //width: 100,
                                    //height: 100,
//),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          24.0), // Define o raio das bordas arredondadas
                                      child: Image.asset(
                                        'assets/images/presilhas.jpeg', // Caminho para sua imagem
                                        width: 72.0, // Largura da imagem
                                        height: 72.0, // Altura da imagem
                                        fit: BoxFit
                                            .cover, // Ajusta a imagem para cobrir a área
                                      ),
                                    ),
                                  ],
                                )),
                            Positioned(
                              top: 10,
                              left: 100,
                              child: Container(
                                //margin: const EdgeInsets.only(
                                // left: 100, top: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      'Presilhas',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 32,
                              left: 90,
                              child: Row(
                                children: [
                                  
                                  IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.apps, color: Colors.white),
                                    iconSize: 18,
                                  ),
                                  Text('1 un', style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'Inter',))
                                ],
                              ),
                            )

                            /*Positioned(
                                  bottom: 15,
                                  right: 20,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                )
                                )*/
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFF1B1B1D),
                            borderRadius: BorderRadius.circular(24),
                             border: Border.all(
                color: Color(0xFF4E4E4E), // Cor da borda
                width: 2, // Largura da borda
              ),
                            ),
                            
                      );
                    }),
              ),
            ],
          )*/
    
          
        ],
      ),
    );
  }
}
