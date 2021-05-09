import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moordb_demo/db/filename.dart';
import 'package:moor/moor.dart' as m;

late AppDatabase db;

void main() {
  db = AppDatabase();
  runApp(Orders());
}

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Orders List'),
        ),
        body: SingleChildScrollView(child: NewOrder()),
      ),
    );
  }
}

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  TextEditingController productNameController = TextEditingController();

  TextEditingController priceController = TextEditingController();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(hintText: 'Product Name'),
          keyboardType: TextInputType.text,
          controller: productNameController,
        ),
        TextField(
          decoration: InputDecoration(hintText: 'Product Price'),
          keyboardType: TextInputType.number,
          controller: priceController,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              db.insertNewOrder(OrdersCompanion(
                price: m.Value(priceController.text),
                productName: m.Value(productNameController.text),
              ));

              priceController.clear();
              productNameController.clear();
            });
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            onPrimary: Colors.white,
          ),
          child: Text('Place Order'),
        ),
        Container(
          height: 700,
          width: double.infinity,
          child: StreamBuilder<List<Order>>(
            stream: db.watchAllOrder(),
            initialData: [],
            builder: (context, AsyncSnapshot<List<Order>> snapshot) {
              // if (snapshot.data == null || snapshot.data!.isEmpty) {
              //   return Container(
              //     padding: const EdgeInsets.all(16.0),
              //     alignment: Alignment.topCenter,
              //     child: Text('No Orders Found'),
              //   );
              // }
              var data = snapshot.data ?? [];
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (_context, index) {
                  return Card(
                    color: Colors.orangeAccent,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(data[index].productName),
                      subtitle: Text('Rs. ${data[index].price}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: () {
                          setState(() {
                            db.deleteOrder(data[index]);
                          });
                        },
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
