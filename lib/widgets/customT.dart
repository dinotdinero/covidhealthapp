import 'package:flutter/material.dart';



class CustomTextField extends StatelessWidget
{
  final TextEditingController contr;
  final IconData image;
  final String hintT;
  bool iso = true;



  CustomTextField(
      {Key key, this.contr, this.image, this.hintT,this.iso}
      ) : super(key: key);



  @override
  Widget build(BuildContext context)
  {
    return Container
      (
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: contr,
        obscureText: iso,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            image,
            color: Colors.amber,
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintT,
        ),
      ),

    );
  }
}
