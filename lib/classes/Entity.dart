import 'dart:convert';
import 'package:http/http.dart' as http;

class Entity {
  Entity({
    this.companyName,
    this.gId,
    this.connections,
    this.spBase,
    this.logoPath,
  });

  final String companyName;
  final String gId;
  final List<Connection> connections;
  final StoredProcBase spBase;
  final String logoPath;

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
        companyName: json['companyName'],
        gId: json['gId'],
        logoPath: json['logoPath'],
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
  String apiUrl;

  StoredProcBase({
    String url,
    this.currentBuild,
    this.databaseName,
    this.serverName,
    this.apiServer,
    this.connectionId,
  }) {
    if (url != null) {
      apiUrl = apiServer + url;
    }
  }

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

  Future<String> getResponse() async {
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonbody = json.encode(this);
    print(jsonbody);
    http.Response response =
        await http.post(apiUrl, headers: headers, body: jsonbody);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Cannot call API");
    }
  }
}

class StoredProcResponseBase {
  final int rc;
  final String errorMsg;

  StoredProcResponseBase(this.rc, this.errorMsg);

  factory StoredProcResponseBase.fromJson(Map<String, dynamic> json) {
    return StoredProcResponseBase(
      json['RC'],
      json['ErrorMsg'],
    );
  }
}
