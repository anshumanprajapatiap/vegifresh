// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/ordersModel.dart';

class OrdersProvider with ChangeNotifier {
  static List<OrderModel> _orders = [];
  List<OrderModel> get getOrders {
    return _orders;
  }

  Future<void> fetchOrders() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      _orders = [];
      // _orders.clear();
      ordersSnapshot.docs.forEach((element) {
        _orders.insert(
          0,
          OrderModel(
            orderId: element.get('orderId'),
            userId: element.get('userId'),
            productId: 'productId',
            userName: element.get('userName'),
            price: element.get('totalPrice').toString(),
            imageUrl: 'https://as1.ftcdn.net/v2/jpg/05/38/77/28/1000_F_538772812_eU63uhIVSCzJ0CEDOmt82kwKpBegHVdC.png',
            quantity: element.get('totalQuantity').toString(),
            // quantity: '',
            orderDate: element.get('orderDate'),
          ),
        );
      });
    });
    notifyListeners();
  }
}