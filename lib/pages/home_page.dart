import 'package:flutter/material.dart';
import 'package:app_base_gestao_estado/models/item.dart';
import 'package:app_base_gestao_estado/models/item_card_style.dart';
import 'package:app_base_gestao_estado/widgets/item_card.dart';
import 'package:app_base_gestao_estado/data/item_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Map<String, dynamic>>> _itemsWithStyle;

  @override
  void initState() {
    super.initState();
    _itemsWithStyle = _loadItems();
  }

  Future<List<Map<String, dynamic>>> _loadItems() async {
    final repo = ItemRepository();
    final items = await repo.fetchItems(limit: 10);

    return items.map((item) {
      const style = ItemCardStyle();
      return {
        'item': item,
        'style': style,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Filmes')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _itemsWithStyle,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final data = snapshot.data ?? [];

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index]['item'] as Item;
              final style = data[index]['style'] as ItemCardStyle;

              return ItemCard(
                index: index,
                title: item.title,
                description: item.description,
                style: style,
              );
            },
          );
        },
      ),
    );
  }
}
