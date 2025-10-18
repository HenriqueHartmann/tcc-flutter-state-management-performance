import 'package:app_base_gestao_estado/models/data_limit_option.dart';
import 'package:flutter/material.dart';
import 'package:app_base_gestao_estado/models/item.dart';
import 'package:app_base_gestao_estado/models/item_card_style.dart';
import 'package:app_base_gestao_estado/widgets/item_card.dart';
import 'package:app_base_gestao_estado/data/item_repository.dart';
import 'dart:developer' as developer;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _itemsWithStyle = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  DataLimitOption _selectedLimit = DataLimitOption.limit1k;
  ItemCardAttribute _selectedAttribute = ItemCardAttribute.backgroundColor;

  Future<void> _loadItems() async {
    setState(() {
      _isLoading = true;
    });

    final repo = ItemRepository();
    final items = await repo.fetchItems(limit: _selectedLimit.value);

    final itemsWithStyle = items.map((item) {
      const style = ItemCardStyle();
      return {
        'item': item,
        'style': style,
      };
    }).toList();

    setState(() {
      _itemsWithStyle = itemsWithStyle;
      _isLoading = false;
    });
  }

  void onItemTapped(
      List<Map<String, dynamic>> data, int index, DateTime tapStartTime) {
    // Executa a mudança
    setState(() {
      final style = data[index]['style'] as ItemCardStyle;
      data[index]['style'] = style.toggleSelectedAttribute(_selectedAttribute);
    });

    // Mede o tempo end-to-end após a renderização
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureEndToEndTime(tapStartTime);
    });
  }

  void _measureEndToEndTime(DateTime tapStartTime) {
    final endTime = DateTime.now();
    final totalDuration = endTime.difference(tapStartTime);

    // Converte para milissegundos (mais fácil de ler)
    final totalMs = totalDuration.inMicroseconds / 1000.0;

    final message =
        'Tempo end-to-end (setState): ${totalMs.toStringAsFixed(1)}ms';
    print(message);
    developer.log(message, name: 'Performance');
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
                child: Text(
                  attr.label,
                ),
              );
            }).toList(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                              });
                              _loadItems();
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
                      itemCount: _itemsWithStyle.length,
                      itemBuilder: (context, index) {
                        final item = _itemsWithStyle[index]['item'] as Item;
                        final style =
                            _itemsWithStyle[index]['style'] as ItemCardStyle;

                        return GestureDetector(
                          onTap: () {
                            final tapTime = DateTime.now();
                            onItemTapped(_itemsWithStyle, index, tapTime);
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
              ),
      ),
    );
  }
}
