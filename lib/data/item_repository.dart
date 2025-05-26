import 'package:app_base_gestao_estado/database/read_database_helper.dart';
import 'package:app_base_gestao_estado/models/item.dart';

class ItemRepository {
  Future<List<Item>> fetchItems() async {
    final db = await ReadOnlyDatabaseHelper.openDatabaseFromAsset();
    final result = await db.query('movies', columns: ['id', 'title', 'description']);
    return result.map((e) => Item.fromMap(e)).toList();
  }
}
