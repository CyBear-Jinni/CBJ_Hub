import 'package:http/http.dart';

abstract class ShellyApiDeviceAbstract {
  ShellyApiDeviceAbstract({
    required this.lastKnownIp,
    required this.mDnsName,
    required this.hostName,
    this.name,
  }) {
    url = 'http://$lastKnownIp';
  }

  String lastKnownIp;
  String mDnsName;
  String hostName;
  String? name;
  late String url;

  Future<String> getStatus() async {
    final Response response = await get(Uri.parse('$url/status'));

    return response.body;
  }
}
