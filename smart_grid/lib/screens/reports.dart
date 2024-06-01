import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class reports extends StatefulWidget {
  const reports({super.key});

  @override
  State<reports> createState() => _reportsState();
}

class _reportsState extends State<reports> {
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
                            onPressed: (() {}),
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                            ),
                            padding: EdgeInsets.only(right: 3)),
                        decoration: BoxDecoration(
                          color: Color(0xFFF4EFE9),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Text(
                        'Relatórios',
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
            Align(
                alignment: Alignment.topLeft, // Alinha o conteúdo à esquerda
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0),
                  child: Text(
                    'Uso De Gavetas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Inter',
                    ),
                  ),
                )),
            Row(
              children: [
                Container(
                  height: 120,
                  width: 72,
                  margin: const EdgeInsets.only(left: 24),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Image.asset('assets/images/presilhas.jpeg',
                              //width: 100,
                              //height: 100,
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    50), // Define o raio das bordas arredondadas
                                child: Container(
                                  width: 68.0, // Largura da imagem
                                  height: 68.0, // Altura da imagem
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1B1B1D),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: Color(0xFFFFE27D), // Cor da borda
                                      width: 2, // Largura da borda
                                    ),
                                  ),
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
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF1B1B1D),
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(
                      color: Color(0xFF4E4E4E), // Cor da borda
                      width: 2, // Largura da borda
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
