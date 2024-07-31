import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant/components/components.dart';
import '../../../core/constant/const/const.dart';
import '../../../core/styles/styles.dart';

class FilterDetails extends StatefulWidget {
  const FilterDetails({Key? key}) : super(key: key);

  @override
  State<FilterDetails> createState() => _FilterDetailsState();
}

class _FilterDetailsState extends State<FilterDetails> {

  @override
  Widget build(BuildContext context) {
    return ListView(

      children: [
        Row(children: [


          InkWell(
              onTap: ()
              {
                Navigator.pop(context);
              },
              child: const Icon(Icons.highlight_remove_rounded))
        ],),
        SizedBox(height: 20.h,),
        Text('المهمات',style: Styles.style16whiteBold,),
        SizedBox(height: 10.h,),

        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customContainer(width: 167.w,text: 'مهمات يومية' ),
            SizedBox(height: 15.h,),
            customContainer(width: 167.w,text: 'مهمات أسبوعية'),
            SizedBox(height: 15.h,),
            customContainer(width: 167.w,text: 'مهمات شهرية'),
          ],),

        SizedBox(height: 20.h,),
        defaultButton(context: context, text: 'اختيار',
            width: 120.w, height: 40.h, textSize: 14.sp, toPage: ()
            {
              Navigator.pop(context);
            }),
      ],);
  }
}
