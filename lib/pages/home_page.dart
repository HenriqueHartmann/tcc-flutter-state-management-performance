import 'package:app_base_gestao_estado/models/data_limit_option.dart';
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

  DataLimitOption _selectedLimit = DataLimitOption.limit10;
  ItemCardAttribute _selectedAttribute = ItemCardAttribute.backgroundColor;

  Future<List<Map<String, dynamic>>> _loadItems() async {
    final repo = ItemRepository();
    final items = await repo.fetchItems(limit: _selectedLimit.value);

    return items.map((item) {
      const style = ItemCardStyle();
      return {
        'item': item,
        'style': style,
      };
    }).toList();
  }

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
                child: Text(attr.label),
              );
            }).toList(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _itemsWithStyle,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }

            final data = snapshot.data ?? [];

            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Flexible(
                        flex: 0,
                        child: Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Text(
                            'Limite de dados',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: DropdownButton<DataLimitOption>(
                          value: _selectedLimit,
                          onChanged: (value) {
                            setState(() {
                              _selectedLimit = value!;
                              _itemsWithStyle = _loadItems();
                            });
                          },
                          items: DataLimitOption.values.map((attr) {
                            return DropdownMenuItem(
                              value: attr,
                              child: Text(attr.label),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index]['item'] as Item;
                      final style = data[index]['style'] as ItemCardStyle;

                      return GestureDetector(
                        onTap: () {
                          onItemTapped(data, index);
                        },
                        child: ItemCard(
                          index: index,
                          title: item.title,
                          description: item.description,
                          style: style,
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
