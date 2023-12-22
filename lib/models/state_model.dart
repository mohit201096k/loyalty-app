class States {
 int id;
 String zone;
 String name;
 int zoneId;
 States(
     {
      required this.id,
      required this.zone,
      required this.name,
      required this.zoneId
     }
     );
 factory States.fromJson(Map<String, dynamic> json) {
  return States(
   id: json['id'] ?? 0,
   zone: json['zone'] ?? '',
   name: json['name'] ?? '',
   zoneId: json['zoneId'] ?? 0,
  );
 }
}
