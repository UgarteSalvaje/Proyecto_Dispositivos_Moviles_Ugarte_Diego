import 'package:flutter/material.dart';


class Rutina {
  final int? id;
  final String nombre;
  final String descripcion;
  final List<String> pasos;
  final String dificultad;
  final String resultado;

  Rutina({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.pasos,
    required this.dificultad,
    required this.resultado,
  });

  factory Rutina.fromJson(Map<String, dynamic> json) {
    return Rutina(
      id: json['id'] as int?,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
      pasos: List<String>.from(json['pasos']),
      dificultad: json['dificultad'] as String,
      resultado: json['resultado'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'pasos': pasos.join(','), // Convert list to string
      'dificultad': dificultad,
      'resultado': resultado,
    };
  }

  static Rutina fromMap(Map<String, dynamic> map) {
    return Rutina(
      id: map['id'] as int?,
      nombre: map['nombre'] as String,
      descripcion: map['descripcion'] as String,
      pasos: (map['pasos'] as String).split(','), // Convert string to list
      dificultad: map['dificultad'] as String,
      resultado: map['resultado'] as String,
    );
  }

  @override
  String toString() {
    return 'Rutina{id: $id, nombre: $nombre, descripcion: $descripcion, pasos: $pasos, dificultad: $dificultad, resultado: $resultado}';
  }
}

class ListaRutinas extends StatefulWidget {
  final List<Rutina> rutinas;

  const ListaRutinas({Key? key, required this.rutinas}) : super(key: key);

  @override
  State<ListaRutinas> createState() => _ListaRutinasState();
}

class _ListaRutinasState extends State<ListaRutinas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Rutinas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){},
              child: const Text('Agregar Rutina'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.rutinas.length,
                itemBuilder: (context, index) {
                  final rutina = widget.rutinas[index];
                  return Card(
                    child: ListTile(
                      title: Text('${rutina.nombre} - ${rutina.dificultad}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Pasos:'),
                          ...rutina.pasos.map((paso) => Text('• $paso')),
                          Text('Resultado: ${rutina.resultado}'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RutinaDetalles(rutina: rutina),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RutinaDetalles extends StatelessWidget {
  final Rutina rutina;

  const RutinaDetalles({Key? key, required this.rutina}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(rutina.nombre),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dificultad: ${rutina.dificultad}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Descripción: ${rutina.descripcion}', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            const Text('Pasos:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...rutina.pasos.map((paso) => Text('• $paso')),
          ],
        ),
      ),
    );
  }
}