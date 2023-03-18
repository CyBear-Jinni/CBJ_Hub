import 'package:hive/hive.dart';

part 'lifx_vendor_credentials_hive_model.g.dart';

@HiveType(typeId: 8)
class LifxVendorCredentialsHiveModel extends HiveObject {
  @HiveField(0)
  late String? senderUniqueId;
  @HiveField(1)
  late String lifxApiKey;
}
