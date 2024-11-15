
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

BukuModel bukuModelFromJson(String str) => BukuModel.fromJson(json.decode(str));

String bukuModelToJson(BukuModel data) => json.encode(data.toJson());

class BukuModel {
  final String judulBuku;
  final int jumlahStokBuku;
  final String penulis;
  final DateTime tanggalTerbit;

  BukuModel({
    required this.judulBuku,
    required this.jumlahStokBuku,
    required this.penulis,
    required this.tanggalTerbit,
  });

  factory BukuModel.fromJson(Map<String, dynamic> json) => BukuModel(
        judulBuku: json["judul_buku"] ?? "",
        jumlahStokBuku: json["jumlah_stok_buku"] ?? 0,
        penulis: json["penulis"] ?? "",
        tanggalTerbit: (json["tanggal_terbit"] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "judul_buku": judulBuku,
        "jumlah_stok_buku": jumlahStokBuku,
        "penulis": penulis,
        "tanggal_terbit": Timestamp.fromDate(tanggalTerbit),
      };
}
