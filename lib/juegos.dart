import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'Rutinas.dart';

class Juego {
  final int id;
  final String nombre;
  final String plataforma;
  final String urlImagen;
  final String descripcion;
  final String link_plataforma;
  final List<Rutina> rutinas;

  const Juego({
    required this.id,
    required this.nombre,
    required this.plataforma,
    required this.urlImagen,
    required this.descripcion,
    required this.link_plataforma,
    required this.rutinas,
  });

  factory Juego.fromJson(Map<String, dynamic> json) {
    return Juego(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      plataforma: json['plataforma'] as String,
      urlImagen: json['urlImagen'] as String? ?? '',
      descripcion: json['descripcion'] as String,
      link_plataforma: json['link_plataforma'] as String,
      rutinas: (json['rutinas'] as List).map((rutina) => Rutina.fromJson(rutina)).toList(),
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'plataforma': plataforma,
      'urlImagen': urlImagen,
      'descripcion': descripcion,
      'link_plataforma': link_plataforma,
    };
  }

  static Juego fromMap(Map<String, dynamic> map) {
    return Juego(
      id: map['id'] as int,
      nombre: map['nombre'] as String,
      plataforma: map['plataforma'] as String,
      urlImagen: map['urlImagen'] as String,
      descripcion: map['descripcion'] as String,
      link_plataforma: map['link_plataforma'] as String,
      rutinas: (map['rutinas'] as List<dynamic>).map((e) => Rutina.fromMap(e)).toList(),
    );
  }

  @override
  String toString() {
    return 'Juego{id: $id, nombre: $nombre, plataforma: $plataforma, urlImagen: $urlImagen, descripcion: $descripcion, link_plataforma: $link_plataforma, rutinas: $rutinas}';
  }

  static Future<List<Juego>> loadJuegos() async {
    try {
      final jsonString = await rootBundle.loadString('assets/Juegos.json');
      final List<dynamic> jsonDecoded = jsonDecode(jsonString) as List<dynamic>;
      return jsonDecoded.map((dynamic item) => Juego.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print("Error loading juegos: $error");
      return [];
    }
  }
}

class ListaJuegos extends StatefulWidget {
  const ListaJuegos({Key? key}) : super(key: key);

  @override
  State<ListaJuegos> createState() => _ListaState();
}

class _ListaState extends State<ListaJuegos> {
  List<Juego> juegos = [];
  Future<List<Juego>>? jueguitos;

  @override
  void initState() {
    super.initState();
    jueguitos = Juego.loadJuegos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Lista de Juegos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Agregar Juego'),
                ),
              ],
            ),
            const SizedBox(height: 10, width: 5),
            FutureBuilder<List<Juego>>(
              future: jueguitos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text(
                    'No hay juegos..',
                    style: TextStyle(fontSize: 22),
                  );
                } else {
                  juegos = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: juegos.length,
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
  return Card(
    child: ListTile(
      leading: const Icon(Icons.gamepad_sharp),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            juegos[index].nombre,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(juegos[index].link_plataforma),
          Text(juegos[index].plataforma),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          juegos[index].urlImagen,
                          height: 100,
                          width: 100,
                          placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(),
                        ),
                        const SizedBox(height: 30, width: 30),
                        Text(juegos[index].descripcion),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text("Cerrar"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Ver Descripción'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaRutinas(
                    rutinas: juegos[index].rutinas,
                  ),
                ),
              );
            },
            child: const Text('Ver Rutinas'),
          ),
        ],
      ),
    ),
  );
}
}