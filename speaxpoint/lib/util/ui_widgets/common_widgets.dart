import 'package:flutter/material.dart';

SnackBar getSnackBar({required Text text, required Color color}) {
  return SnackBar(
    content: text,
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
  );
}


        //  Card(
        //           margin: const EdgeInsets.all(0),
        //           elevation: 0,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(
        //                 CommonUIProperties.cardRoundedEdges),
        //             side: const BorderSide(
        //               width: 1.3,
        //               style: BorderStyle.solid,
        //               color: Color(AppMainColors.p20),
        //             ),
        //           ),
        //           child: ListTile(
        //             contentPadding: const EdgeInsets.only(
        //               left: 10,
        //               right: 10,
        //             ),
        //             leading: ClipRRect(
        //               borderRadius: BorderRadius.circular(25.0),
        //               child: CachedNetworkImage(
        //                   fit: BoxFit.cover,
        //                   width: 45,
        //                   height: 45,
        //                   placeholder: (context, url) =>
        //                       const CircularProgressIndicator(),
        //                   errorWidget: (context, url, error) =>
        //                       const Icon(Icons.error),
        //                   imageUrl:
        //                       "https://www.incimages.com/uploaded_files/image/1920x1080/getty_481292845_77896.jpg"),
        //             ),
        //             title: const Text(
        //               "Hamzeh Bajbouj",
        //               style: TextStyle(
        //                 fontFamily: CommonUIProperties.fontType,
        //                 fontSize: 13,
        //                 fontWeight: FontWeight.w500,
        //                 color: Color(AppMainColors.p90),
        //               ),
        //             ),
        //             subtitle: const Text(
        //               "Vice president of education",
        //               style: TextStyle(
        //                 fontFamily: CommonUIProperties.fontType,
        //                 fontSize: 13,
        //                 fontWeight: FontWeight.normal,
        //                 color: Color(AppMainColors.p40),
        //               ),
        //             ),
        //             trailing: IconButton(
        //               onPressed: () {
        //                 if (widget.fromSetUpRouter) {
        //                   //here we are able to go to the ClubProfileManagementSetUpRouter but when we try ManageMemberAccountSetUpRouter we go no where
        //                   context.pushRoute(SetAndManageMemberAccountRouter(
        //                       isInEditMode: true));
        //                 } else {
        //                   //this one works but it doesn't include the return navigation button
        //                   // context.router.pushNamed(
        //                   //     "/clubPresidentHomeScreen/clubPresidentDashboard/manageMemberAccount/true");
        //                   //this one is the correct one
        //                   context.pushRoute(ManageAccountRouter(
        //                       isInEditMode: true, isTheUserPresidentl: true));
        //                 }
        //               },
        //               icon: const Icon(
        //                 Icons.settings_outlined,
        //                 color: Color(AppMainColors.p40),
        //                 size: 23,
        //               ),
        //             ),
        //           ),
        //         ),