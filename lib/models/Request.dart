import 'package:hive/hive.dart';
part 'Request.g.dart';

@HiveType(typeId: 1)
class Requests {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String date;

  @HiveField(2)
  late String group;

  @HiveField(3)
  late double quantity;

  @HiveField(4)
  late double phone;
  Requests({
    required this.name,
    required this.date,
    required this.group,
    required this.phone,
    required this.quantity,
  });
}
