import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AppForm extends StatefulWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController kodeController,
      namaController,
      hargaController;

  AppForm(
      {required this.formkey,
        required this.kodeController,
        required this.namaController,
        required this.hargaController});

  @override
  AppFormState createState() => AppFormState();
}

class AppFormState extends State<AppForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      autovalidateMode: AutovalidateMode.always,
      child: SingleChildScrollView(
        child: Column(
          children: [
            txtKode(),
            txtNama(),
            txtHarga(),
          ],
        ),
      ),
    );
  }

  txtKode(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.kodeController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Student Name",
          prefixIcon: Icon(Icons.person), // Menambahkan ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Masukan Nama Anda.';
          }
          return null;
        },
      ),

    );
  }
  txtNama(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.namaController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Nama Barang",
          prefixIcon: Icon(Icons.person), // Menambahkan ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Masukan Nama Anda.';
          }
          return null;
        },
      ),

    );
  }
  txtHarga(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.hargaController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Harga Barang",
          prefixIcon: Icon(Icons.person), // Menambahkan ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Masukan Nama Anda.';
          }
          return null;
        },
      ),

    );
  }

}