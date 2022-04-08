class User{
  final String uid;
  final String name;
  final bool isBanned;

//<editor-fold desc="Data Methods">

  const User({
    required this.uid,
    required this.name,
    required this.isBanned,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User && runtimeType == other.runtimeType && uid == other.uid && name == other.name && isBanned == other.isBanned);

  @override
  int get hashCode => uid.hashCode ^ name.hashCode ^ isBanned.hashCode;

  @override
  String toString() {
    return 'User{' + ' uid: $uid,' + ' name: $name,' + ' isBanned: $isBanned,' + '}';
  }

  User copyWith({
    String? uid,
    String? name,
    bool? isBanned,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      isBanned: isBanned ?? this.isBanned,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'name': this.name,
      'isBanned': this.isBanned,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      name: map['name'] as String,
      isBanned: map['isBanned'] as bool,
    );
  }

//</editor-fold>
}