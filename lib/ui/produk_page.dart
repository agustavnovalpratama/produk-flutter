import 'package:belajarmodul/ui/produk_detail.dart';
import 'package:belajarmodul/ui/produk_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProdukPage1 extends StatefulWidget {
  const ProdukPage1({Key? key}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Produk'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            // List 1
            ItemProduk(
              kodeProduk: "A001",
              namaProduk: "Kulkas",
              harga: 2500000,
            ),
            // List 2
            ItemProduk(
              kodeProduk: "A002",
              namaProduk: "TV",
              harga: 5000000,
            ),
            // List 3
            ItemProduk(
              kodeProduk: "A003",
              namaProduk: "Mesin Cuci",
              harga: 1500000,
            ),
          ],
        ),
      ),
      // Floating action button for adding new products
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProdukForm()));
        },
      ),
    );
  }
}

class ItemProduk extends StatelessWidget {
  final String? kodeProduk;
  final String? namaProduk;
  final int? harga;

  const ItemProduk({Key? key, this.kodeProduk, this.namaProduk, this.harga})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the price as currency
    final formattedHarga = harga != null
        ? NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
        .format(harga)
        : 'N/A';

    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.deepPurple,
            child: const Icon(
              Icons.shopping_bag,
              color: Colors.white,
            ),
          ),
          title: Text(
            namaProduk.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            formattedHarga,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.deepPurple,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(
              kodeProduk: kodeProduk,
              namaProduk: namaProduk,
              harga: harga,
            ),
          ),
        );
      },
    );
  }
}
