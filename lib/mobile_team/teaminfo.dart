class MobileTeam {
  MobileTeam({
    required this.teamInfo,
  });
  late final List<TeamInfo> teamInfo;

  MobileTeam.fromJson(Map<String, dynamic> json) {
    teamInfo =
        List.from(json['team_info']).map((e) => TeamInfo.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['team_info'] = teamInfo.map((e) => e.toJson()).toList();
    return _data;
  }
}

class TeamInfo {
  TeamInfo({
    required this.name,
    required this.age,
    required this.country,
    required this.description,
  });
  late final String name;
  late final int age;
  late final String country;
  late final String description;

  TeamInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    country = json['country'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['age'] = age;
    _data['country'] = country;
    _data['description'] = description;
    return _data;
  }
}
