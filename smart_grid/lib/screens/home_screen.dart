
//import 'dart:html';


import 'dart:async';
//import 'dart:ffi';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_grid/screens/search.dart';
import 'package:smart_grid/screens/reports.dart';
import 'package:smart_grid/screens/additem.dart';

import 'package:firebase_database/firebase_database.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex = 0;
  int drawer = 2;

  late DatabaseReference _databaseReference;
  List<Map<dynamic, dynamic>> _searchResults = [];
  int _searchCount = 0;
 

  void _loadItems() async {
    final snapshot = await _databaseReference.get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> drawers = snapshot.value as Map<dynamic, dynamic>;
      List<Map<dynamic, dynamic>> results = [];

      drawers.forEach((drawerKey, drawerData) {
        Map<dynamic, dynamic> items = drawerData['itens'] as Map<dynamic, dynamic>;
        items.forEach((itemId, itemData) {
          results.add({
            'drawerId': drawerData['drawer_id'],
            'drawerData': drawerData,
            'itemId': itemId,
            'itemData': itemData
          });
        });
      });

      setState(() {
        _searchResults = results;
        _searchCount = results.length;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref().child('drawer/drawers');
    _loadItems(); 
    // Carrega os itens ao iniciar a tela
  }


  void _updateDrawerId(int drawerId) async {
    DatabaseReference configRef = FirebaseDatabase.instance.ref().child('drawer/config');
    await configRef.update({'id_drawer': drawerId});
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
              setState(() {
                _searchResults.removeWhere((result) => result['itemData']['name'].toString().toLowerCase() == itemName.toLowerCase());
              });
              _loadItems();
            });
          }
        });
      });
    }
  }






  //List of the pages
  List<Widget> pages = const [
    HomeScreen(),
  ];


  @override
  Widget build(BuildContext context) {

    //CÓDIGO

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;



void _loadItems() async {
  
    final snapshot = await _databaseReference.get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> drawers = snapshot.value as Map<dynamic, dynamic>;
      List<Map<dynamic, dynamic>> results = [];

      drawers.forEach((drawerKey, drawerData) {
        Map<dynamic, dynamic> items = drawerData['itens'] as Map<dynamic, dynamic>;
        items.forEach((itemId, itemData) {
          if(itemData['name'] != null && itemData['name'].toString().length > 1) {
            results.add({
              'drawerId': drawerData['drawer_id'],
              'drawerData': drawerData,
              'itemId': itemId,
              'itemData': itemData
            });
          }
        });
      });

      setState(() {
        _searchResults = results;
        _searchCount = results.length;
      });
    }
  }

    @override
void initState() {
  super.initState();
  _loadItems(); // Chame a função para carregar os itens ao iniciar a tela
}
    //TELA

_loadItems();
    return Scaffold(

      backgroundColor: Color(0xFF1B1B1D),

      // APPBAR =================================================

      appBar: AppBar(
        backgroundColor: Color(0xFF1B1B1D),
        title: Row(
          children: [
            Column(
              //FOTO DE PERFIL
              children: [
                Container(
                  margin: const EdgeInsets.all(24),
                  width: 50, //Tamanho da foto
                  child: const CircleAvatar(
                    radius: 25, //Raio da Foto
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        ExactAssetImage('assets/images/profile.jpg'),
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFA988F9),
                        width: 2.0,
                      )),
                )
              ],
            ),
            //NOME DO USUÁRIO
            Text('Olá, Mari!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: 'Inter',
                )),
            Spacer(),
            Container(
                margin: EdgeInsets.only(right: 24.0),
                child: Stack(children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //fixedSize: Size(48, 48),
                      padding: EdgeInsets.all(0),
                      shape: CircleBorder(),
                      backgroundColor: Color(0xFFA988F9),
                      // Largura e altura fixas
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: width,
                              height: 700,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF4EFE9),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: const Text('Close'),
                              ),
                            );
                          });
                    },
                    child: Container(
                      //margin: EdgeInsets.only(right: 24.0),
                      child: Image.asset(
                        // Use Image.asset para carregar uma imagem local
                        'assets/images/belliconpng.png', // Caminho da imagem
                        //width: 100, // Largura da imagem
                        //height: 100, // Altura da imagem
                      ),
                    ),
                  ),
                  Positioned(
                      right: 4, // Ajuste a posição horizontal
                      top: 0, // Ajuste a posição vertical
                      child: Container(
                        padding: EdgeInsets.all(1), // Espaço ao redor do ponto
                        decoration: BoxDecoration(
                          color: Colors.yellow, // Cor da bolinha
                          borderRadius:
                              BorderRadius.circular(8), // Bordas arredondadas
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16, // Largura mínima
                          minHeight: 16, // Altura mínima
                        ),
                      )),
                ])),
          ],
        ),
      ),

      // BOTTOM NAVIGATION BAR =================================================
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: 100,
        color: Colors.transparent, //Color(0xFF1B1B1D),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //BOTÃO DE RELATÓRIO
            Container(
              margin: EdgeInsets.only(right: 24.0),
              child: ElevatedButton(
                //relatorios
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(48, 48),
                  padding: EdgeInsets.all(0),
                  shape: CircleBorder(),
                  backgroundColor: Colors.yellow,
                  // Largura e altura fixas
                ),
                onPressed: (){}
                
              ,
                child: Container(
                  //margin: EdgeInsets.only(right: 24.0),
                  child: Image.asset(
                    // Use Image.asset para carregar uma imagem local
                    'assets/images/graph.png', // Caminho da imagem
                    //width: 100, // Largura da imagem
                    //height: 100, // Altura da imagem
                  ),
                ),
              ),
            ),

            //BOTÃO DE PESQUISA
            ElevatedButton(
              //busca
              style: ElevatedButton.styleFrom(
                fixedSize: Size(72, 72),
                padding: EdgeInsets.all(0),
                shape: CircleBorder(),
                backgroundColor: Color(0xFFA988F9),
                // Largura e altura fixas
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const search(),
                        type: PageTransitionType.bottomToTop));
              },

              child: Container(
                child: Image.asset(
                  // Use Image.asset para carregar uma imagem local
                  'assets/images/search.png', // Caminho da imagem
                  //width: 100, // Largura da imagem
                  //height: 100, // Altura da imagem
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 24.0),
              child: ElevatedButton(
                //adicionar item
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(48, 48),
                  padding: EdgeInsets.all(0),
                  shape: CircleBorder(),
                  backgroundColor: Colors.yellow,
                  // Largura e altura fixas
                ),
                onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const additem(),
                        type: PageTransitionType.bottomToTop));
              },
                child: Container(
                  //margin: EdgeInsets.only(right: 24.0),
                  child: Image.asset(
                    // Use Image.asset para carregar uma imagem local
                    'assets/images/grid.png', // Caminho da imagem
                    //width: 100, // Largura da imagem
                    //height: 100, // Altura da imagem
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      



      
      // BODY =============================================== 
      
      body: Column(
        children: [
          Container(
            //Título
            //color: Colors.white,
            child: Align(
              alignment: Alignment.topLeft, // Alinha o conteúdo à esquerda
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 22.0, right: 22, top: 31, bottom: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Meus Itens',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () {
                        _loadItems();
                      },
                      child: Text(
                        'Refresh',
                        style: TextStyle(
                          color: Color(0xFFA988F9),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //SizedBox(height: 16.0),
           

            Expanded(
            child: ListView.builder(
              itemCount: _searchCount,
              itemBuilder: (context, index) {
                var result = _searchResults[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                  child: Card(
                    color: Color(0xFFF4EFE9), // Cor de fundo alterada para F4EFE9
                    elevation: 0, // Removida a elevação do card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24), // Borda arredondada
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
                                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.white), // Borda branca
                                ),
                                child: Text(
                                  'Gaveta ${result['drawerId']}',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            result['itemData']['description'],
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          SizedBox(height: 16),
                          Divider(color: Colors.white), // Linha divisória branca
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton.icon(
                                icon: Icon(Icons.search, color: Colors.black), // Ícone preto
                                label: Text('Achar', style: TextStyle(color: Colors.black)),
                                onPressed: () {
                                  _updateDrawerId(result['drawerId']);
                                  print('Achar item: ${result['itemData']['name']}');
                                },
                              ),
                              TextButton.icon(
                                icon: Icon(Icons.edit, color: Colors.black), // Ícone preto
                                label: Text('Editar', style: TextStyle(color: Colors.black)),
                                onPressed: () {
                                  print('Editar item: ${result['itemData']['name']}');
                                },
                              ),
                              TextButton.icon(
                                icon: Icon(Icons.delete, color: Colors.black), // Ícone preto
                                label: Text('Excluir', style: TextStyle(color: Colors.black)),
                                onPressed: () {
                                  _deleteItem(result['itemData']['name']);
                                  print('Excluir item: ${result['itemData']['name']}');
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
          ), // Fim do Expanded



        ]

      )

      
      
     
      
      
     
    );
  }
  
 
}

