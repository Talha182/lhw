// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

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

  QuestionDao? _questionDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `questions` (`id` INTEGER NOT NULL, `questionText` TEXT NOT NULL, `option1` TEXT NOT NULL, `option2` TEXT NOT NULL, `option3` TEXT NOT NULL, `option4` TEXT NOT NULL, `correctAnswer` TEXT NOT NULL, `correctExplanation` TEXT NOT NULL, `incorrectExplanation` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  QuestionDao get questionDao {
    return _questionDaoInstance ??= _$QuestionDao(database, changeListener);
  }
}

class _$QuestionDao extends QuestionDao {
  _$QuestionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _questionInsertionAdapter = InsertionAdapter(
            database,
            'questions',
            (Question item) => <String, Object?>{
                  'id': item.id,
                  'questionText': item.questionText,
                  'option1': item.option1,
                  'option2': item.option2,
                  'option3': item.option3,
                  'option4': item.option4,
                  'correctAnswer': item.correctAnswer,
                  'correctExplanation': item.correctExplanation,
                  'incorrectExplanation': item.incorrectExplanation
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Question> _questionInsertionAdapter;

  @override
  Future<List<Question>> findAllQuestions() async {
    return _queryAdapter.queryList('SELECT * FROM questions',
        mapper: (Map<String, Object?> row) => Question(
            id: row['id'] as int,
            questionText: row['questionText'] as String,
            option1: row['option1'] as String,
            option2: row['option2'] as String,
            option3: row['option3'] as String,
            option4: row['option4'] as String,
            correctAnswer: row['correctAnswer'] as String,
            correctExplanation: row['correctExplanation'] as String,
            incorrectExplanation: row['incorrectExplanation'] as String));
  }

  @override
  Future<void> insertQuestion(Question question) async {
    await _questionInsertionAdapter.insert(question, OnConflictStrategy.abort);
  }
}
