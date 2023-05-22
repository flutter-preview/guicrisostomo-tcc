import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tcc/controller/postgres/Lists/products.dart';
import 'package:tcc/model/Comments.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/comments.dart';
import 'package:tcc/view/widget/listSizeAvailable.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
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

  List<ProductItemList>? productsVariation;
  List<CommentsProduct> commentsProduct = [];

  String textDateTime = '';

  ProductItemList? productSelect;
  int idProduct = 0;
  String nameProduct = '';
  String? descriptionProduct = '';
  String? urlImageProduct;
  String categoryProduct = '';
  bool isFavorite = false;
  Object? argument;

  @override
  void initState() {
    super.initState();
    argument = widget.arguments;

    getProduct(argument.runtimeType == int).then((value) {
      idProduct = value.id;
      productSelect = value;
      nameProduct = value.name;
      descriptionProduct = value.description;
      urlImageProduct = value.link_image;
      categoryProduct = value.variation!.category;
      isFavorite = value.isFavorite;

      getListVariations().then((value) {
        setState(() {
          productsVariation = value;
        });
      });

      getCommentsProductUser();
      getProductLastSale().then((value) {
        textDateTime = value;
        setState(() {});
      });
    });
  }

  Future<ProductItemList> getProduct([bool isNull = false]) async {
    if (argument.runtimeType == int || isNull) {
      int idProduct = argument as int;
      return await ProductsController().getProduct(idProduct).then((value) {
        return value;
      });
    } else {
      return argument as ProductItemList;
    }
  }

  Future<List<ProductItemList>> getListVariations() async {
    return await ProductsController().getAllProductsVariations(nameProduct, categoryProduct).then((value) {
      return value;
    });
  }

  Future<List<CommentsProduct>> getCommentsProductUser() async {
    if (productSelect == null) {
      return [];
    }
    
    if (commentsProduct.isNotEmpty) {
      return commentsProduct;
    }

    return await ProductsController().getCommentsProductUser(productSelect!.name, productSelect!.variation!.category);
  }

  Future<Widget> getListComments() async {
    if (commentsProduct.isEmpty) {
      commentsProduct = await getCommentsProductUser();
    }

    return comments(context, commentsProduct);
  }

  Future<String> getProductLastSale() async {
    NumberFormat formatter = NumberFormat("00");
    DateTime? lastSale;

    if (productSelect == null) {
      return '';
    }

    return await ProductsController().getProductLastSale(productSelect!.name, productSelect!.variation!.category).then((value) {
      if (value == null) {
        return 'nunca';
      }

      lastSale = value.toLocal();

      return '${formatter.format(lastSale!.day)}/${formatter.format(lastSale!.month)}/${lastSale!.year} às ${formatter.format(lastSale!.hour)}:${formatter.format(lastSale!.minute)}';
    });

  }

  @override
  Widget build(BuildContext context) {

    print('object');

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
                  urlImageProduct ?? 'https://lh3.googleusercontent.com/p/AF1QipM9XLEM_XjI2c-GlcHbZgNmHNYpKPpQbJeUriqO=w600-h0',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            nameProduct,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          IconButton(
                            onPressed: () async {
                              await ProductsController().setProductFavorite(idProduct, isFavorite).then((value) {
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              });
                            },
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      descriptionProduct == null ? const SizedBox() :
                        Text(
                          descriptionProduct!,
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
              
              SectionVisible(
                nameSection: 'Tamanhos disponíveis', 
                isShowPart: true,
                child: productsVariation != null ? 
                  listSize(productsVariation!) : 
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ),

              const SizedBox(height: 10,),
        
              SectionVisible(
                nameSection: 'Informações adicionais',
                isShowPart: true, 
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        iconOrder,
                        fit: BoxFit.scaleDown,
                        height: 20,
                      ),
                
                      Text(
                        'Último pedido: $textDateTime',
                      )
                    ],
                  ),
                ),
              ),
        
              
        
              const SizedBox(height: 10,),
        
              SectionVisible(
                nameSection: 'Comentários', 
                child: Column(
                  children: [
                    FutureBuilder(
                      future: getListComments(),
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
              
                    TextFieldGeneral(
                      label: 'Escrever comentário',
                      variavel: txtComment,
                      keyboardType: TextInputType.text,
                      context: context,
                      ico: Icons.person_outline,
                      icoSuffix: Icons.send_outlined,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        validatorString(value!);
                      },

                      eventPressIconSuffix: () async {
                        await ProductsController().addCommentProductUser(productSelect!.id, FirebaseAuth.instance.currentUser!.uid, txtComment.text);
                        setState(() {
                          getCommentsProductUser();
                        });
                      },
              
                    ),
                  ],
                ),
              ),
            ]
          ),
        )
      ),

      bottomNavigationBar: const Bottom(),
      
      
    );
  }
}