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
        title: Text('Relatório de Uso ', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
        backgroundColor: Color(0xFF1B1B1D),
        leading: Container(
         height: 20, // Altura reduzida
  width: 20, // Largura reduzida
  margin: EdgeInsets.only(left: 1),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20), // Tamanho do ícone reduzido
              padding: EdgeInsets.zero,), // Removendo o preenchimento
              //padding: EdgeInsets.only(right: 3)),
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
            return Center(child: Text('Erro ao carregar os dados', style: TextStyle(color: Colors.white, fontFamily: 'Inter')));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Nenhum dado disponível', style: TextStyle(color: Colors.white, fontFamily: 'Inter')));
          } else {
            Map<dynamic, dynamic> drawers = {};
            if (snapshot.hasData && snapshot.data != null) {
              drawers = snapshot.data!.value as Map<dynamic, dynamic>;
            }

            if (drawers.isEmpty) {
              return Center(child: Text('Nenhuma gaveta encontrada', style: TextStyle(color: Colors.white, fontFamily: 'Inter')));
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
              }
            });

            // Ordenar os dados pelos mais acessados
            data.sort((a, b) => b.percentage.compareTo(a.percentage));

            // Gerar cores para os dados (uma única vez)
            if (_colors.isEmpty) {
              for (var _ in data) {
                _colors.add(getRandomColor());
              }
            }

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Essas são suas gavetas mais usadas',
                        style: TextStyle(fontSize: 25, color: Colors.white, fontFamily: 'Inter'),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          for (int i = 0; i < 3 && i < data.length; i++)
                            Expanded(
                              child: Card(
                                color: Colors.transparent, // Torna o cartão transparente
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.white), // Borda branca
                                ),
                                child: Container(
                                  height: 80, // Altura para os cards destacados
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          bottomLeft: Radius.circular(24),
                                        ),
                                        child: Container(
                                          width: 10, // Largura aumentada para a barra vertical
                                          color: _colors[i],
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Gaveta ${data[i].drawerId}',
                                            style: TextStyle(fontSize: 16, color: Colors.white), // Fonte branca
                                          ),
                                          Text(
                                            '${data[i].percentage.toStringAsFixed(2)}% ',
                                            style: TextStyle(fontSize: 14, color: Colors.white), // Fonte branca
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
                          color: Colors.transparent, // Torna o cartão transparente
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.white), // Borda branca
                          ),
                          child: Container(
                            height: 60,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    bottomLeft: Radius.circular(24),
                                  ),
                                  child: Container(
                                    width: 10, // Largura aumentada para a barra vertical
                                    color: _colors[index], // Indicador de cor
                                  ),
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Gaveta ${data[index].drawerId}',
                                      style: TextStyle(fontSize: 16, color: Colors.white), // Fonte branca
                                    ),
                                    Text(
                                      '${data[index].percentage.toStringAsFixed(2)}% de uso',
                                      style: TextStyle(fontSize: 14, color: Colors.white), // Fonte branca
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
