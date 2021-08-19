import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';

import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  @observable
  String? email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email!.isEmailValid();
  get emailError => email == null || emailValid ? null : 'E-mail inválido';

  @observable
  String? password;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password != null && password!.length >= 4;
  get passwordError =>
      password == null || passwordValid ? null : 'Senha é inválida';

  @computed
  bool get isFormValid => passwordValid && emailValid;

  @computed
  get loginPressed => isFormValid && !loading ? _login : null;

  @observable
  bool loading = false;

  @observable
  String? error;

  @action
  Future _login() async {
    loading = true;

    // final user = User(name: name, email: email, phone: phone, password: pass1);
    try {
      // final resultUser = await UserRepository().signUp(user);
      // print(resultUser);
      final user = await UserRepository().loginWithEmail(email, password);
      GetIt.I<UserManagerStore>().setUser(user);
      error = null;
    } catch (e) {
      error = e.toString();
    }

    loading = false;
  }
}
