import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

class PartFinalizeOrder extends StatefulWidget {
  final int partUser;

  const PartFinalizeOrder({super.key, required this.partUser});

  @override
  State<PartFinalizeOrder> createState() => _PartFinalizeOrderState();
}

class _PartFinalizeOrderState extends State<PartFinalizeOrder> {
  bool isShowPart = false;
  Icon iconPart = const Icon(Icons.arrow_right_rounded);

  bool isShowDescriptionPart1 = false;
  Icon iconDescriptionPart1 = const Icon(Icons.arrow_right_rounded);

  bool isShowDescriptionPart2 = false;
  Icon iconDescriptionPart2 = const Icon(Icons.arrow_right_rounded);

  bool isShowDescriptionPart3 = false;
  Icon iconDescriptionPart3 = const Icon(Icons.arrow_right_rounded);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Etapas',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            IconButton(
              icon: iconPart,
              onPressed: () {
                setState(() {
                  isShowPart = !isShowPart;
                });
                  
                if (isShowPart) {
                  setState(() {
                    iconPart = const Icon(Icons.arrow_drop_down_rounded);
                  });
                } else {
                  setState(() {
                    iconPart = const Icon(Icons.arrow_right_rounded);
                  });
                }
              },
            ),
          ],
        ),

        const SizedBox(height: 10),

        if (isShowPart)
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.phone_android, color: globals.primary),

                  const SizedBox(width: 10),

                  Flexible(
                    child: Text(
                      widget.partUser == 1 ? 'Etapa 1: Obtendo informações como nome e telefone - Você está aqui.' : 'Etapa 1: Obtendo informações como nome e telefone.',
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  IconButton(
                    icon: iconDescriptionPart1,
                    onPressed: () {
                      setState(() {
                        isShowDescriptionPart1 = !isShowDescriptionPart1;
                      });
                        
                      if (isShowDescriptionPart1) {
                        setState(() {
                          iconDescriptionPart1 = const Icon(Icons.arrow_drop_down_rounded);
                        });
                      } else {
                        setState(() {
                          iconDescriptionPart1 = const Icon(Icons.arrow_right_rounded);
                        });
                      }
                    },
                  ),
                ],
              ),

              if (isShowDescriptionPart1)
                const Text(
                  'Essas informações serão usadas para identificar seu pedido e para que você possa acompanhar o status do mesmo.',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),

              const SizedBox(height: 10),

              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on_outlined, color: globals.primary),

                  const SizedBox(width: 10),

                  Flexible(
                    child: Text(
                      widget.partUser == 2 ? 'Etapa 2: Obtendo informações do local de entrega - Você está aqui.' : 'Etapa 2: Obtendo informações do local de entrega.',
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  IconButton(
                    icon: iconDescriptionPart2,
                    onPressed: () {
                      setState(() {
                        isShowDescriptionPart2 = !isShowDescriptionPart2;
                      });
                        
                      if (isShowDescriptionPart2) {
                        setState(() {
                          iconDescriptionPart2 = const Icon(Icons.arrow_drop_down_rounded);
                        });
                      } else {
                        setState(() {
                          iconDescriptionPart2 = const Icon(Icons.arrow_right_rounded);
                        });
                      }
                    },
                  ),
                ],
              ),

              if (isShowDescriptionPart2)
                const Text(
                  'Essas informações serão usadas entregar o produto ao endereço indicado.',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),

              const SizedBox(height: 10),

              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.attach_money, color: globals.primary),

                  const SizedBox(width: 10),

                  Flexible(
                    child: Text(
                      widget.partUser == 3 ? 'Etapa 3: Obtendo informações de pagamento - Você está aqui.' : 'Etapa 3: Obtendo informações de pagamento.',
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  IconButton(
                    icon: iconDescriptionPart3,
                    onPressed: () {
                      setState(() {
                        isShowDescriptionPart3 = !isShowDescriptionPart3;
                      });
                        
                      if (isShowDescriptionPart3) {
                        setState(() {
                          iconDescriptionPart3 = const Icon(Icons.arrow_drop_down_rounded);
                        });
                      } else {
                        setState(() {
                          iconDescriptionPart3 = const Icon(Icons.arrow_right_rounded);
                        });
                      }
                    },
                  ),
                ],
              ),

              if (isShowDescriptionPart3)
                const Text(
                  'Essas informações serão para mostrar ao estabelicemento sobre a sua forma de pagamento.',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
            ],
          ),
        ],
    );
  }
}