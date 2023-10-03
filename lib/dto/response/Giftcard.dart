class Giftcard {
  final String image;
  final double price;
  final String type;
  Giftcard({
    required this.image,
    required this.price,
    required this.type,
  });

  factory Giftcard.fromJson(Map<String, dynamic> json) {
    return Giftcard(
      image: json['image'],
      price: json['price'].toDouble(),
      type: json['type'],
    );
  }
}
