import 'package:flutter/material.dart';
import '../models/photo_equipment.dart';
import '../widgets/photo_equipment_card.dart';

class FavoritesPage extends StatefulWidget {
  final List<PhotoEquipment> equipmentList;

  const FavoritesPage({super.key, required this.equipmentList});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  void _toggleFavorite(PhotoEquipment equipment) {
    setState(() {
      equipment.isFavorite = !equipment.isFavorite;
    });
  }

  void _toggleCart(PhotoEquipment equipment) {
    setState(() {
      equipment.isInCart = !equipment.isInCart;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteEquipment = widget.equipmentList.where((equipment) => equipment.isFavorite).toList();

    return Scaffold(
      body: favoriteEquipment.isEmpty
          ? Center(child: Text('Нет лайкнутых'))
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
        padding: EdgeInsets.zero,
        itemCount: favoriteEquipment.length,
        itemBuilder: (context, index) {
          return PhotoEquipmentCard(
            equipment: favoriteEquipment[index],
            onFavoriteTap: _toggleFavorite,
            onCartTap: _toggleCart,
          );
        },
      ),
    );
  }
}
