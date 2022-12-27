class Car {
  late String name;
  late DateTime review;
  late DateTime oc;

  Car({required this.name, required this.review, required this.oc});

  static Car fromJson(Map<String, dynamic> json) =>
      Car(name: json['name'], review: json['review'], oc: json['oc']);
}
