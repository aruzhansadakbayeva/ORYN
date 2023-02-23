//
//  NewsFeedView.swift
//  Oryn
//
//  Created by Aruzhan  on 16.02.2023.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import SDWebImageSwiftUI

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}

struct NewsFeed: Identifiable, Decodable {
    var id = UUID()
    var title: String
    var pic: String
    var description: String
}

struct NewsItemView: View{
    var data: NewsFeed
    var backgroundColors: [Color] = [Color("backgroundColor"),Color("purple")]
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            AnimatedImage(url: URL(string: data.pic)!).resizable()
                .frame(height: UIScreen.main.bounds.height / 2 - 100)
            VStack(alignment: .leading, spacing: 25) {
                Text(data.title).foregroundColor(.white).fontWeight(.heavy).font(.title)
                Text(data.description).foregroundColor(.white).fontWeight(.heavy).font(.body)
                
               
            }.padding()
            Spacer()
        }        .background(LinearGradient(colors: backgroundColors, startPoint: .leading, endPoint: .trailing))
    }
}
struct NewsFeedView: View {
    @ObservedObject var news = getNewsFeedData()
    //@State var title: String = "News"

    var body: some View {

        VStack(alignment: .leading) {
           // Text(title).font(.title).foregroundColor(.white).fontWeight(.heavy).padding(20)

  
                VStack{
                    if self.news.datas.count != 0 {
                        ScrollView(.vertical, showsIndicators: false){
                            VStack(spacing: 15){
                                ForEach(self.news.datas){
                                    i in CellView(data: i)
                                }
                            }.padding()
                        }.edgesIgnoringSafeArea(.all)
                    }
                    else{
                        Loader()
                    }
                
            }
            
        }

    

                       }

}
struct CellView: View {
    var data: NewsFeed
    @State var show = false
    var body: some View{
        VStack{
            AnimatedImage(url: URL(string: data.pic)!).resizable().scaledToFill().frame(height: 208).allowsHitTesting(false)
            HStack{
                VStack(alignment: .leading){
                    Text(data.title).font(.title).foregroundColor(.white).fontWeight(.heavy)
                    
                    Text(data.description).font(.system(size: 14)).foregroundColor(.white).fontWeight(.heavy).font(.body)
                }
                Spacer()
                Button(action: {
                    self.show.toggle()
                }) {
                    Text("Подробнее").font(.system(size: 13)).foregroundColor(.white).font(.body).fontWeight(.heavy).foregroundColor(.black).padding(7)
                }.background(Color("color3")).clipShape(Rectangle()).cornerRadius(20)
            }.padding(.horizontal)
                .padding(.bottom, 6)
        }//.background(Color("lightPurple"))
            .cornerRadius(20)
            .sheet(isPresented: self.$show){
                NewsItemView(data: self.data)
            }
    }
}

struct Loader: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<Loader>) -> UIActivityIndicatorView{
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loader>) {
        
    }
}

class getNewsFeedData: ObservableObject{
    @Published var datas = [NewsFeed]()
    init(){
        let db = Firestore.firestore()
        db.collection("news").addSnapshotListener{
            (snap,err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            for i in snap!.documentChanges{
    
                let id = i.document.documentID

                let title = i.document.get("title") as? String
                let pic = i.document.get("pic") as! String
                let description = i.document.get("description") as? String
                
                self.datas.append(NewsFeed(title: title ?? "", pic: pic, description: description ?? ""))
            }
        }
    }
}


