import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhenzhihui_mobile/app/app.dart';

void main() {
  testWidgets('工作台入口与底部导航显示真实的未接入状态', (tester) async {
    await tester.pumpWidget(const ZhenzhihuiApp());
    expect(find.text('工作空间尚未连接'), findsOneWidget);
    expect(find.text('开发预览'), findsOneWidget);

    await tester.tap(find.text('项目管理'));
    await tester.pumpAndSettle();
    expect(find.text('项目列表尚未接入'), findsOneWidget);

    await tester.tap(find.text('任务'));
    await tester.pumpAndSettle();
    expect(find.text('任务中心尚未接入'), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('工作空间尚未连接'), findsOneWidget);
  });

  testWidgets('深色及大字体下导航和页面可以渲染', (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(
          size: Size(360, 800),
          textScaler: TextScaler.linear(1.3),
          platformBrightness: Brightness.dark,
        ),
        child: ZhenzhihuiApp(),
      ),
    );
    expect(find.text('帧智汇'), findsOneWidget);
    await tester.tap(find.text('我的'));
    await tester.pumpAndSettle();
    expect(find.text('账号功能尚未接入'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
