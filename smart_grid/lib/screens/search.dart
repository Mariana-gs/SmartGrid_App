import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                      onPressed: ((){}), 
                      icon: Icon(Icons.arrow_back_ios_new_rounded, ), padding: EdgeInsets.only(right: 3)),
                      decoration: BoxDecoration(
                        color: Color(0xFFF4EFE9),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Text(
                        '13 Resultados',
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
          Container(
            padding: EdgeInsets.all(23),
            height: 80,
            width: 312,
            child: Row(
              children: [
                Text('Search', style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontFamily: 'Inter')),
                Spacer(),
                Image.asset(
                  // Use Image.asset para carregar uma imagem local
                  'assets/images/search.png', // Caminho da imagem
                  width: 27, // Largura da imagem
                  height: 27, // Altura da imagem
                ),
                /*TextField(
                  onChanged: (context){},
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(22),
                   hintStyle: TextStyle(color: Colors.white, fontFamily: 'Inter'),
                   hintText: 'Search',
                  )
                )*/
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xFFA988F9),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          SingleChildScrollView(
              child: Column(
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
          )
          ),
        ],
      ),
    );
  }
}
