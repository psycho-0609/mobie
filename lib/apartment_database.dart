import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'apartment.dart';

class ApartmentsDatabase {
  static final ApartmentsDatabase instance = ApartmentsDatabase._init();

  static Database? _database;

  ApartmentsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('db.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }
  Future _createDB(Database db, int version) async {
    const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const propertyType = 'TEXT NOT NULL';
    const bedRoomsType = 'TEXT NOT NULL';
    const dateTimeType = 'TEXT NOT NULL';
    const monthlyRentPriceType = 'TEXT NOT NULL';
    const furnitureTypesType = 'TEXT';
    const notesType = 'TEXT';
    const nameOfTheReporterType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $apartmentDB ( 
  id $idType, 
  property $propertyType,
  bedRooms $bedRoomsType,
  dateTime $dateTimeType,
  monthlyRentPrice $monthlyRentPriceType,
  furnitureTypes $furnitureTypesType,
  notes $notesType,
  nameOfTheReporter $nameOfTheReporterType,
  )
''');
  }

  Future<Apartment> createOne(Apartment apartment) async {
    final db = await instance.database;
    final id = await db.insert(apartmentDB, apartment.toMap());
    return apartment.copy(id: id);
  }

  Future<Apartment> findOneApartment(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      apartmentDB,
      columns: Apartments.values,
      where: '${Apartments.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Apartment.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Apartment>> getAllApartments() async {
    final db = await instance.database;
    final result = await db.query(apartmentDB);
    return result.map((json) => Apartment.fromMap(json)).toList();
  }

  Future<List<Apartment>> searchApartmentsByProperty(String property) async {
    final db = await instance.database;
    final result = await db.query(
      apartmentDB,
      where: '${Apartments.property} = ?',
      whereArgs: [property],
    );
    return result.map((json) => Apartment.fromMap(json)).toList();
  }

  Future<int> updateOneApartment(Apartment apartment) async {
    final db = await instance.database;

    return db.update(
      apartmentDB,
      apartment.toMap(),
      where: '${Apartments.id} = ?',
      whereArgs: [apartment.id],
    );
  }

  Future<int> deleteOneApartment(int id) async {
    final db = await instance.database;
    return await db.delete(
      apartmentDB,
      where: '${Apartments.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
