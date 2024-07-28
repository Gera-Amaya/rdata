import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GHume extends StatelessWidget {
  final double humidity;

  const GHume({Key? key, required this.humidity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          ranges: <GaugeRange>[
            GaugeRange(startValue: 0, endValue: 50, color: Colors.yellow),
            GaugeRange(startValue: 50, endValue: 75, color: Colors.purple),
            GaugeRange(startValue: 75, endValue: 100, color: Colors.red),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(value: humidity),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Container(
                child: Text(
                  '$humidity%',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              angle: 90,
              positionFactor: 0.5,
            ),
          ],
        ),
      ],
    );
  }
}
