import 'package:flutter/material.dart';
import 'crypto_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Crypto App!',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              child: Text('Go to Crypto Data'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IosScreen2()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class IosScreen2 extends StatefulWidget {
  @override
  _IosScreen2State createState() => _IosScreen2State();
}

class _IosScreen2State extends State<IosScreen2> {
  CryptoService _cryptoService = CryptoService();
  Future<Crypto>? _futureCrypto;
  final _controller = TextEditingController();
  double? _totalCost;

  @override
  void initState() {
    super.initState();
    _futureCrypto = _cryptoService.fetchCryptoData();
  }

  void refreshData() {
    setState(() {
      _futureCrypto = _cryptoService.fetchCryptoData();
    });
  }

  void calculateTotalCost(String text) {
    double quantity = double.tryParse(text) ?? 0;
    setState(() {
      var snapshot;
      _totalCost = quantity * (double.tryParse(snapshot.data?.price ?? '0') ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Data'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refreshData,
          ),
        ],
      ),
      body: FutureBuilder<Crypto>(
        future: _futureCrypto,
        builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error.toString() ?? 'Unknown error'}');
    } else if (snapshot.hasData) {
      var crypto = snapshot.data!;
      return Column(
        children: [
          ListTile(
            title: Text(crypto.name),
            subtitle: Text(crypto.price),
          ),
          TextField(
            controller: _controller,
            onChanged: (text) {
              double quantity = double.tryParse(text) ?? 0;
              setState(() {
                _totalCost = quantity * (double.tryParse(crypto.price) ?? 0);
              });
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter quantity',
            ),
          ),
          Text('Total cost: \$${_totalCost ?? 0}'),
        ],
      );
    } else {
      return const Text('No data');
    }
  },
),
    );
  }
}