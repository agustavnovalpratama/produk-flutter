import 'package:flutter/material.dart';
import 'package:belajarmodul/produk/produk_detail.dart';
import 'package:belajarmodul/produk/produk_tambah.dart';
import 'package:belajarmodul/models/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:belajarmodul/models/item.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  late Future<List<ItemModel>> _productList;

  @override
  void initState() {
    super.initState();
    _productList = fetchProducts();
  }

  Future<List<ItemModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(BaseUrl.data));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    return items.map<ItemModel>((json) => ItemModel.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar Produk",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 3.0,
      ),
      body: Container(
        color: Colors.grey[100],
        child: FutureBuilder<List<ItemModel>>(
          future: _productList,
          builder: (BuildContext context, AsyncSnapshot<List<ItemModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada data produk'));
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey[300]),
              itemBuilder: (BuildContext context, int index) {
                final product = snapshot.data![index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.tealAccent[400],
                      child: Icon(Icons.shopping_cart, color: Colors.white),
                    ),
                    title: Text(
                      product.nama,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                    subtitle: Text(
                      "Rp ${product.harga.toString() ?? '0'}",
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[400], size: 20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProdukDetail(sw: product)),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        hoverColor: Colors.deepOrange,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProdukTambah()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
