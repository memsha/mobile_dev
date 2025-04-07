import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const DormitoryApp());
}

class DormitoryApp extends StatelessWidget {
  const DormitoryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Общежития КубГАУ',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const DormitoryScreen(),
    );
  }
}

class DormitoryScreen extends StatefulWidget {
  const DormitoryScreen({Key? key}) : super(key: key);

  @override
  State<DormitoryScreen> createState() => _DormitoryScreenState();
}

class _DormitoryScreenState extends State<DormitoryScreen> {
  int likes = 27;
  bool isLiked = false;

  void toggleLike() {
    setState(() {
      if (isLiked) {
        likes--;
      } else {
        likes++;
      }
      isLiked = !isLiked;
    });
  }

  void _openMap() async {
    final Uri mapUri = Uri.parse("https://yandex.ru/maps/-/CHuIIOoJ");
    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Не удалось открыть карту");
    }
  }



  void _makeCall() async {
    final Uri telUri = Uri.parse("tel:+78612215942");
    if (await launchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      debugPrint("Не удалось запустить вызов");
    }
  }


  void _shareInfo() {
    Share.share(
        "Кубанский государственный аграрный университет — один из признанных лидеров высшего аграрного образования в России, крупнейший в ЮФО центр науки, образования и инноваций");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Общежития КубГАУ'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/university.jpg', fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Общежитие №20',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'Краснодар, ул. Калинина, 13',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: toggleLike,
                      ),
                      Text('$likes'),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconButton(Icons.phone, 'ПОЗВОНИТЬ', _makeCall),
                _buildIconButton(Icons.navigation, 'МАРШРУТ', _openMap),
                _buildIconButton(Icons.share, 'ПОДЕЛИТЬСЯ', _shareInfo),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'КубГАУ — одно из ведущих высших учебных заведений России в области аграрного образования. Основанный в 1922 году, университет имеет богатую историю и традиции. За время существования КубГАУ подготовил более 140 тысяч специалистов.\n\n'
                    'В университете 17 факультетов, около 18 тысяч студентов. Направления подготовки включают агрономию, агроинженерию, ветеринарию, технологии переработки, юриспруденцию и многое другое.\n\n'
                    'КубГАУ активно занимается научными исследованиями и внедрением инноваций. В университете работают два НИИ: биотехнологии и сертификации пищевой продукции, а также прикладной и экспериментальной экологии.\n\n'
                    'Кампус включает 22 учебных корпуса, 20 общежитий, библиотеку, спортивный комплекс, ботанический сад и многое другое. КубГАУ активно участвует в международных проектах, обмениваясь опытом с зарубежными вузами и научными центрами.\n\n'
                    'Таким образом, Кубанский государственный аграрный университет сочетает богатые традиции, современные образовательные и научные подходы, активно внедряя инновации.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.green, size: 30),
          onPressed: onPressed,
        ),
        Text(label, style: const TextStyle(color: Colors.green)),
      ],
    );
  }
}
