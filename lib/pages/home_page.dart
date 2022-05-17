import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductInto {
  final String name;
  final double price;

  ProductInto(this.name, this.price);
}

final products = [
  ProductInto('Iphone 13', 1300),
  ProductInto('Macbook M1', 1400),
  ProductInto('Airport', 900),
  ProductInto('airphone', 200),
  ProductInto('apple mouse', 120),
  ProductInto('ipad air m1', 1100),
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentProductIndex = 0;
  int? _inputtedPrice;
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 80)),
            Text(products[_currentProductIndex].name),
            const Padding(padding: EdgeInsets.only(top: 40)),
            SizedBox(
              width: 200,
              child: TextField(
                key: const Key("priceInput"),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  _inputtedPrice = int.tryParse(value);
                },
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 40)),
            ElevatedButton(
              onPressed: () {
                _result = _inputtedPrice == products[_currentProductIndex].price
                    ? 'pass'
                    : 'fail';

                setState(() {});
              },
              child: const Text('Check'),
            ),
            Visibility(
              visible: _result.isNotEmpty,
              child: Text(
                _result,
                key: const Key('result'),
              ),
            ),
            Visibility(
              visible: _result.isNotEmpty,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _result = '';
                    if (_currentProductIndex < products.length - 1) {
                      _currentProductIndex++;
                    }
                  });
                },
                child: const Text('Next'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
