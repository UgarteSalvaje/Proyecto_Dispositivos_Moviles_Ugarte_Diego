import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Juego {
  String nombre;
  String genero;
  String plataforma;
  String urlImagen;
  String descripcion;
  Juego({required this.nombre, required this.genero, required this.plataforma, required this.urlImagen, required this.descripcion});
}

class ListaJuegos extends StatefulWidget {
  const ListaJuegos({Key? key}) : super(key: key);

  @override
  State<ListaJuegos> createState() => _ListaState();
}

class _ListaState extends State<ListaJuegos> {
  List<Juego> juegos = [Juego(nombre: "Street Fighter", genero: "Peleas / Arcade", plataforma: "PS4", urlImagen: 'assets/Images/Street_Fighter_old_logo.svg', descripcion: "Un clásico juego de lucha."),
  Juego(nombre: "Devil May Cry", genero: "Hack and Slash", plataforma: "PS3", urlImagen: 'assets/Images/devil_may_cry_logo.svg', descripcion: "Un juego de acción intensa.")];

  int selectedIndex = -1;

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
                  child: const Text('Agregar Juego')),
                ],
            ),
            const SizedBox(height: 10, width: 5),
            juegos.isEmpty
                ? const Text(
                    'No hay juegos..',
                    style: TextStyle(fontSize: 22),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: juegos.length,
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  )
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
          Text(juegos[index].genero),
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
                        SvgPicture.asset(juegos[index].urlImagen, height: 100, width: 100,),
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
        ],
      ),
    ),
  );
}
}