
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
  return (user == null)?null:user;
}