//
//  ARDisplayView.swift
//  RKitDemo4
//
//  Created by uniwow on 2020/3/5.
//  Copyright © 2020 uniwow. All rights reserved.
//

import SwiftUI
import RealityKit

struct ARDisplayView: View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        
        return DataModel.shared.arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

struct ARDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        ARDisplayView()
    }
}
