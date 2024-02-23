import 'package:flutter/material.dart';
import 'package:statefulapp/details.dart';

enum ProductEnumType { Free, Paid }

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  var _abc;
  var _def;
  final productController = TextEditingController();
  final productDesController = TextEditingController();
  bool? _chek = false;
  ProductEnumType? _productEnumType;

  final dropDownItems = {"Clothing", "Electronic", "Service"};

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    productController.dispose();
    productDesController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productController.addListener(updateValue);
    productDesController.addListener(updateValue);
  }

  void updateValue() {
    setState(() {
      _abc = productController.text;
      _def = productDesController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FORM"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              "Add products in the form below:",
              style: TextStyle(
                fontSize: 34.0,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20.0),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: productController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter A value';
                        } else
                          null;
                      },
                      decoration: const InputDecoration(
                          label: Text("Product name"),
                          icon: Icon(Icons.abc),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: productDesController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter A value';
                        } else
                          null;
                      },
                      decoration: const InputDecoration(
                          label: Text("Product Description"),
                          icon: Icon(Icons.text_snippet_outlined),
                          border: OutlineInputBorder()),
                    ),
                    // Text("product name is ${productController.text}"),
                    // Text("product name is ${productDesController.text}"),
                    const SizedBox(height: 10.0),
                    // Checkbox(
                    //   tristate: true,

                    //     value: _chek,
                    //     onChanged: ((val) {
                    //       setState(() {
                    //         _chek = val;
                    //       });
                    //     })),
                    const SizedBox(height: 10.0),
                    CheckboxListTile(
                      // tristate: true,
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.all(0.00),
                      value: _chek,
                      title: const Text("Top Product"),
                      onChanged: (val) {
                        setState(() {
                          _chek = val;
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                              title: Text(ProductEnumType.Free.name),
                              contentPadding: EdgeInsets.all(0.00),
                              value: ProductEnumType.Free,
                              groupValue: _productEnumType,
                              onChanged: (val) {
                                setState(() {
                                  _productEnumType = val;
                                });
                              }),
                        ),
                        SizedBox(width: 5.0),
                        Expanded(
                          child: RadioListTile(
                              title: Text(ProductEnumType.Paid.name),
                              contentPadding: EdgeInsets.all(0.00),
                              value: ProductEnumType.Paid,
                              groupValue: _productEnumType,
                              onChanged: (val) {
                                setState(() {
                                  _productEnumType = val;
                                });
                              }),
                        )
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    DropdownButtonFormField(
                      items: dropDownItems
                          .map(
                              (e) => DropdownMenuItem(child: Text(e), value: e))
                          .toList(),
                      onChanged: (val) {},
                      icon: const Icon(Icons.arrow_drop_down_circle_outlined,
                          color: Colors.blue),
                      decoration: const InputDecoration(
                          labelText: "Type", icon: Icon(Icons.electric_moped)),
                    ),
                    const SizedBox(height: 30.0),
                    MyButton(context)
                  ],
                )),

            //         OutlinedButton(
            //   style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return Details(productName: productController.text,);
            //         },
            //       ),
            //     );
            //   },
            //   child: const Text(
            //     "SUBMIT FORM",
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            // )
            // MyButton(context),
          ],
        ),
      ),
    );
  }

  OutlinedButton MyButton(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Details(
                productName: productController.text,
              );
            },
          ),
        );
      },
      child: const Text(
        "SUBMIT FORM",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
