///
import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use aPISourceTypeDescriptor instead')
const APISourceType$json = const {
  '1': 'APISourceType',
  '2': const [
    const {'1': 'SOURCE_BOTH', '2': 0},
    const {'1': 'SOURCE_SERVER', '2': 1},
    const {'1': 'SOURCE_CLIENT', '2': 2},
  ],
};

/// Descriptor for `APISourceType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List aPISourceTypeDescriptor = $convert.base64Decode(
    'Cg1BUElTb3VyY2VUeXBlEg8KC1NPVVJDRV9CT1RIEAASEQoNU09VUkNFX1NFUlZFUhABEhEKDVNPVVJDRV9DTElFTlQQAg==');
@$core.Deprecated('Use void_Descriptor instead')
const void_$json = const {
  '1': 'void',
};

/// Descriptor for `void`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List void_Descriptor = $convert.base64Decode('CgR2b2lk');
