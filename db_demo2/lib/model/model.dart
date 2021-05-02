import 'package:jwnotes_app/db/db.dart';
import 'package:jwnotes_app/model/model_constant.dart';

class DbNote extends DbRecord {
  final title = stringField(columnTitle);
  final content = stringField(columnContent);
  final date = intField(columnUpdated);

  @override
  List<Field> get fields => [id, title, content, date];
}
