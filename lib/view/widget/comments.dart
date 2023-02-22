import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

Widget comments(context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ],
    ),

    child: ListView.builder(

      itemCount: 2,
      shrinkWrap:true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('lib/images/imgMe.png'),
                      ),
              
                      const SizedBox(width: 10),
              
                      Text(
                        'Nome do cliente',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: globals.primary,
                        ),
                      ),
                    ],
                  ),
              
                  const Text(
                    'Data',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc vel aliquam lacinia, nunc nisl aliquam nisl, vel aliquam nisl nisl sit amet nisl. Sed euismod, nunc vel aliquam lacinia, nunc nisl aliquam nisl, vel aliquam nisl nisl sit amet nisl.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54
                ),
              ),
            ],
          ),
        );
      }
    ),
  );
}