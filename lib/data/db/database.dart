import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:film/data/db/tables/film_table.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(tables: [FilmTable])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    // утилита LazyDatabase позволяет нам найти правильное место для файла async.
    return LazyDatabase(() async {
      //поместите файл базы данных, названный здесь db.sqlite, в папку документов для вашего приложения
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file);
    });
  }
}
