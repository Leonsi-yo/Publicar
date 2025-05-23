import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LibrosForm extends StatefulWidget {
  const LibrosForm({super.key});
  @override
  _LibrosFormState createState() => _LibrosFormState();
}

class _LibrosFormState extends State<LibrosForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titulo = TextEditingController();
  final TextEditingController _autor = TextEditingController();
  final TextEditingController _anio = TextEditingController();
  final TextEditingController _imagenUrl = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'Título': _titulo.text,
        'Autor': _autor.text,
        'Año': _anio.text,
        'Imagen': _imagenUrl.text,
      };

      final response = await http.post(
        Uri.parse('https://libros-11020-default-rtdb.firebaseio.com/Libros.json'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Libro Publicado Correctamente')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al Publicar el Libro')),
        );
      }
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BOOKLY'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titulo,
                decoration: _inputDecoration('Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el titulo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _autor,
                decoration: _inputDecoration('Autor'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el autor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _anio,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration('Año'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el año';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _imagenUrl,
                decoration: _inputDecoration('URL de la Imagen'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la URL de la imagen';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text('Publicar Libro', style: TextStyle(fontSize: 16)),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
