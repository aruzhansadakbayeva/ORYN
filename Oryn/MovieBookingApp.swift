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

    @StateObject var sessionService = SessionServiceImpl()
    @State var currentTab: Tab = .home

    init() {
        FirebaseApp.configure()
        UITabBar.appearance().isHidden = true
    }


    var body: some Scene {
        WindowGroup {
            NavigationView {
                switch sessionService.state {
                case .loggedIn:
                    VStack(spacing: 0) {
                        TabView(selection: $currentTab) {
                            
                            
                            HomeView()
                                .tag(Tab.home)
                            
                            Text("Location")
                                .tag(Tab.location)
                            
                            Text("Category")
                                .tag(Tab.category)
                            
                            
                            //Text("Profile")
                            //.tag(Tab.profile)
                            AccountView().environmentObject(sessionService).tag(Tab.profile)
                            
                        }
                        CustomTabBar(currentTab: $currentTab)
                    }
                case .loggedOut:
                    VStack(spacing: 0) {
                        TabView(selection: $currentTab) {
                            
                            HomeView()
                                .tag(Tab.home)
                            
                            Text("Location")
                                .tag(Tab.location)
                            
                            Text("Category")
                                .tag(Tab.category)
                            
                            LoginView().environmentObject(sessionService).tag(Tab.profile)
                            
                            
                        }
                        CustomTabBar(currentTab: $currentTab)
                    }
                }
       
                    
                }
        }
    }
}
