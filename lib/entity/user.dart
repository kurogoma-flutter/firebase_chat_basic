class User {
  final String uid;
  final String name;
  final String iconPath;
  final String comment;
  final bool isBanned;

//<editor-fold desc="Data Methods">

  const User({
    required this.uid,
    required this.name,
    required this.iconPath,
    required this.comment,
    required this.isBanned,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          name == other.name &&
          isBanned == other.isBanned &&
          iconPath == other.iconPath &&
          comment == other.comment);

  @override
  int get hashCode => uid.hashCode ^ name.hashCode ^ isBanned.hashCode ^ iconPath.hashCode ^ comment.hashCode;

  @override
  String toString() {
    return 'User{' + ' uid: $uid,' + ' name: $name,' + ' isBanned: $isBanned,' + ' iconPath: $iconPath,' + ' comment: $comment,' + '}';
  }

  User copyWith({
    String? uid,
    String? name,
    String? iconPath,
    String? comment,
    bool? isBanned,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      iconPath: iconPath ?? this.iconPath,
      comment: comment ?? this.comment,
      isBanned: isBanned ?? this.isBanned,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'name': this.name,
      'iconPath': this.iconPath,
      'comment': this.comment,
      'isBanned': this.isBanned,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      name: map['name'] as String,
      iconPath: map['iconPath'] as String,
      comment: map['nacommentme'] as String,
      isBanned: map['isBanned'] as bool,
    );
  }

//</editor-fold>
}
