import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Главное меню',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainMenu(),
        '/simple': (context) => const SimpleList(),
        '/infinity': (context) => const InfinityList(),
        '/math': (context) => const InfinityMathList(),
      },
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главное меню')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/simple');
              },
              child: const Text('Простой список'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/infinity');
              },
              child: const Text('Бесконечный список'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/math');
              },
              child: const Text('Математический список'),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleList extends StatelessWidget {
  const SimpleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Простой список')),
      body: ListView(
        children: const [
          Text('0000'),
          Divider(),
          Text('0001'),
          Divider(),
          Text('0010'),
        ],
      ),
    );
  }
}

class InfinityList extends StatelessWidget {
  const InfinityList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Бесконечный список')),
      body: ListView.builder(
        itemBuilder: (context, index) => Text('строка $index'),
      ),
    );
  }
}

class InfinityMathList extends StatefulWidget {
  const InfinityMathList({Key? key}) : super(key: key);

  @override
  InfinityMathListState createState() => InfinityMathListState();
}

class InfinityMathListState extends State<InfinityMathList> {
  final List<String> _array = [];

  @override
  void initState() {
    super.initState();
    _loadMoreItems();
  }

  void _loadMoreItems() {
    final newItems = List.generate(3, (j) {
      final power = _array.length ~/ 3 + j;
      return '2^$power = ${1 << power}';
    });
    setState(() {
      _array.addAll(newItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Математический список')),
      body: ListView.builder(
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;

          if (index >= _array.length - 2) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _loadMoreItems();
            });
          }

          return ListTile(
            title: Text(_array[index]),
          );
        },
      ),
    );
  }
}