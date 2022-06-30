// ignore_for_file: non_constant_identifier_names


// class KorzinaCardModel extends StatefulWidget {
//   const KorzinaCardModel({
//     Key? key,
//     required this.number,
//     required this.image,
//     required this.title,
//     required this.price,
//     required this.id,
//   }) : super(key: key);
//   final String? title;
//   final String? image;
//   final int? price;
//   final int? id;
//   final int? number;
//
//   @override
//   _KorzinaCardModelState createState() => _KorzinaCardModelState();
// }
//
// class _KorzinaCardModelState extends State<KorzinaCardModel> {
//   @override
//   Widget build(BuildContext context) {
//     var box = Hive.box<KorzinaCard>('korzina_box');
//     KorzinaCard? cad = box.getAt(widget.id!);
//     return Container(
//         width: 314.w,
//         height: 87.h,
//         margin: const EdgeInsets.only(bottom: 12),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15.r),
//           color: primaryColor,
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 67.w,
//               height: 67.h,
//               margin: const EdgeInsets.all(11),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: cWhiteColor),
//               child: Image.asset(widget.image!),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: 12.h),
//                   child: SizedBox(
//                     width: 150,
//                     child: AutoSizeText(
//                       widget.title!,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: textStyleBlack16,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   '${widget.price!} so’m',
//                   style: TextStyle(
//                       color: ctext2Color,
//                       fontSize: 13.sp,
//                       fontFamily: 'Medium'),
//                 ),
//               ],
//             ),
//             const Spacer(),
//             Padding(
//               padding: EdgeInsets.only(right: 19.0.w),
//               child: Text(
//                 'x${widget.number!}',
//                 style: TextStyle(
//                     color: cFirstColor,
//                     fontSize: 16.sp,
//                     fontFamily: 'Medium'),
//               ),
//             ),
//           ],
//         ));
//   }
// }

class Maxsulotlar {
  final String title;
  final String image;
  final int price;
  final int id;

  final List hajmi;


  Maxsulotlar({
    required this.title,
    required this.image,
    required this.price,
    required this.id,
    required this.hajmi,
  });
}

List<Maxsulotlar> maxsulot_list = [
  Maxsulotlar(
    hajmi: [1, 2, 3, 4, 5, 6],
    title: 'Chiken',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 0,
  ),
  Maxsulotlar(
    hajmi: [12],
    title: 'Chiken',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 1,
  ),
  Maxsulotlar(
    hajmi: [1, 2, 3, 4, 5, 6],
    title: 'Chikenfdsafdsfsssssaaaaa',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 2,
  ),
  Maxsulotlar(
    hajmi: [1, 2, 3, 4, 5, 6],
    title: 'Chiken',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 3,
  ),
  Maxsulotlar(
    hajmi: [1, 2, 3, 4, 5, 6],
    title: 'Chikenfdsaaaaaadsfa',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 4,
  ),
  Maxsulotlar(
    hajmi: [1, 2, 3, 4, 5, 6],
    title: 'Chiken',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 5,
  ),
  Maxsulotlar(
    hajmi: [1, 2, 3, 4, 5, 6],
    title: 'Chikenfdsafdsfsssssa',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 6,
  ),
  Maxsulotlar(
    hajmi: [1, 2, 3, 4, 5, 6],
    title: 'Chiken',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 7,
  ),
  Maxsulotlar(
    hajmi: [1, 2, 3, 4, 5, 6],
    title: 'Chiken',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 8,
  ),
  Maxsulotlar(
    hajmi: [1, 2, 3, 4, 5, 6],
    title: 'Chiken',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 9,
  ),
  Maxsulotlar(
    hajmi: [1, 2, 3, 4, 5, 6],
    title: 'Chiken',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 10,
  ),
  Maxsulotlar(
    hajmi: [1, 2, 3, 4, 5, 6],
    title: 'Chiken',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 11,
  ),
  Maxsulotlar(
    hajmi: [1, 2, 3, 4, 5, 6],
    title: 'Chiken',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 12,
  ),
  Maxsulotlar(
    hajmi: [1, 2, 3, 4, 5, 6],
    title: 'Chiken',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 13,
  ),
  Maxsulotlar(
    hajmi: [1, 2, 3, 4, 5, 6],
    title: 'Chiken',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 14,
  ),
  Maxsulotlar(
    hajmi: [1, 2, 3, 4, 5, 6],
    title: 'Chiken',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 15,
  ),
  Maxsulotlar(
    hajmi: [1, 2, 3, 4, 5, 6],
    title: 'Chiken',
    image: 'assets/images/vaqtinchalik/scale_1200 1.png',
    price: 15000,
    id: 16,
  ),
];
