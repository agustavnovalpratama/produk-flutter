import 'package:belajarmodul/ui/produk_detail.dart';
import 'package:flutter/material.dart';

class ProdukForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProdukFormState();
  }
}

class ProdukFormState extends State<ProdukForm> {
  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Produk'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textboxKodeProduk(),
              const SizedBox(height: 16),
              _textboxNamaProduk(),
              const SizedBox(height: 16),
              _textboxHargaProduk(),
              const SizedBox(height: 24),

              // Centering the button and adding padding
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(child: _tombolSimpan()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textboxKodeProduk() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Kode Produk",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      controller: _kodeProdukTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Kode Produk wajib diisi';
        }
        return null;
      },
    );
  }

  Widget _textboxNamaProduk() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama Produk",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama Produk wajib diisi';
        }
        return null;
      },
    );
  }

  Widget _textboxHargaProduk() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Harga Produk",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      controller: _hargaProdukTextboxController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Harga Produk wajib diisi';
        }
        if (int.tryParse(value) == null) {
          return 'Harga Produk harus berupa angka';
        }
        return null;
      },
    );
  }

  Widget _tombolSimpan() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          String kodeProduk = _kodeProdukTextboxController.text;
          String namaProduk = _namaProdukTextboxController.text;
          int harga = int.parse(_hargaProdukTextboxController.text);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProdukDetail(
                kodeProduk: kodeProduk,
                namaProduk: namaProduk,
                harga: harga,
              ),
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'Simpan',
        style: TextStyle(fontSize: 18,),
      ),
    );
  }
}
