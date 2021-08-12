import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/screens/base/base_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  runApp(MyApp());
}

Future<void> initializeParse() async {
  await Parse().initialize('EyD0KNU9a4izKQt0AjnU8w7XaW6guicRgcmUXI0d',
      'https://parseapi.back4app.com/',
      clientKey: 'TejGBpKL9RqNUAmIXTTruvC8Gdxl4E9c4FMlVplJ',
      autoSendSessionId: true,
      debug: true);

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
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BaseScreen());
  }
}
