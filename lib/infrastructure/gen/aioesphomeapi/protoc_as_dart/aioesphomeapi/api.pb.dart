///
//  Generated code. Do not modify.
//  source: aioesphomeapi/api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'api_options.pb.dart' as $0;

import 'api.pbenum.dart';

export 'api.pbenum.dart';

class HelloRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HelloRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'clientInfo')
    ..hasRequiredFields = false
  ;

  HelloRequest._() : super();
  factory HelloRequest({
    $core.String? clientInfo,
  }) {
    final _result = create();
    if (clientInfo != null) {
      _result.clientInfo = clientInfo;
    }
    return _result;
  }
  factory HelloRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HelloRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HelloRequest clone() => HelloRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HelloRequest copyWith(void Function(HelloRequest) updates) => super.copyWith((message) => updates(message as HelloRequest)) as HelloRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HelloRequest create() => HelloRequest._();
  HelloRequest createEmptyInstance() => create();
  static $pb.PbList<HelloRequest> createRepeated() => $pb.PbList<HelloRequest>();
  @$core.pragma('dart2js:noInline')
  static HelloRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HelloRequest>(create);
  static HelloRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get clientInfo => $_getSZ(0);
  @$pb.TagNumber(1)
  set clientInfo($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClientInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientInfo() => clearField(1);
}

class HelloResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HelloResponse', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'apiVersionMajor', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'apiVersionMinor', $pb.PbFieldType.OU3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serverInfo')
    ..hasRequiredFields = false
  ;

  HelloResponse._() : super();
  factory HelloResponse({
    $core.int? apiVersionMajor,
    $core.int? apiVersionMinor,
    $core.String? serverInfo,
  }) {
    final _result = create();
    if (apiVersionMajor != null) {
      _result.apiVersionMajor = apiVersionMajor;
    }
    if (apiVersionMinor != null) {
      _result.apiVersionMinor = apiVersionMinor;
    }
    if (serverInfo != null) {
      _result.serverInfo = serverInfo;
    }
    return _result;
  }
  factory HelloResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HelloResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HelloResponse clone() => HelloResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HelloResponse copyWith(void Function(HelloResponse) updates) => super.copyWith((message) => updates(message as HelloResponse)) as HelloResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HelloResponse create() => HelloResponse._();
  HelloResponse createEmptyInstance() => create();
  static $pb.PbList<HelloResponse> createRepeated() => $pb.PbList<HelloResponse>();
  @$core.pragma('dart2js:noInline')
  static HelloResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HelloResponse>(create);
  static HelloResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get apiVersionMajor => $_getIZ(0);
  @$pb.TagNumber(1)
  set apiVersionMajor($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasApiVersionMajor() => $_has(0);
  @$pb.TagNumber(1)
  void clearApiVersionMajor() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get apiVersionMinor => $_getIZ(1);
  @$pb.TagNumber(2)
  set apiVersionMinor($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasApiVersionMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearApiVersionMinor() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get serverInfo => $_getSZ(2);
  @$pb.TagNumber(3)
  set serverInfo($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasServerInfo() => $_has(2);
  @$pb.TagNumber(3)
  void clearServerInfo() => clearField(3);
}

class ConnectRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'password')
    ..hasRequiredFields = false
  ;

  ConnectRequest._() : super();
  factory ConnectRequest({
    $core.String? password,
  }) {
    final _result = create();
    if (password != null) {
      _result.password = password;
    }
    return _result;
  }
  factory ConnectRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectRequest clone() => ConnectRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectRequest copyWith(void Function(ConnectRequest) updates) => super.copyWith((message) => updates(message as ConnectRequest)) as ConnectRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConnectRequest create() => ConnectRequest._();
  ConnectRequest createEmptyInstance() => create();
  static $pb.PbList<ConnectRequest> createRepeated() => $pb.PbList<ConnectRequest>();
  @$core.pragma('dart2js:noInline')
  static ConnectRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectRequest>(create);
  static ConnectRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get password => $_getSZ(0);
  @$pb.TagNumber(1)
  set password($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPassword() => $_has(0);
  @$pb.TagNumber(1)
  void clearPassword() => clearField(1);
}

class ConnectResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectResponse', createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'invalidPassword')
    ..hasRequiredFields = false
  ;

  ConnectResponse._() : super();
  factory ConnectResponse({
    $core.bool? invalidPassword,
  }) {
    final _result = create();
    if (invalidPassword != null) {
      _result.invalidPassword = invalidPassword;
    }
    return _result;
  }
  factory ConnectResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectResponse clone() => ConnectResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectResponse copyWith(void Function(ConnectResponse) updates) => super.copyWith((message) => updates(message as ConnectResponse)) as ConnectResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConnectResponse create() => ConnectResponse._();
  ConnectResponse createEmptyInstance() => create();
  static $pb.PbList<ConnectResponse> createRepeated() => $pb.PbList<ConnectResponse>();
  @$core.pragma('dart2js:noInline')
  static ConnectResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectResponse>(create);
  static ConnectResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get invalidPassword => $_getBF(0);
  @$pb.TagNumber(1)
  set invalidPassword($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvalidPassword() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvalidPassword() => clearField(1);
}

class DisconnectRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DisconnectRequest', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  DisconnectRequest._() : super();
  factory DisconnectRequest() => create();
  factory DisconnectRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisconnectRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisconnectRequest clone() => DisconnectRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisconnectRequest copyWith(void Function(DisconnectRequest) updates) => super.copyWith((message) => updates(message as DisconnectRequest)) as DisconnectRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DisconnectRequest create() => DisconnectRequest._();
  DisconnectRequest createEmptyInstance() => create();
  static $pb.PbList<DisconnectRequest> createRepeated() => $pb.PbList<DisconnectRequest>();
  @$core.pragma('dart2js:noInline')
  static DisconnectRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisconnectRequest>(create);
  static DisconnectRequest? _defaultInstance;
}

class DisconnectResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DisconnectResponse', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  DisconnectResponse._() : super();
  factory DisconnectResponse() => create();
  factory DisconnectResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisconnectResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisconnectResponse clone() => DisconnectResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisconnectResponse copyWith(void Function(DisconnectResponse) updates) => super.copyWith((message) => updates(message as DisconnectResponse)) as DisconnectResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DisconnectResponse create() => DisconnectResponse._();
  DisconnectResponse createEmptyInstance() => create();
  static $pb.PbList<DisconnectResponse> createRepeated() => $pb.PbList<DisconnectResponse>();
  @$core.pragma('dart2js:noInline')
  static DisconnectResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisconnectResponse>(create);
  static DisconnectResponse? _defaultInstance;
}

class PingRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PingRequest', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  PingRequest._() : super();
  factory PingRequest() => create();
  factory PingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PingRequest clone() => PingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PingRequest copyWith(void Function(PingRequest) updates) => super.copyWith((message) => updates(message as PingRequest)) as PingRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PingRequest create() => PingRequest._();
  PingRequest createEmptyInstance() => create();
  static $pb.PbList<PingRequest> createRepeated() => $pb.PbList<PingRequest>();
  @$core.pragma('dart2js:noInline')
  static PingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PingRequest>(create);
  static PingRequest? _defaultInstance;
}

class PingResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PingResponse', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  PingResponse._() : super();
  factory PingResponse() => create();
  factory PingResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PingResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PingResponse clone() => PingResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PingResponse copyWith(void Function(PingResponse) updates) => super.copyWith((message) => updates(message as PingResponse)) as PingResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PingResponse create() => PingResponse._();
  PingResponse createEmptyInstance() => create();
  static $pb.PbList<PingResponse> createRepeated() => $pb.PbList<PingResponse>();
  @$core.pragma('dart2js:noInline')
  static PingResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PingResponse>(create);
  static PingResponse? _defaultInstance;
}

class DeviceInfoRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeviceInfoRequest', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  DeviceInfoRequest._() : super();
  factory DeviceInfoRequest() => create();
  factory DeviceInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeviceInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeviceInfoRequest clone() => DeviceInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeviceInfoRequest copyWith(void Function(DeviceInfoRequest) updates) => super.copyWith((message) => updates(message as DeviceInfoRequest)) as DeviceInfoRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeviceInfoRequest create() => DeviceInfoRequest._();
  DeviceInfoRequest createEmptyInstance() => create();
  static $pb.PbList<DeviceInfoRequest> createRepeated() => $pb.PbList<DeviceInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static DeviceInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeviceInfoRequest>(create);
  static DeviceInfoRequest? _defaultInstance;
}

class DeviceInfoResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeviceInfoResponse', createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'usesPassword')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'macAddress')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'esphomeVersion')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'compilationTime')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'model')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasDeepSleep')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'projectName')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'projectVersion')
    ..hasRequiredFields = false
  ;

  DeviceInfoResponse._() : super();
  factory DeviceInfoResponse({
    $core.bool? usesPassword,
    $core.String? name,
    $core.String? macAddress,
    $core.String? esphomeVersion,
    $core.String? compilationTime,
    $core.String? model,
    $core.bool? hasDeepSleep,
    $core.String? projectName,
    $core.String? projectVersion,
  }) {
    final _result = create();
    if (usesPassword != null) {
      _result.usesPassword = usesPassword;
    }
    if (name != null) {
      _result.name = name;
    }
    if (macAddress != null) {
      _result.macAddress = macAddress;
    }
    if (esphomeVersion != null) {
      _result.esphomeVersion = esphomeVersion;
    }
    if (compilationTime != null) {
      _result.compilationTime = compilationTime;
    }
    if (model != null) {
      _result.model = model;
    }
    if (hasDeepSleep != null) {
      _result.hasDeepSleep = hasDeepSleep;
    }
    if (projectName != null) {
      _result.projectName = projectName;
    }
    if (projectVersion != null) {
      _result.projectVersion = projectVersion;
    }
    return _result;
  }
  factory DeviceInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeviceInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeviceInfoResponse clone() => DeviceInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeviceInfoResponse copyWith(void Function(DeviceInfoResponse) updates) => super.copyWith((message) => updates(message as DeviceInfoResponse)) as DeviceInfoResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeviceInfoResponse create() => DeviceInfoResponse._();
  DeviceInfoResponse createEmptyInstance() => create();
  static $pb.PbList<DeviceInfoResponse> createRepeated() => $pb.PbList<DeviceInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static DeviceInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeviceInfoResponse>(create);
  static DeviceInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get usesPassword => $_getBF(0);
  @$pb.TagNumber(1)
  set usesPassword($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsesPassword() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsesPassword() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get macAddress => $_getSZ(2);
  @$pb.TagNumber(3)
  set macAddress($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMacAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearMacAddress() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get esphomeVersion => $_getSZ(3);
  @$pb.TagNumber(4)
  set esphomeVersion($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEsphomeVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearEsphomeVersion() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get compilationTime => $_getSZ(4);
  @$pb.TagNumber(5)
  set compilationTime($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCompilationTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearCompilationTime() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get model => $_getSZ(5);
  @$pb.TagNumber(6)
  set model($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasModel() => $_has(5);
  @$pb.TagNumber(6)
  void clearModel() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get hasDeepSleep => $_getBF(6);
  @$pb.TagNumber(7)
  set hasDeepSleep($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasHasDeepSleep() => $_has(6);
  @$pb.TagNumber(7)
  void clearHasDeepSleep() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get projectName => $_getSZ(7);
  @$pb.TagNumber(8)
  set projectName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasProjectName() => $_has(7);
  @$pb.TagNumber(8)
  void clearProjectName() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get projectVersion => $_getSZ(8);
  @$pb.TagNumber(9)
  set projectVersion($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasProjectVersion() => $_has(8);
  @$pb.TagNumber(9)
  void clearProjectVersion() => clearField(9);
}

class ListEntitiesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEntitiesRequest', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ListEntitiesRequest._() : super();
  factory ListEntitiesRequest() => create();
  factory ListEntitiesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEntitiesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEntitiesRequest clone() => ListEntitiesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEntitiesRequest copyWith(void Function(ListEntitiesRequest) updates) => super.copyWith((message) => updates(message as ListEntitiesRequest)) as ListEntitiesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEntitiesRequest create() => ListEntitiesRequest._();
  ListEntitiesRequest createEmptyInstance() => create();
  static $pb.PbList<ListEntitiesRequest> createRepeated() => $pb.PbList<ListEntitiesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListEntitiesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEntitiesRequest>(create);
  static ListEntitiesRequest? _defaultInstance;
}

class ListEntitiesDoneResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEntitiesDoneResponse', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ListEntitiesDoneResponse._() : super();
  factory ListEntitiesDoneResponse() => create();
  factory ListEntitiesDoneResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEntitiesDoneResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEntitiesDoneResponse clone() => ListEntitiesDoneResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEntitiesDoneResponse copyWith(void Function(ListEntitiesDoneResponse) updates) => super.copyWith((message) => updates(message as ListEntitiesDoneResponse)) as ListEntitiesDoneResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEntitiesDoneResponse create() => ListEntitiesDoneResponse._();
  ListEntitiesDoneResponse createEmptyInstance() => create();
  static $pb.PbList<ListEntitiesDoneResponse> createRepeated() => $pb.PbList<ListEntitiesDoneResponse>();
  @$core.pragma('dart2js:noInline')
  static ListEntitiesDoneResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEntitiesDoneResponse>(create);
  static ListEntitiesDoneResponse? _defaultInstance;
}

class SubscribeStatesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubscribeStatesRequest', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SubscribeStatesRequest._() : super();
  factory SubscribeStatesRequest() => create();
  factory SubscribeStatesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeStatesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribeStatesRequest clone() => SubscribeStatesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribeStatesRequest copyWith(void Function(SubscribeStatesRequest) updates) => super.copyWith((message) => updates(message as SubscribeStatesRequest)) as SubscribeStatesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscribeStatesRequest create() => SubscribeStatesRequest._();
  SubscribeStatesRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeStatesRequest> createRepeated() => $pb.PbList<SubscribeStatesRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeStatesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeStatesRequest>(create);
  static SubscribeStatesRequest? _defaultInstance;
}

class ListEntitiesBinarySensorResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEntitiesBinarySensorResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'objectId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uniqueId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceClass')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isStatusBinarySensor')
    ..hasRequiredFields = false
  ;

  ListEntitiesBinarySensorResponse._() : super();
  factory ListEntitiesBinarySensorResponse({
    $core.String? objectId,
    $core.int? key,
    $core.String? name,
    $core.String? uniqueId,
    $core.String? deviceClass,
    $core.bool? isStatusBinarySensor,
  }) {
    final _result = create();
    if (objectId != null) {
      _result.objectId = objectId;
    }
    if (key != null) {
      _result.key = key;
    }
    if (name != null) {
      _result.name = name;
    }
    if (uniqueId != null) {
      _result.uniqueId = uniqueId;
    }
    if (deviceClass != null) {
      _result.deviceClass = deviceClass;
    }
    if (isStatusBinarySensor != null) {
      _result.isStatusBinarySensor = isStatusBinarySensor;
    }
    return _result;
  }
  factory ListEntitiesBinarySensorResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEntitiesBinarySensorResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEntitiesBinarySensorResponse clone() => ListEntitiesBinarySensorResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEntitiesBinarySensorResponse copyWith(void Function(ListEntitiesBinarySensorResponse) updates) => super.copyWith((message) => updates(message as ListEntitiesBinarySensorResponse)) as ListEntitiesBinarySensorResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEntitiesBinarySensorResponse create() => ListEntitiesBinarySensorResponse._();
  ListEntitiesBinarySensorResponse createEmptyInstance() => create();
  static $pb.PbList<ListEntitiesBinarySensorResponse> createRepeated() => $pb.PbList<ListEntitiesBinarySensorResponse>();
  @$core.pragma('dart2js:noInline')
  static ListEntitiesBinarySensorResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEntitiesBinarySensorResponse>(create);
  static ListEntitiesBinarySensorResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get objectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set objectId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasObjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearObjectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get key => $_getIZ(1);
  @$pb.TagNumber(2)
  set key($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get uniqueId => $_getSZ(3);
  @$pb.TagNumber(4)
  set uniqueId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUniqueId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUniqueId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get deviceClass => $_getSZ(4);
  @$pb.TagNumber(5)
  set deviceClass($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDeviceClass() => $_has(4);
  @$pb.TagNumber(5)
  void clearDeviceClass() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isStatusBinarySensor => $_getBF(5);
  @$pb.TagNumber(6)
  set isStatusBinarySensor($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsStatusBinarySensor() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsStatusBinarySensor() => clearField(6);
}

class BinarySensorStateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BinarySensorStateResponse', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'missingState')
    ..hasRequiredFields = false
  ;

  BinarySensorStateResponse._() : super();
  factory BinarySensorStateResponse({
    $core.int? key,
    $core.bool? state,
    $core.bool? missingState,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (state != null) {
      _result.state = state;
    }
    if (missingState != null) {
      _result.missingState = missingState;
    }
    return _result;
  }
  factory BinarySensorStateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BinarySensorStateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BinarySensorStateResponse clone() => BinarySensorStateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BinarySensorStateResponse copyWith(void Function(BinarySensorStateResponse) updates) => super.copyWith((message) => updates(message as BinarySensorStateResponse)) as BinarySensorStateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BinarySensorStateResponse create() => BinarySensorStateResponse._();
  BinarySensorStateResponse createEmptyInstance() => create();
  static $pb.PbList<BinarySensorStateResponse> createRepeated() => $pb.PbList<BinarySensorStateResponse>();
  @$core.pragma('dart2js:noInline')
  static BinarySensorStateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BinarySensorStateResponse>(create);
  static BinarySensorStateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get state => $_getBF(1);
  @$pb.TagNumber(2)
  set state($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get missingState => $_getBF(2);
  @$pb.TagNumber(3)
  set missingState($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMissingState() => $_has(2);
  @$pb.TagNumber(3)
  void clearMissingState() => clearField(3);
}

class ListEntitiesCoverResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEntitiesCoverResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'objectId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uniqueId')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'assumedState')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsPosition')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsTilt')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceClass')
    ..hasRequiredFields = false
  ;

  ListEntitiesCoverResponse._() : super();
  factory ListEntitiesCoverResponse({
    $core.String? objectId,
    $core.int? key,
    $core.String? name,
    $core.String? uniqueId,
    $core.bool? assumedState,
    $core.bool? supportsPosition,
    $core.bool? supportsTilt,
    $core.String? deviceClass,
  }) {
    final _result = create();
    if (objectId != null) {
      _result.objectId = objectId;
    }
    if (key != null) {
      _result.key = key;
    }
    if (name != null) {
      _result.name = name;
    }
    if (uniqueId != null) {
      _result.uniqueId = uniqueId;
    }
    if (assumedState != null) {
      _result.assumedState = assumedState;
    }
    if (supportsPosition != null) {
      _result.supportsPosition = supportsPosition;
    }
    if (supportsTilt != null) {
      _result.supportsTilt = supportsTilt;
    }
    if (deviceClass != null) {
      _result.deviceClass = deviceClass;
    }
    return _result;
  }
  factory ListEntitiesCoverResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEntitiesCoverResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEntitiesCoverResponse clone() => ListEntitiesCoverResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEntitiesCoverResponse copyWith(void Function(ListEntitiesCoverResponse) updates) => super.copyWith((message) => updates(message as ListEntitiesCoverResponse)) as ListEntitiesCoverResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEntitiesCoverResponse create() => ListEntitiesCoverResponse._();
  ListEntitiesCoverResponse createEmptyInstance() => create();
  static $pb.PbList<ListEntitiesCoverResponse> createRepeated() => $pb.PbList<ListEntitiesCoverResponse>();
  @$core.pragma('dart2js:noInline')
  static ListEntitiesCoverResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEntitiesCoverResponse>(create);
  static ListEntitiesCoverResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get objectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set objectId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasObjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearObjectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get key => $_getIZ(1);
  @$pb.TagNumber(2)
  set key($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get uniqueId => $_getSZ(3);
  @$pb.TagNumber(4)
  set uniqueId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUniqueId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUniqueId() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get assumedState => $_getBF(4);
  @$pb.TagNumber(5)
  set assumedState($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAssumedState() => $_has(4);
  @$pb.TagNumber(5)
  void clearAssumedState() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get supportsPosition => $_getBF(5);
  @$pb.TagNumber(6)
  set supportsPosition($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSupportsPosition() => $_has(5);
  @$pb.TagNumber(6)
  void clearSupportsPosition() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get supportsTilt => $_getBF(6);
  @$pb.TagNumber(7)
  set supportsTilt($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSupportsTilt() => $_has(6);
  @$pb.TagNumber(7)
  void clearSupportsTilt() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get deviceClass => $_getSZ(7);
  @$pb.TagNumber(8)
  set deviceClass($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDeviceClass() => $_has(7);
  @$pb.TagNumber(8)
  void clearDeviceClass() => clearField(8);
}

class CoverStateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CoverStateResponse', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..e<LegacyCoverState>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'legacyState', $pb.PbFieldType.OE, defaultOrMaker: LegacyCoverState.LEGACY_COVER_STATE_OPEN, valueOf: LegacyCoverState.valueOf, enumValues: LegacyCoverState.values)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', $pb.PbFieldType.OF)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tilt', $pb.PbFieldType.OF)
    ..e<CoverOperation>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentOperation', $pb.PbFieldType.OE, defaultOrMaker: CoverOperation.COVER_OPERATION_IDLE, valueOf: CoverOperation.valueOf, enumValues: CoverOperation.values)
    ..hasRequiredFields = false
  ;

  CoverStateResponse._() : super();
  factory CoverStateResponse({
    $core.int? key,
    LegacyCoverState? legacyState,
    $core.double? position,
    $core.double? tilt,
    CoverOperation? currentOperation,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (legacyState != null) {
      _result.legacyState = legacyState;
    }
    if (position != null) {
      _result.position = position;
    }
    if (tilt != null) {
      _result.tilt = tilt;
    }
    if (currentOperation != null) {
      _result.currentOperation = currentOperation;
    }
    return _result;
  }
  factory CoverStateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CoverStateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CoverStateResponse clone() => CoverStateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CoverStateResponse copyWith(void Function(CoverStateResponse) updates) => super.copyWith((message) => updates(message as CoverStateResponse)) as CoverStateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CoverStateResponse create() => CoverStateResponse._();
  CoverStateResponse createEmptyInstance() => create();
  static $pb.PbList<CoverStateResponse> createRepeated() => $pb.PbList<CoverStateResponse>();
  @$core.pragma('dart2js:noInline')
  static CoverStateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CoverStateResponse>(create);
  static CoverStateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  LegacyCoverState get legacyState => $_getN(1);
  @$pb.TagNumber(2)
  set legacyState(LegacyCoverState v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasLegacyState() => $_has(1);
  @$pb.TagNumber(2)
  void clearLegacyState() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get position => $_getN(2);
  @$pb.TagNumber(3)
  set position($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPosition() => $_has(2);
  @$pb.TagNumber(3)
  void clearPosition() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get tilt => $_getN(3);
  @$pb.TagNumber(4)
  set tilt($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTilt() => $_has(3);
  @$pb.TagNumber(4)
  void clearTilt() => clearField(4);

  @$pb.TagNumber(5)
  CoverOperation get currentOperation => $_getN(4);
  @$pb.TagNumber(5)
  set currentOperation(CoverOperation v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrentOperation() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentOperation() => clearField(5);
}

class CoverCommandRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CoverCommandRequest', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasLegacyCommand')
    ..e<LegacyCoverCommand>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'legacyCommand', $pb.PbFieldType.OE, defaultOrMaker: LegacyCoverCommand.LEGACY_COVER_COMMAND_OPEN, valueOf: LegacyCoverCommand.valueOf, enumValues: LegacyCoverCommand.values)
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPosition')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'position', $pb.PbFieldType.OF)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasTilt')
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tilt', $pb.PbFieldType.OF)
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stop')
    ..hasRequiredFields = false
  ;

  CoverCommandRequest._() : super();
  factory CoverCommandRequest({
    $core.int? key,
    $core.bool? hasLegacyCommand,
    LegacyCoverCommand? legacyCommand_3,
    $core.bool? hasPosition,
    $core.double? position_5,
    $core.bool? hasTilt,
    $core.double? tilt_7,
    $core.bool? stop,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (hasLegacyCommand != null) {
      _result.hasLegacyCommand = hasLegacyCommand;
    }
    if (legacyCommand_3 != null) {
      _result.legacyCommand_3 = legacyCommand_3;
    }
    if (hasPosition != null) {
      _result.hasPosition = hasPosition;
    }
    if (position_5 != null) {
      _result.position_5 = position_5;
    }
    if (hasTilt != null) {
      _result.hasTilt = hasTilt;
    }
    if (tilt_7 != null) {
      _result.tilt_7 = tilt_7;
    }
    if (stop != null) {
      _result.stop = stop;
    }
    return _result;
  }
  factory CoverCommandRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CoverCommandRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CoverCommandRequest clone() => CoverCommandRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CoverCommandRequest copyWith(void Function(CoverCommandRequest) updates) => super.copyWith((message) => updates(message as CoverCommandRequest)) as CoverCommandRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CoverCommandRequest create() => CoverCommandRequest._();
  CoverCommandRequest createEmptyInstance() => create();
  static $pb.PbList<CoverCommandRequest> createRepeated() => $pb.PbList<CoverCommandRequest>();
  @$core.pragma('dart2js:noInline')
  static CoverCommandRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CoverCommandRequest>(create);
  static CoverCommandRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get hasLegacyCommand => $_getBF(1);
  @$pb.TagNumber(2)
  set hasLegacyCommand($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHasLegacyCommand() => $_has(1);
  @$pb.TagNumber(2)
  void clearHasLegacyCommand() => clearField(2);

  @$pb.TagNumber(3)
  LegacyCoverCommand get legacyCommand_3 => $_getN(2);
  @$pb.TagNumber(3)
  set legacyCommand_3(LegacyCoverCommand v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLegacyCommand_3() => $_has(2);
  @$pb.TagNumber(3)
  void clearLegacyCommand_3() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get hasPosition => $_getBF(3);
  @$pb.TagNumber(4)
  set hasPosition($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHasPosition() => $_has(3);
  @$pb.TagNumber(4)
  void clearHasPosition() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get position_5 => $_getN(4);
  @$pb.TagNumber(5)
  set position_5($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPosition_5() => $_has(4);
  @$pb.TagNumber(5)
  void clearPosition_5() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasTilt => $_getBF(5);
  @$pb.TagNumber(6)
  set hasTilt($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHasTilt() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasTilt() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get tilt_7 => $_getN(6);
  @$pb.TagNumber(7)
  set tilt_7($core.double v) { $_setFloat(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTilt_7() => $_has(6);
  @$pb.TagNumber(7)
  void clearTilt_7() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get stop => $_getBF(7);
  @$pb.TagNumber(8)
  set stop($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasStop() => $_has(7);
  @$pb.TagNumber(8)
  void clearStop() => clearField(8);
}

class ListEntitiesFanResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEntitiesFanResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'objectId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uniqueId')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsOscillation')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsSpeed')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsDirection')
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportedSpeedLevels', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ListEntitiesFanResponse._() : super();
  factory ListEntitiesFanResponse({
    $core.String? objectId,
    $core.int? key,
    $core.String? name,
    $core.String? uniqueId,
    $core.bool? supportsOscillation,
    $core.bool? supportsSpeed,
    $core.bool? supportsDirection,
    $core.int? supportedSpeedLevels,
  }) {
    final _result = create();
    if (objectId != null) {
      _result.objectId = objectId;
    }
    if (key != null) {
      _result.key = key;
    }
    if (name != null) {
      _result.name = name;
    }
    if (uniqueId != null) {
      _result.uniqueId = uniqueId;
    }
    if (supportsOscillation != null) {
      _result.supportsOscillation = supportsOscillation;
    }
    if (supportsSpeed != null) {
      _result.supportsSpeed = supportsSpeed;
    }
    if (supportsDirection != null) {
      _result.supportsDirection = supportsDirection;
    }
    if (supportedSpeedLevels != null) {
      _result.supportedSpeedLevels = supportedSpeedLevels;
    }
    return _result;
  }
  factory ListEntitiesFanResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEntitiesFanResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEntitiesFanResponse clone() => ListEntitiesFanResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEntitiesFanResponse copyWith(void Function(ListEntitiesFanResponse) updates) => super.copyWith((message) => updates(message as ListEntitiesFanResponse)) as ListEntitiesFanResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEntitiesFanResponse create() => ListEntitiesFanResponse._();
  ListEntitiesFanResponse createEmptyInstance() => create();
  static $pb.PbList<ListEntitiesFanResponse> createRepeated() => $pb.PbList<ListEntitiesFanResponse>();
  @$core.pragma('dart2js:noInline')
  static ListEntitiesFanResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEntitiesFanResponse>(create);
  static ListEntitiesFanResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get objectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set objectId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasObjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearObjectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get key => $_getIZ(1);
  @$pb.TagNumber(2)
  set key($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get uniqueId => $_getSZ(3);
  @$pb.TagNumber(4)
  set uniqueId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUniqueId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUniqueId() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get supportsOscillation => $_getBF(4);
  @$pb.TagNumber(5)
  set supportsOscillation($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSupportsOscillation() => $_has(4);
  @$pb.TagNumber(5)
  void clearSupportsOscillation() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get supportsSpeed => $_getBF(5);
  @$pb.TagNumber(6)
  set supportsSpeed($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSupportsSpeed() => $_has(5);
  @$pb.TagNumber(6)
  void clearSupportsSpeed() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get supportsDirection => $_getBF(6);
  @$pb.TagNumber(7)
  set supportsDirection($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSupportsDirection() => $_has(6);
  @$pb.TagNumber(7)
  void clearSupportsDirection() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get supportedSpeedLevels => $_getIZ(7);
  @$pb.TagNumber(8)
  set supportedSpeedLevels($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSupportedSpeedLevels() => $_has(7);
  @$pb.TagNumber(8)
  void clearSupportedSpeedLevels() => clearField(8);
}

class FanStateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FanStateResponse', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'oscillating')
    ..e<FanSpeed>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'speed', $pb.PbFieldType.OE, defaultOrMaker: FanSpeed.FAN_SPEED_LOW, valueOf: FanSpeed.valueOf, enumValues: FanSpeed.values)
    ..e<FanDirection>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: FanDirection.FAN_DIRECTION_FORWARD, valueOf: FanDirection.valueOf, enumValues: FanDirection.values)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'speedLevel', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  FanStateResponse._() : super();
  factory FanStateResponse({
    $core.int? key,
    $core.bool? state,
    $core.bool? oscillating,
  @$core.Deprecated('This field is deprecated.')
    FanSpeed? speed,
    FanDirection? direction,
    $core.int? speedLevel,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (state != null) {
      _result.state = state;
    }
    if (oscillating != null) {
      _result.oscillating = oscillating;
    }
    if (speed != null) {
      // ignore: deprecated_member_use_from_same_package
      _result.speed = speed;
    }
    if (direction != null) {
      _result.direction = direction;
    }
    if (speedLevel != null) {
      _result.speedLevel = speedLevel;
    }
    return _result;
  }
  factory FanStateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FanStateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FanStateResponse clone() => FanStateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FanStateResponse copyWith(void Function(FanStateResponse) updates) => super.copyWith((message) => updates(message as FanStateResponse)) as FanStateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FanStateResponse create() => FanStateResponse._();
  FanStateResponse createEmptyInstance() => create();
  static $pb.PbList<FanStateResponse> createRepeated() => $pb.PbList<FanStateResponse>();
  @$core.pragma('dart2js:noInline')
  static FanStateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FanStateResponse>(create);
  static FanStateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get state => $_getBF(1);
  @$pb.TagNumber(2)
  set state($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get oscillating => $_getBF(2);
  @$pb.TagNumber(3)
  set oscillating($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOscillating() => $_has(2);
  @$pb.TagNumber(3)
  void clearOscillating() => clearField(3);

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  FanSpeed get speed => $_getN(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  set speed(FanSpeed v) { setField(4, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  $core.bool hasSpeed() => $_has(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  void clearSpeed() => clearField(4);

  @$pb.TagNumber(5)
  FanDirection get direction => $_getN(4);
  @$pb.TagNumber(5)
  set direction(FanDirection v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDirection() => $_has(4);
  @$pb.TagNumber(5)
  void clearDirection() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get speedLevel => $_getIZ(5);
  @$pb.TagNumber(6)
  set speedLevel($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSpeedLevel() => $_has(5);
  @$pb.TagNumber(6)
  void clearSpeedLevel() => clearField(6);
}

class FanCommandRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FanCommandRequest', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasState')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasSpeed')
    ..e<FanSpeed>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'speed', $pb.PbFieldType.OE, defaultOrMaker: FanSpeed.FAN_SPEED_LOW, valueOf: FanSpeed.valueOf, enumValues: FanSpeed.values)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasOscillating')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'oscillating')
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasDirection')
    ..e<FanDirection>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: FanDirection.FAN_DIRECTION_FORWARD, valueOf: FanDirection.valueOf, enumValues: FanDirection.values)
    ..aOB(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasSpeedLevel')
    ..a<$core.int>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'speedLevel', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  FanCommandRequest._() : super();
  factory FanCommandRequest({
    $core.int? key,
    $core.bool? hasState,
    $core.bool? state_3,
  @$core.Deprecated('This field is deprecated.')
    $core.bool? hasSpeed,
  @$core.Deprecated('This field is deprecated.')
    FanSpeed? speed_5,
    $core.bool? hasOscillating,
    $core.bool? oscillating_7,
    $core.bool? hasDirection,
    FanDirection? direction_9,
    $core.bool? hasSpeedLevel,
    $core.int? speedLevel_11,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (hasState != null) {
      _result.hasState = hasState;
    }
    if (state_3 != null) {
      _result.state_3 = state_3;
    }
    if (hasSpeed != null) {
      // ignore: deprecated_member_use_from_same_package
      _result.hasSpeed = hasSpeed;
    }
    if (speed_5 != null) {
      // ignore: deprecated_member_use_from_same_package
      _result.speed_5 = speed_5;
    }
    if (hasOscillating != null) {
      _result.hasOscillating = hasOscillating;
    }
    if (oscillating_7 != null) {
      _result.oscillating_7 = oscillating_7;
    }
    if (hasDirection != null) {
      _result.hasDirection = hasDirection;
    }
    if (direction_9 != null) {
      _result.direction_9 = direction_9;
    }
    if (hasSpeedLevel != null) {
      _result.hasSpeedLevel = hasSpeedLevel;
    }
    if (speedLevel_11 != null) {
      _result.speedLevel_11 = speedLevel_11;
    }
    return _result;
  }
  factory FanCommandRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FanCommandRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FanCommandRequest clone() => FanCommandRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FanCommandRequest copyWith(void Function(FanCommandRequest) updates) => super.copyWith((message) => updates(message as FanCommandRequest)) as FanCommandRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FanCommandRequest create() => FanCommandRequest._();
  FanCommandRequest createEmptyInstance() => create();
  static $pb.PbList<FanCommandRequest> createRepeated() => $pb.PbList<FanCommandRequest>();
  @$core.pragma('dart2js:noInline')
  static FanCommandRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FanCommandRequest>(create);
  static FanCommandRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get hasState => $_getBF(1);
  @$pb.TagNumber(2)
  set hasState($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearHasState() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get state_3 => $_getBF(2);
  @$pb.TagNumber(3)
  set state_3($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasState_3() => $_has(2);
  @$pb.TagNumber(3)
  void clearState_3() => clearField(3);

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  $core.bool get hasSpeed => $_getBF(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  set hasSpeed($core.bool v) { $_setBool(3, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  $core.bool hasHasSpeed() => $_has(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  void clearHasSpeed() => clearField(4);

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  FanSpeed get speed_5 => $_getN(4);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  set speed_5(FanSpeed v) { setField(5, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  $core.bool hasSpeed_5() => $_has(4);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  void clearSpeed_5() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasOscillating => $_getBF(5);
  @$pb.TagNumber(6)
  set hasOscillating($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHasOscillating() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasOscillating() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get oscillating_7 => $_getBF(6);
  @$pb.TagNumber(7)
  set oscillating_7($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasOscillating_7() => $_has(6);
  @$pb.TagNumber(7)
  void clearOscillating_7() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get hasDirection => $_getBF(7);
  @$pb.TagNumber(8)
  set hasDirection($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasHasDirection() => $_has(7);
  @$pb.TagNumber(8)
  void clearHasDirection() => clearField(8);

  @$pb.TagNumber(9)
  FanDirection get direction_9 => $_getN(8);
  @$pb.TagNumber(9)
  set direction_9(FanDirection v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasDirection_9() => $_has(8);
  @$pb.TagNumber(9)
  void clearDirection_9() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get hasSpeedLevel => $_getBF(9);
  @$pb.TagNumber(10)
  set hasSpeedLevel($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasHasSpeedLevel() => $_has(9);
  @$pb.TagNumber(10)
  void clearHasSpeedLevel() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get speedLevel_11 => $_getIZ(10);
  @$pb.TagNumber(11)
  set speedLevel_11($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSpeedLevel_11() => $_has(10);
  @$pb.TagNumber(11)
  void clearSpeedLevel_11() => clearField(11);
}

class ListEntitiesLightResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEntitiesLightResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'objectId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uniqueId')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsBrightness')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsRgb')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsWhiteValue')
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsColorTemperature')
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minMireds', $pb.PbFieldType.OF)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxMireds', $pb.PbFieldType.OF)
    ..pPS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effects')
    ..hasRequiredFields = false
  ;

  ListEntitiesLightResponse._() : super();
  factory ListEntitiesLightResponse({
    $core.String? objectId,
    $core.int? key,
    $core.String? name,
    $core.String? uniqueId,
    $core.bool? supportsBrightness,
    $core.bool? supportsRgb,
    $core.bool? supportsWhiteValue,
    $core.bool? supportsColorTemperature,
    $core.double? minMireds,
    $core.double? maxMireds,
    $core.Iterable<$core.String>? effects,
  }) {
    final _result = create();
    if (objectId != null) {
      _result.objectId = objectId;
    }
    if (key != null) {
      _result.key = key;
    }
    if (name != null) {
      _result.name = name;
    }
    if (uniqueId != null) {
      _result.uniqueId = uniqueId;
    }
    if (supportsBrightness != null) {
      _result.supportsBrightness = supportsBrightness;
    }
    if (supportsRgb != null) {
      _result.supportsRgb = supportsRgb;
    }
    if (supportsWhiteValue != null) {
      _result.supportsWhiteValue = supportsWhiteValue;
    }
    if (supportsColorTemperature != null) {
      _result.supportsColorTemperature = supportsColorTemperature;
    }
    if (minMireds != null) {
      _result.minMireds = minMireds;
    }
    if (maxMireds != null) {
      _result.maxMireds = maxMireds;
    }
    if (effects != null) {
      _result.effects.addAll(effects);
    }
    return _result;
  }
  factory ListEntitiesLightResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEntitiesLightResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEntitiesLightResponse clone() => ListEntitiesLightResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEntitiesLightResponse copyWith(void Function(ListEntitiesLightResponse) updates) => super.copyWith((message) => updates(message as ListEntitiesLightResponse)) as ListEntitiesLightResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEntitiesLightResponse create() => ListEntitiesLightResponse._();
  ListEntitiesLightResponse createEmptyInstance() => create();
  static $pb.PbList<ListEntitiesLightResponse> createRepeated() => $pb.PbList<ListEntitiesLightResponse>();
  @$core.pragma('dart2js:noInline')
  static ListEntitiesLightResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEntitiesLightResponse>(create);
  static ListEntitiesLightResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get objectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set objectId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasObjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearObjectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get key => $_getIZ(1);
  @$pb.TagNumber(2)
  set key($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get uniqueId => $_getSZ(3);
  @$pb.TagNumber(4)
  set uniqueId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUniqueId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUniqueId() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get supportsBrightness => $_getBF(4);
  @$pb.TagNumber(5)
  set supportsBrightness($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSupportsBrightness() => $_has(4);
  @$pb.TagNumber(5)
  void clearSupportsBrightness() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get supportsRgb => $_getBF(5);
  @$pb.TagNumber(6)
  set supportsRgb($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSupportsRgb() => $_has(5);
  @$pb.TagNumber(6)
  void clearSupportsRgb() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get supportsWhiteValue => $_getBF(6);
  @$pb.TagNumber(7)
  set supportsWhiteValue($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSupportsWhiteValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearSupportsWhiteValue() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get supportsColorTemperature => $_getBF(7);
  @$pb.TagNumber(8)
  set supportsColorTemperature($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSupportsColorTemperature() => $_has(7);
  @$pb.TagNumber(8)
  void clearSupportsColorTemperature() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get minMireds => $_getN(8);
  @$pb.TagNumber(9)
  set minMireds($core.double v) { $_setFloat(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMinMireds() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinMireds() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get maxMireds => $_getN(9);
  @$pb.TagNumber(10)
  set maxMireds($core.double v) { $_setFloat(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMaxMireds() => $_has(9);
  @$pb.TagNumber(10)
  void clearMaxMireds() => clearField(10);

  @$pb.TagNumber(11)
  $core.List<$core.String> get effects => $_getList(10);
}

class LightStateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LightStateResponse', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brightness', $pb.PbFieldType.OF)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'red', $pb.PbFieldType.OF)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'green', $pb.PbFieldType.OF)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blue', $pb.PbFieldType.OF)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'white', $pb.PbFieldType.OF)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'colorTemperature', $pb.PbFieldType.OF)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effect')
    ..hasRequiredFields = false
  ;

  LightStateResponse._() : super();
  factory LightStateResponse({
    $core.int? key,
    $core.bool? state,
    $core.double? brightness,
    $core.double? red,
    $core.double? green,
    $core.double? blue,
    $core.double? white,
    $core.double? colorTemperature,
    $core.String? effect,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (state != null) {
      _result.state = state;
    }
    if (brightness != null) {
      _result.brightness = brightness;
    }
    if (red != null) {
      _result.red = red;
    }
    if (green != null) {
      _result.green = green;
    }
    if (blue != null) {
      _result.blue = blue;
    }
    if (white != null) {
      _result.white = white;
    }
    if (colorTemperature != null) {
      _result.colorTemperature = colorTemperature;
    }
    if (effect != null) {
      _result.effect = effect;
    }
    return _result;
  }
  factory LightStateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LightStateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LightStateResponse clone() => LightStateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LightStateResponse copyWith(void Function(LightStateResponse) updates) => super.copyWith((message) => updates(message as LightStateResponse)) as LightStateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LightStateResponse create() => LightStateResponse._();
  LightStateResponse createEmptyInstance() => create();
  static $pb.PbList<LightStateResponse> createRepeated() => $pb.PbList<LightStateResponse>();
  @$core.pragma('dart2js:noInline')
  static LightStateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LightStateResponse>(create);
  static LightStateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get state => $_getBF(1);
  @$pb.TagNumber(2)
  set state($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get brightness => $_getN(2);
  @$pb.TagNumber(3)
  set brightness($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBrightness() => $_has(2);
  @$pb.TagNumber(3)
  void clearBrightness() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get red => $_getN(3);
  @$pb.TagNumber(4)
  set red($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRed() => $_has(3);
  @$pb.TagNumber(4)
  void clearRed() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get green => $_getN(4);
  @$pb.TagNumber(5)
  set green($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasGreen() => $_has(4);
  @$pb.TagNumber(5)
  void clearGreen() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get blue => $_getN(5);
  @$pb.TagNumber(6)
  set blue($core.double v) { $_setFloat(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBlue() => $_has(5);
  @$pb.TagNumber(6)
  void clearBlue() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get white => $_getN(6);
  @$pb.TagNumber(7)
  set white($core.double v) { $_setFloat(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasWhite() => $_has(6);
  @$pb.TagNumber(7)
  void clearWhite() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get colorTemperature => $_getN(7);
  @$pb.TagNumber(8)
  set colorTemperature($core.double v) { $_setFloat(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasColorTemperature() => $_has(7);
  @$pb.TagNumber(8)
  void clearColorTemperature() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get effect => $_getSZ(8);
  @$pb.TagNumber(9)
  set effect($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasEffect() => $_has(8);
  @$pb.TagNumber(9)
  void clearEffect() => clearField(9);
}

class LightCommandRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LightCommandRequest', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasState')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasBrightness')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brightness', $pb.PbFieldType.OF)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasRgb')
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'red', $pb.PbFieldType.OF)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'green', $pb.PbFieldType.OF)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blue', $pb.PbFieldType.OF)
    ..aOB(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasWhite')
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'white', $pb.PbFieldType.OF)
    ..aOB(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasColorTemperature')
    ..a<$core.double>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'colorTemperature', $pb.PbFieldType.OF)
    ..aOB(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasTransitionLength')
    ..a<$core.int>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transitionLength', $pb.PbFieldType.OU3)
    ..aOB(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasFlashLength')
    ..a<$core.int>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'flashLength', $pb.PbFieldType.OU3)
    ..aOB(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasEffect')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'effect')
    ..hasRequiredFields = false
  ;

  LightCommandRequest._() : super();
  factory LightCommandRequest({
    $core.int? key,
    $core.bool? hasState,
    $core.bool? state_3,
    $core.bool? hasBrightness,
    $core.double? brightness_5,
    $core.bool? hasRgb,
    $core.double? red,
    $core.double? green,
    $core.double? blue,
    $core.bool? hasWhite,
    $core.double? white_11,
    $core.bool? hasColorTemperature,
    $core.double? colorTemperature_13,
    $core.bool? hasTransitionLength,
    $core.int? transitionLength_15,
    $core.bool? hasFlashLength,
    $core.int? flashLength_17,
    $core.bool? hasEffect,
    $core.String? effect_19,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (hasState != null) {
      _result.hasState = hasState;
    }
    if (state_3 != null) {
      _result.state_3 = state_3;
    }
    if (hasBrightness != null) {
      _result.hasBrightness = hasBrightness;
    }
    if (brightness_5 != null) {
      _result.brightness_5 = brightness_5;
    }
    if (hasRgb != null) {
      _result.hasRgb = hasRgb;
    }
    if (red != null) {
      _result.red = red;
    }
    if (green != null) {
      _result.green = green;
    }
    if (blue != null) {
      _result.blue = blue;
    }
    if (hasWhite != null) {
      _result.hasWhite = hasWhite;
    }
    if (white_11 != null) {
      _result.white_11 = white_11;
    }
    if (hasColorTemperature != null) {
      _result.hasColorTemperature = hasColorTemperature;
    }
    if (colorTemperature_13 != null) {
      _result.colorTemperature_13 = colorTemperature_13;
    }
    if (hasTransitionLength != null) {
      _result.hasTransitionLength = hasTransitionLength;
    }
    if (transitionLength_15 != null) {
      _result.transitionLength_15 = transitionLength_15;
    }
    if (hasFlashLength != null) {
      _result.hasFlashLength = hasFlashLength;
    }
    if (flashLength_17 != null) {
      _result.flashLength_17 = flashLength_17;
    }
    if (hasEffect != null) {
      _result.hasEffect = hasEffect;
    }
    if (effect_19 != null) {
      _result.effect_19 = effect_19;
    }
    return _result;
  }
  factory LightCommandRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LightCommandRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LightCommandRequest clone() => LightCommandRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LightCommandRequest copyWith(void Function(LightCommandRequest) updates) => super.copyWith((message) => updates(message as LightCommandRequest)) as LightCommandRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LightCommandRequest create() => LightCommandRequest._();
  LightCommandRequest createEmptyInstance() => create();
  static $pb.PbList<LightCommandRequest> createRepeated() => $pb.PbList<LightCommandRequest>();
  @$core.pragma('dart2js:noInline')
  static LightCommandRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LightCommandRequest>(create);
  static LightCommandRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get hasState => $_getBF(1);
  @$pb.TagNumber(2)
  set hasState($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearHasState() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get state_3 => $_getBF(2);
  @$pb.TagNumber(3)
  set state_3($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasState_3() => $_has(2);
  @$pb.TagNumber(3)
  void clearState_3() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get hasBrightness => $_getBF(3);
  @$pb.TagNumber(4)
  set hasBrightness($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHasBrightness() => $_has(3);
  @$pb.TagNumber(4)
  void clearHasBrightness() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get brightness_5 => $_getN(4);
  @$pb.TagNumber(5)
  set brightness_5($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBrightness_5() => $_has(4);
  @$pb.TagNumber(5)
  void clearBrightness_5() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasRgb => $_getBF(5);
  @$pb.TagNumber(6)
  set hasRgb($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHasRgb() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasRgb() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get red => $_getN(6);
  @$pb.TagNumber(7)
  set red($core.double v) { $_setFloat(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRed() => $_has(6);
  @$pb.TagNumber(7)
  void clearRed() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get green => $_getN(7);
  @$pb.TagNumber(8)
  set green($core.double v) { $_setFloat(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasGreen() => $_has(7);
  @$pb.TagNumber(8)
  void clearGreen() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get blue => $_getN(8);
  @$pb.TagNumber(9)
  set blue($core.double v) { $_setFloat(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasBlue() => $_has(8);
  @$pb.TagNumber(9)
  void clearBlue() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get hasWhite => $_getBF(9);
  @$pb.TagNumber(10)
  set hasWhite($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasHasWhite() => $_has(9);
  @$pb.TagNumber(10)
  void clearHasWhite() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get white_11 => $_getN(10);
  @$pb.TagNumber(11)
  set white_11($core.double v) { $_setFloat(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasWhite_11() => $_has(10);
  @$pb.TagNumber(11)
  void clearWhite_11() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get hasColorTemperature => $_getBF(11);
  @$pb.TagNumber(12)
  set hasColorTemperature($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasHasColorTemperature() => $_has(11);
  @$pb.TagNumber(12)
  void clearHasColorTemperature() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get colorTemperature_13 => $_getN(12);
  @$pb.TagNumber(13)
  set colorTemperature_13($core.double v) { $_setFloat(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasColorTemperature_13() => $_has(12);
  @$pb.TagNumber(13)
  void clearColorTemperature_13() => clearField(13);

  @$pb.TagNumber(14)
  $core.bool get hasTransitionLength => $_getBF(13);
  @$pb.TagNumber(14)
  set hasTransitionLength($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasHasTransitionLength() => $_has(13);
  @$pb.TagNumber(14)
  void clearHasTransitionLength() => clearField(14);

  @$pb.TagNumber(15)
  $core.int get transitionLength_15 => $_getIZ(14);
  @$pb.TagNumber(15)
  set transitionLength_15($core.int v) { $_setUnsignedInt32(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasTransitionLength_15() => $_has(14);
  @$pb.TagNumber(15)
  void clearTransitionLength_15() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get hasFlashLength => $_getBF(15);
  @$pb.TagNumber(16)
  set hasFlashLength($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasHasFlashLength() => $_has(15);
  @$pb.TagNumber(16)
  void clearHasFlashLength() => clearField(16);

  @$pb.TagNumber(17)
  $core.int get flashLength_17 => $_getIZ(16);
  @$pb.TagNumber(17)
  set flashLength_17($core.int v) { $_setUnsignedInt32(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasFlashLength_17() => $_has(16);
  @$pb.TagNumber(17)
  void clearFlashLength_17() => clearField(17);

  @$pb.TagNumber(18)
  $core.bool get hasEffect => $_getBF(17);
  @$pb.TagNumber(18)
  set hasEffect($core.bool v) { $_setBool(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasHasEffect() => $_has(17);
  @$pb.TagNumber(18)
  void clearHasEffect() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get effect_19 => $_getSZ(18);
  @$pb.TagNumber(19)
  set effect_19($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasEffect_19() => $_has(18);
  @$pb.TagNumber(19)
  void clearEffect_19() => clearField(19);
}

class ListEntitiesSensorResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEntitiesSensorResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'objectId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uniqueId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'icon')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'unitOfMeasurement')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accuracyDecimals', $pb.PbFieldType.O3)
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'forceUpdate')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceClass')
    ..e<SensorStateClass>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stateClass', $pb.PbFieldType.OE, defaultOrMaker: SensorStateClass.STATE_CLASS_NONE, valueOf: SensorStateClass.valueOf, enumValues: SensorStateClass.values)
    ..hasRequiredFields = false
  ;

  ListEntitiesSensorResponse._() : super();
  factory ListEntitiesSensorResponse({
    $core.String? objectId,
    $core.int? key,
    $core.String? name,
    $core.String? uniqueId,
    $core.String? icon,
    $core.String? unitOfMeasurement,
    $core.int? accuracyDecimals,
    $core.bool? forceUpdate,
    $core.String? deviceClass,
    SensorStateClass? stateClass,
  }) {
    final _result = create();
    if (objectId != null) {
      _result.objectId = objectId;
    }
    if (key != null) {
      _result.key = key;
    }
    if (name != null) {
      _result.name = name;
    }
    if (uniqueId != null) {
      _result.uniqueId = uniqueId;
    }
    if (icon != null) {
      _result.icon = icon;
    }
    if (unitOfMeasurement != null) {
      _result.unitOfMeasurement = unitOfMeasurement;
    }
    if (accuracyDecimals != null) {
      _result.accuracyDecimals = accuracyDecimals;
    }
    if (forceUpdate != null) {
      _result.forceUpdate = forceUpdate;
    }
    if (deviceClass != null) {
      _result.deviceClass = deviceClass;
    }
    if (stateClass != null) {
      _result.stateClass = stateClass;
    }
    return _result;
  }
  factory ListEntitiesSensorResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEntitiesSensorResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEntitiesSensorResponse clone() => ListEntitiesSensorResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEntitiesSensorResponse copyWith(void Function(ListEntitiesSensorResponse) updates) => super.copyWith((message) => updates(message as ListEntitiesSensorResponse)) as ListEntitiesSensorResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEntitiesSensorResponse create() => ListEntitiesSensorResponse._();
  ListEntitiesSensorResponse createEmptyInstance() => create();
  static $pb.PbList<ListEntitiesSensorResponse> createRepeated() => $pb.PbList<ListEntitiesSensorResponse>();
  @$core.pragma('dart2js:noInline')
  static ListEntitiesSensorResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEntitiesSensorResponse>(create);
  static ListEntitiesSensorResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get objectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set objectId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasObjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearObjectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get key => $_getIZ(1);
  @$pb.TagNumber(2)
  set key($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get uniqueId => $_getSZ(3);
  @$pb.TagNumber(4)
  set uniqueId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUniqueId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUniqueId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get icon => $_getSZ(4);
  @$pb.TagNumber(5)
  set icon($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIcon() => $_has(4);
  @$pb.TagNumber(5)
  void clearIcon() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get unitOfMeasurement => $_getSZ(5);
  @$pb.TagNumber(6)
  set unitOfMeasurement($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasUnitOfMeasurement() => $_has(5);
  @$pb.TagNumber(6)
  void clearUnitOfMeasurement() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get accuracyDecimals => $_getIZ(6);
  @$pb.TagNumber(7)
  set accuracyDecimals($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAccuracyDecimals() => $_has(6);
  @$pb.TagNumber(7)
  void clearAccuracyDecimals() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get forceUpdate => $_getBF(7);
  @$pb.TagNumber(8)
  set forceUpdate($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasForceUpdate() => $_has(7);
  @$pb.TagNumber(8)
  void clearForceUpdate() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get deviceClass => $_getSZ(8);
  @$pb.TagNumber(9)
  set deviceClass($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDeviceClass() => $_has(8);
  @$pb.TagNumber(9)
  void clearDeviceClass() => clearField(9);

  @$pb.TagNumber(10)
  SensorStateClass get stateClass => $_getN(9);
  @$pb.TagNumber(10)
  set stateClass(SensorStateClass v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasStateClass() => $_has(9);
  @$pb.TagNumber(10)
  void clearStateClass() => clearField(10);
}

class SensorStateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SensorStateResponse', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.OF)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'missingState')
    ..hasRequiredFields = false
  ;

  SensorStateResponse._() : super();
  factory SensorStateResponse({
    $core.int? key,
    $core.double? state,
    $core.bool? missingState,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (state != null) {
      _result.state = state;
    }
    if (missingState != null) {
      _result.missingState = missingState;
    }
    return _result;
  }
  factory SensorStateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SensorStateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SensorStateResponse clone() => SensorStateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SensorStateResponse copyWith(void Function(SensorStateResponse) updates) => super.copyWith((message) => updates(message as SensorStateResponse)) as SensorStateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SensorStateResponse create() => SensorStateResponse._();
  SensorStateResponse createEmptyInstance() => create();
  static $pb.PbList<SensorStateResponse> createRepeated() => $pb.PbList<SensorStateResponse>();
  @$core.pragma('dart2js:noInline')
  static SensorStateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SensorStateResponse>(create);
  static SensorStateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get state => $_getN(1);
  @$pb.TagNumber(2)
  set state($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get missingState => $_getBF(2);
  @$pb.TagNumber(3)
  set missingState($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMissingState() => $_has(2);
  @$pb.TagNumber(3)
  void clearMissingState() => clearField(3);
}

class ListEntitiesSwitchResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEntitiesSwitchResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'objectId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uniqueId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'icon')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'assumedState')
    ..hasRequiredFields = false
  ;

  ListEntitiesSwitchResponse._() : super();
  factory ListEntitiesSwitchResponse({
    $core.String? objectId,
    $core.int? key,
    $core.String? name,
    $core.String? uniqueId,
    $core.String? icon,
    $core.bool? assumedState,
  }) {
    final _result = create();
    if (objectId != null) {
      _result.objectId = objectId;
    }
    if (key != null) {
      _result.key = key;
    }
    if (name != null) {
      _result.name = name;
    }
    if (uniqueId != null) {
      _result.uniqueId = uniqueId;
    }
    if (icon != null) {
      _result.icon = icon;
    }
    if (assumedState != null) {
      _result.assumedState = assumedState;
    }
    return _result;
  }
  factory ListEntitiesSwitchResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEntitiesSwitchResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEntitiesSwitchResponse clone() => ListEntitiesSwitchResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEntitiesSwitchResponse copyWith(void Function(ListEntitiesSwitchResponse) updates) => super.copyWith((message) => updates(message as ListEntitiesSwitchResponse)) as ListEntitiesSwitchResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEntitiesSwitchResponse create() => ListEntitiesSwitchResponse._();
  ListEntitiesSwitchResponse createEmptyInstance() => create();
  static $pb.PbList<ListEntitiesSwitchResponse> createRepeated() => $pb.PbList<ListEntitiesSwitchResponse>();
  @$core.pragma('dart2js:noInline')
  static ListEntitiesSwitchResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEntitiesSwitchResponse>(create);
  static ListEntitiesSwitchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get objectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set objectId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasObjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearObjectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get key => $_getIZ(1);
  @$pb.TagNumber(2)
  set key($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get uniqueId => $_getSZ(3);
  @$pb.TagNumber(4)
  set uniqueId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUniqueId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUniqueId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get icon => $_getSZ(4);
  @$pb.TagNumber(5)
  set icon($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIcon() => $_has(4);
  @$pb.TagNumber(5)
  void clearIcon() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get assumedState => $_getBF(5);
  @$pb.TagNumber(6)
  set assumedState($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAssumedState() => $_has(5);
  @$pb.TagNumber(6)
  void clearAssumedState() => clearField(6);
}

class SwitchStateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SwitchStateResponse', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..hasRequiredFields = false
  ;

  SwitchStateResponse._() : super();
  factory SwitchStateResponse({
    $core.int? key,
    $core.bool? state,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (state != null) {
      _result.state = state;
    }
    return _result;
  }
  factory SwitchStateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SwitchStateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SwitchStateResponse clone() => SwitchStateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SwitchStateResponse copyWith(void Function(SwitchStateResponse) updates) => super.copyWith((message) => updates(message as SwitchStateResponse)) as SwitchStateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SwitchStateResponse create() => SwitchStateResponse._();
  SwitchStateResponse createEmptyInstance() => create();
  static $pb.PbList<SwitchStateResponse> createRepeated() => $pb.PbList<SwitchStateResponse>();
  @$core.pragma('dart2js:noInline')
  static SwitchStateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SwitchStateResponse>(create);
  static SwitchStateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get state => $_getBF(1);
  @$pb.TagNumber(2)
  set state($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);
}

class SwitchCommandRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SwitchCommandRequest', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..hasRequiredFields = false
  ;

  SwitchCommandRequest._() : super();
  factory SwitchCommandRequest({
    $core.int? key,
    $core.bool? state,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (state != null) {
      _result.state = state;
    }
    return _result;
  }
  factory SwitchCommandRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SwitchCommandRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SwitchCommandRequest clone() => SwitchCommandRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SwitchCommandRequest copyWith(void Function(SwitchCommandRequest) updates) => super.copyWith((message) => updates(message as SwitchCommandRequest)) as SwitchCommandRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SwitchCommandRequest create() => SwitchCommandRequest._();
  SwitchCommandRequest createEmptyInstance() => create();
  static $pb.PbList<SwitchCommandRequest> createRepeated() => $pb.PbList<SwitchCommandRequest>();
  @$core.pragma('dart2js:noInline')
  static SwitchCommandRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SwitchCommandRequest>(create);
  static SwitchCommandRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get state => $_getBF(1);
  @$pb.TagNumber(2)
  set state($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);
}

class ListEntitiesTextSensorResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEntitiesTextSensorResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'objectId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uniqueId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'icon')
    ..hasRequiredFields = false
  ;

  ListEntitiesTextSensorResponse._() : super();
  factory ListEntitiesTextSensorResponse({
    $core.String? objectId,
    $core.int? key,
    $core.String? name,
    $core.String? uniqueId,
    $core.String? icon,
  }) {
    final _result = create();
    if (objectId != null) {
      _result.objectId = objectId;
    }
    if (key != null) {
      _result.key = key;
    }
    if (name != null) {
      _result.name = name;
    }
    if (uniqueId != null) {
      _result.uniqueId = uniqueId;
    }
    if (icon != null) {
      _result.icon = icon;
    }
    return _result;
  }
  factory ListEntitiesTextSensorResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEntitiesTextSensorResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEntitiesTextSensorResponse clone() => ListEntitiesTextSensorResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEntitiesTextSensorResponse copyWith(void Function(ListEntitiesTextSensorResponse) updates) => super.copyWith((message) => updates(message as ListEntitiesTextSensorResponse)) as ListEntitiesTextSensorResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEntitiesTextSensorResponse create() => ListEntitiesTextSensorResponse._();
  ListEntitiesTextSensorResponse createEmptyInstance() => create();
  static $pb.PbList<ListEntitiesTextSensorResponse> createRepeated() => $pb.PbList<ListEntitiesTextSensorResponse>();
  @$core.pragma('dart2js:noInline')
  static ListEntitiesTextSensorResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEntitiesTextSensorResponse>(create);
  static ListEntitiesTextSensorResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get objectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set objectId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasObjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearObjectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get key => $_getIZ(1);
  @$pb.TagNumber(2)
  set key($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get uniqueId => $_getSZ(3);
  @$pb.TagNumber(4)
  set uniqueId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUniqueId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUniqueId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get icon => $_getSZ(4);
  @$pb.TagNumber(5)
  set icon($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIcon() => $_has(4);
  @$pb.TagNumber(5)
  void clearIcon() => clearField(5);
}

class TextSensorStateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TextSensorStateResponse', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'missingState')
    ..hasRequiredFields = false
  ;

  TextSensorStateResponse._() : super();
  factory TextSensorStateResponse({
    $core.int? key,
    $core.String? state,
    $core.bool? missingState,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (state != null) {
      _result.state = state;
    }
    if (missingState != null) {
      _result.missingState = missingState;
    }
    return _result;
  }
  factory TextSensorStateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TextSensorStateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TextSensorStateResponse clone() => TextSensorStateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TextSensorStateResponse copyWith(void Function(TextSensorStateResponse) updates) => super.copyWith((message) => updates(message as TextSensorStateResponse)) as TextSensorStateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TextSensorStateResponse create() => TextSensorStateResponse._();
  TextSensorStateResponse createEmptyInstance() => create();
  static $pb.PbList<TextSensorStateResponse> createRepeated() => $pb.PbList<TextSensorStateResponse>();
  @$core.pragma('dart2js:noInline')
  static TextSensorStateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TextSensorStateResponse>(create);
  static TextSensorStateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get state => $_getSZ(1);
  @$pb.TagNumber(2)
  set state($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get missingState => $_getBF(2);
  @$pb.TagNumber(3)
  set missingState($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMissingState() => $_has(2);
  @$pb.TagNumber(3)
  void clearMissingState() => clearField(3);
}

class SubscribeLogsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubscribeLogsRequest', createEmptyInstance: create)
    ..e<LogLevel>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'level', $pb.PbFieldType.OE, defaultOrMaker: LogLevel.LOG_LEVEL_NONE, valueOf: LogLevel.valueOf, enumValues: LogLevel.values)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dumpConfig')
    ..hasRequiredFields = false
  ;

  SubscribeLogsRequest._() : super();
  factory SubscribeLogsRequest({
    LogLevel? level,
    $core.bool? dumpConfig,
  }) {
    final _result = create();
    if (level != null) {
      _result.level = level;
    }
    if (dumpConfig != null) {
      _result.dumpConfig = dumpConfig;
    }
    return _result;
  }
  factory SubscribeLogsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeLogsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribeLogsRequest clone() => SubscribeLogsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribeLogsRequest copyWith(void Function(SubscribeLogsRequest) updates) => super.copyWith((message) => updates(message as SubscribeLogsRequest)) as SubscribeLogsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscribeLogsRequest create() => SubscribeLogsRequest._();
  SubscribeLogsRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeLogsRequest> createRepeated() => $pb.PbList<SubscribeLogsRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeLogsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeLogsRequest>(create);
  static SubscribeLogsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  LogLevel get level => $_getN(0);
  @$pb.TagNumber(1)
  set level(LogLevel v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLevel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLevel() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get dumpConfig => $_getBF(1);
  @$pb.TagNumber(2)
  set dumpConfig($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDumpConfig() => $_has(1);
  @$pb.TagNumber(2)
  void clearDumpConfig() => clearField(2);
}

class SubscribeLogsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubscribeLogsResponse', createEmptyInstance: create)
    ..e<LogLevel>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'level', $pb.PbFieldType.OE, defaultOrMaker: LogLevel.LOG_LEVEL_NONE, valueOf: LogLevel.valueOf, enumValues: LogLevel.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tag')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sendFailed')
    ..hasRequiredFields = false
  ;

  SubscribeLogsResponse._() : super();
  factory SubscribeLogsResponse({
    LogLevel? level,
    $core.String? tag,
    $core.String? message,
    $core.bool? sendFailed,
  }) {
    final _result = create();
    if (level != null) {
      _result.level = level;
    }
    if (tag != null) {
      _result.tag = tag;
    }
    if (message != null) {
      _result.message = message;
    }
    if (sendFailed != null) {
      _result.sendFailed = sendFailed;
    }
    return _result;
  }
  factory SubscribeLogsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeLogsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribeLogsResponse clone() => SubscribeLogsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribeLogsResponse copyWith(void Function(SubscribeLogsResponse) updates) => super.copyWith((message) => updates(message as SubscribeLogsResponse)) as SubscribeLogsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscribeLogsResponse create() => SubscribeLogsResponse._();
  SubscribeLogsResponse createEmptyInstance() => create();
  static $pb.PbList<SubscribeLogsResponse> createRepeated() => $pb.PbList<SubscribeLogsResponse>();
  @$core.pragma('dart2js:noInline')
  static SubscribeLogsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeLogsResponse>(create);
  static SubscribeLogsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  LogLevel get level => $_getN(0);
  @$pb.TagNumber(1)
  set level(LogLevel v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLevel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLevel() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get tag => $_getSZ(1);
  @$pb.TagNumber(2)
  set tag($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTag() => $_has(1);
  @$pb.TagNumber(2)
  void clearTag() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get sendFailed => $_getBF(3);
  @$pb.TagNumber(4)
  set sendFailed($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSendFailed() => $_has(3);
  @$pb.TagNumber(4)
  void clearSendFailed() => clearField(4);
}

class SubscribeHomeassistantServicesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubscribeHomeassistantServicesRequest', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SubscribeHomeassistantServicesRequest._() : super();
  factory SubscribeHomeassistantServicesRequest() => create();
  factory SubscribeHomeassistantServicesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeHomeassistantServicesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribeHomeassistantServicesRequest clone() => SubscribeHomeassistantServicesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribeHomeassistantServicesRequest copyWith(void Function(SubscribeHomeassistantServicesRequest) updates) => super.copyWith((message) => updates(message as SubscribeHomeassistantServicesRequest)) as SubscribeHomeassistantServicesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscribeHomeassistantServicesRequest create() => SubscribeHomeassistantServicesRequest._();
  SubscribeHomeassistantServicesRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeHomeassistantServicesRequest> createRepeated() => $pb.PbList<SubscribeHomeassistantServicesRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeHomeassistantServicesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeHomeassistantServicesRequest>(create);
  static SubscribeHomeassistantServicesRequest? _defaultInstance;
}

class HomeassistantServiceMap extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HomeassistantServiceMap', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..hasRequiredFields = false
  ;

  HomeassistantServiceMap._() : super();
  factory HomeassistantServiceMap({
    $core.String? key,
    $core.String? value,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory HomeassistantServiceMap.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HomeassistantServiceMap.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HomeassistantServiceMap clone() => HomeassistantServiceMap()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HomeassistantServiceMap copyWith(void Function(HomeassistantServiceMap) updates) => super.copyWith((message) => updates(message as HomeassistantServiceMap)) as HomeassistantServiceMap; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HomeassistantServiceMap create() => HomeassistantServiceMap._();
  HomeassistantServiceMap createEmptyInstance() => create();
  static $pb.PbList<HomeassistantServiceMap> createRepeated() => $pb.PbList<HomeassistantServiceMap>();
  @$core.pragma('dart2js:noInline')
  static HomeassistantServiceMap getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HomeassistantServiceMap>(create);
  static HomeassistantServiceMap? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class HomeassistantServiceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HomeassistantServiceResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'service')
    ..pc<HomeassistantServiceMap>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', $pb.PbFieldType.PM, subBuilder: HomeassistantServiceMap.create)
    ..pc<HomeassistantServiceMap>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dataTemplate', $pb.PbFieldType.PM, subBuilder: HomeassistantServiceMap.create)
    ..pc<HomeassistantServiceMap>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'variables', $pb.PbFieldType.PM, subBuilder: HomeassistantServiceMap.create)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isEvent')
    ..hasRequiredFields = false
  ;

  HomeassistantServiceResponse._() : super();
  factory HomeassistantServiceResponse({
    $core.String? service,
    $core.Iterable<HomeassistantServiceMap>? data,
    $core.Iterable<HomeassistantServiceMap>? dataTemplate,
    $core.Iterable<HomeassistantServiceMap>? variables,
    $core.bool? isEvent,
  }) {
    final _result = create();
    if (service != null) {
      _result.service = service;
    }
    if (data != null) {
      _result.data.addAll(data);
    }
    if (dataTemplate != null) {
      _result.dataTemplate.addAll(dataTemplate);
    }
    if (variables != null) {
      _result.variables.addAll(variables);
    }
    if (isEvent != null) {
      _result.isEvent = isEvent;
    }
    return _result;
  }
  factory HomeassistantServiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HomeassistantServiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HomeassistantServiceResponse clone() => HomeassistantServiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HomeassistantServiceResponse copyWith(void Function(HomeassistantServiceResponse) updates) => super.copyWith((message) => updates(message as HomeassistantServiceResponse)) as HomeassistantServiceResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HomeassistantServiceResponse create() => HomeassistantServiceResponse._();
  HomeassistantServiceResponse createEmptyInstance() => create();
  static $pb.PbList<HomeassistantServiceResponse> createRepeated() => $pb.PbList<HomeassistantServiceResponse>();
  @$core.pragma('dart2js:noInline')
  static HomeassistantServiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HomeassistantServiceResponse>(create);
  static HomeassistantServiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get service => $_getSZ(0);
  @$pb.TagNumber(1)
  set service($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasService() => $_has(0);
  @$pb.TagNumber(1)
  void clearService() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<HomeassistantServiceMap> get data => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<HomeassistantServiceMap> get dataTemplate => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<HomeassistantServiceMap> get variables => $_getList(3);

  @$pb.TagNumber(5)
  $core.bool get isEvent => $_getBF(4);
  @$pb.TagNumber(5)
  set isEvent($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsEvent() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsEvent() => clearField(5);
}

class SubscribeHomeAssistantStatesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubscribeHomeAssistantStatesRequest', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SubscribeHomeAssistantStatesRequest._() : super();
  factory SubscribeHomeAssistantStatesRequest() => create();
  factory SubscribeHomeAssistantStatesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeHomeAssistantStatesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribeHomeAssistantStatesRequest clone() => SubscribeHomeAssistantStatesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribeHomeAssistantStatesRequest copyWith(void Function(SubscribeHomeAssistantStatesRequest) updates) => super.copyWith((message) => updates(message as SubscribeHomeAssistantStatesRequest)) as SubscribeHomeAssistantStatesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscribeHomeAssistantStatesRequest create() => SubscribeHomeAssistantStatesRequest._();
  SubscribeHomeAssistantStatesRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeHomeAssistantStatesRequest> createRepeated() => $pb.PbList<SubscribeHomeAssistantStatesRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeHomeAssistantStatesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeHomeAssistantStatesRequest>(create);
  static SubscribeHomeAssistantStatesRequest? _defaultInstance;
}

class SubscribeHomeAssistantStateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SubscribeHomeAssistantStateResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entityId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attribute')
    ..hasRequiredFields = false
  ;

  SubscribeHomeAssistantStateResponse._() : super();
  factory SubscribeHomeAssistantStateResponse({
    $core.String? entityId,
    $core.String? attribute,
  }) {
    final _result = create();
    if (entityId != null) {
      _result.entityId = entityId;
    }
    if (attribute != null) {
      _result.attribute = attribute;
    }
    return _result;
  }
  factory SubscribeHomeAssistantStateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeHomeAssistantStateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribeHomeAssistantStateResponse clone() => SubscribeHomeAssistantStateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribeHomeAssistantStateResponse copyWith(void Function(SubscribeHomeAssistantStateResponse) updates) => super.copyWith((message) => updates(message as SubscribeHomeAssistantStateResponse)) as SubscribeHomeAssistantStateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubscribeHomeAssistantStateResponse create() => SubscribeHomeAssistantStateResponse._();
  SubscribeHomeAssistantStateResponse createEmptyInstance() => create();
  static $pb.PbList<SubscribeHomeAssistantStateResponse> createRepeated() => $pb.PbList<SubscribeHomeAssistantStateResponse>();
  @$core.pragma('dart2js:noInline')
  static SubscribeHomeAssistantStateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeHomeAssistantStateResponse>(create);
  static SubscribeHomeAssistantStateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get entityId => $_getSZ(0);
  @$pb.TagNumber(1)
  set entityId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEntityId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntityId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get attribute => $_getSZ(1);
  @$pb.TagNumber(2)
  set attribute($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAttribute() => $_has(1);
  @$pb.TagNumber(2)
  void clearAttribute() => clearField(2);
}

class HomeAssistantStateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HomeAssistantStateResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entityId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attribute')
    ..hasRequiredFields = false
  ;

  HomeAssistantStateResponse._() : super();
  factory HomeAssistantStateResponse({
    $core.String? entityId,
    $core.String? state,
    $core.String? attribute,
  }) {
    final _result = create();
    if (entityId != null) {
      _result.entityId = entityId;
    }
    if (state != null) {
      _result.state = state;
    }
    if (attribute != null) {
      _result.attribute = attribute;
    }
    return _result;
  }
  factory HomeAssistantStateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HomeAssistantStateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HomeAssistantStateResponse clone() => HomeAssistantStateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HomeAssistantStateResponse copyWith(void Function(HomeAssistantStateResponse) updates) => super.copyWith((message) => updates(message as HomeAssistantStateResponse)) as HomeAssistantStateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HomeAssistantStateResponse create() => HomeAssistantStateResponse._();
  HomeAssistantStateResponse createEmptyInstance() => create();
  static $pb.PbList<HomeAssistantStateResponse> createRepeated() => $pb.PbList<HomeAssistantStateResponse>();
  @$core.pragma('dart2js:noInline')
  static HomeAssistantStateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HomeAssistantStateResponse>(create);
  static HomeAssistantStateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get entityId => $_getSZ(0);
  @$pb.TagNumber(1)
  set entityId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEntityId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntityId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get state => $_getSZ(1);
  @$pb.TagNumber(2)
  set state($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get attribute => $_getSZ(2);
  @$pb.TagNumber(3)
  set attribute($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAttribute() => $_has(2);
  @$pb.TagNumber(3)
  void clearAttribute() => clearField(3);
}

class GetTimeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTimeRequest', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetTimeRequest._() : super();
  factory GetTimeRequest() => create();
  factory GetTimeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTimeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTimeRequest clone() => GetTimeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTimeRequest copyWith(void Function(GetTimeRequest) updates) => super.copyWith((message) => updates(message as GetTimeRequest)) as GetTimeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTimeRequest create() => GetTimeRequest._();
  GetTimeRequest createEmptyInstance() => create();
  static $pb.PbList<GetTimeRequest> createRepeated() => $pb.PbList<GetTimeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTimeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTimeRequest>(create);
  static GetTimeRequest? _defaultInstance;
}

class GetTimeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTimeResponse', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'epochSeconds', $pb.PbFieldType.OF3)
    ..hasRequiredFields = false
  ;

  GetTimeResponse._() : super();
  factory GetTimeResponse({
    $core.int? epochSeconds,
  }) {
    final _result = create();
    if (epochSeconds != null) {
      _result.epochSeconds = epochSeconds;
    }
    return _result;
  }
  factory GetTimeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTimeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTimeResponse clone() => GetTimeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTimeResponse copyWith(void Function(GetTimeResponse) updates) => super.copyWith((message) => updates(message as GetTimeResponse)) as GetTimeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTimeResponse create() => GetTimeResponse._();
  GetTimeResponse createEmptyInstance() => create();
  static $pb.PbList<GetTimeResponse> createRepeated() => $pb.PbList<GetTimeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTimeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTimeResponse>(create);
  static GetTimeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get epochSeconds => $_getIZ(0);
  @$pb.TagNumber(1)
  set epochSeconds($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEpochSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpochSeconds() => clearField(1);
}

class ListEntitiesServicesArgument extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEntitiesServicesArgument', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..e<ServiceArgType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: ServiceArgType.SERVICE_ARG_TYPE_BOOL, valueOf: ServiceArgType.valueOf, enumValues: ServiceArgType.values)
    ..hasRequiredFields = false
  ;

  ListEntitiesServicesArgument._() : super();
  factory ListEntitiesServicesArgument({
    $core.String? name,
    ServiceArgType? type,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (type != null) {
      _result.type = type;
    }
    return _result;
  }
  factory ListEntitiesServicesArgument.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEntitiesServicesArgument.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEntitiesServicesArgument clone() => ListEntitiesServicesArgument()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEntitiesServicesArgument copyWith(void Function(ListEntitiesServicesArgument) updates) => super.copyWith((message) => updates(message as ListEntitiesServicesArgument)) as ListEntitiesServicesArgument; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEntitiesServicesArgument create() => ListEntitiesServicesArgument._();
  ListEntitiesServicesArgument createEmptyInstance() => create();
  static $pb.PbList<ListEntitiesServicesArgument> createRepeated() => $pb.PbList<ListEntitiesServicesArgument>();
  @$core.pragma('dart2js:noInline')
  static ListEntitiesServicesArgument getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEntitiesServicesArgument>(create);
  static ListEntitiesServicesArgument? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  ServiceArgType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(ServiceArgType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);
}

class ListEntitiesServicesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEntitiesServicesResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..pc<ListEntitiesServicesArgument>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'args', $pb.PbFieldType.PM, subBuilder: ListEntitiesServicesArgument.create)
    ..hasRequiredFields = false
  ;

  ListEntitiesServicesResponse._() : super();
  factory ListEntitiesServicesResponse({
    $core.String? name,
    $core.int? key,
    $core.Iterable<ListEntitiesServicesArgument>? args,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (key != null) {
      _result.key = key;
    }
    if (args != null) {
      _result.args.addAll(args);
    }
    return _result;
  }
  factory ListEntitiesServicesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEntitiesServicesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEntitiesServicesResponse clone() => ListEntitiesServicesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEntitiesServicesResponse copyWith(void Function(ListEntitiesServicesResponse) updates) => super.copyWith((message) => updates(message as ListEntitiesServicesResponse)) as ListEntitiesServicesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEntitiesServicesResponse create() => ListEntitiesServicesResponse._();
  ListEntitiesServicesResponse createEmptyInstance() => create();
  static $pb.PbList<ListEntitiesServicesResponse> createRepeated() => $pb.PbList<ListEntitiesServicesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListEntitiesServicesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEntitiesServicesResponse>(create);
  static ListEntitiesServicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get key => $_getIZ(1);
  @$pb.TagNumber(2)
  set key($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<ListEntitiesServicesArgument> get args => $_getList(2);
}

class ExecuteServiceArgument extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ExecuteServiceArgument', createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bool', protoName: 'bool_')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'legacyInt', $pb.PbFieldType.O3)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'float', $pb.PbFieldType.OF, protoName: 'float_')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'string', protoName: 'string_')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'int', $pb.PbFieldType.OS3, protoName: 'int_')
    ..p<$core.bool>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'boolArray', $pb.PbFieldType.PB)
    ..p<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'intArray', $pb.PbFieldType.PS3)
    ..p<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'floatArray', $pb.PbFieldType.PF)
    ..pPS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stringArray')
    ..hasRequiredFields = false
  ;

  ExecuteServiceArgument._() : super();
  factory ExecuteServiceArgument({
    $core.bool? bool_1,
    $core.int? legacyInt,
    $core.double? float,
    $core.String? string,
    $core.int? int_5,
    $core.Iterable<$core.bool>? boolArray,
    $core.Iterable<$core.int>? intArray,
    $core.Iterable<$core.double>? floatArray,
    $core.Iterable<$core.String>? stringArray,
  }) {
    final _result = create();
    if (bool_1 != null) {
      _result.bool_1 = bool_1;
    }
    if (legacyInt != null) {
      _result.legacyInt = legacyInt;
    }
    if (float != null) {
      _result.float = float;
    }
    if (string != null) {
      _result.string = string;
    }
    if (int_5 != null) {
      _result.int_5 = int_5;
    }
    if (boolArray != null) {
      _result.boolArray.addAll(boolArray);
    }
    if (intArray != null) {
      _result.intArray.addAll(intArray);
    }
    if (floatArray != null) {
      _result.floatArray.addAll(floatArray);
    }
    if (stringArray != null) {
      _result.stringArray.addAll(stringArray);
    }
    return _result;
  }
  factory ExecuteServiceArgument.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExecuteServiceArgument.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExecuteServiceArgument clone() => ExecuteServiceArgument()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExecuteServiceArgument copyWith(void Function(ExecuteServiceArgument) updates) => super.copyWith((message) => updates(message as ExecuteServiceArgument)) as ExecuteServiceArgument; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExecuteServiceArgument create() => ExecuteServiceArgument._();
  ExecuteServiceArgument createEmptyInstance() => create();
  static $pb.PbList<ExecuteServiceArgument> createRepeated() => $pb.PbList<ExecuteServiceArgument>();
  @$core.pragma('dart2js:noInline')
  static ExecuteServiceArgument getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExecuteServiceArgument>(create);
  static ExecuteServiceArgument? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get bool_1 => $_getBF(0);
  @$pb.TagNumber(1)
  set bool_1($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBool_1() => $_has(0);
  @$pb.TagNumber(1)
  void clearBool_1() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get legacyInt => $_getIZ(1);
  @$pb.TagNumber(2)
  set legacyInt($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLegacyInt() => $_has(1);
  @$pb.TagNumber(2)
  void clearLegacyInt() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get float => $_getN(2);
  @$pb.TagNumber(3)
  set float($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFloat() => $_has(2);
  @$pb.TagNumber(3)
  void clearFloat() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get string => $_getSZ(3);
  @$pb.TagNumber(4)
  set string($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasString() => $_has(3);
  @$pb.TagNumber(4)
  void clearString() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get int_5 => $_getIZ(4);
  @$pb.TagNumber(5)
  set int_5($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasInt_5() => $_has(4);
  @$pb.TagNumber(5)
  void clearInt_5() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.bool> get boolArray => $_getList(5);

  @$pb.TagNumber(7)
  $core.List<$core.int> get intArray => $_getList(6);

  @$pb.TagNumber(8)
  $core.List<$core.double> get floatArray => $_getList(7);

  @$pb.TagNumber(9)
  $core.List<$core.String> get stringArray => $_getList(8);
}

class ExecuteServiceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ExecuteServiceRequest', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..pc<ExecuteServiceArgument>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'args', $pb.PbFieldType.PM, subBuilder: ExecuteServiceArgument.create)
    ..hasRequiredFields = false
  ;

  ExecuteServiceRequest._() : super();
  factory ExecuteServiceRequest({
    $core.int? key,
    $core.Iterable<ExecuteServiceArgument>? args,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (args != null) {
      _result.args.addAll(args);
    }
    return _result;
  }
  factory ExecuteServiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExecuteServiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExecuteServiceRequest clone() => ExecuteServiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExecuteServiceRequest copyWith(void Function(ExecuteServiceRequest) updates) => super.copyWith((message) => updates(message as ExecuteServiceRequest)) as ExecuteServiceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExecuteServiceRequest create() => ExecuteServiceRequest._();
  ExecuteServiceRequest createEmptyInstance() => create();
  static $pb.PbList<ExecuteServiceRequest> createRepeated() => $pb.PbList<ExecuteServiceRequest>();
  @$core.pragma('dart2js:noInline')
  static ExecuteServiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExecuteServiceRequest>(create);
  static ExecuteServiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<ExecuteServiceArgument> get args => $_getList(1);
}

class ListEntitiesCameraResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEntitiesCameraResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'objectId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uniqueId')
    ..hasRequiredFields = false
  ;

  ListEntitiesCameraResponse._() : super();
  factory ListEntitiesCameraResponse({
    $core.String? objectId,
    $core.int? key,
    $core.String? name,
    $core.String? uniqueId,
  }) {
    final _result = create();
    if (objectId != null) {
      _result.objectId = objectId;
    }
    if (key != null) {
      _result.key = key;
    }
    if (name != null) {
      _result.name = name;
    }
    if (uniqueId != null) {
      _result.uniqueId = uniqueId;
    }
    return _result;
  }
  factory ListEntitiesCameraResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEntitiesCameraResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEntitiesCameraResponse clone() => ListEntitiesCameraResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEntitiesCameraResponse copyWith(void Function(ListEntitiesCameraResponse) updates) => super.copyWith((message) => updates(message as ListEntitiesCameraResponse)) as ListEntitiesCameraResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEntitiesCameraResponse create() => ListEntitiesCameraResponse._();
  ListEntitiesCameraResponse createEmptyInstance() => create();
  static $pb.PbList<ListEntitiesCameraResponse> createRepeated() => $pb.PbList<ListEntitiesCameraResponse>();
  @$core.pragma('dart2js:noInline')
  static ListEntitiesCameraResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEntitiesCameraResponse>(create);
  static ListEntitiesCameraResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get objectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set objectId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasObjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearObjectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get key => $_getIZ(1);
  @$pb.TagNumber(2)
  set key($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get uniqueId => $_getSZ(3);
  @$pb.TagNumber(4)
  set uniqueId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUniqueId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUniqueId() => clearField(4);
}

class CameraImageResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CameraImageResponse', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', $pb.PbFieldType.OY)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'done')
    ..hasRequiredFields = false
  ;

  CameraImageResponse._() : super();
  factory CameraImageResponse({
    $core.int? key,
    $core.List<$core.int>? data,
    $core.bool? done,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (data != null) {
      _result.data = data;
    }
    if (done != null) {
      _result.done = done;
    }
    return _result;
  }
  factory CameraImageResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CameraImageResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CameraImageResponse clone() => CameraImageResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CameraImageResponse copyWith(void Function(CameraImageResponse) updates) => super.copyWith((message) => updates(message as CameraImageResponse)) as CameraImageResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CameraImageResponse create() => CameraImageResponse._();
  CameraImageResponse createEmptyInstance() => create();
  static $pb.PbList<CameraImageResponse> createRepeated() => $pb.PbList<CameraImageResponse>();
  @$core.pragma('dart2js:noInline')
  static CameraImageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CameraImageResponse>(create);
  static CameraImageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get data => $_getN(1);
  @$pb.TagNumber(2)
  set data($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get done => $_getBF(2);
  @$pb.TagNumber(3)
  set done($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDone() => $_has(2);
  @$pb.TagNumber(3)
  void clearDone() => clearField(3);
}

class CameraImageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CameraImageRequest', createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'single')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stream')
    ..hasRequiredFields = false
  ;

  CameraImageRequest._() : super();
  factory CameraImageRequest({
    $core.bool? single,
    $core.bool? stream,
  }) {
    final _result = create();
    if (single != null) {
      _result.single = single;
    }
    if (stream != null) {
      _result.stream = stream;
    }
    return _result;
  }
  factory CameraImageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CameraImageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CameraImageRequest clone() => CameraImageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CameraImageRequest copyWith(void Function(CameraImageRequest) updates) => super.copyWith((message) => updates(message as CameraImageRequest)) as CameraImageRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CameraImageRequest create() => CameraImageRequest._();
  CameraImageRequest createEmptyInstance() => create();
  static $pb.PbList<CameraImageRequest> createRepeated() => $pb.PbList<CameraImageRequest>();
  @$core.pragma('dart2js:noInline')
  static CameraImageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CameraImageRequest>(create);
  static CameraImageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get single => $_getBF(0);
  @$pb.TagNumber(1)
  set single($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSingle() => $_has(0);
  @$pb.TagNumber(1)
  void clearSingle() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get stream => $_getBF(1);
  @$pb.TagNumber(2)
  set stream($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStream() => $_has(1);
  @$pb.TagNumber(2)
  void clearStream() => clearField(2);
}

class ListEntitiesClimateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEntitiesClimateResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'objectId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uniqueId')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsCurrentTemperature')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsTwoPointTargetTemperature')
    ..pc<ClimateMode>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportedModes', $pb.PbFieldType.KE, valueOf: ClimateMode.valueOf, enumValues: ClimateMode.values, defaultEnumValue: ClimateMode.CLIMATE_MODE_OFF)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'visualMinTemperature', $pb.PbFieldType.OF)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'visualMaxTemperature', $pb.PbFieldType.OF)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'visualTemperatureStep', $pb.PbFieldType.OF)
    ..aOB(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'legacySupportsAway')
    ..aOB(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportsAction')
    ..pc<ClimateFanMode>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportedFanModes', $pb.PbFieldType.KE, valueOf: ClimateFanMode.valueOf, enumValues: ClimateFanMode.values, defaultEnumValue: ClimateFanMode.CLIMATE_FAN_ON)
    ..pc<ClimateSwingMode>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportedSwingModes', $pb.PbFieldType.KE, valueOf: ClimateSwingMode.valueOf, enumValues: ClimateSwingMode.values, defaultEnumValue: ClimateSwingMode.CLIMATE_SWING_OFF)
    ..pPS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportedCustomFanModes')
    ..pc<ClimatePreset>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportedPresets', $pb.PbFieldType.KE, valueOf: ClimatePreset.valueOf, enumValues: ClimatePreset.values, defaultEnumValue: ClimatePreset.CLIMATE_PRESET_NONE)
    ..pPS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'supportedCustomPresets')
    ..hasRequiredFields = false
  ;

  ListEntitiesClimateResponse._() : super();
  factory ListEntitiesClimateResponse({
    $core.String? objectId,
    $core.int? key,
    $core.String? name,
    $core.String? uniqueId,
    $core.bool? supportsCurrentTemperature,
    $core.bool? supportsTwoPointTargetTemperature,
    $core.Iterable<ClimateMode>? supportedModes,
    $core.double? visualMinTemperature,
    $core.double? visualMaxTemperature,
    $core.double? visualTemperatureStep,
    $core.bool? legacySupportsAway,
    $core.bool? supportsAction,
    $core.Iterable<ClimateFanMode>? supportedFanModes,
    $core.Iterable<ClimateSwingMode>? supportedSwingModes,
    $core.Iterable<$core.String>? supportedCustomFanModes,
    $core.Iterable<ClimatePreset>? supportedPresets,
    $core.Iterable<$core.String>? supportedCustomPresets,
  }) {
    final _result = create();
    if (objectId != null) {
      _result.objectId = objectId;
    }
    if (key != null) {
      _result.key = key;
    }
    if (name != null) {
      _result.name = name;
    }
    if (uniqueId != null) {
      _result.uniqueId = uniqueId;
    }
    if (supportsCurrentTemperature != null) {
      _result.supportsCurrentTemperature = supportsCurrentTemperature;
    }
    if (supportsTwoPointTargetTemperature != null) {
      _result.supportsTwoPointTargetTemperature = supportsTwoPointTargetTemperature;
    }
    if (supportedModes != null) {
      _result.supportedModes.addAll(supportedModes);
    }
    if (visualMinTemperature != null) {
      _result.visualMinTemperature = visualMinTemperature;
    }
    if (visualMaxTemperature != null) {
      _result.visualMaxTemperature = visualMaxTemperature;
    }
    if (visualTemperatureStep != null) {
      _result.visualTemperatureStep = visualTemperatureStep;
    }
    if (legacySupportsAway != null) {
      _result.legacySupportsAway = legacySupportsAway;
    }
    if (supportsAction != null) {
      _result.supportsAction = supportsAction;
    }
    if (supportedFanModes != null) {
      _result.supportedFanModes.addAll(supportedFanModes);
    }
    if (supportedSwingModes != null) {
      _result.supportedSwingModes.addAll(supportedSwingModes);
    }
    if (supportedCustomFanModes != null) {
      _result.supportedCustomFanModes.addAll(supportedCustomFanModes);
    }
    if (supportedPresets != null) {
      _result.supportedPresets.addAll(supportedPresets);
    }
    if (supportedCustomPresets != null) {
      _result.supportedCustomPresets.addAll(supportedCustomPresets);
    }
    return _result;
  }
  factory ListEntitiesClimateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEntitiesClimateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEntitiesClimateResponse clone() => ListEntitiesClimateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEntitiesClimateResponse copyWith(void Function(ListEntitiesClimateResponse) updates) => super.copyWith((message) => updates(message as ListEntitiesClimateResponse)) as ListEntitiesClimateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEntitiesClimateResponse create() => ListEntitiesClimateResponse._();
  ListEntitiesClimateResponse createEmptyInstance() => create();
  static $pb.PbList<ListEntitiesClimateResponse> createRepeated() => $pb.PbList<ListEntitiesClimateResponse>();
  @$core.pragma('dart2js:noInline')
  static ListEntitiesClimateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEntitiesClimateResponse>(create);
  static ListEntitiesClimateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get objectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set objectId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasObjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearObjectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get key => $_getIZ(1);
  @$pb.TagNumber(2)
  set key($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get uniqueId => $_getSZ(3);
  @$pb.TagNumber(4)
  set uniqueId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUniqueId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUniqueId() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get supportsCurrentTemperature => $_getBF(4);
  @$pb.TagNumber(5)
  set supportsCurrentTemperature($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSupportsCurrentTemperature() => $_has(4);
  @$pb.TagNumber(5)
  void clearSupportsCurrentTemperature() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get supportsTwoPointTargetTemperature => $_getBF(5);
  @$pb.TagNumber(6)
  set supportsTwoPointTargetTemperature($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSupportsTwoPointTargetTemperature() => $_has(5);
  @$pb.TagNumber(6)
  void clearSupportsTwoPointTargetTemperature() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<ClimateMode> get supportedModes => $_getList(6);

  @$pb.TagNumber(8)
  $core.double get visualMinTemperature => $_getN(7);
  @$pb.TagNumber(8)
  set visualMinTemperature($core.double v) { $_setFloat(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasVisualMinTemperature() => $_has(7);
  @$pb.TagNumber(8)
  void clearVisualMinTemperature() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get visualMaxTemperature => $_getN(8);
  @$pb.TagNumber(9)
  set visualMaxTemperature($core.double v) { $_setFloat(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasVisualMaxTemperature() => $_has(8);
  @$pb.TagNumber(9)
  void clearVisualMaxTemperature() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get visualTemperatureStep => $_getN(9);
  @$pb.TagNumber(10)
  set visualTemperatureStep($core.double v) { $_setFloat(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasVisualTemperatureStep() => $_has(9);
  @$pb.TagNumber(10)
  void clearVisualTemperatureStep() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get legacySupportsAway => $_getBF(10);
  @$pb.TagNumber(11)
  set legacySupportsAway($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasLegacySupportsAway() => $_has(10);
  @$pb.TagNumber(11)
  void clearLegacySupportsAway() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get supportsAction => $_getBF(11);
  @$pb.TagNumber(12)
  set supportsAction($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasSupportsAction() => $_has(11);
  @$pb.TagNumber(12)
  void clearSupportsAction() => clearField(12);

  @$pb.TagNumber(13)
  $core.List<ClimateFanMode> get supportedFanModes => $_getList(12);

  @$pb.TagNumber(14)
  $core.List<ClimateSwingMode> get supportedSwingModes => $_getList(13);

  @$pb.TagNumber(15)
  $core.List<$core.String> get supportedCustomFanModes => $_getList(14);

  @$pb.TagNumber(16)
  $core.List<ClimatePreset> get supportedPresets => $_getList(15);

  @$pb.TagNumber(17)
  $core.List<$core.String> get supportedCustomPresets => $_getList(16);
}

class ClimateStateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClimateStateResponse', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..e<ClimateMode>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mode', $pb.PbFieldType.OE, defaultOrMaker: ClimateMode.CLIMATE_MODE_OFF, valueOf: ClimateMode.valueOf, enumValues: ClimateMode.values)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentTemperature', $pb.PbFieldType.OF)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetTemperature', $pb.PbFieldType.OF)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetTemperatureLow', $pb.PbFieldType.OF)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetTemperatureHigh', $pb.PbFieldType.OF)
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'legacyAway')
    ..e<ClimateAction>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'action', $pb.PbFieldType.OE, defaultOrMaker: ClimateAction.CLIMATE_ACTION_OFF, valueOf: ClimateAction.valueOf, enumValues: ClimateAction.values)
    ..e<ClimateFanMode>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fanMode', $pb.PbFieldType.OE, defaultOrMaker: ClimateFanMode.CLIMATE_FAN_ON, valueOf: ClimateFanMode.valueOf, enumValues: ClimateFanMode.values)
    ..e<ClimateSwingMode>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'swingMode', $pb.PbFieldType.OE, defaultOrMaker: ClimateSwingMode.CLIMATE_SWING_OFF, valueOf: ClimateSwingMode.valueOf, enumValues: ClimateSwingMode.values)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customFanMode')
    ..e<ClimatePreset>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preset', $pb.PbFieldType.OE, defaultOrMaker: ClimatePreset.CLIMATE_PRESET_NONE, valueOf: ClimatePreset.valueOf, enumValues: ClimatePreset.values)
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customPreset')
    ..hasRequiredFields = false
  ;

  ClimateStateResponse._() : super();
  factory ClimateStateResponse({
    $core.int? key,
    ClimateMode? mode,
    $core.double? currentTemperature,
    $core.double? targetTemperature,
    $core.double? targetTemperatureLow,
    $core.double? targetTemperatureHigh,
    $core.bool? legacyAway,
    ClimateAction? action,
    ClimateFanMode? fanMode,
    ClimateSwingMode? swingMode,
    $core.String? customFanMode,
    ClimatePreset? preset,
    $core.String? customPreset,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (mode != null) {
      _result.mode = mode;
    }
    if (currentTemperature != null) {
      _result.currentTemperature = currentTemperature;
    }
    if (targetTemperature != null) {
      _result.targetTemperature = targetTemperature;
    }
    if (targetTemperatureLow != null) {
      _result.targetTemperatureLow = targetTemperatureLow;
    }
    if (targetTemperatureHigh != null) {
      _result.targetTemperatureHigh = targetTemperatureHigh;
    }
    if (legacyAway != null) {
      _result.legacyAway = legacyAway;
    }
    if (action != null) {
      _result.action = action;
    }
    if (fanMode != null) {
      _result.fanMode = fanMode;
    }
    if (swingMode != null) {
      _result.swingMode = swingMode;
    }
    if (customFanMode != null) {
      _result.customFanMode = customFanMode;
    }
    if (preset != null) {
      _result.preset = preset;
    }
    if (customPreset != null) {
      _result.customPreset = customPreset;
    }
    return _result;
  }
  factory ClimateStateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClimateStateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClimateStateResponse clone() => ClimateStateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClimateStateResponse copyWith(void Function(ClimateStateResponse) updates) => super.copyWith((message) => updates(message as ClimateStateResponse)) as ClimateStateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClimateStateResponse create() => ClimateStateResponse._();
  ClimateStateResponse createEmptyInstance() => create();
  static $pb.PbList<ClimateStateResponse> createRepeated() => $pb.PbList<ClimateStateResponse>();
  @$core.pragma('dart2js:noInline')
  static ClimateStateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClimateStateResponse>(create);
  static ClimateStateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  ClimateMode get mode => $_getN(1);
  @$pb.TagNumber(2)
  set mode(ClimateMode v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearMode() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get currentTemperature => $_getN(2);
  @$pb.TagNumber(3)
  set currentTemperature($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrentTemperature() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentTemperature() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get targetTemperature => $_getN(3);
  @$pb.TagNumber(4)
  set targetTemperature($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTargetTemperature() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetTemperature() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get targetTemperatureLow => $_getN(4);
  @$pb.TagNumber(5)
  set targetTemperatureLow($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTargetTemperatureLow() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetTemperatureLow() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get targetTemperatureHigh => $_getN(5);
  @$pb.TagNumber(6)
  set targetTemperatureHigh($core.double v) { $_setFloat(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTargetTemperatureHigh() => $_has(5);
  @$pb.TagNumber(6)
  void clearTargetTemperatureHigh() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get legacyAway => $_getBF(6);
  @$pb.TagNumber(7)
  set legacyAway($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLegacyAway() => $_has(6);
  @$pb.TagNumber(7)
  void clearLegacyAway() => clearField(7);

  @$pb.TagNumber(8)
  ClimateAction get action => $_getN(7);
  @$pb.TagNumber(8)
  set action(ClimateAction v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasAction() => $_has(7);
  @$pb.TagNumber(8)
  void clearAction() => clearField(8);

  @$pb.TagNumber(9)
  ClimateFanMode get fanMode => $_getN(8);
  @$pb.TagNumber(9)
  set fanMode(ClimateFanMode v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasFanMode() => $_has(8);
  @$pb.TagNumber(9)
  void clearFanMode() => clearField(9);

  @$pb.TagNumber(10)
  ClimateSwingMode get swingMode => $_getN(9);
  @$pb.TagNumber(10)
  set swingMode(ClimateSwingMode v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasSwingMode() => $_has(9);
  @$pb.TagNumber(10)
  void clearSwingMode() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get customFanMode => $_getSZ(10);
  @$pb.TagNumber(11)
  set customFanMode($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCustomFanMode() => $_has(10);
  @$pb.TagNumber(11)
  void clearCustomFanMode() => clearField(11);

  @$pb.TagNumber(12)
  ClimatePreset get preset => $_getN(11);
  @$pb.TagNumber(12)
  set preset(ClimatePreset v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasPreset() => $_has(11);
  @$pb.TagNumber(12)
  void clearPreset() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get customPreset => $_getSZ(12);
  @$pb.TagNumber(13)
  set customPreset($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCustomPreset() => $_has(12);
  @$pb.TagNumber(13)
  void clearCustomPreset() => clearField(13);
}

class ClimateCommandRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ClimateCommandRequest', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasMode')
    ..e<ClimateMode>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mode', $pb.PbFieldType.OE, defaultOrMaker: ClimateMode.CLIMATE_MODE_OFF, valueOf: ClimateMode.valueOf, enumValues: ClimateMode.values)
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasTargetTemperature')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetTemperature', $pb.PbFieldType.OF)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasTargetTemperatureLow')
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetTemperatureLow', $pb.PbFieldType.OF)
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasTargetTemperatureHigh')
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetTemperatureHigh', $pb.PbFieldType.OF)
    ..aOB(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasLegacyAway')
    ..aOB(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'legacyAway')
    ..aOB(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasFanMode')
    ..e<ClimateFanMode>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fanMode', $pb.PbFieldType.OE, defaultOrMaker: ClimateFanMode.CLIMATE_FAN_ON, valueOf: ClimateFanMode.valueOf, enumValues: ClimateFanMode.values)
    ..aOB(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasSwingMode')
    ..e<ClimateSwingMode>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'swingMode', $pb.PbFieldType.OE, defaultOrMaker: ClimateSwingMode.CLIMATE_SWING_OFF, valueOf: ClimateSwingMode.valueOf, enumValues: ClimateSwingMode.values)
    ..aOB(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasCustomFanMode')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customFanMode')
    ..aOB(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPreset')
    ..e<ClimatePreset>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preset', $pb.PbFieldType.OE, defaultOrMaker: ClimatePreset.CLIMATE_PRESET_NONE, valueOf: ClimatePreset.valueOf, enumValues: ClimatePreset.values)
    ..aOB(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasCustomPreset')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customPreset')
    ..hasRequiredFields = false
  ;

  ClimateCommandRequest._() : super();
  factory ClimateCommandRequest({
    $core.int? key,
    $core.bool? hasMode,
    ClimateMode? mode_3,
    $core.bool? hasTargetTemperature,
    $core.double? targetTemperature_5,
    $core.bool? hasTargetTemperatureLow,
    $core.double? targetTemperatureLow_7,
    $core.bool? hasTargetTemperatureHigh,
    $core.double? targetTemperatureHigh_9,
    $core.bool? hasLegacyAway,
    $core.bool? legacyAway_11,
    $core.bool? hasFanMode,
    ClimateFanMode? fanMode_13,
    $core.bool? hasSwingMode,
    ClimateSwingMode? swingMode_15,
    $core.bool? hasCustomFanMode,
    $core.String? customFanMode_17,
    $core.bool? hasPreset,
    ClimatePreset? preset_19,
    $core.bool? hasCustomPreset,
    $core.String? customPreset_21,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (hasMode != null) {
      _result.hasMode = hasMode;
    }
    if (mode_3 != null) {
      _result.mode_3 = mode_3;
    }
    if (hasTargetTemperature != null) {
      _result.hasTargetTemperature = hasTargetTemperature;
    }
    if (targetTemperature_5 != null) {
      _result.targetTemperature_5 = targetTemperature_5;
    }
    if (hasTargetTemperatureLow != null) {
      _result.hasTargetTemperatureLow = hasTargetTemperatureLow;
    }
    if (targetTemperatureLow_7 != null) {
      _result.targetTemperatureLow_7 = targetTemperatureLow_7;
    }
    if (hasTargetTemperatureHigh != null) {
      _result.hasTargetTemperatureHigh = hasTargetTemperatureHigh;
    }
    if (targetTemperatureHigh_9 != null) {
      _result.targetTemperatureHigh_9 = targetTemperatureHigh_9;
    }
    if (hasLegacyAway != null) {
      _result.hasLegacyAway = hasLegacyAway;
    }
    if (legacyAway_11 != null) {
      _result.legacyAway_11 = legacyAway_11;
    }
    if (hasFanMode != null) {
      _result.hasFanMode = hasFanMode;
    }
    if (fanMode_13 != null) {
      _result.fanMode_13 = fanMode_13;
    }
    if (hasSwingMode != null) {
      _result.hasSwingMode = hasSwingMode;
    }
    if (swingMode_15 != null) {
      _result.swingMode_15 = swingMode_15;
    }
    if (hasCustomFanMode != null) {
      _result.hasCustomFanMode = hasCustomFanMode;
    }
    if (customFanMode_17 != null) {
      _result.customFanMode_17 = customFanMode_17;
    }
    if (hasPreset != null) {
      _result.hasPreset = hasPreset;
    }
    if (preset_19 != null) {
      _result.preset_19 = preset_19;
    }
    if (hasCustomPreset != null) {
      _result.hasCustomPreset = hasCustomPreset;
    }
    if (customPreset_21 != null) {
      _result.customPreset_21 = customPreset_21;
    }
    return _result;
  }
  factory ClimateCommandRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClimateCommandRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClimateCommandRequest clone() => ClimateCommandRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClimateCommandRequest copyWith(void Function(ClimateCommandRequest) updates) => super.copyWith((message) => updates(message as ClimateCommandRequest)) as ClimateCommandRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClimateCommandRequest create() => ClimateCommandRequest._();
  ClimateCommandRequest createEmptyInstance() => create();
  static $pb.PbList<ClimateCommandRequest> createRepeated() => $pb.PbList<ClimateCommandRequest>();
  @$core.pragma('dart2js:noInline')
  static ClimateCommandRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClimateCommandRequest>(create);
  static ClimateCommandRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get hasMode => $_getBF(1);
  @$pb.TagNumber(2)
  set hasMode($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHasMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearHasMode() => clearField(2);

  @$pb.TagNumber(3)
  ClimateMode get mode_3 => $_getN(2);
  @$pb.TagNumber(3)
  set mode_3(ClimateMode v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasMode_3() => $_has(2);
  @$pb.TagNumber(3)
  void clearMode_3() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get hasTargetTemperature => $_getBF(3);
  @$pb.TagNumber(4)
  set hasTargetTemperature($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHasTargetTemperature() => $_has(3);
  @$pb.TagNumber(4)
  void clearHasTargetTemperature() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get targetTemperature_5 => $_getN(4);
  @$pb.TagNumber(5)
  set targetTemperature_5($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTargetTemperature_5() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetTemperature_5() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasTargetTemperatureLow => $_getBF(5);
  @$pb.TagNumber(6)
  set hasTargetTemperatureLow($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHasTargetTemperatureLow() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasTargetTemperatureLow() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get targetTemperatureLow_7 => $_getN(6);
  @$pb.TagNumber(7)
  set targetTemperatureLow_7($core.double v) { $_setFloat(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTargetTemperatureLow_7() => $_has(6);
  @$pb.TagNumber(7)
  void clearTargetTemperatureLow_7() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get hasTargetTemperatureHigh => $_getBF(7);
  @$pb.TagNumber(8)
  set hasTargetTemperatureHigh($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasHasTargetTemperatureHigh() => $_has(7);
  @$pb.TagNumber(8)
  void clearHasTargetTemperatureHigh() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get targetTemperatureHigh_9 => $_getN(8);
  @$pb.TagNumber(9)
  set targetTemperatureHigh_9($core.double v) { $_setFloat(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTargetTemperatureHigh_9() => $_has(8);
  @$pb.TagNumber(9)
  void clearTargetTemperatureHigh_9() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get hasLegacyAway => $_getBF(9);
  @$pb.TagNumber(10)
  set hasLegacyAway($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasHasLegacyAway() => $_has(9);
  @$pb.TagNumber(10)
  void clearHasLegacyAway() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get legacyAway_11 => $_getBF(10);
  @$pb.TagNumber(11)
  set legacyAway_11($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasLegacyAway_11() => $_has(10);
  @$pb.TagNumber(11)
  void clearLegacyAway_11() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get hasFanMode => $_getBF(11);
  @$pb.TagNumber(12)
  set hasFanMode($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasHasFanMode() => $_has(11);
  @$pb.TagNumber(12)
  void clearHasFanMode() => clearField(12);

  @$pb.TagNumber(13)
  ClimateFanMode get fanMode_13 => $_getN(12);
  @$pb.TagNumber(13)
  set fanMode_13(ClimateFanMode v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasFanMode_13() => $_has(12);
  @$pb.TagNumber(13)
  void clearFanMode_13() => clearField(13);

  @$pb.TagNumber(14)
  $core.bool get hasSwingMode => $_getBF(13);
  @$pb.TagNumber(14)
  set hasSwingMode($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasHasSwingMode() => $_has(13);
  @$pb.TagNumber(14)
  void clearHasSwingMode() => clearField(14);

  @$pb.TagNumber(15)
  ClimateSwingMode get swingMode_15 => $_getN(14);
  @$pb.TagNumber(15)
  set swingMode_15(ClimateSwingMode v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasSwingMode_15() => $_has(14);
  @$pb.TagNumber(15)
  void clearSwingMode_15() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get hasCustomFanMode => $_getBF(15);
  @$pb.TagNumber(16)
  set hasCustomFanMode($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasHasCustomFanMode() => $_has(15);
  @$pb.TagNumber(16)
  void clearHasCustomFanMode() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get customFanMode_17 => $_getSZ(16);
  @$pb.TagNumber(17)
  set customFanMode_17($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasCustomFanMode_17() => $_has(16);
  @$pb.TagNumber(17)
  void clearCustomFanMode_17() => clearField(17);

  @$pb.TagNumber(18)
  $core.bool get hasPreset => $_getBF(17);
  @$pb.TagNumber(18)
  set hasPreset($core.bool v) { $_setBool(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasHasPreset() => $_has(17);
  @$pb.TagNumber(18)
  void clearHasPreset() => clearField(18);

  @$pb.TagNumber(19)
  ClimatePreset get preset_19 => $_getN(18);
  @$pb.TagNumber(19)
  set preset_19(ClimatePreset v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasPreset_19() => $_has(18);
  @$pb.TagNumber(19)
  void clearPreset_19() => clearField(19);

  @$pb.TagNumber(20)
  $core.bool get hasCustomPreset => $_getBF(19);
  @$pb.TagNumber(20)
  set hasCustomPreset($core.bool v) { $_setBool(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasHasCustomPreset() => $_has(19);
  @$pb.TagNumber(20)
  void clearHasCustomPreset() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get customPreset_21 => $_getSZ(20);
  @$pb.TagNumber(21)
  set customPreset_21($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasCustomPreset_21() => $_has(20);
  @$pb.TagNumber(21)
  void clearCustomPreset_21() => clearField(21);
}

class ListEntitiesNumberResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEntitiesNumberResponse', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'objectId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uniqueId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'icon')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minValue', $pb.PbFieldType.OF)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxValue', $pb.PbFieldType.OF)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'step', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  ListEntitiesNumberResponse._() : super();
  factory ListEntitiesNumberResponse({
    $core.String? objectId,
    $core.int? key,
    $core.String? name,
    $core.String? uniqueId,
    $core.String? icon,
    $core.double? minValue,
    $core.double? maxValue,
    $core.double? step,
  }) {
    final _result = create();
    if (objectId != null) {
      _result.objectId = objectId;
    }
    if (key != null) {
      _result.key = key;
    }
    if (name != null) {
      _result.name = name;
    }
    if (uniqueId != null) {
      _result.uniqueId = uniqueId;
    }
    if (icon != null) {
      _result.icon = icon;
    }
    if (minValue != null) {
      _result.minValue = minValue;
    }
    if (maxValue != null) {
      _result.maxValue = maxValue;
    }
    if (step != null) {
      _result.step = step;
    }
    return _result;
  }
  factory ListEntitiesNumberResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEntitiesNumberResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEntitiesNumberResponse clone() => ListEntitiesNumberResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEntitiesNumberResponse copyWith(void Function(ListEntitiesNumberResponse) updates) => super.copyWith((message) => updates(message as ListEntitiesNumberResponse)) as ListEntitiesNumberResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEntitiesNumberResponse create() => ListEntitiesNumberResponse._();
  ListEntitiesNumberResponse createEmptyInstance() => create();
  static $pb.PbList<ListEntitiesNumberResponse> createRepeated() => $pb.PbList<ListEntitiesNumberResponse>();
  @$core.pragma('dart2js:noInline')
  static ListEntitiesNumberResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEntitiesNumberResponse>(create);
  static ListEntitiesNumberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get objectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set objectId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasObjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearObjectId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get key => $_getIZ(1);
  @$pb.TagNumber(2)
  set key($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get uniqueId => $_getSZ(3);
  @$pb.TagNumber(4)
  set uniqueId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUniqueId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUniqueId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get icon => $_getSZ(4);
  @$pb.TagNumber(5)
  set icon($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIcon() => $_has(4);
  @$pb.TagNumber(5)
  void clearIcon() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get minValue => $_getN(5);
  @$pb.TagNumber(6)
  set minValue($core.double v) { $_setFloat(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMinValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearMinValue() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get maxValue => $_getN(6);
  @$pb.TagNumber(7)
  set maxValue($core.double v) { $_setFloat(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMaxValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearMaxValue() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get step => $_getN(7);
  @$pb.TagNumber(8)
  set step($core.double v) { $_setFloat(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasStep() => $_has(7);
  @$pb.TagNumber(8)
  void clearStep() => clearField(8);
}

class NumberStateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NumberStateResponse', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.OF)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'missingState')
    ..hasRequiredFields = false
  ;

  NumberStateResponse._() : super();
  factory NumberStateResponse({
    $core.int? key,
    $core.double? state,
    $core.bool? missingState,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (state != null) {
      _result.state = state;
    }
    if (missingState != null) {
      _result.missingState = missingState;
    }
    return _result;
  }
  factory NumberStateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NumberStateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NumberStateResponse clone() => NumberStateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NumberStateResponse copyWith(void Function(NumberStateResponse) updates) => super.copyWith((message) => updates(message as NumberStateResponse)) as NumberStateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NumberStateResponse create() => NumberStateResponse._();
  NumberStateResponse createEmptyInstance() => create();
  static $pb.PbList<NumberStateResponse> createRepeated() => $pb.PbList<NumberStateResponse>();
  @$core.pragma('dart2js:noInline')
  static NumberStateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NumberStateResponse>(create);
  static NumberStateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get state => $_getN(1);
  @$pb.TagNumber(2)
  set state($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get missingState => $_getBF(2);
  @$pb.TagNumber(3)
  set missingState($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMissingState() => $_has(2);
  @$pb.TagNumber(3)
  void clearMissingState() => clearField(3);
}

class NumberCommandRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NumberCommandRequest', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OF3)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  NumberCommandRequest._() : super();
  factory NumberCommandRequest({
    $core.int? key,
    $core.double? state,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (state != null) {
      _result.state = state;
    }
    return _result;
  }
  factory NumberCommandRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NumberCommandRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NumberCommandRequest clone() => NumberCommandRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NumberCommandRequest copyWith(void Function(NumberCommandRequest) updates) => super.copyWith((message) => updates(message as NumberCommandRequest)) as NumberCommandRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NumberCommandRequest create() => NumberCommandRequest._();
  NumberCommandRequest createEmptyInstance() => create();
  static $pb.PbList<NumberCommandRequest> createRepeated() => $pb.PbList<NumberCommandRequest>();
  @$core.pragma('dart2js:noInline')
  static NumberCommandRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NumberCommandRequest>(create);
  static NumberCommandRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get key => $_getIZ(0);
  @$pb.TagNumber(1)
  set key($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get state => $_getN(1);
  @$pb.TagNumber(2)
  set state($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);
}

class APIConnectionApi {
  $pb.RpcClient _client;
  APIConnectionApi(this._client);

  $async.Future<HelloResponse> hello($pb.ClientContext? ctx, HelloRequest request) {
    var emptyResponse = HelloResponse();
    return _client.invoke<HelloResponse>(ctx, 'APIConnection', 'hello', request, emptyResponse);
  }
  $async.Future<ConnectResponse> connect($pb.ClientContext? ctx, ConnectRequest request) {
    var emptyResponse = ConnectResponse();
    return _client.invoke<ConnectResponse>(ctx, 'APIConnection', 'connect', request, emptyResponse);
  }
  $async.Future<DisconnectResponse> disconnect($pb.ClientContext? ctx, DisconnectRequest request) {
    var emptyResponse = DisconnectResponse();
    return _client.invoke<DisconnectResponse>(ctx, 'APIConnection', 'disconnect', request, emptyResponse);
  }
  $async.Future<PingResponse> ping($pb.ClientContext? ctx, PingRequest request) {
    var emptyResponse = PingResponse();
    return _client.invoke<PingResponse>(ctx, 'APIConnection', 'ping', request, emptyResponse);
  }
  $async.Future<DeviceInfoResponse> device_info($pb.ClientContext? ctx, DeviceInfoRequest request) {
    var emptyResponse = DeviceInfoResponse();
    return _client.invoke<DeviceInfoResponse>(ctx, 'APIConnection', 'device_info', request, emptyResponse);
  }
  $async.Future<$0.void_> list_entities($pb.ClientContext? ctx, ListEntitiesRequest request) {
    var emptyResponse = $0.void_();
    return _client.invoke<$0.void_>(ctx, 'APIConnection', 'list_entities', request, emptyResponse);
  }
  $async.Future<$0.void_> subscribe_states($pb.ClientContext? ctx, SubscribeStatesRequest request) {
    var emptyResponse = $0.void_();
    return _client.invoke<$0.void_>(ctx, 'APIConnection', 'subscribe_states', request, emptyResponse);
  }
  $async.Future<$0.void_> subscribe_logs($pb.ClientContext? ctx, SubscribeLogsRequest request) {
    var emptyResponse = $0.void_();
    return _client.invoke<$0.void_>(ctx, 'APIConnection', 'subscribe_logs', request, emptyResponse);
  }
  $async.Future<$0.void_> subscribe_homeassistant_services($pb.ClientContext? ctx, SubscribeHomeassistantServicesRequest request) {
    var emptyResponse = $0.void_();
    return _client.invoke<$0.void_>(ctx, 'APIConnection', 'subscribe_homeassistant_services', request, emptyResponse);
  }
  $async.Future<$0.void_> subscribe_home_assistant_states($pb.ClientContext? ctx, SubscribeHomeAssistantStatesRequest request) {
    var emptyResponse = $0.void_();
    return _client.invoke<$0.void_>(ctx, 'APIConnection', 'subscribe_home_assistant_states', request, emptyResponse);
  }
  $async.Future<GetTimeResponse> get_time($pb.ClientContext? ctx, GetTimeRequest request) {
    var emptyResponse = GetTimeResponse();
    return _client.invoke<GetTimeResponse>(ctx, 'APIConnection', 'get_time', request, emptyResponse);
  }
  $async.Future<$0.void_> execute_service($pb.ClientContext? ctx, ExecuteServiceRequest request) {
    var emptyResponse = $0.void_();
    return _client.invoke<$0.void_>(ctx, 'APIConnection', 'execute_service', request, emptyResponse);
  }
  $async.Future<$0.void_> cover_command($pb.ClientContext? ctx, CoverCommandRequest request) {
    var emptyResponse = $0.void_();
    return _client.invoke<$0.void_>(ctx, 'APIConnection', 'cover_command', request, emptyResponse);
  }
  $async.Future<$0.void_> fan_command($pb.ClientContext? ctx, FanCommandRequest request) {
    var emptyResponse = $0.void_();
    return _client.invoke<$0.void_>(ctx, 'APIConnection', 'fan_command', request, emptyResponse);
  }
  $async.Future<$0.void_> light_command($pb.ClientContext? ctx, LightCommandRequest request) {
    var emptyResponse = $0.void_();
    return _client.invoke<$0.void_>(ctx, 'APIConnection', 'light_command', request, emptyResponse);
  }
  $async.Future<$0.void_> switch_command($pb.ClientContext? ctx, SwitchCommandRequest request) {
    var emptyResponse = $0.void_();
    return _client.invoke<$0.void_>(ctx, 'APIConnection', 'switch_command', request, emptyResponse);
  }
  $async.Future<$0.void_> camera_image($pb.ClientContext? ctx, CameraImageRequest request) {
    var emptyResponse = $0.void_();
    return _client.invoke<$0.void_>(ctx, 'APIConnection', 'camera_image', request, emptyResponse);
  }
  $async.Future<$0.void_> climate_command($pb.ClientContext? ctx, ClimateCommandRequest request) {
    var emptyResponse = $0.void_();
    return _client.invoke<$0.void_>(ctx, 'APIConnection', 'climate_command', request, emptyResponse);
  }
  $async.Future<$0.void_> number_command($pb.ClientContext? ctx, NumberCommandRequest request) {
    var emptyResponse = $0.void_();
    return _client.invoke<$0.void_>(ctx, 'APIConnection', 'number_command', request, emptyResponse);
  }
}

