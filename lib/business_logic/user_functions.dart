
import 'package:app_fintes/business_logic/data/globals.dart';
import 'package:app_fintes/business_logic/data/users_data.dart';
import 'package:app_fintes/business_logic/models/user_model.dart';

User? login (String email, String password){
  User? user;
  for (var u in users){
    if (u.email == email && u.password == password){
      user = u;
      break;
    }
  }
  globalUser = user;
  return (user == null)?null:user;
}

bool register (String name, String email, String password){
  bool registered = false;
  if (users.where((u) => u.email == email).isEmpty){
    users.add(User(
      id: (users.length + 1).toString(),
      name: name,
      email: email,
      password: password,
    ));
    registered = true;
  }
  return registered;
}