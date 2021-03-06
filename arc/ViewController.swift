//
//  ViewController.swift
//  arc
//
//  Created by James Liang on 3/31/19.
//  Copyright © 2019 James Liang. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    }
    
    func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    @IBAction func node(_ sender: Any) {
        let x = Double.random(in: -0.3 ..< 0.3)
        let y = Double.random(in: -0.3 ..< 0.3)
        let z = Double.random(in: -1.0 ..< -0.3)
        let randomColor = self.generateRandomColor()
        let randomChamfer = CGFloat.random(in: -0.1 ..< 0.1)
        
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: randomChamfer)
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        node.geometry?.firstMaterial?.diffuse.contents = randomColor
        
        node.position = SCNVector3(x,y,z)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    @IBAction func capsule(_ sender: Any) {
        let x = Double.random(in: -0.3 ..< 0.3)
        let y = Double.random(in: -0.3 ..< 0.3)
        let z = Double.random(in: -1.0 ..< -0.3)
        let randomColor = self.generateRandomColor()
        
        let capsule = SCNNode()
        capsule.geometry = SCNCapsule(capRadius: 0.07, height: 0.3)
        capsule.geometry?.firstMaterial?.specular.contents = UIColor.white
        capsule.geometry?.firstMaterial?.diffuse.contents = randomColor
        
        capsule.position = SCNVector3(x,y,z)
        self.sceneView.scene.rootNode.addChildNode(capsule)
    }
    
    @IBAction func cone(_ sender: Any) {
        let x = Double.random(in: -0.3 ..< 0.3)
        let y = Double.random(in: -0.3 ..< 0.3)
        let z = Double.random(in: -1.0 ..< -0.3)
        let randomColor = self.generateRandomColor()
        
        let cone = SCNNode()
        cone.geometry = SCNCone(topRadius: 0.0, bottomRadius: 0.1, height: 0.3)
        cone.geometry?.firstMaterial?.specular.contents = UIColor.white
        cone.geometry?.firstMaterial?.diffuse.contents = randomColor
        
        cone.position = SCNVector3(x,y,z)
        self.sceneView.scene.rootNode.addChildNode(cone)
    }
    
    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
    
    func restartSession(){
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes{ (node, _) in node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
}
