import 'package:flutter/material.dart';
import 'package:tcc/view/widget/appBar.dart';

class ScreenInfoItem extends StatefulWidget {
  final Object? arguments;
  const ScreenInfoItem({
    super.key,
    required this.arguments,
  });

  @override
  State<ScreenInfoItem> createState() => _ScreenInfoItemState();
}

class _ScreenInfoItemState extends State<ScreenInfoItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Informações do item', 
        context: context,
        withoutIcons: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      'lib/images/imgPizza.png',
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Pizza de Calabresa',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Descrição: Pizza de calabresa com queijo e molho de tomate',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Categoria: Pizza',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Preço: R\$ 20,00',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Tamanho: Grande',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Quantidade: 1',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Comentários:',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Comentário 1',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Comentário 2',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}