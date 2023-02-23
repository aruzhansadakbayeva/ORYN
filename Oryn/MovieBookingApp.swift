//
//  MovieBookingApp.swift
//  MovieBooking
//
//  Created by Willie Yam on 2022-08-16.
//

import SwiftUI
import Firebase
import FirebaseCore
import UIKit
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct MovieBookingApp: App {


    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
