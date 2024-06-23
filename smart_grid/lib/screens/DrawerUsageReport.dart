import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smart_grid/screens/home_screen.dart';

class DrawerUsageReport extends StatefulWidget {
  @override
  _DrawerUsageReportState createState() => _DrawerUsageReportState();
}

class _DrawerUsageReportState extends State<DrawerUsageReport> {
  late DatabaseReference _databaseReference;
  final List<Color> _colors = []; // Lista para armazenar as cores geradas

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref().child('drawer/drawers');
  }

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B1B1D),
      appBar: AppBar(
        title: Text('Relatório de Uso das Gavetas', style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF1B1B1D),
        leading:   Container(
                      height: 48,
                      width: 48,
                      margin: EdgeInsets.only(right: 1),
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
      ),
      body: FutureBuilder(
        future: _databaseReference.get(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os dados'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Nenhum dado disponível'));
          } else {
            Map<dynamic, dynamic> drawers = {};
            if (snapshot.hasData && snapshot.data != null) {
              drawers = snapshot.data!.value as Map<dynamic, dynamic>;
            }

            if (drawers.isEmpty) {
              return Center(child: Text('Nenhuma gaveta encontrada'));
            }

            int totalAccesses = 0;
            drawers.forEach((key, value) {
              if (value['drawer_access'] != null) {
                totalAccesses += int.parse(value['drawer_access'].toString());
              }
            });

            List<DrawerUsageData> data = [];
            drawers.forEach((key, value) {
              if (value['drawer_access'] != null) {
                double percentage = (int.parse(value['drawer_access'].toString()) / totalAccesses) * 100;
                data.add(DrawerUsageData(value['drawer_id'], percentage));
                _colors.add(getRandomColor()); // Adicionar cor correspondente
              }
            });

            // Ordenar os dados pelos mais acessados
            data.sort((a, b) => b.percentage.compareTo(a.percentage));

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CustomPaint(
                      painter: PieChartPainter(data, _colors),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    children: [
                      for (int i = 0; i < 3 && i < data.length; i++)
                        Expanded(
                          child: Card(
                            child: Container(
                              height: 80, // Altura para os cards destacados
                              child: Row(
                                children: [
                                  Container(
                                    width: 5, // Largura reduzida para a barra vertical
                                    color: _colors[i],
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Gaveta ${data[i].drawerId}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        '${data[i].percentage.toStringAsFixed(2)}% de uso',
                                        style: TextStyle(fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      // Pular os três primeiros itens que já estão destacados
                      if (index < 3) return SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 4.0),
                        child: Card(
                          child: Container(
                            height: 60,
                            child: Row(
                              children: [
                                Container(
                                  width: 5, // Largura reduzida para a barra vertical
                                  color: _colors[index], // Indicador de cor
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Gaveta ${data[index].drawerId}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '${data[index].percentage.toStringAsFixed(2)}% de uso',
                                      style: TextStyle(fontSize: 14, color: Colors.grey),
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
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class DrawerUsageData {
  final int drawerId;
  final double percentage;

  DrawerUsageData(this.drawerId, this.percentage);
}

class PieChartPainter extends CustomPainter {
  final List<DrawerUsageData> data;
  final List<Color> colors;

  PieChartPainter(this.data, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    double totalPercentage = 0;
    for (var item in data) {
      totalPercentage += item.percentage;
    }

    double startAngle = -pi / 2; // Start at 12 o'clock position
    for (var i = 0; i < data.length; i++) {
      final item = data[i];
      final sweepAngle = (item.percentage / 100) * 2 * pi;
      final paint = Paint()..color = colors[i];
      canvas.drawArc(
        Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
