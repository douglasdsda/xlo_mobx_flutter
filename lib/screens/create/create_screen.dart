import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/stores/create_store.dart';

import 'components/category_field.dart';
import 'components/cep_field.dart';
import 'components/hide_phone_field.dart';
import 'components/images_field.dart';

class CreateScreen extends StatelessWidget {
  CreateScreen({Key? key}) : super(key: key);

  final CreateStore createStore = CreateStore();

  final labelStyle = TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.grey,
    fontSize: 18,
  );

  final contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Text('Criar Anúncio'),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Card(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImagesField(createStore),
                  Observer(builder: (_) {
                    return TextFormField(
                      onChanged: createStore.setTitle,
                      decoration: InputDecoration(
                          labelText: 'Título *',
                          labelStyle: labelStyle,
                          errorText: createStore.titleError,
                          contentPadding: contentPadding),
                    );
                  }),
                  Observer(builder: (_) {
                    return TextFormField(
                      onChanged: createStore.setDescription,
                      decoration: InputDecoration(
                          labelText: 'Descrição *',
                          labelStyle: labelStyle,
                          errorText: createStore.descriptionError,
                          contentPadding: contentPadding),
                      maxLines: null,
                    );
                  }),
                  CategoryField(createStore),
                  CepField(createStore),
                  Observer(builder: (_) {
                    return TextFormField(
                      onChanged: createStore.setPrice,
                      decoration: InputDecoration(
                          labelText: 'Preço *',
                          labelStyle: labelStyle,
                          contentPadding: contentPadding,
                          prefixText: 'R\$ ',
                          errorText: createStore.priceError),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        RealInputFormatter(centavos: true)
                      ],
                    );
                  }),
                  HidePhoneField(createStore),
                  Observer(builder: (_) {
                    return SizedBox(
                      height: 50,
                      child: GestureDetector(
                        onTap: createStore.invalidSendPressed,
                        child: ElevatedButton(
                          child: Text("Enviar"),
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              onSurface: Colors.orange.withAlpha(120),
                              primary: Colors.orange,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              textStyle: TextStyle(color: Colors.white)),
                          onPressed: createStore.sendPressed,
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
