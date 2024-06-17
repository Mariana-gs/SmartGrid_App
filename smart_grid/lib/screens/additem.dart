import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class additem extends StatefulWidget {
  const additem({super.key});

  @override
  State<additem> createState() => _additemState();
}

class _additemState extends State<additem> {
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
                        'Adicionar Item',
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
                  padding: const EdgeInsets.only(left: 22.0, bottom: 24),
                  child: Text(
                    'Nome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                ),
            
            
           
                   // Largura da borda
                  
                
                
                Spacer(),
                
          ])
              );
  }
}
