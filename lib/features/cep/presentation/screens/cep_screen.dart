import 'package:cep_app/features/cep/presentation/widgets/cep_screen_app_bar_widget.dart';
import 'package:flutter/material.dart';

class CepScreen extends StatelessWidget {
  const CepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CepScreenAppBarWidget(
      title: 'Cep App - Clean Architecture',
      tabs: [
        Center(child: Text('Tab 1')),
        Center(child: Text('Tab 2')),
      ],
    );
  }
}
