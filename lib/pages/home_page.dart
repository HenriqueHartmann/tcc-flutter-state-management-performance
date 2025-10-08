import 'package:app_base_gestao_estado/bloc/item_list/item_list_bloc.dart';
import 'package:app_base_gestao_estado/bloc/item_list/item_list_event.dart';
import 'package:app_base_gestao_estado/bloc/item_list/item_list_state.dart';
import 'package:app_base_gestao_estado/bloc/item_style/item_style_bloc.dart';
import 'package:app_base_gestao_estado/bloc/item_style/item_style_event.dart';
import 'package:app_base_gestao_estado/bloc/item_style/item_style_state.dart';
import 'package:app_base_gestao_estado/models/data_limit_option.dart';
import 'package:flutter/material.dart';
import 'package:app_base_gestao_estado/models/item.dart';
import 'package:app_base_gestao_estado/models/item_card_style.dart';
import 'package:app_base_gestao_estado/widgets/item_card.dart';
import 'package:app_base_gestao_estado/data/item_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataLimitOption _selectedLimit = DataLimitOption.limit1k;
  ItemCardAttribute _selectedAttribute = ItemCardAttribute.backgroundColor;
  late ItemListBloc _itemListBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        _itemListBloc = ItemListBloc(repository: ItemRepository())
          ..add(LoadItemList(limit: _selectedLimit.value));
        return _itemListBloc;
      },
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
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
                        _itemListBloc.add(LoadItemList(limit: _selectedLimit.value));
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
              Expanded(
                child: BlocBuilder<ItemListBloc, ItemListState>(
                  builder: (context, state) {
                    if (state is ItemListLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is ItemListError) {
                      return Center(child: Text('Erro: ${state.message}'));
                    }

                    if (state is ItemListLoaded) {
                      final data = state.itemsWithStyle;

                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index]['item'] as Item;
                          final style = data[index]['style'] as ItemCardStyle;

                          return BlocProvider<ItemStyleBloc>(
                            create: (_) => ItemStyleBloc(initialStyle: style),
                            child: BlocBuilder<ItemStyleBloc, ItemStyleState>(
                              builder: (context, styleState) {
                                if (styleState is ItemStyleLoaded) {
                                  return GestureDetector(
                                    onTap: () {
                                      final tapTime = DateTime.now();
                                      context.read<ItemStyleBloc>().add(
                                            ToggleItemStyle(
                                                attribute: _selectedAttribute,
                                                tapStartTime: tapTime),
                                          );
                                    },
                                    child: ItemCard(
                                      index: index,
                                      title: item.title,
                                      description: item.description,
                                      style: styleState.style,
                                    ),
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
