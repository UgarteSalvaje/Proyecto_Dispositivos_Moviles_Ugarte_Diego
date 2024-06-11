import 'package:flutter/material.dart';

class Recortatorio{
  String namerutina;
  String namejuego;
  String hora;

  Recortatorio({required this.namerutina, required this.namejuego, required this.hora});
}

class ListaRecordatorios extends StatefulWidget {
  const ListaRecordatorios({Key? key}) : super(key: key);

  @override
  State<ListaRecordatorios> createState() => _RecordatoriosState();
}

class _RecordatoriosState extends State<ListaRecordatorios> {
  TextEditingController rutinaController = TextEditingController();
  TextEditingController juegoController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  //List<String> pasosTemporales = [];
  List<Recortatorio> recordatorios = [Recortatorio(namerutina: "Dominar el Shoryuken", namejuego: "StreetFighter", hora: "13:00"),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordatorios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){},
              child: const Text('Agregar Recordatorio'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: recordatorios.length,
                itemBuilder: (context, index) {
                  final recordatorio = recordatorios[index];
                  return Card(
                    child: ListTile(
                      title: Text('${recordatorio.namerutina} - ${recordatorio.namejuego}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('hora de practica: ${recordatorio.hora}'),
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