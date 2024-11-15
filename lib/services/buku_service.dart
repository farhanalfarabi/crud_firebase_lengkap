import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latihan_firebase_medium/models/buku_model.dart';

// ! PATH Collection
const String collectionName = "rak-buku";

class BukuService {
  // ! instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ! Collection Reference
  late final CollectionReference<BukuModel> _rakBukuRef;

  // ! Constructor
  BukuService() {
    _rakBukuRef = _firestore
        .collection(collectionName)
        .withConverter<BukuModel>(
            fromFirestore: (snapshot, _) =>
                BukuModel.fromJson(snapshot.data()!),
            toFirestore: (rakBuku, _) => rakBuku.toJson());
  }

  // SERVICES

  // Add Buku
  Future<void> addBuku(BukuModel buku) async {
    await _rakBukuRef.add(buku);
  }

  // Get All Buku
  Stream<QuerySnapshot<BukuModel>> getAllData() {
    return _rakBukuRef.snapshots();
  }

  // Get Buku By Id
  Future<DocumentSnapshot<BukuModel>> getDataById(String id) async {
    return await _rakBukuRef.doc(id).get();
  }

  // Update Buku
  Future<void> updateBuku(String id, BukuModel buku) async {
    await _rakBukuRef.doc(id).update(buku.toJson());
  }

  // Delete Buku
  Future<void> deleteBuku(String id) async {
    await _rakBukuRef.doc(id).delete();
  }
}
