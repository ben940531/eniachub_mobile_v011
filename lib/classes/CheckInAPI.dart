import 'package:eniachub_mobile_v011/classes/Entity.dart';

class CheckInAPI extends StoredProcBase {
  bool inOut;
  static const String _apiUrl = "pEBP_Work_CheckInOut";

  CheckInAPI(StoredProcBase spBase)
      : super(
          currentBuild: spBase.currentBuild,
          databaseName: spBase.databaseName,
          serverName: spBase.serverName,
          apiServer: spBase.apiServer,
          connectionId: spBase.connectionId,
          url: _apiUrl,
        );

  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json.putIfAbsent('inOut', () => inOut);
    return json;
  }
}
