//
//  ARUIView.swift
//  RKitDemo
//
//  Created by uniwow on 2020/2/25.
//  Copyright © 2020 uniwow. All rights reserved.
//

import SwiftUI
import ARKit

struct ARUIView: View {
    
    @EnvironmentObject var data: DataModel
    var body: some View {
        VStack{
            Toggle(isOn: $data.enableAR) {
                
                return Text("AR")
            }
            
            Stepper("x: \(Int(data.xTranslation))",
                value:$data.xTranslation,in: -100...100)
            Stepper("y: \(Int(data.yTranslation))",
            value:$data.yTranslation,in: -100...100)
            Stepper("z: \(Int(data.zTranslation))",
            value:$data.zTranslation,in: -100...100)
            
        }.frame(width: CGFloat(200),height: CGFloat(200)).background(Color.clear)
            
    }
}

struct ARUIView_Previews: PreviewProvider {
    static var previews: some View {
        ARUIView()
    }
}
