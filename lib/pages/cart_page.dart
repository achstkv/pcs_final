import 'package:flutter/material.dart';
import '../models/photo_equipment.dart';

class CartPage extends StatefulWidget {
  final List<PhotoEquipment> equipmentList;

  const CartPage({super.key, required this.equipmentList});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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

  double getTotalPrice() {
    double total = 0;
    for (var equipment in widget.equipmentList) {
      if (equipment.isInCart) {
        total += equipment.price;
      }
    }
    return total;
  }

  void _placeOrder() {
    final cartEquipment = widget.equipmentList.where((equipment) =>
    equipment.isInCart).toList();

    if (cartEquipment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Корзина пуста')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Подтверждение заказа'),
          content: Text(
              'Вы уверены, что вы хотите совершить заказ на сумму \$${getTotalPrice()
                  .toStringAsFixed(2)}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  for (var equipment in cartEquipment) {
                    equipment.isInCart = false;
                  }
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Заказ успешно совершен!')),
                );
              },
              child: Text('Заказать'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartEquipment = widget.equipmentList.where((equipment) =>
    equipment.isInCart).toList();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: cartEquipment.isEmpty
                ? Center(child: Text('Корзина пуста'))
                : ListView.builder(
              itemCount: cartEquipment.length,
              itemBuilder: (context, index) {
                final equipment = cartEquipment[index];
                return Dismissible(
                  key: ValueKey(equipment),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      equipment.isInCart = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${equipment
                          .title} удален из корзины')),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: Image.network(
                      equipment.imageUrl,
                      height: 50,
                      width: 50,
                      fit: BoxFit.contain,
                    ),
                    title: Text(equipment.title),
                    subtitle: Text('\$${equipment.price.toStringAsFixed(2)}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          equipment.isInCart = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Удалить'),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey[1],
              border: Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Общая сумма',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      '\$${getTotalPrice().toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _placeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: Text(
                    'Заказать',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}