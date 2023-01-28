abstract class SystemCommandsBaseClassD {
  Future<String> getCurrentUserName();

  Future<String> getLocalDbPath(Future<String?> currentUserName);

  Future<String> getUuidOfCurrentDevice();

  Future<String> getDeviceHostName();

  Future<String> getAllEtcReleaseFilesText();

  Future<String?> getFileContent(String fileFullPath);

  Future<String?> getDeviceConfiguration();

  Future<String> getProjectFilesLocation();

  Future<String?> getIpFromMdnsName(String mdnsName);

// TODO: Need to find a way in dart to get os environment variable
// /// Get Snap location environment variable "SNAP"
// Future<String> getSnapLocationEnvironmentVariable();
//
// /// Get Snap common environment variable "SNAP_COMMON" can be modified by root
// Future<String> getSnapCommonEnvironmentVariable();
//
// /// Get Snap user common environment variable "SNAP_USER_COMMON"
// Future<String> getSnapUserCommonEnvironmentVariable();
}
