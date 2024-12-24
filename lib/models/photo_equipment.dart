class PhotoEquipment {
  final String title;
  final String brand;
  final double price;
  final String imageUrl;
  final String category;
  final String description;
  bool isFavorite;
  bool isInCart;

  PhotoEquipment({
    required this.title,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.description,
    this.isFavorite = false,
    this.isInCart = false,
  });
}
