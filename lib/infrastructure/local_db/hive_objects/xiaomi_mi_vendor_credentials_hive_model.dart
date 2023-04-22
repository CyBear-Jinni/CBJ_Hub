import 'package:hive/hive.dart';

part 'xiaomi_mi_vendor_credentials_hive_model.g.dart';

@HiveType(typeId: 10)
class XiaomiMiVendorCredentialsHiveModel extends HiveObject {
  @HiveField(0)
  late String? senderUniqueId;
  @HiveField(1)
  late String xiaomiMiAccountEmail;
  @HiveField(2)
  late String xiaomiMiAccountPass;
}
