# 帧智汇 Flutter Android 项目规划

## 当前交付

独立 Flutter Android 工程：Material 导航、品牌工作台、项目 / 素材 / 任务 / 账号入口和明确的未接入状态。当前没有真实账号、项目数据、上传、生成或通知功能，也不连接生产服务。Android applicationId `com.example.zhenzhihui_mobile` 是开发占位，发布前须确认正式包名与签名。

## 验收与开发命令

Flutter 3.38.8 / Dart 3.10.7 为创建时环境；团队在确定正式版本后统一工具链。Android SDK 与模拟器以 `flutter doctor` / `flutter devices` 输出为准。

```powershell
flutter pub get
flutter analyze
flutter test
powershell -ExecutionPolicy Bypass -File scripts/android.ps1 -Device emulator-5554
```

模拟器设备 ID 可能变化，以 `flutter devices` 的输出为准。模拟器无法代替真机测试；Windows 不能完成本地 iOS 构建和签名。

## 业务与接口调查（2026-11-09）

现有 Web 项目为 `F:\项目\zhenzhihui-web-recat`。当前实现将 `/home` 重定向至创作入口；项目、素材等路由要求登录。Web 请求携带同源 Cookie，认证会话查询 `/api/v1/auth/session`，并具备共享的续期机制；项目列表使用 `/api/v1/creative/projects`，可传工作空间与分页参数。以上是 Web 实现观察，**不是已确认的 App 接入契约**。后端地址、移动端会话/SSO 回调、账号、授权、HTTPS 和接口版本均需与服务端核实。不能直接使用浏览器代理或假设已获得授权。

## 建议交付阶段

1. 基础工程：完成本次导航、开发工具及空/未接入状态。
2. 会话与工作空间：确认移动端登录方案和测试环境；实现登录、恢复、退出、切换空间及隔离测试。
3. 项目和任务查询：先接只读接口，覆盖加载、空、失败、分页、前后台恢复，区分真实空数据和未连接状态。
4. 素材与结果：相册/文件权限、上传进度与错误恢复、图片/视频预览；持久化资产 ID，不持久化过期签名 URL。
5. 一条完整生成流程：在明确任务创建、幂等、费用与重试契约后，接入一个经授权的测试流程；覆盖断网、重复点击和重启恢复。
6. 发布准备：真机兼容、性能、无障碍、签名、隐私与商店资料；iOS 项目和签名需后续在 macOS 上配置。

## 结构与原则

`lib/app` 负责应用和导航；`lib/features` 按业务组织页面。后续对接时引入明确的 service/repository 和状态边界，选用项目实际需要且兼容锁定 SDK 的库；不要预先引入未经验证的大量依赖。测试数据不能冒充真实账号或生成结果。生产环境不做未经授权的写入或付费任务。

## Windows 中文路径

项目按要求位于 `F:\项目\zhenzhihui-flutter`。本机 Android Gradle 和 Flutter 着色器编译器不能直接从该路径完成构建。请在 PowerShell 中从项目根目录执行 `powershell -ExecutionPolicy Bypass -File scripts/android.ps1`；仅构建 APK 可加 `-BuildOnly`，指定设备可加 `-Device emulator-5554`。脚本会临时映射空闲盘符，结束后移除映射，不移动源码。关闭终端、进程异常终止或系统重启后的盘符状态可用 `subst` 查看；不要删除其他程序创建的映射。Flutter 的常规 `flutter analyze` 与 `flutter test` 可在原路径运行。
