class Entity {
  Entity({this.companyName, this.gId, this.connections, this.spBase});

  final String companyName;
  final String gId;
  final List<Connection> connections;
  final StoredProcBase spBase;

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
        companyName: json['companyName'],
        gId: json['gId'],
        spBase: StoredProcBase.fromJson(json['spBase']),
        connections: json['connections'] != null
            ? List<Connection>.from((json['connections'] as Iterable<dynamic>)
                .map<dynamic>((dynamic d) =>
                    Connection.fromJson(d as Map<String, dynamic>)))
            : null);
  }
}

class Connection {
  Connection({this.name, this.gId, this.connectionTypeId});

  final String gId;
  final int connectionTypeId;
  final String name;

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      name: json['name'],
      connectionTypeId: json['connectionTypeId'],
      gId: json['gId'],
    );
  }
}

class StoredProcBase {
  final int currentBuild;
  final String databaseName;
  final String serverName;
  final String apiServer;
  final String connectionId;

  const StoredProcBase({
    this.currentBuild,
    this.databaseName,
    this.serverName,
    this.apiServer,
    this.connectionId,
  });

  factory StoredProcBase.fromJson(Map<String, dynamic> json) {
    return StoredProcBase(
      currentBuild: json['currentBuild'],
      databaseName: json['databaseName'],
      serverName: json['serverName'],
      apiServer: json['apiServer'],
      connectionId: json['connectionId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'currentBuild': currentBuild,
        'databaseName': databaseName,
        'serverName': serverName,
        'apiServer': apiServer,
        'connectionId': connectionId,
      };
}
