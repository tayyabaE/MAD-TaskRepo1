class User{
  final int? id;
  String name;
  String role;

  User({
    this.id,
    required this.name,
    required this.role,
  });


Map<String, dynamic> toMap(){
  return{
    'id' : id,
    'name' : name,
    'role' : role,
  };
}

factory User.fromMap(Map<String, dynamic> row){
  return User(
  id: row['id'] as int,
  name: row['name'] as String,
  role: row['role'] as String,
  );
  }
}