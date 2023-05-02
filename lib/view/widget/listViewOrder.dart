import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/main.dart';
import 'package:tcc/model/Sales.dart';

Widget listViewOrder(List<Sales> dados) {

  return ListView.builder(
    itemCount: dados.length,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      Sales item = dados[index];
      DateTime date = item.date;
      String dateText = DateFormat("d 'de' MMMM 'de' y 'às' HH':'mm':'ss", "pt_BR").format(date);
      num total = item.total;

      return Card(
        color: Colors.white,
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          
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
            Navigator.push(
              context,
              // 'order/info',
              navigator('order/info', item)

            //   //Passagem de parâmetro
              // arguments: dados.docs[index],

            );
          },
        )
      );
    },
  );  
}