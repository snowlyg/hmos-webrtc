# 实现ArkTS与H5的交互功能

## 简介

本示例主要介绍ArkTS侧与H5侧如何交互，通过JSBridge的相关接口实现了话费充值的场景案例，展示了ArkTS侧如何调用H5侧的方法、H5侧如何调用ArkTS侧的方法，帮助开发者掌握ArkTS侧与H5侧的交互。

## 效果预览
![SelectContact](screenshots/device/SelectContact.gif)

## 使用说明

1. 在应用首页，点击按钮进入话费充值页面。
2. 点击右侧联系人图标拉起系统通讯录页面，选中联系人后异步返回联系人信息。
3. 选择金额点击底部充值按钮会出现toast提示。

## 工程目录

```
├──entry/src/main/ets                         // 代码区
│  ├──entryability
│  │  └──EntryAbility.ets       
│  ├──entrybackupability
│  │  └──EntryBackupAbility.ets           
│  └──pages
│     ├──Index.ets                            // 主页面
│     └──SelectContact.ets                    // 话费充值页面
└──entry/src/main/resources                   // 应用资源目录
```

## 具体实现

1. 在ArkTS侧实现拉起联系人的方法chooseContact，调用系统提供的contact接口，拉起通讯录，并返回选择的联系人信息。
2. 调用javaScriptProxy或registerJavaScriptProxy注册JS对象和方法chooseContact。
3. 在H5侧调用chooseContact方法。
4. 在H5侧实现话费充值的方法recharge。
5. 在ArkTS侧使用runJavaScript调用H5的recharge方法。

## 相关权限

无

## 约束与限制

1. 本示例仅支持标准系统上运行，支持设备：华为手机。
2. HarmonyOS系统：HarmonyOS 5.0.0 Release及以上。
3. DevEco Studio版本：DevEco Studio 5.0.0 Release及以上。
4. HarmonyOS SDK版本：HarmonyOS 5.0.0 Release SDK及以上。
