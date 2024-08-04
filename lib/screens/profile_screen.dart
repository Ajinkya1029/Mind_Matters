import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget{
  ProfileScreen({super.key});
  @override
  State<ProfileScreen>createState()=>_ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen>{
  @override
  Widget build(BuildContext context){
    return const Padding(
      padding:  EdgeInsets.all(5),
      child: Column(children: <Widget>[
        Row(children: <Widget>[],),
        Row(children: <Widget>[],),
        Column(children: <Widget>[],)
      
      
      
      ],),
    );
  }
}