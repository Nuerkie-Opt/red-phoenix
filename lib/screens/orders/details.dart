import 'package:ecommerceproject/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Details extends StatelessWidget {
  final Order order;
  const Details({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List orderStatus = order.status.split(RegExp(r'(?=[A-Z])'));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Details', style: Theme.of(context).primaryTextTheme.headline3),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Products',
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: order.products.length,
                  separatorBuilder: (context, ind) {
                    return Divider();
                  },
                  itemBuilder: (context, ind) {
                    return ListTile(
                      title: Text(
                        order.products[ind].product.name,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amount: ${order.products[ind].salePrice.toString()}',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Quantity: ${order.products[ind].quantity.toString()}',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Size: ${order.products[ind].selectedSize.toString()}',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Color: ${order.products[ind].selectedColor.toString()}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  }),
              SizedBox(height: 20),
              Text(
                'Status',
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
              Text(
                '${orderStatus.join(' ').toUpperCase()}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Text('Date', style: Theme.of(context).primaryTextTheme.headline1),
              Text(
                '${DateFormat('yyyy-MM-dd – kk:mm').format(order.date)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Text('Address', style: Theme.of(context).primaryTextTheme.headline1),
              Text(
                '${order.userAddress.address} ${order.userAddress.gpsAddress}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                '${order.userAddress.city} ${order.userAddress.region}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Text('Delivery Fee', style: Theme.of(context).primaryTextTheme.headline1),
              Text(
                'GHS ${order.deliveryFee}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Text('Total Amount', style: Theme.of(context).primaryTextTheme.headline1),
              Text(
                'GHS ${order.amount.toString()}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          )),
    );
  }
}
