import 'package:hive/hive.dart';
part 'user_hive.g.dart';

@HiveType(typeId: 1)
class User {
  User({
    required this.name,
    required this.email,
    required this.id,
  });

  @HiveField(0)
  String name;
  @HiveField(1)
  String email;
  @HiveField(2)
  String id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "id": id,
      };
}
