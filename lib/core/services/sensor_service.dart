import 'package:sensors_plus/sensors_plus.dart';

class SensorService {
  Stream<AccelerometerEvent> get accelerometerStream => accelerometerEvents;
}
