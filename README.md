# 帧智汇 Flutter 移动端

Android 项目基础，目前为未接入后端的开发预览。具体状态、运行方法和后续阶段见 [Android 项目规划](docs/android-plan.md)。

在 Windows 的项目根目录运行 Android 模拟器：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/android.ps1
```

仅构建调试包：`powershell -ExecutionPolicy Bypass -File scripts/android.ps1 -BuildOnly`。脚本会临时创建英文盘符，以兼容中文目录。
