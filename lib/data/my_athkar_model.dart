import 'package:hive/hive.dart';

part 'my_athkar_model.g.dart';

@HiveType(typeId: 0)
class MyAthkarModel {
  @HiveField(0)
  final String thekr;
  @HiveField(1)
  final String note;

  MyAthkarModel(this.thekr, this.note);
}
