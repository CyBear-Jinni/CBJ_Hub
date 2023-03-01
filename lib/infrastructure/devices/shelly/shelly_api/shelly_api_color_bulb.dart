import 'dart:io';

import 'package:cbj_hub/infrastructure/devices/shelly/shelly_api/shelly_api_device_abstract.dart';

class ShellyApiColorBulb extends ShellyApiDeviceAbstract {
  ShellyApiColorBulb({
    required super.lastKnownIp,
    required super.mDnsName,
    required super.hostName,
    this.bulbeMode = ShellyBulbeMode.white,
  });

  // The mod of the bulb, an be white or color
  ShellyBulbeMode bulbeMode;

  Future<String> turnOn() async {
    final HttpClientRequest httpClientRequest =
        await HttpClient().getUrl(Uri.parse('$url/color/0?turn=on'));
    final HttpClientResponse response = await httpClientRequest.close();

    return response.reasonPhrase;
  }

  Future<String> turnOff() async {
    final HttpClientRequest httpClientRequest =
        await HttpClient().getUrl(Uri.parse('$url/color/0?turn=off'));
    final HttpClientResponse response = await httpClientRequest.close();

    return response.reasonPhrase;
  }

  Future<String> changeModeToWhite() async {
    bulbeMode = ShellyBulbeMode.white;
    final HttpClientRequest httpClientRequest =
        await HttpClient().getUrl(Uri.parse('$url/settings/?mode=white'));
    final HttpClientResponse response = await httpClientRequest.close();

    return response.reasonPhrase;
  }

  Future<String> changeModeToColor() async {
    bulbeMode = ShellyBulbeMode.colore;
    final HttpClientRequest httpClientRequest =
        await HttpClient().getUrl(Uri.parse('$url/settings/?mode=color'));
    final HttpClientResponse response = await httpClientRequest.close();

    return response.reasonPhrase;
  }

  /// Changing brightness alone called gain and it is 0-100.
  /// I think works only on color mode
  Future<String> changeBrightnessColorGain(String brightness) async {
    final HttpClientRequest httpClientRequest = await HttpClient()
        .getUrl(Uri.parse('$url/color/0?turn=on&gain=$brightness'));
    final HttpClientResponse response = await httpClientRequest.close();
    return response.reasonPhrase;
  }

  /// Change temperature
  Future<String> changTemperature({
    required String temperature,
  }) async {
    if (bulbeMode != ShellyBulbeMode.white) {
      await changeModeToWhite();
    }

    final HttpClientRequest httpClientRequest = await HttpClient().getUrl(
      Uri.parse(
        '$url/color/0?turn=on&temp=$temperature',
      ),
    );
    final HttpClientResponse response = await httpClientRequest.close();
    return response.reasonPhrase;
  }

  /// Chang brightness
  Future<String> changBrightness({
    required String brightness,
  }) async {
    HttpClientRequest httpClientRequest;

    switch (bulbeMode) {
      case ShellyBulbeMode.white:
        httpClientRequest = await HttpClient().getUrl(
          Uri.parse(
            '$url/color/0?turn=on&brightness=$brightness',
          ),
        );
        break;
      case ShellyBulbeMode.colore:
        httpClientRequest = await HttpClient().getUrl(
          Uri.parse(
            '$url/color/0?turn=on&gain=$brightness',
          ),
        );
        break;
    }

    final HttpClientResponse response = await httpClientRequest.close();
    return response.reasonPhrase;
  }

  /// Change color of the bulb, I think will also change to color mode
  Future<String> changeColor({
    required String red,
    required String green,
    required String blue,
    String white = "0",
  }) async {
    if (bulbeMode != ShellyBulbeMode.colore) {
      await changeModeToColor();
    }

    final HttpClientRequest httpClientRequest = await HttpClient().getUrl(
      Uri.parse(
        '$url/color/0?turn=on&red=$red&green=$green&blue=$blue&white=$white',
      ),
    );
    final HttpClientResponse response = await httpClientRequest.close();
    return response.reasonPhrase;
  }
}

enum ShellyBulbeMode { white, colore }
