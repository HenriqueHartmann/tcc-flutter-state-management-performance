import 'package:app_base_gestao_estado/item_card_style.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage ({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final List<Map<String, dynamic>> items = [
    {
      'title': 'Item 1',
      'description': 'Descrição do item 1',
      'style': const ItemCardStyle(),
    },
    {
      'title': 'Item 2',
      'description': 'Descrição do item 2',
      'style': const ItemCardStyle(),
    },
    {
      'title': 'Item 3',
      'description': 'Descrição do item 3',
      'style': const ItemCardStyle(),
    },
  ];
  // ...
}
