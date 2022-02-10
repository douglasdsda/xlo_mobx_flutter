import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class CepField extends StatelessWidget {
  CepField(this.createStore) : cepstore = createStore!.cepStore;

  final CreateStore? createStore;
  final CepStore? cepstore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Observer(builder: (_) {
          return TextFormField(
            onChanged: cepstore!.setCep,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter()
            ],
            decoration: InputDecoration(
              errorText: createStore!.addressError,
              labelText: 'Cep *',
              labelStyle: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.grey,
                fontSize: 18,
              ),
              contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
            ),
          );
        }),
        Observer(builder: (_) {
          if (cepstore!.address == null &&
              cepstore!.error == null &&
              !cepstore!.loading)
            return Container();
          else if (cepstore!.address == null && cepstore!.error == null)
            return LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Colors.purple,
              ),
              backgroundColor: Colors.transparent,
            );
          else if (cepstore!.error != null)
            return Container(
              color: Colors.red.withAlpha(100),
              height: 50,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              child: Text(
                cepstore!.error.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            );
          else {
            final a = cepstore!.address;

            return Container(
              color: Colors.purple.withAlpha(150),
              height: 50,
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text(
                'Localização ${a!.district}, ${a.city!.nome} - ${a.uf!.sigla}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
        }),
      ],
    );
  }
}
