import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gomaa/core/constant/components/components.dart';
import 'package:gomaa/core/constant/const/const.dart';
import 'package:gomaa/core/styles/styles.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/cubit.dart';
import 'package:gomaa/features/HomePage/HomePageEmployee/logic/states.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {

  int index;
  int id;
  ProfilePage({required this.index,required this.id});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    var cubit = TasksCubit.get(context);

    var images = cubit.images
        ?.where((image) => image.task_id!.toInt() == cubit.adminTaskForOneUser![widget.index].id!.toInt())
        .map((imageModel) => imageModel.image_path ?? '')
        .toList() ?? [];
    return BlocConsumer<TasksCubit,TasksStates>(
      listener: (context, state) {

      },
      builder: (context, state) =>  Scaffold(
        appBar: appBarDefaultTheme(context: context,
            isReverse: true, title: 'البيانات كاملة'),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(

              children: <Widget>[
                SizedBox(height: 20.h),

                InkWell(
                  onTap: ()
                  {
                    navigateTo(context, ZoomableImage
                      (imageUrls: images,));
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: images.isNotEmpty ? GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,

                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Image.network(
                            images[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ) : Center(child: Text('لا يوجد صور',style: Styles.style16SemiBold,)),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  cubit.users![widget.id].name.toString(),

                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.h),
                Divider(),
                Row(
                  children: [
                    Text(
                      'اسم المهمة : ',
                      style: Styles.style16whiteBold,
                    ),
                    Expanded(
                      child: Text(
                        cubit.adminTaskForOneUser![widget.index].task_name.toString(),
                        style: Styles.style16SemiBold,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),
                Divider(),
                Row(
                  children: [
                    Text(
                      'الوصف : ',
                      style: Styles.style16whiteBold,
                    ),
                    Expanded(
                      child: Text(
                        cubit.adminTaskForOneUser![widget.index].description.toString(),
                        style: Styles.style16SemiBold,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                Divider(),
                Row(
                  children: [
                    Text(
                      ' رقم موبايل العميل : ',
                      style: Styles.style16whiteBold,
                    ),
                    Expanded(
                      child: Text(
                        cubit.adminTaskForOneUser![widget.index].client_phone != null ? cubit.adminTaskForOneUser![widget.index].client_phone.toString() : 'لا يوجد' ,
                        style: Styles.style16SemiBold,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                Divider(),
                Row(
                  children: [
                    Text(
                      ' تاريخ الانتهاء : ',
                      style: Styles.style16whiteBold,
                    ),
                    Expanded(
                      child: Text(
                        cubit.adminTaskForOneUser![widget.index].deadline !=  null ? cubit.adminTaskForOneUser![widget.index].deadline.toString() : 'لا يوجد',
                        style: Styles.style16SemiBold,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                Divider(),
                Row(
                  children: [
                    Text(
                      'الحالة : ',
                      style: Styles.style16whiteBold,
                    ),
                    Expanded(
                      child: Text(
                        ' مكتملة',
                        style: GoogleFonts.cairo(color: primaryColor,fontWeight : FontWeight.w900,fontSize : 16.sp),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),



                Divider(),
                Row(
                  children: [
                    Text(
                      'العنوان الحالي :',
                      style: Styles.style16whiteBold,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: ()
                        {
                          launchUrl(Uri.parse('https://www.google.com/maps/search/?api=1&query=${cubit.adminTaskForOneUser![widget.index].full_address.toString()}'));
                        },
                        child: Text(
                          cubit.adminTaskForOneUser![widget.index].full_address.toString(),
                          style: Styles.style16SemiBold,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),


                Divider(),
                Row(
                  children: [
                    Text(
                     'رابط المكان : ',
                      style: Styles.style16whiteBold,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: ()
                        {
                          launchUrl(Uri.parse(cubit.adminTaskForOneUser![widget.index].url.toString()));
                        },
                        child: Text(
                          cubit.adminTaskForOneUser![widget.index].url != null ? cubit.adminTaskForOneUser![widget.index].url.toString() : 'لا يوجد',
                          style: Styles.style16SemiBold,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),
                Divider(),
                Row(
                  children: [
                    Text(
                    'التاريخ والوقت : ',
                      style: Styles.style16whiteBold,
                    ),
                    Expanded(
                      child: Text(
                        cubit.adminTaskForOneUser![widget.index].updated_at.toString(),
                        style: Styles.style16SemiBold,
                      ),
                    ),
                  ],
                ),
                Text(
                  cubit.adminTaskForOneUser![widget.index].created_at.toString(),
                  style: Styles.style16SemiBold,
                ),
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ZoomableImage extends StatelessWidget {
  final List<String> imageUrls;


  ZoomableImage({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        itemCount: imageUrls.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(imageUrls[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        pageController: PageController(initialPage: 0),
      ),
    );
  }

}