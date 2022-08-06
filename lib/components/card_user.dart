import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logique_techtest/components/rounded_container.dart';

class CardUser extends StatelessWidget {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? title;
  final String? picture;
  final Function() onTap;

  const CardUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.picture,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: RoundedContainer(
        border: true,
        borderWidth: 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: ExtendedImage.network(
                picture ?? "",
                width: 125,
                cache: true,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text("$title $firstName $lastName"),
          ],
        ),
      ),
    );
  }
}
