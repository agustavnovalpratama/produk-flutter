class ItemModel {
  final int id;
  final String nama;
  final String kode;
  final String harga;


  ItemModel({
    required this.id,
    required this.nama,
    required this.kode,
    required this.harga,

  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    // Add null checks and default values if necessary
    return ItemModel(
      id: json['id'] ?? 0, // Default to 0 if id is not present
      nama: json['nama'] ?? '', // Default to empty string if nama is not present
      kode: json['kode'] ?? '',
      harga: json['harga'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama': nama,
    'kode': kode,
    'harga': harga,
  };
}