//
//  MovieBookingApp.swift
//  MovieBooking
//
//  Created by Willie Yam on 2022-08-16.
//

import SwiftUI
import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import UIKit
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
      for urlContext in URLContexts {
          let url = urlContext.url
          Auth.auth().canHandle(url)
      }
      // URL not auth related, developer should handle it.
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
                            
                           VenueList()
                                .tag(Tab.location)
                            
                          //  Text("Category")
                            ContentView()
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
                            
                            VenueList()
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
