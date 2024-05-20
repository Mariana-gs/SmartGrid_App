import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_grid/screens/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex = 0;

  //List of the pages
  List<Widget> pages = const [
    HomeScreen(),
  ];

  //List of pages icons
  List<IconData> iconList = [
    Icons.home,
  ];

  List<String> titleList = [
    'Home',
    'Relatórios',
    'Pesquisa',
    'Adicionar Item',
  ];

  List<String> _lembretes = [
    'Lembrete 1',
    'Lembrete 2',
    'Lembrete 3',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B1B1D),
      appBar: AppBar(
        backgroundColor: Color(0xFF1B1B1D),
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Text('Olá, Mari!',
                style: TextStyle(
                  color: Color(0xFFA988F9),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                )),
            Spacer(),
            Container(
                margin: EdgeInsets.only(right: 24.0),
                child: Stack(children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(48, 48),
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
                              height: 700,
                              child: Center(
                                child: ElevatedButton(
                                  child: const Text('Close'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
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
      
      
      
      
      /*floatingActionButton: FloatingActionButton(
          //mini: false,
          backgroundColor: Color(0xFFA988F9),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    child: const search(),
                    type: PageTransitionType.bottomToTop));
          },
          child: Image.asset(
            'assets/images/Search.png',
            height: 28,
          )),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
      
      
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: 100,
        color: Color(0xFF1B1B1D),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              onPressed: () {},
              child: Container(
                //margin: EdgeInsets.only(right: 24.0),
                child: Image.asset(
                  // Use Image.asset para carregar uma imagem local
                  'assets/images/graph.png', // Caminho da imagem
                  //width: 100, // Largura da imagem
                  //height: 100, // Altura da imagem
                ),
              ),
            ),),
            
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
              onPressed: () {},
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

// =================== BODY

      body: 
      Column(
      children: <Widget>[
      Container(
          //color: Colors.white,
          child: Align(
            alignment: Alignment.topLeft, // Alinha o conteúdo à esquerda
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Meus Lembretes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
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
                    onPressed: () {}, child: Text('Ver Mais >', style: TextStyle(
                        color: Color(0xFFA988F9),
                        
                      ),),
                  ),
                ],
              ),
            ),
          ),
        ),
      
      



      ],
      )


    );
  }
}
