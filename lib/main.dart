import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.orange,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aplikasi Gueh')),
      body: Container(
        color: Colors.blue[200], // Tambahkan warna latar belakang di sini
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (usernameController.text == 'user' &&
                            passwordController.text == 'pass') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MenuScreen()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Username atau Password salah')),
                          );
                        }
                      },
                      child: const Text('Login'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: Colors.blue[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Grid for the first two items
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(context, Icons.calculate, 'Kalkulator',
                      CalculatorScreen()),
                  _buildMenuCard(context, Icons.check_circle,
                      'Deskripsi Ganjil Genap', OddEvenScreen()),
                ],
              ),
            ),
            // ListTile for Anggota Kelompok
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: ListTile(
                leading: Icon(Icons.group),
                title: Text('Anggota Kelompok'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GroupMembersScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
      BuildContext context, IconData icon, String title, Widget screen) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.blue),
              const SizedBox(height: 16),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _operator = "";
  double _num1 = 0;
  double _num2 = 0;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _num1 = 0;
        _num2 = 0;
        _operator = "";
      } else if (buttonText == "=") {
        _num2 = double.parse(_output);
        double result;

        if (_operator == "+") {
          result = _num1 + _num2;
        } else if (_operator == "-") {
          result = _num1 - _num2;
        } else if (_operator == "*") {
          result = _num1 * _num2;
        } else if (_operator == "/") {
          result = _num1 / _num2;
        } else {
          result = 0;
        }

        // Check if result is an integer
        if (result == result.roundToDouble()) {
          _output =
              result.toInt().toString(); // Convert to int if it's an integer
        } else {
          _output = result.toString(); // Keep as double if it's not an integer
        }

        _operator = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        _num1 = double.parse(_output);
        _operator = buttonText;
        _output = "0";
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }
    });
  }

  Widget _buildButton(String buttonText, {Color color = Colors.blue}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(25.0),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 30, vertical: 90), // Menyesuaikan padding
            alignment: Alignment.topRight,
            color: Colors.grey[200],
            child: Text(
              _output,
              style: const TextStyle(fontSize: 80),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton("7", color: Colors.blue),
                    _buildButton("8", color: Colors.blue),
                    _buildButton("9", color: Colors.blue),
                    _buildButton("/", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4", color: Colors.blue),
                    _buildButton("5", color: Colors.blue),
                    _buildButton("6", color: Colors.blue),
                    _buildButton("*", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1", color: Colors.blue),
                    _buildButton("2", color: Colors.blue),
                    _buildButton("3", color: Colors.blue),
                    _buildButton("-", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("C", color: Colors.red),
                    _buildButton("0", color: Colors.blue),
                    _buildButton("=", color: Colors.green),
                    _buildButton("+", color: Colors.orange),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OddEvenScreen extends StatelessWidget {
  final TextEditingController numberController = TextEditingController();

  OddEvenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deskripsi Ganjil Genap')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: numberController,
              decoration: InputDecoration(
                labelText: 'Masukkan angka',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                int number = int.parse(numberController.text);
                String description = (number % 2 == 0) ? 'Genap' : 'Ganjil';
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Hasil'),
                    content: Text('$number adalah $description'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Cek'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GroupMembersScreen extends StatelessWidget {
  final List<String> members = [
    'Dhika Dzakya Arifin (124220096)',
    'Moh. Fadliansyah (124220118)'
  ];

  GroupMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anggota Kelompok')),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: ListTile(
              title: Text(
                members[index],
                style: const TextStyle(fontSize: 18),
              ),
            ),
          );
        },
      ),
    );
  }
}
