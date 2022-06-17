import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../helper/data_helper.dart';
import '../model/ders.dart';

class DersListesi extends StatelessWidget {
  final Function onDismiss;
  const DersListesi({Key? key, required this.onDismiss}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Ders> tumDersler = DataHelper.tumEklenenDersler;
    return tumDersler.length > 0
        ? ListView.builder(
            itemCount: tumDersler.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.horizontal,
                onDismissed: (a) {
                  onDismiss(index);
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    child: ListTile(
                      subtitle: Text(
                          "${tumDersler[index].krediDegeri.toStringAsFixed(0)} Kredi, Not Değeri ${tumDersler[index].harfDegeri}"),
                      title: Text(tumDersler[index].ad),
                      leading: CircleAvatar(
                        backgroundColor: Sabitler.anaRenk,
                        child: Text(
                          (tumDersler[index].harfDegeri *
                                  tumDersler[index].krediDegeri)
                              .toStringAsFixed(0),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : Container(
            child: Center(
              child: Text(
                "Lütfen Ders Ekleyiniz",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
            ),
          );
  }
}
