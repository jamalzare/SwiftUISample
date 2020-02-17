//
//  ContentView.swift
//  SwiftUIStart
//
//  Created by Jamal on 2/16/20.
//  Copyright © 2020 Jamal. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isAdShowing = true
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .background(Color.black)
                .frame(width: 200, height: 200, alignment: .center)
        
        
        TabView {
            NavigationView{
                ScrollView(.vertical){
                    TopView()
                    
                    if isAdShowing {
                        TopCardView(isAdShowing: $isAdShowing)
                    } else {
                        EmptyView()
                    }
                    
                    CoursesScrollView()
                    RecommendedScrollView()
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("House")
            }.tag(1)
            
            Text("Tab Content 2").tabItem { Image(systemName: "book.fill") }.tag(1)
            
            Text("Tab Content 3").tabItem { Image(systemName: "square.fill") }.tag(1)
            
            Text("Tab Content 4").tabItem { Image(systemName: "person.fill") }.tag(1)
        }
        
        
        
        
    }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//make in new .swift file
struct TopView: View {
    var body: some View {
        HStack{
            SearchView()
            TopButtonView()
        }
        .padding(.horizontal)
    }
}

struct SearchView: View {
    @State private var search = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(.systemGray5))
                .cornerRadius(12)
                .frame(height: 60)
            
            HStack{
                TextField("Search", text: $search)
                
                Image(systemName: "magnifyingglass")
                    .font(Font.system(size: 22).weight(.bold))
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(.systemIndigo))
                    .cornerRadius(12)
            }
            .padding()
        }
    }
}

struct TopButtonView: View {
    var body: some View {
        Button(action: buttonAction) {
            Image(systemName: "slider.horizontal.3")
                .font(Font.system(size: 22).weight(.bold))
                .frame(width:60, height:60)
                .foregroundColor(Color(.label))
                .background(Color(.systemGray5))
                .cornerRadius(12)
        }
    }
    
    func buttonAction(){
        print("button tapped")
    }
    
}

struct TopCardView: View {
    @Binding var isAdShowing: Bool
    
    var body: some View {
        HStack{
            ZStack(alignment: .leading){
                Image("learn")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(x: 160, y: 0)
                
                VStack(alignment: .leading){
                    CardHeaderLabelView(label: "Upgrade")
                    CardHeaderLabelView(label: "Your Profile")
                    CardBodyLabelView(label: "Eduction is passport to the")
                    CardBodyLabelView(label: "feature, so learn more & more")
                    
                    Spacer()
                    CardButtonView()
                }
            }
            
            Spacer()
            XButtonView(isAdShowing: $isAdShowing)
        }
            
        .padding()
        .frame(width: UIScreen.main.bounds.width - 32, height: 220, alignment: .center)
        .background(CardGradientView())
        .cornerRadius(18)
        .padding(.vertical)
        
    }
}

struct CardHeaderLabelView: View {
    let label: String
    
    var body: some View {
        Text(label)
            .font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color.white)
    }
}

struct CardBodyLabelView: View {
    let label: String
    
    var body: some View {
        Text(label)
            .foregroundColor(Color(.systemGray5))
    }
}

struct CardGradientView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(.systemIndigo), Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct XButtonView: View {
    @Binding var isAdShowing: Bool
    
    var body: some View {
        
        VStack {
            Button(action: action) {
                Image(systemName: "xmark")
                    .font(Font.body.weight(.medium))
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.white.opacity(0.4))
                    .clipShape(Circle())
                
                Spacer().background(Color.yellow)
            }
        }
    }
    
    func action(){
        isAdShowing.toggle()
    }
}

struct CardButtonView: View {
    var body: some View {
        Button(action: {
            print("Tap!!")
        }) {
            Text("Go Pro")
                .accentColor(.white)
                .frame(width: 100, height: 40)
                .background(Color.orange)
                .clipShape(Capsule())
                .padding(.vertical)
            
        }
    }
}

struct HeaderView: View {
    let label: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.title)
                .fontWeight(.heavy)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct Course: Identifiable {
    var id = UUID()
    let image: String
    let category: String
    let label: String
    let numberOfLessons: String
    let percentageWatched: CGFloat
}

struct CoursesScrollView: View {
    
    var body: some View {
        VStack{
            HeaderView(label: "Runing Courses")
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(0 ..< 5){ _ in
                        CoursesView()
                    }
                }
            }
        }
    }
}

struct CoursesView: View {
    var courses = [
        Course(id: UUID(), image: "learn", category: "Arts & Crafts", label: "How to make paper Crafts", numberOfLessons: "3 of 9", percentageWatched: 50),
        Course(id: UUID(), image: "learn", category: "Robotics", label: "How to make robots! yeah", numberOfLessons: "6 of 29", percentageWatched: 12),
    ]
    
    var body: some View {
        VStack(alignment: .leading){
            ForEach(courses, id: \.id){ course in
                NavigationLink(destination: Text("Comming Soon")){
                    HStack(alignment: .top){
                        Image(course.image)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: ContentMode.fit)
                            .frame(width: 72, height: 72)
                            .background(CardGradientView())
                            //.clipShape(Circle())
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading){
                            Text(course.category)
                                .foregroundColor(.purple)
                                .padding(.bottom, 4)
                            
                            Text(course.label)
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundColor(Color(.label))
                            
                            HStack {
                                Text(course.numberOfLessons)
                                    .foregroundColor(.secondary)
                                
                                Spacer()
                                ZStack(alignment: .leading){
                                    Rectangle()
                                        .frame(width: 100, height: 8)
                                        .foregroundColor(Color(.systemGray5))
                                    
                                    Rectangle()
                                        .frame(width: course.percentageWatched, height: 8)
                                        .foregroundColor(.orange)
                                }
                                .clipShape(Capsule())
                                
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}


struct RecommendedScrollView: View {
    
    var body: some View {
        VStack{
            HeaderView(label: "Recommended Courses")
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(0 ..< 5){ _ in
                        ZStack(alignment: .topLeading){
                            Image("learn")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 100, height: 200)
                            Rectangle()
                                .foregroundColor(.purple)
                                .opacity(0.9)
                            
                            Button(action: {
                                
                            }) {
                                Text("Recommended")
                                .bold()
                                    .foregroundColor(Color(.label))
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Capsule())
                                    .padding()
                            }
                            
                        }
                        .cornerRadius(12)
                    }
                    .padding(.leading)
                }
            }
        }
    }
    
}
