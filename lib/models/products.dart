import 'dart:convert';

class Producto {
  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.cantidad,
    this.descripcion,
    this.imagen,
  });

  String id;
  String nombre;
  double precio;
  int cantidad;
  String? descripcion;
  String? imagen;

  factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str)) ;
   String toJson() => json.encode(toMap());
    factory Producto.fromMap(Map<String, dynamic> json) => Producto(
          id: json["_id"],
          nombre: json["nombre"],
          precio: json["precio"].toDouble(),
          cantidad: json["cantidad"],
          descripcion: json["descripcion"],
          imagen: json["imagen"],
      );
      Map<String, dynamic> toMap() => {
          "_id": id,
          "nombre": nombre,
          "precio": precio,
          "cantidad": cantidad,
          "descripcion": descripcion,
          "imagen": imagen,
      };

  @override
  String toString() {
    return 'Producto: ${ this.nombre } - ${ this.precio }';
  }
  }

   class _Producto {
    _Producto({
        required this.id,
        required this.nombre,
        required this.precio,
        required this.cantidad,
        this.descripcion,
        this.imagen,
    });
    String id;
   String nombre;
   double precio;
  int cantidad;
  String? descripcion;
  String? imagen;

 factory _Producto.fromJson(String str) => _Producto.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory _Producto.fromMap(Map<String, dynamic> json) => _Producto(
        id: json["_id"],
        nombre: json["nombre"],
        precio: json["precio"],
        cantidad: json["cantidad"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],

    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nombre": nombre,
        "precio": precio,
        "cantidad": cantidad,
        "descripcion": descripcion,
        "imagen": imagen,
    };

  }

