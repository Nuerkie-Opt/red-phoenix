import 'package:ecommerceproject/models/order.dart';
import 'package:ecommerceproject/screens/orders/details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderTab extends StatelessWidget {
  final List<Order> orders;
  const OrderTab({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(top: 20),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Details(order: orders[index])));
            },
            title: Text(
              '${DateFormat('yyyy-MM-dd – kk:mm').format(orders[index].date)}',
              style: Theme.of(context).primaryTextTheme.headline1,
            ),
            subtitle: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: orders[index].products.length,
                itemBuilder: (context, ind) {
                  return ListTile(
                    title: Text(
                      orders[index].products[ind].product.name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amount: ${orders[index].products[ind].salePrice.toString()}',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Quantity: ${orders[index].products[ind].quantity.toString()}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }),
            trailing: Text(
              'GHS ${orders[index].amount.toString()}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: orders.length);
  }
}
