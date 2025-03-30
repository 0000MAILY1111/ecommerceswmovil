import 'package:admin_dashboard/models/products.dart';
import 'package:admin_dashboard/providers/products_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsModal extends StatefulWidget {

   final Producto? producto;
   
   const ProductsModal({Key? key, this.producto}) : super(key: key);

  @override
  State<ProductsModal> createState() => _ProductsModalState();
}

class _ProductsModalState extends State<ProductsModal> {
String nombre = '';
String descripcion = '';
double precio = 0;  
String disponible = '';
String img = '';
String? id ; 

@override
void initState() {
  super.initState();

  id = ( widget.producto?.id )!;
  nombre = ( widget.producto?.nombre )!;
  descripcion = ( widget.producto?.descripcion )!;
  precio = ( widget.producto?.precio )!;

}


  @override
  Widget build(BuildContext context) {

    final productsProvider = Provider.of<ProductsProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.all(20),
      height: 500,
      width: 300, // expanded
      decoration: buildBoxDecoration(),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( widget.producto?.nombre ?? 'Nueva Produto', style: CustomLabels.h1.copyWith( color: Colors.white )    ),
              IconButton(
                icon: Icon( Icons.close, color: Colors.white, ), 
                onPressed: () => Navigator.of(context).pop()
              )
            ],
          ),

          Divider( color: Colors.white.withOpacity(0.3 )),

          SizedBox(height: 20 ),

          TextFormField(
            initialValue: widget.producto?.nombre ?? '',
            onChanged: ( value ) => nombre = value,
            decoration: CustomInputs.loginInputDecoration(
              hint: 'Nombre del producto', 
              label: 'Producto', 
              icon: Icons.new_releases_outlined
            ),
            style: TextStyle( color: Colors.white ),
          ),

          Container(
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedButton(
              onPressed: () async{
                
                try {
                  if( id == null ) {
                    // Crear
                    await productsProvider.newProduct(nombre);
                    NotificationsService.showSnackbar('$nombre creado!');

                  } else {
                    // Actualizar
                    await productsProvider.updateProduct( id!, nombre );
                    NotificationsService.showSnackbar('$nombre Actualizado!');
                  }

                  Navigator.of(context).pop();

                } catch (e) {
                  Navigator.of(context).pop();
                  NotificationsService.showSnackbarError('No se pudo guardar el Producto');
                }
                
          
                

              },
              text: 'Guardar',
              color: Colors.white, recognizer: null,
            ),
          )

        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
    borderRadius: BorderRadius.only( topLeft:  Radius.circular(20), topRight: Radius.circular(20) ),
    color: Color(0xff0F2041),
    boxShadow: [
      BoxShadow(
        color: Colors.black26
      )
    ]
  );
}