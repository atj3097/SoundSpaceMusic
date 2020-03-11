//
//  ContentView.swift
//  SoundSpaceMusic
//
//  Created by God on 3/11/20.
//  Copyright © 2020 Adam Jackson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
            VStack {
            Image("coverArt")
                .resizable()
                .frame(width: 100.0, height: 100.0, alignment: .center)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
