import '../models/location.dart';
import '../models/user.dart';

abstract class IStorage {
  Stream<List<LocationModel>> getAllLocations(UserModel userModel);
  
  Future<bool> createUser(UserModel userModel);
  Future<bool> saveLocation(UserModel userModel, LocationModel location);
  Future<bool> deleteLocation(UserModel userModel, LocationModel location);
}
