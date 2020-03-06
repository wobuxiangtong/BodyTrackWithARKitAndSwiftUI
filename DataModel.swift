//
//  DataModel.swift
//  RKitDemo4
//
//  Created by uniwow on 2020/3/2.
//  Copyright © 2020 uniwow. All rights reserved.
//

//
//  DataModel.swift
//  RKitDemo
//
//  Created by uniwow on 2020/2/24.
//  Copyright © 2020 uniwow. All rights reserved.
//

import Combine
import RealityKit
import ARKit


final class DataModel: NSObject,ObservableObject,ARSessionDelegate {
    static var shared = DataModel()
    
    @Published var arView: ARView!
    @Published var enableAR = false
    
    @Published var xTranslation: Float = 0 {
        didSet {
            translateBox()
        }
    }
    @Published var yTranslation: Float = 0 {
        didSet {
            translateBox()
        }
    }
    @Published var zTranslation: Float = 0 {
        didSet {
            translateBox()
        }
    }
    
    
    var character: BodyTrackedEntity?
    var characterOffset: SIMD3<Float> = [-1.0, 0, 0] // Offset the character by one meter to the left
    let characterAnchor = AnchorEntity()
    
    
    
    override init() {
        super.init()
        arView = ARView(frame: .zero)
        arView.session.delegate = self
        
        // If the iOS device doesn't support body tracking, raise a developer error for
        // this unhandled case.
        guard ARBodyTrackingConfiguration.isSupported else {
            fatalError("This feature is only supported on devices with an A12 chip")
        }

        // Run a body tracking configration.
        let configuration = ARBodyTrackingConfiguration()
        arView.session.run(configuration)

        
        arView.scene.anchors.append(characterAnchor)
        
        var cancellable: AnyCancellable? = nil
        cancellable = Entity.loadBodyTrackedAsync(named: "robot").sink(
            receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: Unable to load model: \(error.localizedDescription)")
                }
                cancellable?.cancel()
        }, receiveValue: { (character: Entity) in
            if let character = character as? BodyTrackedEntity {
                // Scale the character to human size
                character.scale = [1.0, 1.0, 1.0]
                self.character = character
                cancellable?.cancel()
            } else {
                print("Error: Unable to load model as BodyTrackedEntity")
            }
        })
        
    }
    
    
    
    
    
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
         for anchor in anchors {
             guard let bodyAnchor = anchor as? ARBodyAnchor else { continue }
             
             // Update the position of the character anchor's position.
             let bodyPosition = simd_make_float3(bodyAnchor.transform.columns.3)
            print("----->",characterOffset)
             characterAnchor.position = bodyPosition + characterOffset
             // Also copy over the rotation of the body anchor, because the skeleton's pose
             // in the world is relative to the body anchor's rotation.
             characterAnchor.orientation = Transform(matrix: bodyAnchor.transform).rotation
    
             if let character = character, character.parent == nil {
                 // Attach the character to its anchor as soon as
                 // 1. the body anchor was detected and
                 // 2. the character was loaded.
                 characterAnchor.addChild(character)
             }
         }
     }
    
    func translateBox() {
        
        let xTranslationM = xTranslation
        let yTranslationM = yTranslation
        let zTranslationM = zTranslation
        
        characterOffset = SIMD3<Float>(xTranslationM,
        yTranslationM,
        zTranslationM)
    }
    
    
    
}


