import 'package:cloud_firestore/cloud_firestore.dart';

import '../errors/storage_exception.dart';
import '../models/location.dart';
import '../models/user.dart';
import 'storage_interface.dart';

class FirestoreDatabase implements IStorage {
  final FirebaseFirestore _firestore;

  const FirestoreDatabase(this._firestore);

  @override
  Future<bool> createUser(UserModel userModel) async {
    int time = DateTime.now().millisecondsSinceEpoch;

    try {
      await _firestore
          .collection('users')
          .doc()
          .set({'timeWhenAccountWasCreatedSinceEpoch': time});
    } catch (e) {
      print(e);

      return false;
    }

    print(time);

    return true;
  }

  @override
  Stream<List<LocationModel>> getAllLocations(UserModel userModel) {
    Stream<DocumentSnapshot> documentSnapshotStream =
        _firestore.collection('users').doc(userModel.uid)?.snapshots();
    
    if (documentSnapshotStream == null) {
      throw UserDoesNotExists('The user does not exists on database.');
    }

    return documentSnapshotStream.asyncMap((docSnapshot) =>
        docSnapshot.data() == null
            ? null
            : _mappingDocSnapshotToListOfLocations(docSnapshot));
  }

  @override
  Future<bool> saveLocation(UserModel userModel, LocationModel location) async {
    DocumentReference documentReference =
        _firestore.collection('users').doc(userModel.uid);

    try {
      await documentReference.set(
          {location.locationKey: location.toMap()}, SetOptions(merge: true));
    } catch (NoSuchMethodError) {
      throw UserDoesNotExists('User not exists on database.');
    }

    return true;
  }

  @override
  Future<bool> deleteLocation(UserModel userModel, LocationModel location) {
    // TODO: implement deleteLocation
    throw UnimplementedError();
  }

  List<LocationModel> _mappingDocSnapshotToListOfLocations(
      DocumentSnapshot documentSnapshot) {
    List<LocationModel> locations = [];

    documentSnapshot.data().forEach((key, data) {
      if (key != 'timeWhenAccountWasCreatedSinceEpoch') {
        locations.add(LocationModel.fromMap(data));
      }
    });

    return locations;
  }
}
