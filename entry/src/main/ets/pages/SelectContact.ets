/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { webview } from '@kit.ArkWeb';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { abilityAccessCtrl } from '@kit.AbilityKit';

import { promptAction } from '@kit.ArkUI';
import { contact } from '@kit.ContactsKit';
import { deviceInfo } from '@kit.BasicServicesKit';
import { i18n } from '@kit.LocalizationKit';

@Component
export struct SelectContact {

  webviewController: webview.WebviewController = new webview.WebviewController();
  uiContext: UIContext = this.getUIContext();
  aboutToAppear() {
    hilog.info(0xFF00, 'SelectContact', '%{public}s', '[LifeCycle] aboutToAppear');
   // 配置Web开启调试模式
    webview.WebviewController.setWebDebuggingAccess(true);
    // 获取权限请求通知，点击onConfirm按钮后，拉起摄像头和麦克风。
    let atManager = abilityAccessCtrl.createAtManager();
    atManager.requestPermissionsFromUser(this.uiContext.getHostContext(), ['ohos.permission.CAMERA', 'ohos.permission.MICROPHONE'])
      .then((data) => {
        console.info('data:' + JSON.stringify(data));
        console.info('data permissions:' + data.permissions);
        console.info('data authResults:' + data.authResults);
      }).catch((error: BusinessError) => {
      console.error(`Failed to request permissions from user. Code is ${error.code}, message is ${error.message}`);
    })
  }

  aboutToDisappear() {
    this.webviewController.deleteJavaScriptRegister('jsbridgeHandle');
    hilog.info(0xFF00, 'SelectContact', '%{public}s', '[LifeCycle] aboutToDisappear');
  }

  build() {
    Column() {
      Web({
        // src: $rawfile(/zh/.test(i18n.System.getSystemLanguage()) ? 'index.html' : 'index_en.html'),
        // src:  $rawfile('test.html'),
        src:'https://rtc.chindeo.com/rtc/remote-test.html',
        // src:'https://janus.conf.meetecho.com/demos/audiobridge.html',
        controller: this.webviewController
      })
        .onPermissionRequest((event) => {
          if (event) {
            event.request.grant(event.request.getAccessibleResource());
            // this.uiContext.showAlertDialog({
            //   title: 'title',
            //   message: 'text',
            //   primaryButton: {
            //     value: 'deny',
            //     action: () => {
            //       event.request.deny();
            //     }
            //   },
            //   secondaryButton: {
            //     value: 'onConfirm',
            //     action: () => {
            //       event.request.grant(event.request.getAccessibleResource());
            //     }
            //   },
            //   cancel: () => {
            //     event.request.deny();
            //   }
            // })
          }
        })
        .javaScriptAccess(true)
        // .javaScriptProxy({
        //   object: {
        //     call: this.chooseContact
        //   },
        //   name: 'jsbridgeHandle',
        //   methodList: ['call'],
        //   controller: this.webviewController
        // })
          .width('100%')
          .height('100%')
        .onAppear(() => {
          hilog.info(0xFF00, 'SelectContact', '%{public}s', '[LifeCycle] onAppear');
        })
        .onDisAppear(() => {
          hilog.info(0xFF00, 'SelectContact', '%{public}s', '[LifeCycle] onDisAppear');
        })
        // .onControllerAttached(() => {
        //   this.webviewController.registerJavaScriptProxy({ call: this.chooseContact }, 'jsbridgeHandle', ['call']);
        //   hilog.info(0xFF00, 'SelectContact', '%{public}s', '[LifeCycle] onControllerAttached');
        // })
        .onLoadIntercept(() => {
          hilog.info(0xFF00, 'SelectContact', '%{public}s', '[LifeCycle] onLoadIntercept');
          return false;
        })
        .onInterceptRequest((event) => {
          hilog.info(0xFF00, 'SelectContact', '%{public}s', '[LifeCycle] onInterceptRequest, '
            + event.request.getRequestUrl());
          return null;
        })
        .onPageBegin(() => {
          hilog.info(0xFF00, 'SelectContact', '%{public}s', '[LifeCycle] onPageBegin');
        })
        .onPageEnd(() => {
          hilog.info(0xFF00, 'SelectContact', '%{public}s', '[LifeCycle] onPageEnd');
        })

      Blank()

    //   Button($r('app.string.recharge_button'))
    //     .width('100%')
    //     .height($r('app.float.button_height'))
    //     .margin({ bottom: $r('app.float.button_margin_bottom') })
    //     .onClick(() => {
    //       this.webviewController.runJavaScript('recharge()')
    //         .then((result) => {
    //           promptAction.showToast({ message: result.replaceAll('"', '') });
    //         });
    //     })
    // }
    // .width('100%')
    // .height('100%')
    // .padding({
    //   left: $r('app.float.margin_left_normal'),
    //   right: $r('app.float.margin_right_normal')
    // })
  }

  //
  // /**
  //  * Use system ability of getting contacts.
  //  */
  // chooseContact(): Promise<string> {
  //   let phone: string = '';
  //   let name: string = '';
  //   return new Promise((resolve) => {
  //     if (deviceInfo.productModel === 'emulator') {
  //       return resolve('13800000000_test');
  //     }
  //     let promise = contact.selectContacts();
  //     promise.then((info: Array<contact.Contact>) => {
  //       info.forEach((item: contact.Contact) => {
  //         phone = item?.phoneNumbers ? item?.phoneNumbers[0].phoneNumber : '';
  //         name = item?.name ? item?.name?.fullName : '';
  //       })
  //       resolve(phone + '_' + name);
  //     }).catch((err: object) => {
  //       hilog.error(0xFF00, 'SelectContact', '%{public}s', `selectContact fail: err->${JSON.stringify(err)}`);
  //     });
  //   })
  }
}