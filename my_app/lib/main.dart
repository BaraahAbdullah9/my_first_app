import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false, 
    home: MainMenu(),
  ));
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تكليف رقم (1)المهندس عمر الساكت'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.code, size: 80, color: Colors.indigo),
            const SizedBox(height: 40),
            
            // زر التمرين الأول
            _buildMenuButton(
              context, 
              'التمرين الأول: التنقل البسيط', 
              Icons.layers, 
              Colors.blue, 
              const HomeScreen()
            ),
            
            const SizedBox(height: 20),
            
            // زر التمرين الثاني
            _buildMenuButton(
              context, 
              'التمرين الثاني: تمرير البيانات', 
              Icons.swap_horiz, 
              const Color.fromARGB(255, 61, 143, 64), 
              const ProductListScreen()
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildMenuButton(BuildContext context, String title, IconData icon, Color color, Widget nextScreen) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(title, style: const TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen));
        },
      ),
    );
  }
}


// الجزء الخاص بالتمرين الأول: Basic Navigation


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الرئيسية (التمرين 1)'), backgroundColor: Colors.blue),
      body: Center(
        child: ElevatedButton(
          child: const Text('انتقل للتفاصيل (Push)'),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailScreen())),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التفاصيل'), backgroundColor: Colors.blue),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
          child: const Text('رجوع (Pop)'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}

// الجزء الخاص بالتمرين الثاني: Data Passing


class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المنتجات (التمرين 2)'), backgroundColor: const Color.fromARGB(255, 61, 143, 64)),
      body: ListView(
        children: [
          _productTile(context, 'آيفون 15', 'هاتف ذكي ممتاز', '3500 ريال'),
          _productTile(context, 'لابتوب HP', 'جهاز للعمل الشاق', '2800 ريال'),
        ],
      ),
    );
  }

  Widget _productTile(BuildContext context, String name, String desc, String price) {
    return ListTile(
      title: Text(name),
      subtitle: Text(price),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailScreen(name: name, desc: desc, price: price)),
        );
        if (result != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
        }
      },
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final String name, desc, price;
  const ProductDetailScreen({super.key, required this.name, required this.desc, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name), backgroundColor: const Color.fromARGB(255, 61, 143, 64)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(price, style: const TextStyle(fontSize: 20, color: Colors.green)),
            const SizedBox(height: 20),
            Text(desc),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'تم الرجوع من $name'),
              child: const Text('رجوع مع تأكيد'),
            )
          ],
        ),
      ),
    );
  }
}