
import 'package:app_fintes/business_logic/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<User?> login (String email, String password) async {
  User? user;
  await FirebaseFirestore.instance.collection('Users')
    .where('email', isEqualTo: email)
    .where('password', isEqualTo: password)
    .get()
    .then((value) {
      if (value.docs.isNotEmpty){
        user = User.fromJson(value.docs.first.data(), value.docs.first.id);
      }
    })
    .catchError((error) {});
    return user;
}

Future<bool> register (User user) async{
  bool wasCreated = false;
  User? response = await getUserByEmail(user.email);
  if(response == null){
    await FirebaseFirestore.instance.collection('Users')
      .add(user.toJson())
      .then((value) {
        wasCreated = true;
      })
      .catchError((error) {});
  }
  return wasCreated;
}

Future<User?> getUserByEmail(String email) async {
  User? user;
  await FirebaseFirestore.instance.collection('Users')
    .where('email', isEqualTo: email)
    .get()
    .then((value) {
      if (value.docs.isNotEmpty){
        user = User.fromJson(value.docs.first.data(), value.docs.first.id);
      }
    })
    .catchError((error) {});
  return user;
}

Future<List<User>> getUsers() async {
  List<User> users = [];
  await FirebaseFirestore.instance.collection('Users')
    .get()
    .then((value) {
      for (var doc in value.docs){
        User user = User.fromJson(doc.data(), doc.id);
        users.add(user);
      }
    })
    .catchError((error){});
  return users;
}


