//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_grid/screens/search.dart';
import 'package:smart_grid/screens/reports.dart';
import 'package:smart_grid/screens/additem.dart';




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

  List<String> _grids = [
    'Grid 1',
    'Grid 2',
    'Grid 3',
    'Grid 4',
  ];

  @override
  Widget build(BuildContext context) {

    //CÓDIGO

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //TELA

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
                onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const reports(),
                        type: PageTransitionType.bottomToTop));
              },
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
        children: <Widget>[
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
                        'Meus Lembretes',
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
                      onPressed: () {},
                      child: Text(
                        'Ver Tudo >',
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
          SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 72,
                child: ListView.builder(
                    itemCount: _lembretes.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 288,
                        margin: const EdgeInsets.only(left: 24),
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
                                      icon: Icon(Icons.more_vert)),
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
                                        color: Colors.black,
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
                                    icon: Icon(Icons.alarm),
                                    iconSize: 18,
                                  ),
                                  Text('2:00'),
                                  IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.apps),
                                    iconSize: 18,
                                  ),
                                  Text('1 un'),
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
                            color: Color(0xFFF4EFE9),
                            borderRadius: BorderRadius.circular(24)),
                      );
                    }),
              ),
            ],
          )
          ),
          Container(
            //Título
            //color: Colors.white,
            child: Align(
              alignment: Alignment.topLeft, // Alinha o conteúdo à esquerda
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 15.0, left: 22.0, right: 22.0, top: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Minhas Grids',
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
                      onPressed: () {},
                      child: Text(
                        'Ver Tudo >',
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
          SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                //width: ,
                height: height * 0.42,
                child: ListView.builder(
                    itemCount: _lembretes.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 144,
                        width: 312,
                        margin: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 24),
                        child: Stack(
                          children: [
                            Positioned(
                                top: 10,
                                right: 0,
                                child: Container(
                                  height: 0,
                                  width: 6,
                                  /*child: IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.more_vert)),
                                  decoration: BoxDecoration(
                                    //color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(50),
                                  ),*/
                                ),
                                ),
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
                            color: Color(0xFFF4EFE9),
                            borderRadius: BorderRadius.circular(24)),
                      );
                    }),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
