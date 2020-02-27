import 'package:eniachub_mobile_v011/classes/Entity.dart';

class CheckInStatusAPI extends StoredProcBase {
  static const String _apiUrl = "pEBP_Work_Status";

  CheckInStatusAPI(StoredProcBase spBase)
      : super(
          currentBuild: spBase.currentBuild,
          databaseName: spBase.databaseName,
          serverName: spBase.serverName,
          apiServer: spBase.apiServer,
          connectionId: spBase.connectionId,
          url: _apiUrl,
        );
}
