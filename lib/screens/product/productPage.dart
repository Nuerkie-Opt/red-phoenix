import 'package:ecommerceproject/components/toast.dart';
import 'package:ecommerceproject/models/orderedProduct.dart';
import 'package:ecommerceproject/models/product.dart';
import 'package:ecommerceproject/providers/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String? color;
  int? size;

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.network(
                  widget.product.productImage,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListTile(
                        title: Text('Name', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200)),
                        subtitle: Text(widget.product.name, style: Theme.of(context).primaryTextTheme.bodyText2)),
                  ),
                  Expanded(
                      child: ListTile(
                    title: Text('Quantity', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200)),
                    subtitle: Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                quantity--;
                              });
                            }),
                        Text(quantity.toString(), style: Theme.of(context).primaryTextTheme.bodyText2),
                        IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            }),
                      ],
                    ),
                  ))
                ],
              ),
              ListTile(
                  title: Text('Price', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200)),
                  subtitle: widget.product.discounted
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("GHS ${widget.product.discountPrice.toString()}",
                                style: Theme.of(context).primaryTextTheme.bodyText2),
                            SizedBox(
                              width: 40,
                            ),
                            Text("GHS ${widget.product.price.toString()}",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough, color: Theme.of(context).primaryColor))
                          ],
                        )
                      : Text("GHS ${widget.product.price.toString()}",
                          style: Theme.of(context).primaryTextTheme.bodyText2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Size', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200)),
                      subtitle: DropdownButtonFormField(
                        hint: Text('Size...'),
                        value: size,
                        onChanged: (newvalue) {
                          setState(() {
                            size = newvalue as int?;
                          });
                        },
                        items: widget.product.sizes?.map((size) {
                          return DropdownMenuItem(
                            child: Text(size.toString()),
                            value: size,
                          );
                        }).toList(),
                        validator: (value) {
                          if (size != value) {
                            return 'Select size';
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Colour', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200)),
                      subtitle: DropdownButtonFormField(
                        hint: Text('Colour...'),
                        value: color,
                        onChanged: (newvalue) {
                          setState(() {
                            color = newvalue as String?;
                          });
                        },
                        items: widget.product.colors?.map((color) {
                          return DropdownMenuItem(
                            child: Text(color),
                            value: color,
                          );
                        }).toList(),
                        validator: (value) {
                          if (color != value) {
                            return 'Select colour';
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: widget.product.descriptionAvailable,
                replacement: Container(),
                child: ListTile(
                    title: Text('Description', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200)),
                    subtitle:
                        Text(widget.product.description ?? "", style: Theme.of(context).primaryTextTheme.bodyText2)),
              ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                primary: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                minimumSize: Size.fromHeight(50),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                )),
            onPressed: () {
              OrderedProduct orderedProduct = OrderedProduct(
                  product: widget.product,
                  quantity: quantity,
                  selectedSize: size,
                  selectedColor: color,
                  salePrice: widget.product.discounted ? widget.product.discountPrice : widget.product.price);
              cart.addItem(orderedProduct);
              showToastMessage("Item added to cart");
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add to cart',
                  style: Theme.of(context).primaryTextTheme.headline3,
                ),
                Icon(
                  Icons.add_shopping_cart_rounded,
                  color: Colors.white,
                )
              ],
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
