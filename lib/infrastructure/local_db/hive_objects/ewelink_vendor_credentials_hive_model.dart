import 'package:hive/hive.dart';

part 'ewelink_vendor_credentials_hive_model.g.dart';

@HiveType(typeId: 11)
class EwelinkVendorCredentialsHiveModel extends HiveObject {
  @HiveField(0)
  late String? senderUniqueId;
  @HiveField(1)
  late String ewelinkAccountEmail;
  @HiveField(2)
  late String ewelinkAccountPass;
}
