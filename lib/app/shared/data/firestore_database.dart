import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_app/app/shared/models/user.dart';

import '../models/location.dart';
import 'storage_interface.dart';

class FirestoreDatabase implements IStorage {
  final FirebaseFirestore _firestore;

  const FirestoreDatabase(this._firestore);

  @override
  Future<bool> createUser(UserModel userModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(userModel.uid)
          .set({'locations': []});
    } catch (_) {
      return false;
    }

    return true;
  }

  @override
  Future<List<String>> getAllLocations(UserModel userModel) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(userModel.uid).get();

    return documentSnapshot?.get('locations');
  }

  @override
  Future<bool> saveLocation(UserModel userModel, LocationModel location) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteLocation(UserModel userModel, LocationModel location) {
    // TODO: implement deleteLocation
    throw UnimplementedError();
  }
}
