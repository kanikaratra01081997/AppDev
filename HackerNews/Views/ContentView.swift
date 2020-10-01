//
//  ContentView.swift
//  HackerNews
//
//  Created by Kanika Ratra on 30/08/20.
//  Copyright © 2020 Kanika Ratra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
   @ObservedObject var networkManager = NetworkManager()
    
    
    var body: some View {
        NavigationView {
            
            
            List(networkManager.posts){post in
                
                
                NavigationLink(destination:DetailView(url:post.url)) {
                    HStack {
                                       Text(String(post.points))
                                         Text(post.title)
                                   }
                }
                
               
              
            }
                
            
            .navigationBarTitle("hackerNews")
           
        }
        .onAppear {
            self.networkManager.fethData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//let posts=[Post(id: "1", title: "hello"),
//Post(id: "2", title: "hello kanika"),Post(id: "3", title: "hello kanikaaa")]
