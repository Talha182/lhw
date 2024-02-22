// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `User` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `email` TEXT NOT NULL, `phone` TEXT NOT NULL, `nic` TEXT NOT NULL, `idNo` TEXT NOT NULL, `dob` TEXT NOT NULL, `village` TEXT NOT NULL, `ucName` TEXT NOT NULL, `yearsExperience` INTEGER NOT NULL, `emailVerifiedAt` TEXT, `password` TEXT NOT NULL, `image` TEXT NOT NULL, `roleId` INTEGER, `status` TEXT NOT NULL, `rememberToken` TEXT, `createdAt` TEXT NOT NULL, `updatedAt` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'User',
            (User item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'phone': item.phone,
                  'nic': item.nic,
                  'idNo': item.idNo,
                  'dob': item.dob,
                  'village': item.village,
                  'ucName': item.ucName,
                  'yearsExperience': item.yearsExperience,
                  'emailVerifiedAt': item.emailVerifiedAt,
                  'password': item.password,
                  'image': item.image,
                  'roleId': item.roleId,
                  'status': item.status,
                  'rememberToken': item.rememberToken,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  @override
  Future<List<User>> findAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM User',
        mapper: (Map<String, Object?> row) => User(
            id: row['id'] as int,
            name: row['name'] as String,
            email: row['email'] as String,
            phone: row['phone'] as String,
            nic: row['nic'] as String,
            idNo: row['idNo'] as String,
            dob: row['dob'] as String,
            village: row['village'] as String,
            ucName: row['ucName'] as String,
            yearsExperience: row['yearsExperience'] as int,
            emailVerifiedAt: row['emailVerifiedAt'] as String?,
            password: row['password'] as String,
            image: row['image'] as String,
            roleId: row['roleId'] as int?,
            status: row['status'] as String,
            rememberToken: row['rememberToken'] as String?,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String));
  }

  @override
  Stream<User?> findUserById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM User WHERE id = ?1',
        mapper: (Map<String, Object?> row) => User(
            id: row['id'] as int,
            name: row['name'] as String,
            email: row['email'] as String,
            phone: row['phone'] as String,
            nic: row['nic'] as String,
            idNo: row['idNo'] as String,
            dob: row['dob'] as String,
            village: row['village'] as String,
            ucName: row['ucName'] as String,
            yearsExperience: row['yearsExperience'] as int,
            emailVerifiedAt: row['emailVerifiedAt'] as String?,
            password: row['password'] as String,
            image: row['image'] as String,
            roleId: row['roleId'] as int?,
            status: row['status'] as String,
            rememberToken: row['rememberToken'] as String?,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String),
        arguments: [id],
        queryableName: 'User',
        isView: false);
  }

  @override
  Future<User?> findUserByEmailAndPassword(
    String email,
    String password,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM User WHERE email = ?1 AND password = ?2',
        mapper: (Map<String, Object?> row) => User(
            id: row['id'] as int,
            name: row['name'] as String,
            email: row['email'] as String,
            phone: row['phone'] as String,
            nic: row['nic'] as String,
            idNo: row['idNo'] as String,
            dob: row['dob'] as String,
            village: row['village'] as String,
            ucName: row['ucName'] as String,
            yearsExperience: row['yearsExperience'] as int,
            emailVerifiedAt: row['emailVerifiedAt'] as String?,
            password: row['password'] as String,
            image: row['image'] as String,
            roleId: row['roleId'] as int?,
            status: row['status'] as String,
            rememberToken: row['rememberToken'] as String?,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String),
        arguments: [email, password]);
  }

  @override
  Future<void> insertUser(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }
}
