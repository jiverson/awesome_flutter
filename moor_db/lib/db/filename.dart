import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:moor/moor.dart';
import 'dart:io';

// assuming that your file is called filename.dart. This will give an error at first,
// but it's needed for moor to know about the generated code
part 'filename.g.dart';

// this will generate a table called "orders" for us. The rows of that table will
// be represented by a class called "Orders".
class Orders extends Table {
  TextColumn get price => text()();
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productName => text()();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    print(dbFolder);
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

// this annotation tells moor to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@UseMoor(tables: [Orders])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
  Future<List<Order>> getAllOrder() => select(orders).get();
  Stream<List<Order>> watchAllOrder() => select(orders).watch();
  Future insertNewOrder(OrdersCompanion entry) => into(orders).insert(entry);
  Future deleteOrder(Order order) => delete(orders).delete(order);
}
