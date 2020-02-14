class Entity {
  Entity({this.companyName, this.gId, this.connections});

  final String companyName;
  final String gId;
  final List<Connection> connections;

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
        companyName: json['companyName'],
        gId: json['gId'],
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
