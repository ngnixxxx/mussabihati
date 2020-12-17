import 'package:hive/hive.dart';

part 'my_tassabih_model.g.dart';

@HiveType(typeId: 1)
class MyTassabihModel {
  @HiveField(0)
  final String tassbih;
  @HiveField(1)
  final String note;
  @HiveField(2)
  final int count;
  @HiveField(3)
  final int requiredCount;

  MyTassabihModel(this.tassbih, this.note, this.count, this.requiredCount);
}
