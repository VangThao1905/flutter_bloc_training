import 'package:user_repository/src/models/models.dart';
import 'package:uuid/uuid.dart';

class UserRepository {

  UserRepository(){
    user = User('');
  }

  late User user;

  // User getUser() {
  //   // if (_user != null)
  //   return user;
  //   // return Future.delayed(
  //   //     Duration(milliseconds: 300), () => _user = User(Uuid().v4()));
  // }
}
