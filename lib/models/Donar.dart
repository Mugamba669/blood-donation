import 'package:hive/hive.dart';
part 'Donar.g.dart';

@HiveType(typeId: 0)
class Donar {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String contact;

  @HiveField(2)
  late String bloodGroup;

  @HiveField(3)
  late double longitude;

  @HiveField(4)
  late double latitude;
  // Items constructor
  Donar({
    required this.name,
    required this.contact,
    required this.bloodGroup,
    required this.latitude,
    required this.longitude,
  });
}
