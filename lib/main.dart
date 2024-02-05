import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RenderingWidget(),
    );
  }
}

class RenderingWidget extends StatefulWidget {
  const RenderingWidget({Key? key}) : super(key: key);

  @override
  _RenderingWidgetState createState() => _RenderingWidgetState();
}

class _RenderingWidgetState extends State<RenderingWidget> {
  Map<dynamic, dynamic> mapData = {};
  var registry = JsonWidgetRegistry.instance;

  @override
  void initState() {
    super.initState();
    
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String response = await rootBundle.loadString('assets/ui.json');
    final data = json.decode(response);
    setState(() {
      mapData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Widget oluşturmadan önce gelen verilerin tamamlanmış olmasını kontrol ediyorum
    if (mapData.isEmpty) {
      // Veri henüz yüklenmemişse bir yükleniyor göstergesi oluşturdum
      return CircularProgressIndicator();
    } else {
      // Veri yüklendiyse JsonWidgetData.fromDynamic ile widget'ı oluşturalım
      var widget = JsonWidgetData.fromDynamic(mapData, registry: registry);
      return widget.build(context: context);
    }
  }
}
