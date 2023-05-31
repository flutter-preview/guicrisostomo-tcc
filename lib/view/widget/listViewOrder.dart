import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tcc/model/Sales.dart';
import 'package:tcc/globals.dart' as globals;

Widget listViewOrder(List<Sales> dados) {

  return ListView.builder(
    itemCount: dados.length,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      Sales item = dados[index];
      DateTime date = item.date;
      String dateText = DateFormat("d 'de' MMMM 'de' y 'às' HH':'mm':'ss", "pt_BR").format(date);
      num total = item.total;
      String status = item.status;

      return Card(
        color: Colors.white,
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          leading: status == 'Andamento' ? Icon(
            Icons.timer_outlined,
            color: globals.primary,
          ) : status == 'Finalizado' ? Icon(
            Icons.check_circle,
            color: globals.primary,
          ) : status == 'Cancelado' ? Icon(
            Icons.cancel_outlined,
            color: globals.primary,
          ) : Icon(
            Icons.check_circle_outline,
            color: globals.primary,
          ),

          title: Text(
            'Data: $dateText',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),

              Text(
                'Total: R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),

              /*Text(
                'Tipo: entrega',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),*/
            ]
          ),

          //EVENTO DE CLIQUE
          onTap: ()  {
            // print('Clicou no item ${dados.docs[index]}');
            GoRouter.of(context).push('/order/info', extra: item);
          },
        )
      );
    },
  );  
}