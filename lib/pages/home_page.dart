import 'package:app_base_gestao_estado/providers/item_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_base_gestao_estado/models/item_card_style.dart';
import 'package:app_base_gestao_estado/widgets/item_card.dart';
import 'package:app_base_gestao_estado/data/item_repository.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void> _initFuture;
  ItemCardAttribute _selectedAttribute = ItemCardAttribute.backgroundColor;

  @override
  void initState() {
    super.initState();

    _initFuture = Future<void>(() async {
      await Future.delayed(Duration.zero);
      final items = await ItemRepository().fetchItems(limit: 1000);
      if (mounted) {
        Provider.of<ItemProvider>(context, listen: false).initialize(items);
      }
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
              return DropdownMenuItem<ItemCardAttribute>(
                value: attr,
                child: Text(attr.label),
              );
            }).toList(),
          )
        ],
      ),
      body: FutureBuilder<void>(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final itemCount = context.watch<ItemProvider>().items.length;

          return ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return Selector<ItemProvider, ItemWithStyle>(
                selector: (_, provider) => provider.items[index],
                shouldRebuild: (prev, next) => prev != next,
                builder: (context, itemWithStyle, _) {
                  return GestureDetector(
                    onTap: () {
                      context.read<ItemProvider>().toggleStyle(index, _selectedAttribute);
                    },
                    child: ItemCard(
                      index: index,
                      title: itemWithStyle.item.title,
                      description: itemWithStyle.item.description,
                      style: itemWithStyle.style,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
