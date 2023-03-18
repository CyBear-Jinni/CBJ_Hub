import 'package:hive/hive.dart';

part 'esphome_vendor_credentials_hive_model.g.dart';

@HiveType(typeId: 9)
class EspHomeVendorCredentialsHiveModel extends HiveObject {
  @HiveField(0)
  late String? senderUniqueId;
  @HiveField(1)
  late String espHomeDevicePass;
}
