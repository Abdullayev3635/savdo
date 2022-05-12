// class OrderDescriptionWidget extends StatelessWidget {
//   const OrderDescriptionWidget({
//     Key? key,
//     required this.transaction,
//   }) : super(key: key);
//
//   final List<KorzinaCard> transaction;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 8.0.w),
//       child: Theme(
//         data: ThemeData(
//           dividerColor: Colors.transparent,
//         ),
//         child: ExpansionTile(
//           childrenPadding: const EdgeInsets.symmetric(vertical: 10),
//           title: Text(
//             'Buyurtma tafsilotlari:',
//             style: TextStyle(
//                 color: ctext2Color, fontSize: 14.sp, fontFamily: 'Medium'),
//           ),
//           // collapsedIconColor: ,
//           iconColor: cFirstColor,
//           children: [
//             const MySeparator(
//               color: Color(0xffF0F1FF),
//             ),
//             ListView.builder(
//                 padding:
//                     EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 10.h),
//                 physics: const BouncingScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: transaction.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                           width: 200.w,
//                           child: Text(
//                             "${transaction[index].title} fdfdsfsdfdsf",
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 color: cGreyColor2,
//                                 fontSize: 14.sp,
//                                 fontFamily: 'Medium'),
//                           ),
//                         ),
//                         Text(
//                           '${transaction[index].number} x ${transaction[index].price} UZS',
//                           style: TextStyle(
//                               color: cGreyColor2,
//                               fontSize: 14.sp,
//                               fontFamily: 'Medium'),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//             const MySeparator(
//               color: Color(0xffF0F1FF),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
