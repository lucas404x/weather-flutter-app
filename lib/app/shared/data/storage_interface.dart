import '../models/location.dart';
import '../models/user.dart';

abstract class IStorage {
  Future<bool> createUser(UserModel userModel);
  Future<List<String>> getAllLocations(UserModel userModel);
  Future<bool> saveLocation(UserModel userModel, LocationModel location);
  Future<bool> deleteLocation(UserModel userModel, LocationModel location);
}
