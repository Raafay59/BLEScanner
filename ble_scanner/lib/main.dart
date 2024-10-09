import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<List<ScanResult>> _scanSubscription;

  void startScan() {
    print('Start scanning');
    // Start scanning
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    // Listen to scan results
    _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        print('Device found: ${r.device.platformName}');
      }
    });

    // Stop scanning after timeout
    Future.delayed(const Duration(seconds: 5), () {
      print('Stop scanning');
      FlutterBluePlus.stopScan();
      _scanSubscription.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BLE Scanner'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: startScan,
            child: const Text('Start Scan'),
          ),
        ),
      ),
    );
  }
}