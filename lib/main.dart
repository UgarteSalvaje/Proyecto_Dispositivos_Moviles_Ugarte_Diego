import 'package:flutter/material.dart';
import 'juegos.dart';
import 'Rutinas.dart';
import 'Recordatorio.dart';
import 'Recomendaciones.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Game Trainer';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Ingrese su nombre de usuario',
              ),
            ),
        ), Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Ingrese su Contraseña',
            ),
          ),
        ),

        ElevatedButton(child: const Text('Iniciar Sesion'), onPressed: () 
      {Navigator.push(context, MaterialPageRoute(builder: (context) => const Pantalla()),);},)
      ],
    );
  }
}

class Pantalla extends StatelessWidget{
  const Pantalla({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Powerpuff',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ), 
      home: const MyHomePage(title: 'Bienvenido La_li_lu_le_lo!'),
    );
  }
}
  @override
  

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Perfil{
  String sesion;
  String nacionalidad;
  String codigo_jugador;

  Perfil({required this.sesion, required this.nacionalidad, required this.codigo_jugador});
}

class _Perfil extends StatefulWidget {
  const _Perfil({Key? key}) : super(key: key);

  @override
  State<_Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<_Perfil>{
  
  Perfil perfil = Perfil(sesion: "La li lu le lo", nacionalidad: "Chilena", codigo_jugador: "A7AKJNDJCN");
  late final TextEditingController sessionController;
  late final TextEditingController nationalityController;
  late final TextEditingController player_codeController;
  
  @override
  void initState() {
    super.initState();
    // Asignar valores iniciales a los controladores de texto
    sessionController = TextEditingController(text: perfil.sesion);
    nationalityController = TextEditingController(text: perfil.nacionalidad);
    player_codeController = TextEditingController(text: perfil.codigo_jugador);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Center(
        //padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(controller: sessionController,
                decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nombre de usuario:',
                labelStyle: TextStyle(color: Colors.black),
                ),
                enabled: false,
                style: const TextStyle(color: Colors.black),
              ),
            ), 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(controller: nationalityController,
                decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nacionalidad:',
                labelStyle: TextStyle(color: Colors.black),
                ),
                enabled: false,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(controller: player_codeController,
                decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Codigo de Jugador:',
                labelStyle: TextStyle(color: Colors.black),
                ),
                enabled: false,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _MyHomePageState extends State<MyHomePage> {
  
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    News(),
    ListaRutinas(),
    ListaJuegos(),
    _Perfil(),
    ListaRecordatorios(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: _selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            //selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            //selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.fitness_center),
            label: 'Rutinas',
          ),
          NavigationDestination(
            icon: Icon(Icons.games),
            label: 'Juegos',
          ),
          NavigationDestination(
           icon: Icon(Icons.person),
            label: 'Usuario',
          ),
          NavigationDestination(
            icon: Icon(Icons.alarm),
            label: 'Deberes',
          )
        ],
      ),
    );
  }

}
