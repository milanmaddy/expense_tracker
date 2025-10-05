class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? profileUrl;
  final String? phoneNumber;
  final DateTime? joinedDate;
  final bool? isActive;
  // final UserRole? role;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.profileUrl,
    this.phoneNumber,
    this.joinedDate,
    this.isActive,
    // this.role,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'profileUrl': profileUrl,
    'phoneNumber': phoneNumber,
    'joinedDate': joinedDate?.toIso8601String(),
    'isActive': isActive,
    // 'role': role?.toString(),
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    profileUrl: json['profileUrl'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    joinedDate: json['joinedDate'] != null
        ? DateTime.tryParse(json['joinedDate'])
        : null,
    isActive: json['isActive'] as bool?,
    // role: json['role'] != null
    //     ? UserRole.values.firstWhere(
    //       (e) => e.toString() == json['role'],
    //   orElse: () => UserRole.MEMBER,
    // )
    //     : null,
  );

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? profileUrl,
    String? phoneNumber,
    DateTime? joinedDate,
    bool? isActive,
    // UserRole? role,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        profileUrl: profileUrl ?? this.profileUrl,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        joinedDate: joinedDate ?? this.joinedDate,
        isActive: isActive ?? this.isActive,
        // role: role ?? this.role,
      );
}