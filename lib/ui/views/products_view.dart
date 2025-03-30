


import 'package:admin_dashboard/datatables/products_datasource.dart';
import 'package:admin_dashboard/providers/products_provider.dart';
import 'package:admin_dashboard/ui/buttons/custom_icon_button.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:admin_dashboard/ui/modals/products_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatefulWidget {

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();

    Provider.of<ProductsProvider>(context, listen: false).getProducts();

  }


  @override
  Widget build(BuildContext context) {

    final producto = Provider.of<ProductsProvider>(context).productos;

    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Productos', style: CustomLabels.h1 ),

          SizedBox( height: 10 ),

          PaginatedDataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Productos')),
                DataColumn(label: Text('Creado por')),
                DataColumn(label: Text('Acciones')),
              ], 
              source: ProductsDTS( producto, context ),
              header: Text('Producto disponibles', maxLines: 2 ),
              onRowsPerPageChanged: ( value ) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              rowsPerPage: _rowsPerPage,
              actions: [
                CustomIconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context, 
                      builder: ( _ ) => ProductsModal( producto: null )
                    );
                  }, 
                  text: 'Crear', 
                  icon: Icons.add_outlined,
                )
              ],
            )

        ],
      ),
    );
  }
}