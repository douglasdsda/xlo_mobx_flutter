import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/screens/base/base_screen.dart';
import 'package:xlo_mobx/screens/category/category_screen.dart';
import 'package:xlo_mobx/stores/page_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import 'repositories/category_repository.dart';
import 'repositories/ibge_repository.dart';
import 'stores/category_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();

  setupLocators();
  runApp(MyApp());

  // IBGERepository().getUFList().then((value) => {
  //       IBGERepository()
  //           .getCityListFromApi(value.first)
  //           .then((value) => print(value))
  //     });
}

void setupLocators() {
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(UserManagerStore());
  GetIt.I.registerSingleton(CategoryStore());
}

Future<void> initializeParse() async {
  await Parse().initialize(
      'fds1232FDS!dsa11232pmGFDS41', 'https://parseapi.back4app.com/',
      clientKey: 'p3gjhianmçdsi123&@Gefbnm12123',
      autoSendSessionId: true,
      debug: true);

  // final categories = await CategoryRepository().getList();
  // print(categories);

  // final category = ParseObject('Categories')
  // ..set<String>('Title', 'Camisetas')
  // ..set<int>('Position', 1);

  // final response = await category.save();

  // print(response.success);

  // final category = ParseObject('Categories')
  //   ..objectId = 'MOoUENzfGy'
  //   ..set<int>('Position', 3);

  // await category.delete();

  // final response = await ParseObject('Categories').getObject('jL1H0kvvvb');
  // if (response.success) {
  //   print(response.result);
  // }

  // final response = await ParseObject('Categories').getAll();
  // if (response.success) {
  //   for (final object in response.result) {
  //     print(object);
  //   }
  // }

  // final query = QueryBuilder(ParseObject('Categories'));
  // query.whereContains('Title', 'Camisetas 2');

  // final response = await query.query();

  // if (response.success) {
  //   print(response.result);
  // }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'XLO',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.purple,
          appBarTheme: AppBarTheme(elevation: 0),
        ),
        home: BaseScreen());
  }
}
