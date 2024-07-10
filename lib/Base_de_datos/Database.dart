import 'package:proyecto_ugarte_diego/Rutinas.dart';
import 'package:proyecto_ugarte_diego/juegos.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Define a private constructor to prevent instantiation from outside
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static const _databaseName = 'Games_Database.db';
  static const _databaseVersion = 3;

  // Function to open the database (or create it if it doesn't exist)
  Future<Database> get database async {
    final databasePath = await getDatabasesPath();
    print('The versions in _databaseVersion is $_databaseVersion');
    return await openDatabase(
      '$databasePath/$_databaseName',
      onCreate: (db, version) {
        // Create the "game" table on database creation
        print('The versions in version is $version');
        db.execute('''
          CREATE TABLE juego(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            nombre TEXT,
            plataforma TEXT,
            urlImagen TEXT,
            descripcion TEXT,
            link_plataforma TEXT
          )
        ''');
        db.execute('''
          CREATE TABLE rutina(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            descripcion TEXT,
            pasos TEXT,
            dificultad TEXT,
            resultado TEXT,
            juego_id INTEGER,
            FOREIGN KEY (juego_id) REFERENCES juego (id) ON DELETE CASCADE
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Handle database schema upgrades if needed
        // (implement logic for updating existing tables here)
        print('The versions in oldVersion is $oldVersion and newVersion is $newVersion');
        for (int version = oldVersion + 1; version <= newVersion; version++) {
          switch (version) {
            case 3:
              // Create a new table with the desired AUTOINCREMENT column
              print('The version is $version and Create a new table with the desired AUTOINCREMENT column');
              await db.execute('''
                CREATE TABLE juego_nuevo(
                  id INTEGER PRIMARY KEY AUTOINCREMENT, 
                  name TEXT,
                  gender TEXT,
                  year INTEGER,
                  version INTEGER)
              ''');

              await db.execute('''
                CREATE TABLE Rutina_nueva(
                  id INTEGER PRIMARY KEY AUTOINCREMENT, 
                  name TEXT,
                  gender TEXT,
                  year INTEGER,
                  version INTEGER)
              ''');

              // Migrate data from the old table to the new table
              final oldData = await db.query('juego');
              for (final row in oldData) {
                await db.insert('juego_nuevo', row);
              }

              // Drop the old table after successful migration
              await db.execute('DROP TABLE juego');

              // Rename the new table to the original name
              await db.execute('ALTER TABLE juego_nuevo RENAME TO juego');
              break;
            default:
              throw Exception('Unsupported upgrade version: $version');
          }
        }
      },
      version: 3, // This version is for determining the onCreate, onUpgrade, or onDowngrade option (new version)
    );
  }

  Future<void> insertJuego(Juego juego) async {
    final db = await database;

    await db.transaction((txn) async {
      final juegoId = await txn.insert('juego', juego.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

      for (final rutina in juego.rutinas) {
        await txn.insert('rutina', {
          ...rutina.toMap(),
          'juego_id': juegoId,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  Future<List<Juego>> getJuegos() async {
    final db = await database;
    final List<Map<String, dynamic>> juegosData = await db.query('juego');

    List<Juego> juegos = [];

    for (final juegoData in juegosData) {
      final List<Map<String, dynamic>> rutinasData = await db.query('rutina', where: 'juego_id = ?', whereArgs: [juegoData['id']]);
      final List<Rutina> rutinas = rutinasData.map((data) => Rutina.fromMap(data)).toList();

      juegos.add(Juego.fromMap({
        ...juegoData,
        'rutinas': rutinas,
      }));
    }

    return juegos;
  }
}