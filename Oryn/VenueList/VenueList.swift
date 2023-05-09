//
//  VenueList.swift
//  Oryn
//
//  Created by Aruzhan  on 19.03.2023.
//

import SwiftUI
import AVFoundation

import Combine
struct Venue: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let category: String
    let image: String
    let description: String

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
    @State private var isBookingSheetPresented = false
    @State private var bookingTime = Date()
    @State private var numberOfPersons = 1
    @State private var fullName = ""
    @State private var email = ""
    
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
            HStack{
                Text("★ Рейтинг: 4.2/5")
                   .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color("pink"))
                    .padding(.bottom, 20)
                
                Text("• Средний чек: 3500 тг.")
                 .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color("pink"))
                    .foregroundColor(.purple)
                    .padding(.bottom, 20)
                
            }
            Divider()
            
            Text(venue.description) // add venue description
                .font(.body)
                .padding()
            
  
            Button(action: {
                isBookingSheetPresented.toggle()
            }) {
                HStack {
                    Spacer()
                    Text("Забронировать место")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(Color("pink"))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 2)
                )
            }
            .padding(.bottom, 50)
            .sheet(isPresented: $isBookingSheetPresented, onDismiss: {
                // Handle dismiss action if needed
            }, content: {
                BookingSheet(bookingTime: $bookingTime,
                             numberOfPersons: $numberOfPersons,
                             fullName: $fullName,
                             email: $email,
                             onBookingConfirmed: {
                    // Handle booking confirmed action
                })
            })
            
            Text("Стоимость бронирования: ? тг.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom)
        }
    }
    
    
    struct BookingSheet: View {
        
        @Binding var bookingTime: Date
        @Binding var numberOfPersons: Int
        @Binding var fullName: String
        @Binding var email: String
        var onBookingConfirmed: () -> Void
        
        var body: some View {
            NavigationView {
                Form {
                    DatePicker("Время бронирования", selection: $bookingTime, displayedComponents: .hourAndMinute)
                    Stepper("Количество персон: \(numberOfPersons)", value: $numberOfPersons, in: 1...10)
                    TextField("ФИО", text: $fullName)
                    TextField("Email", text: $email)
                }
                .navigationBarTitle(Text("Бронирование"), displayMode: .inline)
                .navigationBarItems(
                    trailing: NavigationLink(
                        destination: PaymentView(), // Замените PaymentView() на ваш вид
                        label: {
                            Text("Перейти к оплате")
                        }
                    )
                )

            }
        }
    }
}

struct PaymentView: View {
    @StateObject var paymentViewModel = PaymentViewModel()

    var body: some View {
        Form {
            Section(header: Text("Card Details")) {
                TextField("Card Number", text: $paymentViewModel.cardNumber)
                    .keyboardType(.numberPad)
                    .onReceive(Just(paymentViewModel.cardNumber)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            paymentViewModel.cardNumber = filtered
                        }
                        if filtered.count > 16 {
                            paymentViewModel.cardNumber = String(filtered.prefix(16))
                        }
                    }
                HStack {
                    TextField("Expiration Date", text: $paymentViewModel.expirationDate)
                        .keyboardType(.numberPad)
                    Spacer()
                    TextField("CVV", text: $paymentViewModel.cvv)
                        .keyboardType(.numberPad)
                }
            }

            Section {
                NavigationLink(
                    destination:
                        FullScreenImageView(imageName: "done")) {
                        Text("Оплатить бронь")
                    }
                
                .disabled(!paymentViewModel.isValid)
            }
        }
        .navigationBarTitle("Payment Details")

    }
}

class PaymentViewModel: ObservableObject {
    @Published var cardNumber: String = ""
    @Published var expirationDate: String = ""
    @Published var cvv: String = ""

    var isValid: Bool {
        !cardNumber.isEmpty && cardNumber.count == 16 && !expirationDate.isEmpty && !cvv.isEmpty
    }

}

struct FullScreenImageView: View {
    var imageName: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

        }
        /*.navigationBarItems(
            leading: EmptyView(),
            trailing: NavigationLink(
                destination: VenueList(),
                label: {
                    Text("Далее")
                })
               
        )
        */
        .navigationBarBackButtonHidden(true)
    }
    

}

struct Reservation: Identifiable {
    let id = UUID()
    let reservationNumber: Int

    let date: Date
    let guests: Int
}

struct ReservationListView: View {
    let reservations = [
        Reservation(reservationNumber: 1756938,  date: Date(), guests: 2),
        Reservation(reservationNumber: 9282828, date: Date(timeIntervalSinceNow: 86400), guests: 4),
        Reservation(reservationNumber: 2445773, date: Date(timeIntervalSinceNow: 172800), guests: 3),
        Reservation(reservationNumber: 3698473,  date: Date(timeIntervalSinceNow: 259200), guests: 5),
        Reservation(reservationNumber: 3335577,  date: Date(timeIntervalSinceNow: 345600), guests: 2),
        Reservation(reservationNumber: 9000224,  date: Date(timeIntervalSinceNow: 432000), guests: 6)
    ]
    
    var body: some View {
        List(reservations) { reservation in
            NavigationLink(destination: ReservationDetailView(reservation: reservation)) {
                VStack(alignment: .leading) {
                    Text("Reservation #\(reservation.reservationNumber)")
                        .font(.headline)
            
                    Text("\(reservation.date, formatter: dateFormatter)")
                }
            }
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}

struct ReservationDetailView: View {
    let reservation: Reservation
    
    var body: some View {
        VStack {
    Text("Loading...")
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}
