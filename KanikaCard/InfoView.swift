//
//  InfoView.swift
//  KanikaCard
//
//  Created by Kanika Ratra on 29/08/20.
//  Copyright © 2020 Kanika Ratra. All rights reserved.
//

import SwiftUI
struct InfoView: View {
    let text:String
    let imageName:String
    
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 50).frame( height: 50).foregroundColor(.white).overlay(HStack {
            Image(systemName: imageName).foregroundColor(.green)
            Text(text)
        }).padding(.all)
    }
}


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "hello", imageName: "phone.fill")
            .previewLayout(.sizeThatFits)
    }
}
