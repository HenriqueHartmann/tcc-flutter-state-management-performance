import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ReadOnlyDatabaseHelper {
  static const _dbName = 'movies.db';

  static Future<Database> openDatabaseFromAsset() async {
    final documentsDir = await getApplicationDocumentsDirectory();
    final dbPath = join(documentsDir.path, _dbName);

    // Garante que o banco seja copiado do assets apenas uma vez
    final dbExists = await File(dbPath).exists();

    if (!dbExists) {
      final byteData = await rootBundle.load('assets/database/$_dbName');
      final buffer = byteData.buffer;
      await File(dbPath).writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
      );
    }

    return await openDatabase(dbPath, readOnly: true);
  }
}
