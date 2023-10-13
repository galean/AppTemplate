//
//  AppTemplateApp.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 20.02.2023.
//

import SwiftUI

@main
struct AppTemplateApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    let screenshotNoti = NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .onReceive(screenshotNoti) { response in
//                    AppAnalytic.shared.log(event: AppAnalytic.EventKey.Common.screenshot_taken.rawValue)
                }
        }
    }
}
