import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';

import 'cep_store.dart';
import 'user_manager_store.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStoreBase with _$CreateStore;

abstract class _CreateStoreBase with Store {
  ObservableList images = ObservableList();

  @observable
  Category? category;

  @action
  void setCategory(Category? value) => category = value;

  @computed
  bool get categoryValid => category != null;
  dynamic get categoryError {
    if (!showErrors || categoryValid)
      return null;
    else
      return 'Campo obrigatório';
  }

  @computed
  bool get imagesValid => images.isNotEmpty;
  dynamic get imagesError {
    if (!showErrors || imagesValid)
      return null;
    else
      return 'Insira imagens';
  }

  @observable
  String title = '';

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title.length >= 6;
  dynamic get titleError {
    if (!showErrors || titleValid)
      return null;
    else if (title.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Título muito curto';
  }

  @observable
  String description = '';

  @action
  void setDescription(String value) => description = value;

  @computed
  bool get descriptionValid => description.length >= 10;
  dynamic get descriptionError {
    if (!showErrors || descriptionValid)
      return null;
    else if (description.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Descrição muito curto';
  }

  CepStore? cepStore = CepStore();

  @computed
  Address? get address => cepStore!.address;
  bool get addressValid => address != null;
  dynamic get addressError {
    if (!showErrors || addressValid) {
      return null;
    } else
      return 'Campo obrigatório';
  }

  @observable
  String priceText = '';

  @action
  void setPrice(String value) => priceText = value;

  @computed
  dynamic get price {
    if (priceText.contains(',')) {
      return num.tryParse(priceText.replaceAll(RegExp('[^0-9]'), ''));
    } else {
      return num.tryParse(priceText);
    }
  }

  bool get priceValid => price != null && price <= 9999999;
  dynamic get priceError {
    if (!showErrors || priceValid)
      return null;
    else if (priceText.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Preço inválido';
  }

  @observable
  bool? hidePhone = false;

  @action
  void setHidePhone(bool? value) => hidePhone = value;

  @computed
  bool get formValid =>
      imagesValid &&
      titleValid &&
      descriptionValid &&
      categoryValid &&
      addressValid &&
      priceValid;

  @computed
  get sendPressed => formValid ? _send : null;

  @observable
  bool showErrors = false;

  @observable
  bool loading = false;

  @action
  void invalidSendPressed() => showErrors = true;

  Future<void> _send() async {
    final ad = new Ad();
    ad.title = title;
    ad.description = description;
    ad.category = category;
    ad.price = price;
    ad.hidePhone = hidePhone ?? false;
    ad.images = images;
    ad.address = address;
    ad.user = GetIt.I<UserManagerStore>().user;

    loading = true;
    try {
      await AdRepository().save(ad);
      // savedAd = true;
    } catch (e) {
      // error = e;
    }
    loading = false;
  }
}
