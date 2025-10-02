import 'package:app_base_gestao_estado/models/item.dart';
import 'package:app_base_gestao_estado/models/item_card_style.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;
import 'package:flutter/widgets.dart';

class ItemWithStyleNotifier extends ChangeNotifier {
  final Item item;
  ItemCardStyle style;

  ItemWithStyleNotifier({
    required this.item,
    required this.style,
  });

  // Variável para medição end-to-end
  DateTime? _tapStartTime;

  void toggleStyle(ItemCardAttribute attribute, {DateTime? tapStartTime}) {
    // Captura o tempo do tap
    _tapStartTime = tapStartTime ?? DateTime.now();
    
    // Executa a mudança
    style = style.toggleSelectedAttribute(attribute);
    notifyListeners();
    
    // Mede o tempo end-to-end após a renderização
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureEndToEndTime();
    });
  }
  
  void _measureEndToEndTime() {
    if (_tapStartTime != null) {
      final endTime = DateTime.now();
      final totalDuration = endTime.difference(_tapStartTime!);
      
      // Converte para milissegundos (mais fácil de ler)
      final totalMs = totalDuration.inMicroseconds / 1000.0;
      
      final message = 'Tempo end-to-end: ${totalMs.toStringAsFixed(1)}ms';
      print(message);
      developer.log(message, name: 'Performance');
      
      _tapStartTime = null;
    }
  }
}
