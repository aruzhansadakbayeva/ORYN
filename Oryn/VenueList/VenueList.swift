//
//  VenueList.swift
//  Oryn
//
//  Created by Aruzhan  on 19.03.2023.
//

import SwiftUI

struct Venue: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let category: String
    let image: String
}

struct VenueList: View {
    var backgroundColors: [Color] = [Color("backgroundColor"),Color("purple")]
    @State var venues: [Venue] = []
    
    var categories: [String] {
        Array(Set(venues.map { $0.category })).sorted()
    }
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 17){
                    Text("Категории")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Text("Планируйте свои встречи и мероприятия в лучших заведениях города")
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundColor(.white)
                     
                }.padding()
               
              
                List(categories, id: \.self)  { category in
                  
                    VStack(alignment: .leading, spacing: 10) {
                            NavigationLink(destination: VenueCategoryList(category: category, venues: venues.filter { $0.category == category })) {
                                HStack {
                                    Text(category)
                                        .font(.title3)
                                  .foregroundColor(Color("grey"))
                                       .fontWeight(.bold)
                                    Spacer()
                                   // Image(systemName: "chevron.right")
                                    //    .foregroundColor(Color("grey"))
                               
                                }
                               .padding(.horizontal)
                               .padding(.vertical, 10)
                            }
                         
                            //.listRowBackground(Color.clear)
                          //  .listRowBackground(Color.black.opacity(0.5))
                        
                    }
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity)
            }
            .background(LinearGradient(colors: backgroundColors, startPoint: .leading, endPoint: .trailing))
         
            .onAppear {
                fetchVenues()
            }
        }
        .accentColor(.blue)

        
    }
    
    func fetchVenues() {
        guard let url = URL(string: "https://my-json-server.typicode.com/aruzhansadakbayeva/database/posts/") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                venues = try JSONDecoder().decode([Venue].self, from: data)
            } catch {
                print(error)
            }
        }.resume()
    }
}


struct VenueCategoryList: View {
    
    let category: String
    let venues: [Venue]
    var body: some View {

            List(venues) { venue in
                NavigationLink(destination: VenueDetail(venue: venue)) {
                    HStack {
                        AsyncImage(url: URL(string: venue.image)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(10)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(10)
                            @unknown default:
                                fatalError()
                            }
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            Text(venue.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text(venue.category)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationBarTitle(category)
         
        
    }
}

struct VenueDetail: View {
    
    let venue: Venue
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: venue.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding()
                @unknown default:
                    fatalError()
                }
            }
            Text(venue.name)
                .font(.title)
                .padding()

            Text("Описание") // add venue description
                .font(.body)
                .padding()

     

            Button(action: {
                // handle booking action
            }) {
                HStack {
                    Spacer()
                    Text("Забронировать")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(Color("pink"))
                .cornerRadius(20)
           
            }
            .padding(.bottom, 50)

        }
    }
}
