//
//  ContentView.swift
//  KanikaCard
//
//  Created by Kanika Ratra on 29/08/20.
//  Copyright © 2020 Kanika Ratra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            Color(red: 0.75, green: 0.22, blue: 0.17).edgesIgnoringSafeArea(.all)
            VStack {
                Image("kanika")
                    .resizable().aspectRatio(contentMode: .fit).frame(width: 250, height: 250).clipShape(Rectangle()).overlay(Rectangle().stroke(Color.white,lineWidth: 5))
                Text("Kanika Ratra")
                    .font(Font.custom("Pacifico-Regular", size: 40)).foregroundColor(.white).bold()
                Text("iOS Developer").foregroundColor(.white).font(.system(size: 25))
                Divider()
                
                InfoView(text: "+9172909270**", imageName:"phone.fill")
             
                 InfoView(text:"kanikaratra01@gmail.com", imageName: "envelope.fill")
           
                
                
            }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 
