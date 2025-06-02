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

  ItemCardAttribute _selectedAttribute = ItemCardAttribute.backgroundColor;

  void onItemTapped(List<Map<String, dynamic>> data, int index) {
    setState(() {
      final style = data[index]['style'] as ItemCardStyle;

      data[index]['style'] = style.toggleSelectedAttribute(_selectedAttribute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Filmes'),
        actions: [
          DropdownButton<ItemCardAttribute>(
            value: _selectedAttribute,
            onChanged: (value) {
              setState(() {
                _selectedAttribute = value!;
              });
            },
            items: ItemCardAttribute.values.map((attr) {
              return DropdownMenuItem(
                value: attr,
                child: Text(attr.toString().split('.').last),
              );
            }).toList(),
          ),
        ],
      ),
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

              return GestureDetector(
                onTap: () {
                  // Ação ao tocar no item
                  onItemTapped(data, index); // substitua com a função de toggle desejada
                },
                child: ItemCard(
                  index: index,
                  title: item.title,
                  description: item.description,
                  style: style,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
