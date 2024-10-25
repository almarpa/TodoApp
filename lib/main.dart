import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Complejo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ComplexWidgetScreen(),
    );
  }
}

class ComplexWidgetScreen extends StatefulWidget {
  @override
  _ComplexWidgetScreenState createState() => _ComplexWidgetScreenState();
}

class _ComplexWidgetScreenState extends State<ComplexWidgetScreen> {
  int _counter = 0;

  // Método para incrementar el contador
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Complejo'),
      ),
      body: Column(
        children: [
          // Un header que muestra un contador
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Contador: $_counter',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: _incrementCounter,
                ),
              ],
            ),
          ),
          Expanded(
            // Lista de tarjetas en un ListView
            child: ListView.builder(
              itemCount: 5, // Cambia este valor para más tarjetas
              itemBuilder: (context, index) {
                return _buildCard(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Método que construye cada tarjeta
  Widget _buildCard(int index) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen de la tarjeta
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/400x200'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tarjeta #${index + 1}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Este es un texto de ejemplo para la tarjeta #${index + 1}. Puedes personalizar este contenido como quieras.',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Acciones del botón
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Botón en tarjeta #${index + 1} presionado'),
                          ),
                        );
                      },
                      child: const Text('Acción 1'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Otra acción del botón
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Acción 2 en tarjeta #${index + 1}'),
                          ),
                        );
                      },
                      child: const Text('Acción 2'),
                    ),
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
