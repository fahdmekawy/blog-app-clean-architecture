import '../../../../core/common/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) => UserModel(
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        id: map['id'] ?? '',
      );

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
