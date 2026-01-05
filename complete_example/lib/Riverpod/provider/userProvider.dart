import 'package:complete_example/Riverpod/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<User> initialUser = [
  User(id: 1, name: "Ali", role: "Admin"),
  User(id: 2, name: "Ahmed", role: "Normal User")
];

class UserNotifier extends StateNotifier<List<User>>{
  UserNotifier() : super(initialUser);

  void togglePresent (int id) {
    final i = state.indexWhere((u) => u.id == id);
    if (i != -1) {
      state[i].isPresent = !state[i].isPresent;
      state = [...state];
    }
  }
    void add(User user){
      state.add(user);
      state = [...state];
    }

    void update(User user){
      final i = state.indexWhere((u) => u.id == user.id);
      if(i != -1){
        state[i].name = user.name;
        state[i].role = user.role;
        state= [...state];
      }
    }

    void delete(User user){
      final i = state.indexWhere((u) => u.id == user.id);
      if(i != -1){
        state.remove(user);
        state= [...state];
      }
    }

    void markAllPresent(){
      for(var user in state){
        user.isPresent = false;
      }
      state = [...state];
    }

    void markAllAbsent(){
      for(var user in state){
        user.isPresent = true;
      }
      state = [...state];
    }

  int get totalPresent => state.where((u) => !u.isPresent).length;
  int get totalAbsent => state.where((u) => u.isPresent).length;

  User getOne(int id) => state.singleWhere((u) => u.id ==id);
}

final userProvider = StateNotifierProvider<UserNotifier, List<User>>(
    (ref) => UserNotifier()
);