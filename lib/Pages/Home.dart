import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatelessWidget {
  late List<PieData> _piedata = [
    PieData("Bimo", 32),
    PieData("condia", 23),
    PieData("Milka", 30),
    PieData("others", 15),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 5, 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 20,
                            child: TextField(
                              maxLines: 1,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(.4),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22),
                                prefixIcon: Icon(Icons.search,
                                    color: Colors.black.withOpacity(.6)),
                                hintText: 'Search anything.....',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              color: Colors.white70,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30.0),
                                  topLeft: Radius.circular(30.0),
                                  bottomLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0),
                                ),
                              ),
                              child: SizedBox(
                                height: 150.0,
                                width: MediaQuery.of(context).size.width - 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Categories',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, top: 20),
                              child: Row(
                                children: [
                                  Text(
                                    'Statistique',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_circle_right),
                                  )
                                ],
                              ),
                            ),
                            SfCircularChart(
                              title: ChartTitle(
                                text: 'Your best sales',
                              ),
                              legend: Legend(isVisible: true),
                              series: <CircularSeries>[
                                PieSeries<PieData, String>(
                                    dataSource: _piedata,
                                    xValueMapper: (PieData data, _) =>
                                        data.text,
                                    yValueMapper: (PieData data, _) => data.pb,
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true)),
                              ],
                            ),
                            SfCartesianChart(
                              title: ChartTitle(text: 'Your stock'),
                              primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(width: 0),
                                title: AxisTitle(text: 'Categories on stock'),
                              ),
                              primaryYAxis: NumericAxis(
                                  labelFormat: '{value}',
                                  title: AxisTitle(text: 'Product on stock'),
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                  majorTickLines:
                                      const MajorTickLines(size: 0)),
                              series: <ChartSeries<ChartSampleData, String>>[
                                ColumnSeries<ChartSampleData, String>(
                                  onCreateRenderer:
                                      (ChartSeries<ChartSampleData, String>
                                          series) {
                                    return _CustomColumnSeriesRenderer();
                                  },
                                  dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                      labelAlignment:
                                          ChartDataLabelAlignment.middle),
                                  dataSource: <ChartSampleData>[
                                    ChartSampleData(
                                        x: 'oils',
                                        y: 1241,
                                        pointColor: const Color.fromARGB(
                                            53, 92, 125, 1)),
                                    ChartSampleData(
                                        x: 'Sugars',
                                        y: 1332,
                                        pointColor: const Color.fromARGB(
                                            192, 108, 132, 1)),
                                    ChartSampleData(
                                        x: 'Cocoa ',
                                        y: 918,
                                        pointColor: const Color.fromARGB(
                                            246, 114, 128, 1)),
                                    ChartSampleData(
                                        x: 'cereals',
                                        y: 456,
                                        pointColor: const Color.fromARGB(
                                            248, 177, 149, 1)),
                                    ChartSampleData(
                                        x: 'Beverages',
                                        y: 529,
                                        pointColor: const Color.fromARGB(
                                            116, 180, 155, 1)),
                                  ],
                                  width: 0.8,
                                  xValueMapper: (ChartSampleData sales, _) =>
                                      sales.x as String,
                                  yValueMapper: (ChartSampleData sales, _) =>
                                      sales.y,
                                  pointColorMapper:
                                      (ChartSampleData sales, _) =>
                                          sales.pointColor,
                                )
                              ],
                              tooltipBehavior: TooltipBehavior(
                                  enable: true,
                                  canShowMarker: false,
                                  header: ''),
                            ),
                          ]),
                    ]))));
  }
}

/*
  
                */
class ChartSampleData {
  ChartSampleData({required this.x, required this.y, required this.pointColor});
  final String x;
  final double y;
  final Color pointColor;
}

class PieData {
  PieData(this.text, this.pb);
  final double pb;
  final String text;
}

class _CustomColumnSeriesRenderer extends ColumnSeriesRenderer {
  _CustomColumnSeriesRenderer();

  @override
  ChartSegment createSegment() {
    return _ColumnCustomPainter();
  }
}

class _ColumnCustomPainter extends ColumnSegment {
  List<Color> colorList = <Color>[
    const Color.fromRGBO(53, 92, 125, 1),
    const Color.fromRGBO(192, 108, 132, 1),
    const Color.fromRGBO(246, 114, 128, 1),
    const Color.fromRGBO(248, 177, 149, 1),
    const Color.fromRGBO(116, 180, 155, 1)
  ];
  @override
  int get currentSegmentIndex => super.currentSegmentIndex!;

  @override
  Paint getFillPaint() {
    final Paint customerFillPaint = Paint();
    customerFillPaint.isAntiAlias = false;
    customerFillPaint.color = colorList[currentSegmentIndex];
    customerFillPaint.style = PaintingStyle.fill;
    return customerFillPaint;
  }

  @override
  Paint getStrokePaint() {
    final Paint customerStrokePaint = Paint();
    customerStrokePaint.isAntiAlias = false;
    customerStrokePaint.color = Colors.transparent;
    customerStrokePaint.style = PaintingStyle.stroke;
    return customerStrokePaint;
  }

  @override
  void onPaint(Canvas canvas) {
    double x, y;
    x = segmentRect.center.dx;
    y = segmentRect.top;
    double width = 0;
    const double height = 20;
    width = segmentRect.width;
    final Paint paint = Paint();
    paint.color = getFillPaint().color;
    paint.style = PaintingStyle.fill;
    final Path path = Path();
    final double factor = segmentRect.height * (1 - animationFactor);
    path.moveTo(x - width / 2, y + factor + height);
    path.lineTo(x, (segmentRect.top + factor + height) - height);
    path.lineTo(x + width / 2, y + factor + height);
    path.lineTo(x + width / 2, segmentRect.bottom + factor);
    path.lineTo(x - width / 2, segmentRect.bottom + factor);
    path.close();
    canvas.drawPath(path, paint);
  }
}
