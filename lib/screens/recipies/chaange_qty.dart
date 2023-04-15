import 'package:flutter/material.dart';

class ChangeQty extends StatefulWidget {
  final data;
  const ChangeQty({Key? key, this.data}) : super(key: key);

  @override
  State<ChangeQty> createState() => _ChangeQtyState();
}

class _ChangeQtyState extends State<ChangeQty> {
  var qty = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Quantity'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Quantity: ${widget.data['qty']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'New Quantity:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (qty > 1) {
                        qty--;
                      }
                    });
                  },
                  icon: Icon(Icons.remove),
                ),
                Text(
                  '$qty',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      qty++;
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, qty);
              },
              child: Text('Change'),
            ),
          ],
        ),
      ),
    );
  }
}
