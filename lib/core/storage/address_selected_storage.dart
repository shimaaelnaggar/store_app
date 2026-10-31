import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddressSelectionStorage {
  final FlutterSecureStorage storage;

  AddressSelectionStorage({required this.storage});

  Future<void> saveSelectedAddress({
    required String userId,
    required String addressId,
  }) async {
    await storage.write(
      key: 'selectedAddress_$userId',
      value: addressId,
    );
  }

  Future<String?> getSelectedAddress({
    required String userId,
  }) async {
    return await storage.read(
      key: 'selectedAddress_$userId',
    );
  }

  Future<void> clearSelectedAddress({
    required String userId,
  }) async {
    await storage.delete(
      key: 'selectedAddress_$userId',
    );
  }
}
