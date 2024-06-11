import 'package:flutter/material.dart';
import 'Rutinas.dart';

class Recomendaciones{
  Rutina rutina;
  String usuario;
  int likes;
  Recomendaciones({required this.rutina, required this.usuario, required this.likes});
}

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);
  @override
  _NewsState createState() => _NewsState();
}



class _NewsState  extends  State<News>{
  List<Rutina> rutinas = [Rutina(prioridad: "Alta", juego: "StreetFighter", desafio: "Aprender el kikosho de Chun-Li", pasos: ["Hacer los movimientos de kikosho", 
  "Lanzarlo tanto en el aire como en la tierra"],),];

  List<bool> mostrarPasos = [];

  @override
  void initState() {
    super.initState();
    mostrarPasos = List<bool>.filled(rutinas.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Game Trainer',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const Center(
                child: Card(
                  elevation: 4,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Novedades de: Street Fighter'),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: rutinas.length,
                  itemBuilder: (context, index) {
                    final recomendacion = rutinas[index];
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text('${recomendacion.desafio} - ${recomendacion.juego}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      mostrarPasos[index] = !mostrarPasos[index];
                                    });
                                  },
                                  child: Text(mostrarPasos[index] ? 'Ocultar pasos' : 'Ver los pasos'),
                                ),
                                if (mostrarPasos[index])
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: recomendacion.pasos.map((paso) => Text(paso)).toList(),
                                  ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.save),
                              onPressed: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.favorite_outline),
                                      onPressed: () {},
                                    ),
                                    Text('35 me gusta'),
                                  ],
                                ),
                                Text('Usuario: Vishoo'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}