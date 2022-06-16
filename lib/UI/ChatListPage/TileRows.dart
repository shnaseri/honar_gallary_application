import 'package:flutter/material.dart';

ListTile tile({required String msg,required IconData im}) {
  return ListTile(
    leading: Icon(im,color: Colors.black54,size: 30,),
    title: Text(msg,style: const TextStyle(color: Colors.black54,fontSize: 18,fontWeight: FontWeight.w800),),
  );
}

ListTile list({required String url,required String name,required String tym,required String desc,required String msg,required bool isRead}) {
  return ListTile(
    contentPadding: const EdgeInsets.only(top: 5, left: 10),
    leading: CircleAvatar(
      radius: 30,
      backgroundImage: ExactAssetImage(url),
    ),
    title: Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19
          ),),
          Text(tym, style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14
          ),),
        ],
      ),
    ),
    subtitle: Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(desc, style: const TextStyle(fontWeight: FontWeight.w500),),
          Container(
            width: 20,
            height: 20,
            child: Align(
                child: Text(msg, style: const TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),),
                alignment: const Alignment(0.1, 0.6)
            ),
            decoration: BoxDecoration(
              // border: isRead ? Border.all(width: 1) : Border.all(width: 0),
              borderRadius: BorderRadius.circular(500),
              color: isRead ? Colors.green : Colors.white,
            ),
          )
        ],
      ),
    ),
  );
}