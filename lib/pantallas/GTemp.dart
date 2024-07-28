import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GTemp extends StatelessWidget {
  final double temperature;

  const GTemp({Key? key, required this.temperature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: -10,
          maximum: 50,
          ranges: <GaugeRange>[
            GaugeRange(startValue: -10, endValue: 0, color: Colors.blue),
            GaugeRange(startValue: 0, endValue: 30, color: Colors.green),
            GaugeRange(startValue: 30, endValue: 50, color: Colors.red),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(value: temperature),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Container(
                child: Text(
                  '$temperature°C',
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
