import 'package:flutter/material.dart';

import '../features/home/home_page.dart';
import '../features/workspace/placeholder_page.dart';

class ZhenzhihuiApp extends StatelessWidget {
  const ZhenzhihuiApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xff0b9e7e);
    ThemeData theme(Brightness brightness) {
      final scheme = ColorScheme.fromSeed(
        seedColor: seed,
        brightness: brightness,
      );
      return ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: scheme.surface,
      );
    }

    return MaterialApp(
      title: '帧智汇',
      debugShowCheckedModeBanner: false,
      theme: theme(Brightness.light),
      darkTheme: theme(Brightness.dark),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  void _select(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomePage(onNavigate: _select),
      const PlaceholderPage(
        title: '项目',
        icon: Icons.folder_open_outlined,
        heading: '项目列表尚未接入',
        description: '完成登录和工作空间接入后，可在这里查看项目和历史作品。',
      ),
      const PlaceholderPage(
        title: '素材',
        icon: Icons.photo_library_outlined,
        heading: '素材库尚未接入',
        description: '完成素材接口接入后，可在这里查看和管理图片、视频。',
      ),
      const PlaceholderPage(
        title: '任务',
        icon: Icons.pending_actions_outlined,
        heading: '任务中心尚未接入',
        description: '完成任务接口接入后，可在这里查看生成进度和结果。',
      ),
      const PlaceholderPage(
        title: '我的',
        icon: Icons.person_outline,
        heading: '账号功能尚未接入',
        description: '登录方式和工作空间接口确认后，将在这里管理账号。',
      ),
    ];
    return PopScope(
      canPop: _selectedIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _selectedIndex != 0) _select(0);
      },
      child: Scaffold(
        body: SafeArea(child: pages[_selectedIndex]),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _select,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.auto_awesome_outlined),
              selectedIcon: Icon(Icons.auto_awesome),
              label: '工作台',
            ),
            NavigationDestination(
              icon: Icon(Icons.folder_outlined),
              selectedIcon: Icon(Icons.folder),
              label: '项目',
            ),
            NavigationDestination(
              icon: Icon(Icons.photo_library_outlined),
              selectedIcon: Icon(Icons.photo_library),
              label: '素材',
            ),
            NavigationDestination(
              icon: Icon(Icons.pending_actions_outlined),
              selectedIcon: Icon(Icons.pending_actions),
              label: '任务',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: '我的',
            ),
          ],
        ),
      ),
    );
  }
}
