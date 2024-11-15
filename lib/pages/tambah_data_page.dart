import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latihan_firebase_medium/models/buku_model.dart';
import 'package:latihan_firebase_medium/services/buku_service.dart';

// ignore: must_be_immutable
class TambahDataPage extends StatelessWidget {
  TambahDataPage({super.key});

  TextEditingController judulController = TextEditingController();
  TextEditingController penulisController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();

  // inisialisasi sevice
  BukuService bukuService = BukuService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Data'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: judulController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Judul Buku',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: penulisController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Penulis',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: jumlahController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Jumlah Stok',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    BukuModel buku = BukuModel(
                        judulBuku: judulController.text,
                        jumlahStokBuku: int.parse(jumlahController.text),
                        penulis: penulisController.text,
                        tanggalTerbit: DateTime.now());

                    bukuService.addBuku(buku).then((value) =>
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Data Berhasil Ditambahkan"))));

                    Navigator.pop(context);
                  },
                  child: const Text("Kirim"))
            ],
          ),
        ));
  }
}
