import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../providers/product.dart';
import '../const.dart';

enum Page { favorite, allProducts }
enum ProductE {
  id,
  title,
  description,
  price,
  imageUrl,
}

class EditProductScreen extends StatefulWidget {
  EditProductScreen({Key? key}) : super(key: key);
  static const routeName = '/editProductScreen';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  /*ubdating or adding product*/
  bool ifInit = false;
  var productProperties = {
    ProductE.id: DateTime.now().toString(),
    ProductE.title: '',
    ProductE.description: '',
    ProductE.imageUrl: '',
    ProductE.price: '',
  };

  var _editedProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');

/*controlers form*/
  final imgUrlControler = TextEditingController();

  final FocusNode focNtitl = FocusNode();
  final FocusNode focNprice = FocusNode();
  final FocusNode focNimageUrl = FocusNode();
  late Products products;

  void setFocus(BuildContext context, FocusNode currant, FocusNode next) {
    void setState(VoidCallback fn) {
      currant.unfocus();
      if (next != null) {
        FocusScope.of(context).requestFocus(next);
      }
      super.setState(fn);
    }
  }

  @override
  void didChangeDependencies() {
    /*in init state you are not allowed to use ModalRoute*/
    if (!ifInit) {
      var routArgs = ModalRoute.of(context)!.settings.arguments != null
          ? ModalRoute.of(context)!.settings.arguments as Product
          : null;
      products = Provider.of<Products>(context, listen: false);
      /*if product exist ubdate map for display in text fields*/
      if (routArgs != null) {
        productProperties = {
          ProductE.id: routArgs.id,
          ProductE.price: routArgs.price.toString(),
          ProductE.title: routArgs.title,
          ProductE.description: routArgs.description,
        };
        /*becouse textField can have init value and controler*/
        imgUrlControler.text = routArgs.imageUrl;
      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    focNtitl.dispose();
    focNprice.dispose();
    focNimageUrl.dispose();
    imgUrlControler.dispose();
    super.dispose();
  }

  void _ubdateUI() {
    /*Ubdate Ui*/
    setState(() {});
  }

  void initState() {
    /*add listen to changes*/
    focNimageUrl.addListener(_ubdateUI);
  }

  final _form = GlobalKey<FormState>();

  void _savedForm() {
    if(_form.currentState!.validate()){
      _form.currentState!.save();
      if (products.products.any((element) => element.id == _editedProduct.id)) {
        products.ubdateProduct(_editedProduct);
      } else {
        products.addProduct(_editedProduct);
      }
      Navigator.pop(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBacground,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit',
          style: kTextTitle,
        ),
        backgroundColor: kColorMain,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: _savedForm,
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: value??'',
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                  },
                  initialValue: productProperties[ProductE.title],
                  focusNode: focNtitl,
                  onFieldSubmitted: (value) => setFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kColorMain)),
                    label: Text(
                      'Title',
                      style: kTextSubtitle,
                    ),
                    focusColor: kColorMain,
                    hoverColor: kColorMain,
                  ),
                ),
                TextFormField(
                  validator: (valu) {
                    if (valu!.isEmpty) {
                      return 'U have to give the prise';
                    }
                    if (double.parse(valu) < 5) {
                      return 'U have to give at number grater then 5';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: double.parse(value ?? ''),
                        imageUrl: _editedProduct.imageUrl);
                  },
                  initialValue: productProperties[ProductE.price],
                  focusNode: focNprice,
                  onFieldSubmitted: (value) =>
                      setFocus(context, focNprice, focNimageUrl),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kColorMain)),
                    label: Text(
                      'Price',
                      style: kTextSubtitle,
                    ),
                    focusColor: kColorMain,
                    hoverColor: kColorMain,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (valu) {
                    if (valu!.isEmpty) {
                      return 'U have to give the description';
                    }
                    if (valu.length < 10) {
                      return 'U have to give at least 10 characters';
                    }
                    return null;
                  },
                  initialValue: productProperties[ProductE.description],
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: value ?? '',
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                  },
                  textInputAction: TextInputAction.newline,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelStyle: kText,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kColorMain)),
                    label: Text(
                      'Description',
                      style: kTextSubtitle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: imgUrlControler.text.isEmpty
                            ? Text('There is no image to display',
                                textAlign: TextAlign.center, style: kText)
                            : Container(
                                height: 150,
                                child: Image.network(
                                  imgUrlControler.text,
                                  fit: BoxFit.cover,
                                ))),
                    SizedBox(
                      width: 20,
                    ),
                    /*imgUrlControler.text.isEmpty
                        ?*/
                    Expanded(
                      child: TextFormField(
                        validator: (valu) {
                          if (valu!.isEmpty) {
                            return 'U have to give the image url';
                          }
                          if (!Uri.parse(valu).isAbsolute) {
                            return 'U have to give valid image URL';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: imgUrlControler.text);
                        },
                        focusNode: focNimageUrl,
                        controller: imgUrlControler,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.url,
                        decoration: InputDecoration(
                          labelStyle: kText,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kColorMain)),
                          label: Text(
                            'Image Url',
                            style: kTextSubtitle,
                          ),
                          /*focusColor: kColorMain,
                          hoverColor: kColorMain,*/
                        ),
                      ),
                    )
                    /* : Container(),*/
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatefulWidget {
  final FocusNode _currantFocN;
  final String lable;
  final TextInputType keybordType;
  final String? initialValue;
  FocusNode? nextFocN;
  Function onSaved;

  CustomTextFormField({
    Key? key,
    required FocusNode currantFocN,
    required this.lable,
    required this.keybordType,
    required this.onSaved,
    this.nextFocN,
    this.initialValue,
  })  : _currantFocN = currantFocN,
        super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  void setFocus(BuildContext context) {
    void setState(VoidCallback fn) {
      widget._currantFocN.unfocus();
      if (widget.nextFocN != null) {
        FocusScope.of(context).requestFocus(widget.nextFocN);
      }
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (value) {
        widget.onSaved(value);
      },
      initialValue: widget.initialValue,
      focusNode: widget._currantFocN,
      onFieldSubmitted: (value) => setFocus,
      textInputAction: TextInputAction.next,
      keyboardType: widget.keybordType,
      decoration: InputDecoration(
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: kColorMain)),
        labelStyle: TextStyle(
            color: widget._currantFocN.hasFocus ? kColorMain : Colors.white),
        label: Text(
          widget.lable,
          style: kTextSubtitle,
        ),
        focusColor: kColorMain,
        hoverColor: kColorMain,
      ),
    );
  }
}
