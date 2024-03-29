//
//  ScrollSection.swift
//  MovieBooking
//
//  Created by Willie Yam on 2022-08-18.
//

import SwiftUI

struct ScrollSection: View {
    @State var title: String = "Now Playing"
    @State var posters: [String] = ["poster1", "poster2", "poster3", "poster4", "poster5", "poster6"]
        
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
        Text("fjgfjhgjfh")
                }
                }
                .offset(x: 20)
                .padding(.trailing, 40)
            }
        }
    


struct ScrollSection_Previews: PreviewProvider {
    static var previews: some View {
        ScrollSection()
    }
}
