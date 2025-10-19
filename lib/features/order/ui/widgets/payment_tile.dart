// import 'package:flutter/material.dart';
// import 'package:flutter_woocommerce/app/app_colors.dart';
//
// class PaymentTile extends StatelessWidget {
//   final Widget icon;
//   final String label;
//   final bool selected;
//   final VoidCallback onTap;
//
//   const PaymentTile({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.selected,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       decoration: BoxDecoration(
//         color: selected
//             ? AppColors.themeColor.withValues(alpha: 0.1)
//             : Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: selected ? AppColors.themeColor : Colors.grey.shade300,
//         ),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Row(
//             children: [
//               icon,
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Text(
//                   label,
//                   style: TextStyle(
//                     fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
//                     color: selected ? AppColors.themeColor : Colors.black87,
//                   ),
//                 ),
//               ),
//               if (selected)
//                 const Icon(Icons.check_circle, color: AppColors.themeColor),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
