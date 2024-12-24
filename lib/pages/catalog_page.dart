import 'package:flutter/material.dart';
import '../models/photo_equipment.dart';
import '../widgets/photo_equipment_card.dart';

class CatalogPage extends StatefulWidget {
  final List<PhotoEquipment> equipmentList;

  const CatalogPage({super.key, required this.equipmentList});

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
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
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
        padding: EdgeInsets.zero,
        itemCount: widget.equipmentList.length,
        itemBuilder: (context, index) {
          return PhotoEquipmentCard(
            equipment: widget.equipmentList[index],
            onFavoriteTap: _toggleFavorite,
            onCartTap: _toggleCart,
          );
        },
      ),
    );
  }
}
