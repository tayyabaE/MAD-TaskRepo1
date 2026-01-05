class User{
  final int id;
  String name;
  String role;
  bool isPresent;

  User({
    required this.id,
    required this.name,
    required this.role,
     this.isPresent= false,
  });
}