import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:belajarmodul/models/api.dart';
import 'package:http/http.dart' as http;

class ProdukTambah extends StatefulWidget {
  const ProdukTambah({super.key});
  @override
  State<StatefulWidget> createState() => ProdukTambahState();
}

class ProdukTambahState extends State<ProdukTambah> {
  final formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  Future createProduct() async {
    return await http.post(
      Uri.parse(BaseUrl.tambah),
      body: {
        'kode': kodeController.text,
        'nama': namaController.text,
        'harga': hargaController.text,
      },
    );
  }

  void _onConfirm(BuildContext context) async {
    // Validate the form
    if (formKey.currentState?.validate() ?? false) {
      final response = await createProduct();
      final data = json.decode(response.body);
      if (data['success']) {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tambah Produk",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 3.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey, // Assign the form key here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              _textboxKode(),
              _textboxNama(),
              _textboxHarga(),
              const SizedBox(height: 20.0),
              _tombolSimpan(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textboxKode() {
    return _buildTextField(
      controller: kodeController,
      label: "Kode Produk",
      icon: Icons.code,
      hint: "Masukkan kode produk",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Kode produk wajib diisi';
        }
        return null;
      },
    );
  }

  Widget _textboxNama() {
    return _buildTextField(
      controller: namaController,
      label: "Nama Produk",
      icon: Icons.shopping_bag,
      hint: "Masukkan nama produk",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama produk wajib diisi';
        }
        return null;
      },
    );
  }

  Widget _textboxHarga() {
    return _buildTextField(
      controller: hargaController,
      label: "Harga Produk",
      icon: Icons.price_check,
      hint: "Masukkan harga produk",
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Harga produk wajib diisi';
        }
        return null;
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.teal),
          border: InputBorder.none,
          labelStyle: const TextStyle(fontSize: 16, color: Colors.teal),
        ),
        validator: validator,
      ),
    );
  }

  Widget _tombolSimpan() {
    return ElevatedButton(
      onPressed: () {
        _onConfirm(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        elevation: 6.0,
        shadowColor: Colors.teal.withOpacity(0.4),
      ),
      child: const Text(
        'Simpan Produk',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
