class Room {
  int id;
  String label, description, price, image;

  Room(
      {required this.id,
      required this.label,
      required this.description,
      required this.price,
      required this.image});

  static Room fromJson(Map<String, dynamic> json) => Room(
      id: json['id'],
      label: json['label'],
      description: json['description'],
      price: json['prix'].toString(),
      image: "https://kofhotel.kofcorporation.com/old${json['image']}");
}
