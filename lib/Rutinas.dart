import 'package:flutter/material.dart';

class Rutina {
  String prioridad;
  String juego;
  String desafio;
  List<String> pasos;

  Rutina({required this.prioridad, required this.juego, required this.desafio, required this.pasos});
}

class ListaRutinas extends StatefulWidget {
  const ListaRutinas({Key? key}) : super(key: key);

  @override
  State<ListaRutinas> createState() => _ListaRutinasState();
}

class _ListaRutinasState extends State<ListaRutinas> {
  List<String> pasosTemporales = [];
  List<Rutina> rutinas = [Rutina(prioridad: "Alta", juego: "StreetFighter", desafio: "Dominar el shoryuken", pasos: ["Hacer un golpe fuerte", "Pa"],),];

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
                itemCount: rutinas.length,
                itemBuilder: (context, index) {
                  final rutina = rutinas[index];
                  return Card(
                    child: ListTile(
                      title: Text('${rutina.juego} - ${rutina.desafio}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Prioridad: ${rutina.prioridad}'),
                          const Text('Pasos:'),
                          ...rutina.pasos.map((paso) => Text('• $paso')),
                        ],
                      ),
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