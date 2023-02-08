import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../helper/data_helper.dart';
import '../model/ders.dart';
import 'ders_listesi.dart';
import 'harf_dropdown_widget.dart';
import 'kredi_dropdown_widget.dart';
import 'ortalama_goster.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  OrtalamaHesaplaPage({Key? key}) : super(key: key);

  @override
  State<OrtalamaHesaplaPage> createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  var formKey = GlobalKey<FormState>();
  double secilenHarfDeger = 4;
  double secilenKrediDeger = 1;
  String girilenDersAdi = "";
  final lessonName = TextEditingController();
  bool onInput = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            Sabitler.baslikText,
            style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildForm(),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OrtalamaGoster(
                      ortalama: DataHelper.ortalamaHesapla(),
                      dersSayisi: DataHelper.tumEklenenDersler.length),
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 2,
          ),
          Expanded(
            child: DersListesi(
              onDismiss: (index) {
                DataHelper.tumEklenenDersler.removeAt(index);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: Sabitler.yatayPadding8,
            child: _buildTextFormBuild(),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: HarfDropdownWidget(onHarfSecildi: (harf) {
                    secilenHarfDeger = harf;
                  }),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: KrediDropdownWidget(onKrediSecildi: (kredi) {
                    secilenKrediDeger = kredi;
                  }),
                ),
              ),
              IconButton(
                color: Sabitler.anaRenk,
                iconSize: 30,
                onPressed: _dersEkleveOrtalamaHesapla,
                icon: Icon(Icons.arrow_forward_ios_sharp),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  TextFormField _buildTextFormBuild() {
    return TextFormField(
      controller: lessonName,
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      onChanged: (deger) {
        if (deger.isNotEmpty) {
          setState(() {
            onInput = true;
          });
        } else {
          setState(() {
            onInput = false;
          });
        }
      },
      validator: (s) {
        if (s!.length <= 0) {
          return "Ders adini giriniz";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        suffixIcon: onInput
            ? IconButton(
                onPressed: () {
                  lessonName.clear();
                  setState(() {
                    girilenDersAdi = '';
                    onInput = false;
                  });
                },
                icon: Icon(Icons.close))
            : null,
        hintText: "Ders giriniz",
        border: OutlineInputBorder(
          borderRadius: Sabitler.borderRadius,
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3),
      ),
    );
  }

  _dersEkleveOrtalamaHesapla() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDers = Ders(
          ad: girilenDersAdi,
          harfDegeri: secilenHarfDeger,
          krediDegeri: secilenKrediDeger);
      DataHelper.dersEkle(eklenecekDers);
      lessonName.clear();
      girilenDersAdi = '';
      setState(() {});
    }
  }
}
