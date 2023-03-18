import 'package:isar/isar.dart';

part 'lifx_vendor_credentials_isar_model.g.dart';

@collection
class LifxVendorCredentialsIsarModel {
  Id id = Isar.autoIncrement;

  late String? senderUniqueId;
  late String lifxApiKey;
  late String tuyaUserPassword;
  late String tuyaCountryCode;
  late String tuyaBizType;
  late String tuyaRegion;
  late String loginVendor;
}
