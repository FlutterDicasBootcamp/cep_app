import 'package:cep_app/shared/ui/theme/domain/providers/theme_notifier.dart';
import 'package:cep_app/shared/ui/theme/domain/providers/theme_notifier_provider.dart';
import 'package:cep_app/shared/ui/theme/domain/providers/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CepScreen extends ConsumerStatefulWidget {
  const CepScreen({super.key});

  @override
  ConsumerState<CepScreen> createState() => _CepScreenState();
}

class _CepScreenState extends ConsumerState<CepScreen> {
  @override
  void initState() {
    ref.read<ThemeNotifier>(themeNotifierProvider.notifier).initThemeState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(
            value: ref.watch<ThemeState>(themeNotifierProvider).getTheme ==
                ThemeMode.dark,
            onChanged: (_) => ref
                .read<ThemeNotifier>(themeNotifierProvider.notifier)
                .changeTheme(context),
          ),
        ],
      ),
    );
  }
}
