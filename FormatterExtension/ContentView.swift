//
//  ContentView.swift
//  SwiftFormatter
//
//  Created by Simon Anreiter on 30.01.20.
//  Copyright © 2020 Simon Anreiter. All rights reserved.
//

import Combine
import SwiftFormatConfiguration
import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
            Text("""
                1. Go to SystemPreferences -> Extensions
                2. Enable FormatterExtension
                """)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
