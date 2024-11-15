import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latihan_firebase_medium/models/buku_model.dart';

import 'package:latihan_firebase_medium/services/buku_service.dart';

class UpdateDataPage extends StatefulWidget {
  final String bukuId;

  const UpdateDataPage({
    Key? key,
    required this.bukuId,
  }) : super(key: key);

  @override
  State<UpdateDataPage> createState() => _UpdateDataPageState();
}

class _UpdateDataPageState extends State<UpdateDataPage> {
  TextEditingController judulController = TextEditingController();

  TextEditingController penulisController = TextEditingController();

  TextEditingController jumlahController = TextEditingController();

  // inisialisasi sevice
  BukuService bukuService = BukuService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataBuku();
  }

  // fungsi untuk mengambil data buku
  Future<void> getDataBuku() async {
    // ambil data berdasarkan id
    final docSnapshot = await bukuService.getDataById(widget.bukuId);

    // jika data ada maka ubah isi controller
    if (docSnapshot.exists) {
      BukuModel buku = docSnapshot.data()!;
      setState(() {
        judulController.text = buku.judulBuku;
        penulisController.text = buku.penulis;
        jumlahController.text = buku.jumlahStokBuku.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Data'),
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

                    bukuService.updateBuku(widget.bukuId, buku).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Berhasil Update")));
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Update"))
            ],
          ),
        ));
  }
}
