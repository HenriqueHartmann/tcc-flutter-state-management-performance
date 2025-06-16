import 'package:app_base_gestao_estado/models/item_with_style_notifier.dart';
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
        title: const Text('Filmes com ChangeNotifier por item'),
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

          final items = context.watch<ItemProvider>().items;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: items[index],
                child: Consumer<ItemWithStyleNotifier>(
                  builder: (context, itemNotifier, _) {
                    return GestureDetector(
                      onTap: () {
                        itemNotifier.toggleStyle(_selectedAttribute);
                      },
                      child: ItemCard(
                        index: index,
                        title: itemNotifier.item.title,
                        description: itemNotifier.item.description,
                        style: itemNotifier.style,
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
