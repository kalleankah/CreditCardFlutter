import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:credit_card_flutter/credit_card_formatter.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({Key? key}) : super(key: key);

  @override
  CreditCardFormState createState() {
    return CreditCardFormState();
  }
}

class CreditCardFormState extends State<CreditCardForm> {
  // Global key that uniquely identifies the Form widget
  final _formKey = GlobalKey<FormState>();

  // Control which background image is used for the card
  final int _cardBackground = Random().nextInt(24) + 1;

  // Text that should appear on the card image
  String _cardNumber = '#### #### #### ####';
  String _cardName = "Card Holder";
  String _cvv = "CVV";
  int? _monthValue;
  int? _yearValue;

  TextStyle cardTextStyleMain = const TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    shadows: <Shadow>[
      Shadow(
        offset: Offset(2.0, 2.0),
        blurRadius: 4.0,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    ],
  );

  setCardNumber(String rawInput) {
    setState(() {
      _cardNumber = rawInput;
    });
  }

  //  Build the app
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      AspectRatio(
          aspectRatio: 675 / 435,
          child: Stack(
            children: <Widget>[
              CreditCardBackground(
                background: _cardBackground,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/images/chip.png'),
                          Image.asset('assets/images/visa.png'),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: Text(
                        _cardNumber,
                        style: cardTextStyleMain,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Text(
                              _cardName.toUpperCase(),
                              style: cardTextStyleMain,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              _cvv,
                              style: cardTextStyleMain,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
      Form(
          key: _formKey,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: TextFormField(
                      onChanged: (String newVal) {
                        setCardNumber(newVal);
                      },
                      keyboardType: TextInputType.number,
                      // inputFormatters: [LengthLimitingTextInputFormatter(16)],
                      inputFormatters: [
                        // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        CreditCardFormatter(
                            mask: '#### #### #### ####', separator: ' ')
                      ],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          labelText: 'Card Number'),
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      onChanged: (String newVal) {
                        setState(() {
                          _cardName = newVal;
                        });
                      },
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          labelText: 'Card Holder'),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 10,
                          fit: FlexFit.tight,
                          child: DecoratedInputContainer(
                            child: DropdownButton<int>(
                                isExpanded: true,
                                underline: const SizedBox(),
                                hint: const Text("Month"),
                                value: _monthValue,
                                items: <int>[
                                  1,
                                  2,
                                  3,
                                  4,
                                  5,
                                  6,
                                  7,
                                  8,
                                  9,
                                  10,
                                  11,
                                  12
                                ].map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (newVal) {
                                  setState(() {
                                    _monthValue = newVal;
                                  });
                                }),
                          ),
                        ),
                        const Spacer(flex: 1),
                        Flexible(
                          flex: 10,
                          fit: FlexFit.tight,
                          child: DecoratedInputContainer(
                            child: DropdownButton<int>(
                                isExpanded: true,
                                underline: const SizedBox(),
                                hint: const Text("Year"),
                                value: _yearValue,
                                items: <int>[
                                  2028,
                                  2027,
                                  2026,
                                  2025,
                                  2024,
                                  2023,
                                  2022,
                                  2021,
                                  2020
                                ].map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (newVal) {
                                  setState(() {
                                    _yearValue = newVal;
                                  });
                                }),
                          ),
                        ),
                        const Spacer(flex: 2),
                        Flexible(
                          flex: 10,
                          fit: FlexFit.tight,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3)
                            ],
                            onChanged: (String newVal) {
                              setState(() {
                                _cvv = newVal;
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                labelText: 'CVV'),
                          ),
                        )
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF0055D4)),
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState?.validate() ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')));
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ]))
    ]);
  }
}

class CreditCardBackground extends StatelessWidget {
  const CreditCardBackground({
    Key? key,
    required this.background,
  }) : super(key: key);

  final int background;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset('assets/images/' + background.toString() + '.jpeg'));
  }
}

class DecoratedInputContainer extends StatelessWidget {
  const DecoratedInputContainer({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(12)),
      child: child,
    );
  }
}
