import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tlr/Pages/Home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class statstique extends StatelessWidget {
  late List<PieData> _piedata = [
    PieData("Bimo", 32),
    PieData("condia", 23),
    PieData("Milka", 30),
    PieData("others", 15),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SfCircularChart(
            title: ChartTitle(
              text: AppLocalizations.of(context)!.yourbestsales,
            ),
            legend: Legend(isVisible: true),
            series: <CircularSeries>[
              PieSeries<PieData, String>(
                  dataSource: _piedata,
                  xValueMapper: (PieData data, _) => data.text,
                  yValueMapper: (PieData data, _) => data.pb,
                  dataLabelSettings: DataLabelSettings(isVisible: true)),
            ],
          ),
          SfCartesianChart(
            title: ChartTitle(text: AppLocalizations.of(context)!.yourstock),
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
              title: AxisTitle(
                  text: AppLocalizations.of(context)!.categoriesonstock),
            ),
            primaryYAxis: NumericAxis(
                labelFormat: '{value}',
                title: AxisTitle(
                    text: AppLocalizations.of(context)!.productonstock),
                majorGridLines: const MajorGridLines(width: 0),
                majorTickLines: const MajorTickLines(size: 0)),
            series: <ChartSeries<ChartSampleData, String>>[
              ColumnSeries<ChartSampleData, String>(
                onCreateRenderer:
                    (ChartSeries<ChartSampleData, String> series) {
                  return _CustomColumnSeriesRenderer();
                },
                dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.middle),
                dataSource: <ChartSampleData>[
                  ChartSampleData(
                      x: AppLocalizations.of(context)!.oils,
                      y: 1241,
                      pointColor: const Color.fromARGB(53, 92, 125, 1)),
                  ChartSampleData(
                      x: AppLocalizations.of(context)!.sugars,
                      y: 1332,
                      pointColor: const Color.fromARGB(192, 108, 132, 1)),
                  ChartSampleData(
                      x: AppLocalizations.of(context)!.cocoa,
                      y: 918,
                      pointColor: const Color.fromARGB(246, 114, 128, 1)),
                  ChartSampleData(
                      x: AppLocalizations.of(context)!.cereals,
                      y: 456,
                      pointColor: const Color.fromARGB(248, 177, 149, 1)),
                  ChartSampleData(
                      x: AppLocalizations.of(context)!.beverages,
                      y: 529,
                      pointColor: const Color.fromARGB(116, 180, 155, 1)),
                ],
                width: 0.8,
                xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                yValueMapper: (ChartSampleData sales, _) => sales.y,
                pointColorMapper: (ChartSampleData sales, _) =>
                    sales.pointColor,
              )
            ],
            tooltipBehavior:
                TooltipBehavior(enable: true, canShowMarker: false, header: ''),
          ),
        ],
      ),
    );
  }
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
