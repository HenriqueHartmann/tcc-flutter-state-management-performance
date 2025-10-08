import 'package:app_base_gestao_estado/bloc/item_style/item_style_event.dart';
import 'package:app_base_gestao_estado/bloc/item_style/item_style_state.dart';
import 'package:app_base_gestao_estado/models/item_card_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer' as developer;

class ItemStyleBloc extends Bloc<ItemStyleEvent, ItemStyleState> {
  late ItemCardStyle _style;

  ItemStyleBloc({ItemCardStyle? initialStyle}) : super(ItemStyleInitial()) {
    _style = initialStyle ?? const ItemCardStyle();
    emit(ItemStyleLoaded(style: _style));

    on<ToggleItemStyle>((event, emit) {
      // Captura o tempo do tap
      final tapStartTime = event.tapStartTime ?? DateTime.now();
      
      // Executa a mudança
      _style = _style.toggleSelectedAttribute(event.attribute);
      emit(ItemStyleLoaded(style: _style));
      
      // Mede o tempo end-to-end após a renderização
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _measureEndToEndTime(tapStartTime);
      });
    });
  }
  
  void _measureEndToEndTime(DateTime tapStartTime) {
    final endTime = DateTime.now();
    final totalDuration = endTime.difference(tapStartTime);
    
    // Converte para milissegundos (mais fácil de ler)
    final totalMs = totalDuration.inMicroseconds / 1000.0;
    
    final message = 'Tempo end-to-end (Bloc): ${totalMs.toStringAsFixed(1)}ms';
    print(message);
    developer.log(message, name: 'Performance');
  }
}
