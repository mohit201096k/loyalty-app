class Details {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String username;
  final String type;
 final  bool enabled;
  final List<String> zones;
  final List<String> states;
  final List<String> cities;

  Details({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
     required this.username,
    required this.type,
    required this.enabled,
    required this.zones,
    required this.states,
    required this.cities,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      id: json['id'] as int,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      username: json['username'] as String,
      type: json['type'] as String,
      enabled: json['enabled'] as bool,
      zones: (json['zones'] as List<dynamic>).map((zone) => zone as String).toList(),
      states: (json['states'] as List<dynamic>).map((state) => state as String).toList(),
      cities: (json['cities'] as List<dynamic>).map((city) => city as String).toList(),
    );
  }
}
