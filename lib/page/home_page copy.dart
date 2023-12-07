import 'package:firebasestrems/service/firebase_service.dart';
import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();
  final TextEditingController _nombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registros de tareas '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre de la tarea'),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await firebaseService.guardarCiudad(_nombreController.text);
                    _nombreController.clear();
                  },
                  child: Text('Guardar'),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para cargar las ciudades y mostrarlas en una lista
                  },
                  child: Text('Cargar Tareas'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: StreamBuilder(
                stream: firebaseService.obtenerCiudades(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  var ciudades = snapshot.data!.docs;
                  List<Widget> ciudadWidgets = [];

                  for (var ciudad in ciudades) {
                    var ciudadId = ciudad.id;
                    var nombre = ciudad['nombre'];

                    var ciudadWidget = ListTile(
                      title: Text(nombre),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => firebaseService.eliminarCiudad(ciudadId),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Mostrar cuadro de diálogo para editar el nombre y actualizar
                              _mostrarDialogoEditar(context, ciudadId, nombre);
                            },
                          ),
                        ],
                      ),
                    );

                    ciudadWidgets.add(ciudadWidget);
                  }

                  return ListView(
                    children: ciudadWidgets,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función para mostrar un cuadro de diálogo para editar el nombre de la ciudad
  Future<void> _mostrarDialogoEditar(
      BuildContext context, String ciudadId, String nombreActual) async {
    TextEditingController _nuevoNombreController = TextEditingController();
    _nuevoNombreController.text = nombreActual;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Ciudad'),
          content: TextField(
            controller: _nuevoNombreController,
            decoration: InputDecoration(labelText: 'Nuevo nombre'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await firebaseService.actualizarCiudad(
                    ciudadId, _nuevoNombreController.text);
                Navigator.of(context).pop();
              },
              child: Text('Actualizar'),
            ),
          ],
        );
      },
    );
  }
}
