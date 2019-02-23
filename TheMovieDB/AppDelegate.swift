//
//  AppDelegate.swift
//  TheMovieDB
//
//  Created by Miquel Masip on 22/02/2019.
//  Copyright © 2019 Miquel Masip. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        launchMainScreen()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    // MARK: - Private methods
    private func setupNavigationBar() {
        UINavigationBar.appearance().backgroundColor = UIColor.hexString("#FFFFFF")
        UINavigationBar.appearance().tintColor = UIColor.hexString("#000000")
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size: 20)!]
    }

    private func launchMainScreen() {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = MainBuilder().main()
        window?.makeKeyAndVisible()
    }
}
