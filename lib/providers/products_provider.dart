import 'package:admin_dashboard/api/CafeApi.dart';
import 'package:admin_dashboard/models/http/products_response.dart';
import 'package:admin_dashboard/models/products.dart';
import 'package:flutter/material.dart';


class ProductsProvider extends ChangeNotifier {
  List<Producto> productos = [];

  getProducts() async {
    final resp = await CafeApi.httpGet('/productos');
    final productsResp = ProductsResponse.fromMap(resp);

    this.productos = [...productsResp.productos];

    print( this.productos );

    notifyListeners();
  }

  Future newProduct( String name ) async {

    final data = {
      'nombre': name
    };

    try {

      final json = await CafeApi.post('/productos', data );
      final newProduct = Producto.fromMap(json);

      productos.add( newProduct );
      notifyListeners();
      
    } catch (e) {
      throw 'Error al crear producto';
    }

  }

  Future updateProduct( String id, String name ) async {

    final data = {
      'nombre': name
    };

    try {

      await CafeApi.put('/productos/$id', data );
    
      this.productos = this.productos.map(
        (product) {
          if ( product.id != id ) return product;
          product.nombre = name;
          return product;
        }
      ).toList();

      notifyListeners();
      
    } catch (e) {
      throw 'Error al actualizar producto';
    }

  }

  Future deleteProduct( String id ) async {

    try {

      await CafeApi.delete('/productos/$id',{});
    
      this.productos = this.productos.where((product) => product.id != id ).toList();

      notifyListeners();
      
    } catch (e) {
      throw 'Error al eliminar producto';
    }

  }
}