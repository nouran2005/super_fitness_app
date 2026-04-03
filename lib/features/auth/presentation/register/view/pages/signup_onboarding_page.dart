// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:super_fitness_app/app/core/router/route_names.dart';
// import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';
// import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_intent.dart';
// import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_states.dart';

// class SignupOnboardingPage extends StatefulWidget {
//   const SignupOnboardingPage({super.key});

//   @override
//   State<SignupOnboardingPage> createState() =>
//       _SignupOnboardingPageState();
// }

// class _SignupOnboardingPageState extends State<SignupOnboardingPage> {
//   final PageController _controller = PageController();
//   int currentPage = 0;

//   void nextPage() {
//     _controller.nextPage(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<SignupCubit, SignupStates>(
//         listener: (context, state) {
//           if (state.signupResource.isSuccess) {
//             context.go(RouteNames.home);
//           }
//           if (state.signupResource.isError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.signupResource.error ?? '')),
//             );
//           }
//         },
//         builder: (context, state) {
//           return Column(
//             children: [
//               Expanded(
//                 child: PageView(
//                   controller: _controller,
//                   physics: const NeverScrollableScrollPhysics(),
//                   onPageChanged: (index) => setState(() => currentPage = index),
//                   children: [
//                     _GenderPage(onNext: nextPage),
//                     _AgePage(onNext: nextPage),
//                     _WeightPage(onNext: nextPage),
//                     _HeightPage(onNext: nextPage),
//                     _GoalPage(onNext: nextPage),
//                     _ActivityPage(),
//                   ],
//                 ),
//               ),

//               _ProgressIndicator(currentPage),
//               const SizedBox(height: 16),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class _GenderPage extends StatelessWidget {
//   final VoidCallback onNext;

//   const _GenderPage({required this.onNext});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("TELL US ABOUT YOURSELF"),

//         _SelectButton(
//           text: "Male",
//           onTap: () {
//             context.read<SignupCubit>()
//               .doIntent(SetGender("male"));
//             onNext();
//           },
//         ),

//         _SelectButton(
//           text: "Female",
//           onTap: () {
//             context.read<SignupCubit>()
//               .doIntent(SetGender("female"));
//             onNext();
//           },
//         ),
//       ],
//     );
//   }
// }

// class _AgePage extends StatefulWidget {
//   final VoidCallback onNext;
//   const _AgePage({required this.onNext});

//   @override
//   State<_AgePage> createState() => _AgePageState();
// }

// class _AgePageState extends State<_AgePage> {
//   int age = 25;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("HOW OLD ARE YOU?"),
//         Slider(
//           min: 10,
//           max: 80,
//           value: age.toDouble(),
//           onChanged: (v) => setState(() => age = v.toInt()),
//         ),
//         Text("$age"),

//         ElevatedButton(
//           onPressed: () {
//             context.read<SignupCubit>()
//               .doIntent(SetAge(age));
//             widget.onNext();
//           },
//           child: const Text("Next"),
//         ),
//       ],
//     );
//   }
// }

// class _WeightPage extends StatefulWidget {
//   final VoidCallback onNext;
//   const _WeightPage({required this.onNext});

//   @override
//   State<_WeightPage> createState() => _WeightPageState();
// }

// class _WeightPageState extends State<_WeightPage> {
//   int weight = 70;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("WHAT IS YOUR WEIGHT?"),
//         Slider(
//           min: 40,
//           max: 150,
//           value: weight.toDouble(),
//           onChanged: (v) => setState(() => weight = v.toInt()),
//         ),
//         Text("$weight KG"),

//         ElevatedButton(
//           onPressed: () {
//             context.read<SignupCubit>()
//               .doIntent(SetWeight(weight));
//             widget.onNext();
//           },
//           child: const Text("Next"),
//         ),
//       ],
//     );
//   }
// }

// class _HeightPage extends StatefulWidget {
//   final VoidCallback onNext;
//   const _HeightPage({required this.onNext});

//   @override
//   State<_HeightPage> createState() => _HeightPageState();
// }

// class _HeightPageState extends State<_HeightPage> {
//   int height = 170;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("WHAT IS YOUR HEIGHT?"),
//         Slider(
//           min: 140,
//           max: 210,
//           value: height.toDouble(),
//           onChanged: (v) => setState(() => height = v.toInt()),
//         ),
//         Text("$height CM"),

//         ElevatedButton(
//           onPressed: () {
//             context.read<SignupCubit>()
//               .doIntent(SetHeight(height));
//             widget.onNext();
//           },
//           child: const Text("Next"),
//         ),
//       ],
//     );
//   }
// }

// class _GoalPage extends StatelessWidget {
//   final VoidCallback onNext;
//   const _GoalPage({required this.onNext});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("WHAT IS YOUR GOAL?"),

//         _SelectButton(
//           text: "Lose Weight",
//           onTap: () {
//             context.read<SignupCubit>()
//               .doIntent(SetGoal("lose_weight"));
//             onNext();
//           },
//         ),

//         _SelectButton(
//           text: "Gain Weight",
//           onTap: () {
//             context.read<SignupCubit>()
//               .doIntent(SetGoal("gain_weight"));
//             onNext();
//           },
//         ),
//       ],
//     );
//   }
// }

// class _ActivityPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("YOUR ACTIVITY LEVEL"),

//         _SelectButton(
//           text: "Beginner",
//           onTap: () {
//             context.read<SignupCubit>()
//               .doIntent(SetActivityLevel("beginner"));

//             context.read<SignupCubit>()
//               .doIntent(PerformSignup());
//           },
//         ),

//         _SelectButton(
//           text: "Intermediate",
//           onTap: () {
//             context.read<SignupCubit>()
//               .doIntent(SetActivityLevel("intermediate"));

//             context.read<SignupCubit>()
//               .doIntent(PerformSignup());
//           },
//         ),
//       ],
//     );
//   }
// }

// class _SelectButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onTap;

//   const _SelectButton({required this.text, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ElevatedButton(
//         onPressed: onTap,
//         child: Text(text),
//       ),
//     );
//   }
// }

// class _ProgressIndicator extends StatelessWidget {
//   final int index;
//   const _ProgressIndicator(this.index);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(
//         6,
//         (i) => Container(
//           margin: const EdgeInsets.all(4),
//           width: i == index ? 16 : 8,
//           height: 8,
//           decoration: BoxDecoration(
//             color: i <= index ? Colors.orange : Colors.grey,
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/signup_onboarding_app_bar.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/signup_onboarding_page_body.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';

class SignupOnboardingPage extends StatelessWidget {
  const SignupOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignupCubit>(),
      child: Scaffold(
        appBar: const SignupOnboardingAppBar(),
        body: const SignupOnboardingPageBody(),
      ),
    );
  }
}

// //
// // ====================== PAGES ======================
// //

// class _GenderPage extends StatelessWidget {
//   final VoidCallback onNext;
//   const _GenderPage({required this.onNext});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 80),
//         const _Header("Tell us about yourself", "Choose your gender"),
//         const SizedBox(height: 24),
//         _GlassCard(
//           child: BlocBuilder<SignupCubit, SignupStates>(
//             builder: (context, state) {
//               return Column(
//                 children: [
//                   _GenderItem(
//                     title: "Male",
//                     icon: Icons.male,
//                     selected: state.gender == "male",
//                     onTap: () => context
//                         .read<SignupCubit>()
//                         .doIntent(SetGender("male")),
//                   ),
//                   const SizedBox(height: 20),
//                   _GenderItem(
//                     title: "Female",
//                     icon: Icons.female,
//                     selected: state.gender == "female",
//                     onTap: () => context
//                         .read<SignupCubit>()
//                         .doIntent(SetGender("female")),
//                   ),
//                   const SizedBox(height: 30),
//                   _NextButton(onTap: onNext),
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _GenderItem extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final bool selected;
//   final VoidCallback onTap;

//   const _GenderItem({
//     required this.title,
//     required this.icon,
//     required this.selected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         padding: const EdgeInsets.all(24),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: selected ? Colors.greenAccent : Colors.transparent,
//           border: Border.all(color: Colors.white),
//         ),
//         child: Column(
//           children: [
//             Icon(icon, size: 40, color: Colors.black),
//             const SizedBox(height: 8),
//             Text(title, style: const TextStyle(color: Colors.black)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _AgePage extends StatefulWidget {
//   final VoidCallback onNext;
//   const _AgePage({required this.onNext});

//   @override
//   State<_AgePage> createState() => _AgePageState();
// }

// class _AgePageState extends State<_AgePage> {
//   double age = 25;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 80),
//         const _Header("How old are you?", "Age helps us personalize"),
//         const SizedBox(height: 24),
//         _GlassCard(
//           child: Column(
//             children: [
//               Text("${age.toInt()} Years",
//                   style: const TextStyle(
//                       fontSize: 36,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold)),
//               Slider(
//                 value: age,
//                 min: 10,
//                 max: 80,
//                 onChanged: (v) => setState(() => age = v),
//               ),
//               const SizedBox(height: 20),
//               _NextButton(
//                 onTap: () {
//                   context
//                       .read<SignupCubit>()
//                       .doIntent(SetAge(age.toInt()));
//                   widget.onNext();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _WeightPage extends StatefulWidget {
//   final VoidCallback onNext;
//   const _WeightPage({required this.onNext});

//   @override
//   State<_WeightPage> createState() => _WeightPageState();
// }

// class _WeightPageState extends State<_WeightPage> {
//   double weight = 70;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 80),
//         const _Header("Your Weight", "In kilograms"),
//         const SizedBox(height: 24),
//         _GlassCard(
//           child: Column(
//             children: [
//               Text("${weight.toInt()} kg",
//                   style: const TextStyle(
//                       fontSize: 36,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold)),
//               Slider(
//                 value: weight,
//                 min: 30,
//                 max: 150,
//                 onChanged: (v) => setState(() => weight = v),
//               ),
//               const SizedBox(height: 20),
//               _NextButton(
//                 onTap: () {
//                   context
//                       .read<SignupCubit>()
//                       .doIntent(SetWeight(weight.toInt()));
//                   widget.onNext();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _HeightPage extends StatefulWidget {
//   final VoidCallback onNext;
//   const _HeightPage({required this.onNext});

//   @override
//   State<_HeightPage> createState() => _HeightPageState();
// }

// class _HeightPageState extends State<_HeightPage> {
//   double height = 170;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 80),
//         const _Header("Your Height", "In centimeters"),
//         const SizedBox(height: 24),
//         _GlassCard(
//           child: Column(
//             children: [
//               Text("${height.toInt()} cm",
//                   style: const TextStyle(
//                       fontSize: 36,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold)),
//               Slider(
//                 value: height,
//                 min: 120,
//                 max: 220,
//                 onChanged: (v) => setState(() => height = v),
//               ),
//               const SizedBox(height: 20),
//               _NextButton(
//                 onTap: () {
//                   context
//                       .read<SignupCubit>()
//                       .doIntent(SetHeight(height.toInt()));
//                   widget.onNext();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _FinishPage extends StatelessWidget {
//   const _FinishPage();

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: _GlassCard(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text("All Set 🎉",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold)),
//             const SizedBox(height: 20),
//             _NextButton(
//               text: "Create Account",
//               onTap: () {
//                 context.read<SignupCubit>().doIntent(PerformSignup());
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
