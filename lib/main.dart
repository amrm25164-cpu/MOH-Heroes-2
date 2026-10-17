
import 'package:flutter/material.dart';

void main() {
  runApp(const MOHApp());
}

const bg = Color(0xFF101318);
const panel = Color(0xFF1D232B);
const accent = Color(0xFFE5A13A);

class MOHApp extends StatelessWidget {
  const MOHApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MOH Heroes 2',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void message(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            Row(
              children: [
                const Icon(
                  Icons.sports_esports,
                  color: accent,
                  size: 34,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'MY GAME LAUNCHER',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => message(
                    context,
                    'إعدادات المحاكي ستتوفر بعد ربط PPSSPP.',
                  ),
                  icon: const Icon(Icons.settings_outlined),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: panel,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: accent.withValues(alpha: 0.35),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.military_tech,
                    size: 82,
                    color: accent,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'MEDAL OF HONOR',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'HEROES 2  •  PSP',
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'GAME MENU',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 58,
              child: FilledButton.icon(
                onPressed: () => message(
                  context,
                  'لم يتم ربط محاكي PSP بعد. هذا الزر واجهة فقط.',
                ),
                icon: const Icon(Icons.play_arrow, size: 28),
                label: const Text(
                  'PLAY GAME',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => message(
                context,
                'اختيار ملف ISO يحتاج إضافة أداة اختيار ملفات وربطها بالمحاكي.',
              ),
              icon: const Icon(Icons.folder_open),
              label: const Text('SELECT GAME FILE (ISO)'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                side: const BorderSide(color: accent),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('About'),
                  content: const Text(
                    'MOH Heroes 2 Launcher\n'
                    'Personal project for Android.\n\n'
                    'PSP emulator integration is not '
                    'included in this version.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('CLOSE'),
                    ),
                  ],
                ),
              ),
              icon: const Icon(Icons.info_outline),
              label: const Text('ABOUT APP'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
            ),
            const SizedBox(height: 26),
            const Divider(color: Colors.white12),
            const SizedBox(height: 10),
            const Text(
              'PERSONAL GAME LAUNCHER',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white38,
                fontSize: 11,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
