import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:belajarmodul/models/api.dart';
import 'package:belajarmodul/produk/produk_edit.dart';
import 'package:belajarmodul/models/item.dart';

class ProdukDetail extends StatefulWidget {
  final ItemModel sw;
  ProdukDetail({required this.sw});

  @override
  State<StatefulWidget> createState() => ProdukDetailState();
}

class ProdukDetailState extends State<ProdukDetail> {
  void deleteItem(BuildContext context) async {
    final response = await http.post(
      Uri.parse(BaseUrl.hapus),
      body: {
        'id': widget.sw.id.toString(),
      },
    );
    final data = json.decode(response.body);
    if (data['success']) {
      showToast();
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: "Penghapusan Data Berhasil",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Hapus Data',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
          ),
          content: const Text('Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Row(
                children: const [
                  Icon(Icons.cancel, color: Colors.grey),
                  SizedBox(width: 5),
                  Text("Batal"),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                deleteItem(context);
              },
              child: Row(
                children: const [
                  Icon(Icons.delete, color: Colors.redAccent),
                  SizedBox(width: 5),
                  Text("Hapus"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Barang",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 4.0,
        actions: [
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            tooltip: 'Hapus Barang',
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
              icon: Icons.info,
              label: "ID Barang",
              value: '${widget.sw.id}',
              color: Colors.indigo,
            ),
            _buildDetailRow(
              icon: Icons.code,
              label: "Kode Barang",
              value: widget.sw.kode,
              color: Colors.amber,
            ),
            _buildDetailRow(
              icon: Icons.shopping_bag,
              label: "Nama Barang",
              value: widget.sw.nama,
              color: Colors.deepOrange,
            ),
            _buildDetailRow(
              icon: Icons.monetization_on,
              label: "Harga Barang",
              value: 'Rp ${widget.sw.harga}',
              color: Colors.green,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepOrange,
        hoverColor: Colors.green,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => ProdukEdit(sw: widget.sw)),
        ),
        icon: const Icon(Icons.edit, color: Colors.white),
        label: const Text("Edit"),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, size: 30, color: color),
        title: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
    );
  }
}
