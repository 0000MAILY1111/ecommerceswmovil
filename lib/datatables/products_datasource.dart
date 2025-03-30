import 'package:admin_dashboard/models/products.dart';
import 'package:admin_dashboard/providers/products_provider.dart';
import 'package:admin_dashboard/ui/modals/products_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductsDTS extends DataTableSource {

  final List<Producto> productos;
  final BuildContext context;

  ProductsDTS(this.productos, this.context);


  @override
  DataRow getRow(int index) {

    final producto = this.productos [index];
    
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell( Text( producto.id ) ),
        DataCell( Text( producto.nombre ) ),
      
        DataCell( 
          Row(
            children: [
              IconButton(
                icon: Icon( Icons.edit_outlined ),
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context, 
                      builder: ( _ ) => ProductsModal ( producto: producto )
                  );
                }
              ),
              IconButton(
                icon: Icon( Icons.delete_outline, color: Colors.red.withOpacity(0.8)),
                onPressed: () {
                  
                  final dialog = AlertDialog(
                    title: Text('¿Está seguro de borrarlo?'),//products.nombre >>length
                    content: Text('¿Borrar definitivamente ${productos.length }?'),
                    actions: [
                      TextButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Si, borrar'),
                        onPressed: () async {
                          await Provider.of<ProductsProvider>(context, listen: false)
                            .deleteProduct(producto.id);

                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );

                  showDialog(
                    context: context, 
                    builder: ( _ ) => dialog 
                  );


                }
              ),
            ],
          )
        ),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => productos.length;

  @override

  int get selectedRowCount => 0;

}


