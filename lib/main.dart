import 'package:app_base_gestao_estado/pages/home_page.dart';
import 'package:app_base_gestao_estado/providers/item_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ItemProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App de Itens',
      home: HomePage(),
    );
  }
}
