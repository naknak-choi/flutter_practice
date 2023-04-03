import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String moneyName, code, amount;
  final IconData icon;
  final bool isInverted;
  final double order;

  final _blackColor = const Color(0xFF181818);

  const CurrencyCard({
    super.key,
    required this.moneyName,
    required this.code,
    required this.amount,
    required this.icon,
    required this.isInverted,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Transform.translate(
      offset: Offset(0, -20 * order),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isInverted ? Colors.white : _blackColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    moneyName,
                    style: TextStyle(
                      color: isInverted ? _blackColor : Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        amount,
                        style: TextStyle(
                          color: isInverted ? _blackColor : Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        code,
                        style: TextStyle(
                          color: isInverted
                              ? Colors.black.withOpacity(0.5)
                              : Colors.white.withOpacity(0.5),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.scale(
                scale: 2.2,
                child: Transform.translate(
                  offset: const Offset(-5, 10),
                  child: Icon(
                    icon,
                    color: isInverted ? _blackColor : Colors.white,
                    size: 88,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
