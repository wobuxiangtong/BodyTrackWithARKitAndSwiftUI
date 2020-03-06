//
//  ContentView.swift
//  RKitDemo4
//
//  Created by uniwow on 2020/2/26.
//  Copyright © 2020 uniwow. All rights reserved.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    @EnvironmentObject var data: DataModel
    var body: some View {
        ZStack {
//            Color.green.edgesIgnoringSafeArea(.all).opacity(0.5)
            
            if data.enableAR {
                
                ARDisplayView()
            }
            ARUIView()
        }
    }
}










#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
