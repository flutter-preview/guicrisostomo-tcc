import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/model/Comments.dart';

Widget comments(context, List<CommentsProduct> list) {
  return ListView.builder(
    itemCount: list.length,
    shrinkWrap:true,
    scrollDirection: Axis.vertical,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      NumberFormat formatter = NumberFormat("00");
      
      DateTime date = list[index].date.toLocal();
      String dateFormatted = '${formatter.format(date.day)}/${formatter.format(date.month)}/${formatter.format(date.year)}';
      String hourFormatted = '${formatter.format(date.hour)}:${formatter.format(date.minute)}';

      return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.1),
              width: 5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          list[index].urlImageUser ?? 'https://i.pinimg.com/originals/0f/4c/3e/0f4c3e2e0b5b5b0b5b0b5b0b5b0b5b0b.jpg',
                        ),
                      ),
              
                      const SizedBox(width: 10),
              
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list[index].nameUser,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: globals.primary,
                            ),
                          ),
      
                          Text(
                            '$dateFormatted às $hourFormatted',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              Text(
                list[index].comment,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    }
  );
}