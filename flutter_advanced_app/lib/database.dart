import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'expense.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static final Future<Database> _database = initDB();

  Future<Database> get database async {
    return _database;
  }

  static Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String tempPath =documentsDirectory.path;
    String path = join(tempPath, "ExpenseDB2.db");
    return await openDatabase(
        path, version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE Expense ("
              "id INTEGER PRIMARY KEY,"
              "amount REAL,"
              "date TEXT,"
              "category TEXT"
              ")");
          await db.execute(
              "INSERT INTO Expense ('id', 'amount', 'date', 'category') values (?, ?, ?, ?)",
              [1, 1000, '2019-04-01 10:00:00', "Food"]);
        }
    );
  }

  Future<List<Expense>> getAllExpenses() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query("Expense",
        columns: Expense.columns, orderBy: "date DESC");
    List<Expense> expenses = List.empty(growable: true);
    for (var result in results) {
      Expense expense = Expense.fromMap(result);
      expenses.add(expense);
    }
    return expenses;
  }

  Future<Expense?> getExpenseById(int id) async {
    final db = await database;
    var result = await db.query("Expense", where: "id = ", whereArgs: [id]);
    if (result.isNotEmpty) {
      return Expense.fromMap(result.first);
    }
  }

  Future<double> getTotalExpense() async {
    final db = await database;
    List<Map> list =
        await db.rawQuery("Select SUM(amount) as amount from expense");
    return list.isNotEmpty ? list[0]["amount"] : Null;
  }

  Future<Expense> insert(Expense expense) async {
    final db = await database;
    var maxIdResult =
        await db.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM Expense");
    var id = maxIdResult.first["last_inserted_id"];
    var result = await db.rawInsert(
        "INSERT Into Expense (id, amount, date, category)"
        " VALUES (?, ?, ?, ?)",
        [id, expense.amount, expense.date.toString(), expense.category]);
    return Expense(result, expense.amount, expense.date, expense.category);
  }

  update(Expense product) async {
    final db = await database;
    var result = await db.update("Expense", product.toMap(),
        where: "id = ?", whereArgs: [product.id]);
    return result;
  }

  delete(int id) async {
    final db = await database;
    db.delete("Expense", where: "id = ?", whereArgs: [id]);
  }
}
