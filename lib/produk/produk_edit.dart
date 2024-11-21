import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:belajarmodul/models/api.dart';
import 'package:http/http.dart' as http;
import 'package:belajarmodul/models/item.dart';
import 'form.dart';

class ProdukEdit extends StatefulWidget {
  final ItemModel sw;

  ProdukEdit({required this.sw});

  @override
  State<StatefulWidget> createState() => ProdukEditState();
}

class ProdukEditState extends State<ProdukEdit> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  late TextEditingController kodeController, namaController, hargaController;

  Future editSw() async {
    try {
      final response = await http.post(
        Uri.parse(BaseUrl.edit),
        body: {
          "id": widget.sw.id.toString(),
          "kode": kodeController.text,
          "nama": namaController.text,
          "harga": hargaController.text,
        },
      );

      if (response.statusCode != 200) {
        return null;
      }

      return json.decode(response.body);
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  void showToast(String message, {Color backgroundColor = Colors.greenAccent}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> _onConfirm(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      showToast("Please fill out all fields", backgroundColor: Colors.redAccent);
      return;
    }

    setState(() {
      isLoading = true;
    });

    final data = await editSw();
    setState(() {
      isLoading = false;
    });

    if (data == null) {
      showToast("Failed to update data. Please try again later.", backgroundColor: Colors.redAccent);
      return;
    }

    if (data['success']) {
      showToast("Perubahan data berhasil");
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    } else {
      showToast("Failed to update data. Please try again.", backgroundColor: Colors.redAccent);
    }
  }

  @override
  void initState() {
    kodeController = TextEditingController(text: widget.sw.kode);
    namaController = TextEditingController(text: widget.sw.nama);
    hargaController = TextEditingController(text: widget.sw.harga.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Barang",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 3.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: double.infinity,
            height: 55, // Fixed height for consistent look
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                padding: EdgeInsets.zero, // Remove extra padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: isLoading ? null : () => _onConfirm(context),
              child: isLoading
                  ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.save, color: Colors.white),
                  SizedBox(width: 8), // Adjust spacing
                  Text(
                    "Update",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              _buildTextField(
                controller: kodeController,
                label: "Kode Barang",
                icon: Icons.code,
                hint: "Masukkan kode barang",
                validator: (value) => value!.isEmpty ? "Kode Barang is required" : null,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: namaController,
                label: "Nama Barang",
                icon: Icons.shopping_bag,
                hint: "Masukkan nama barang",
                validator: (value) => value!.isEmpty ? "Nama Barang is required" : null,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: hargaController,
                label: "Harga Barang",
                icon: Icons.attach_money,
                hint: "Masukkan harga barang",
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Harga Barang is required" : null,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String hint = '',
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
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
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.teal),
          labelStyle: const TextStyle(fontSize: 16, color: Colors.teal),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
      ),
    );
  }
}
