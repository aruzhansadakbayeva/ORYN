//
//  HomeView.swift
//  MovieBooking
//
//  Created by Willie Yam on 2022-08-17.
//

import SwiftUI


struct HomeView: View {
    @State var animate: Bool = false

    
    var body: some View {
        ZStack {
            CircleBackground(color: Color("backgroundColor"))
                .blur(radius: animate ? 30 : 100)
                .offset(x: animate ? -50 : -130, y: animate ? -30 : -100)
  
            
            CircleBackground(color: Color("backgroundColor"))
                .blur(radius: animate ? 30 : 100)
                .offset(x: animate ? 100 : 130, y: animate ? 150 : 100)
  
            
            VStack(spacing: 0.0) {
                Text("Новости")
                    .fontWeight(.bold)
                    .font(.title3)
                    .foregroundColor(.white)
                
                CustomSearchBar()
                    .padding(EdgeInsets(top: 30, leading: 20, bottom: 20, trailing: 20))
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20.0) {

                        NewsFeedView()

                    }
                    .padding(.bottom, 90)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("backgroundColor"), Color("backgroundColor2")]), startPoint: .top, endPoint: .bottom)
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
