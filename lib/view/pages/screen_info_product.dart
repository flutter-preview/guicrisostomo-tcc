import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tcc/controller/mysql/Lists/products.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/model/Variation.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/comments.dart';
import 'package:tcc/view/widget/listSizeAvailable.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenInfoProduct extends StatefulWidget {
  final Object? arguments;

  const ScreenInfoProduct({
    super.key,
    required this.arguments,
  });

  @override
  State<ScreenInfoProduct> createState() => _ScreenInfoProductState();
}

class _ScreenInfoProductState extends State<ScreenInfoProduct> {
  final String imgPizza = 'lib/images/imgPizza.png';

  final String iconOrder = 'lib/images/iconOrder.svg';

  var txtComment = TextEditingController();

  List<ProductItemList> productsVariation = [];

  @override
  Widget build(BuildContext context) {
    ProductItemList productSelect = widget.arguments as ProductItemList;

    String nameProduct = productSelect.name;
    String descriptionProduct = productSelect.description!;
    String? urlImageProduct = productSelect.link_image;
    String categoryProduct = productSelect.variation!.category;

    Future<void> getAllVariations() async {
      productsVariation = await ProductsController().getAllProductsVariations(nameProduct, categoryProduct);
    }

    Future<Widget> getListVariations() async {
      
      if (productsVariation.isEmpty) {
        await getAllVariations();
      }

      return listSize(productsVariation);
    }

    if (productsVariation.isEmpty) {
      getAllVariations();
    }

    print('b');

    return Scaffold(
      
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  urlImageProduct ?? imgPizza,
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
              ),
            ),
          
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                  child: Row(
                    children: [
                      
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                
                      const Text(
                        'Informações',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              
                
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        nameProduct,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                
                      Text(
                        descriptionProduct,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ]
                  ),
                ),
              ]
            )
          ),
        ),
      ),
    
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10,),
        
              const Center(
                child: Text(
                  'Tamanhos disponíveis',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
        
              const SizedBox(height: 10,),
        
              FutureBuilder(
                future: getListVariations(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data as Widget;
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),

              const SizedBox(height: 10,),
        
              const Center(
                child: Text(
                  'Informações adicionais',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
        
              const SizedBox(height: 10,),
        
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      iconOrder,
                      fit: BoxFit.scaleDown,
                      height: 20,
                    ),
              
                    const Text(
                      'Último pedido: 19:52 do dia 27/05/2022'
                    )
                  ],
                ),
              ),
        
              const SizedBox(height: 10,),
        
              const Text(
                'Comentários',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
        
              const SizedBox(height: 10,),
        
              comments(context),
        
              const SizedBox(height: 10,),
        
              TextFieldGeneral(
                label: 'Escrever comentário',
                variavel: txtComment,
                keyboardType: TextInputType.text,
                context: context,
                ico: Icons.person_outline,
                icoSuffix: Icons.send_outlined,
                validator: (value) {
                  validatorString(value!);
                },

                eventPressIconSuffix: () {
                  
                },
        
              ),
            ]
          ),
        )
      ),

      bottomNavigationBar: const Bottom(),
      
    );
  }
}