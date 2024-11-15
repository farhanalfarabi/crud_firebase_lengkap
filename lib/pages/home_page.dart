import 'package:flutter/material.dart';
import 'package:latihan_firebase_medium/models/buku_model.dart';
import 'package:latihan_firebase_medium/pages/tambah_data_page.dart';
import 'package:latihan_firebase_medium/pages/update_data.dart';
import 'package:latihan_firebase_medium/services/buku_service.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });

  final BukuService bukuService = BukuService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Data'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TambahDataPage()));
                },
                child: const Text("Tambah Data"))
          ],
        ),
        body: StreamBuilder(
          stream: bukuService.getAllData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (snapshot.connectionState == ConnectionState.active) {
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  BukuModel data = snapshot.data!.docs[index].data();
                  return ListTile(
                    title: Text(data.judulBuku),
                    subtitle: Text(data.penulis),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateDataPage(
                                            bukuId:
                                                snapshot.data!.docs[index].id,
                                          )));
                            }),
                        IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              bool? confirm = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                        "Anda yakin ingin menghapus data ini?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text("Batal")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                          child: const Text("Hapus")),
                                    ],
                                  );
                                },
                              );
                              if (confirm == true) {
                                bukuService
                                    .deleteBuku(snapshot.data!.docs[index].id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Data berhasil dihapus")));
                              }
                            }),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Text("Tidak ada data"),
            );
          },
        ));
  }
}
