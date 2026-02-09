class UserModel {
  final String id;
  final String? phone;
  final String? name;
  final String? language;
  final DateTime createdAt;

  UserModel({
    required this.id,
    this.phone,
    this.name,
    this.language,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      language: json['language'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'name': name,
      'language': language,
      'created_at': createdAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? phone,
    String? name,
    String? language,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
