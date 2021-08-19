import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/parse_erros.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class UserRepository {
  Future<User> signUp(User user) async {
    final parserUser = ParseUser(user.email, user.password, user.email);

    parserUser.set<dynamic>(keyUserName, user.name);
    parserUser.set<dynamic>(keyUserPhone, user.phone);
    parserUser.set<dynamic>(keyUserType, user.type!.index);

    final response = await parserUser.signUp();

    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  Future<User> loginWithEmail(dynamic email, dynamic password) async {
    final parserUser = ParseUser(email, password, null);

    final response = await parserUser.login();

    if (response.success) {
      return mapParseToUser(response.result);
    } else
      return Future.error(ParseErrors.getDescription(response.error!.code));
  }

  Future currentUser() async {
    final parseUser = await ParseUser.currentUser();
    if (parseUser != null) {
      final response =
          await ParseUser.getCurrentUserFromServer(parseUser.sessionToken);
      if (response!.success) {
        return mapParseToUser(response.result);
      } else
        parseUser.logout();
    }
    return null;
  }

  User mapParseToUser(ParseUser parseUser) {
    return User(
      id: parseUser.objectId,
      name: parseUser.get(keyUserName),
      email: parseUser.get(keyUserEmail),
      phone: parseUser.get(keyUserPhone),
      type: UserType.values[parseUser.get(keyUserType)],
      createdAt: parseUser.get(keyUserCreatedAt),
    );
  }
}
