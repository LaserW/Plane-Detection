//
//  node.swift
//  Plane Detection
//
//  Created by Березин Дмитрий Борисович on 27/01/2019.
//  Copyright © 2019 Dmitry Berezin. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class Node: UIViewController {
    
    func loadCampus() -> SCNNode? {
        guard let scene = SCNScene(named: "art.scnassets/Campus.scn") else {return nil}
        let node = scene.rootNode.clone()
        return node
    }
    
    //********
    //****programming
    
    func loadProgrammaticCampus(anchor: ARPlaneAnchor) -> SCNNode {
        let campusNode = SCNNode()
        let buildingNode = loadBuilding()
        
        let treeNode = loadTree()
        treeNode.scale = SCNVector3(0.15,0.15,0.15)
        treeNode.position.z += 0.6    //влево-вправо
        treeNode.position.x -= 2.2  //вперёд-назад
        treeNode.position.y += 0.1 //вверх-вниз
        
        let treeNode1 = loadTree()
        treeNode1.scale = SCNVector3(0.15,0.15,0.15)
        treeNode1.position.z += 0
        treeNode1.position.x -= 2.2
        treeNode1.position.y += 0.1
        
        let treeNode2 = loadTree()
        treeNode2.scale = SCNVector3(0.15,0.15,0.15)
        treeNode2.position.z -= 0.6
        treeNode2.position.x -= 2.2
        treeNode2.position.y += 0.1
        
        let treeNode3 = loadTree()
        treeNode3.scale = SCNVector3(0.15,0.15,0.15)
        treeNode3.position.z += 0.6
        treeNode3.position.x += 2.2
        treeNode3.position.y += 0.1
        
        let treeNode4 = loadTree()
        treeNode4.scale = SCNVector3(0.15,0.15,0.15)
        treeNode4.position.z += 0
        treeNode4.position.x += 2.2
        treeNode4.position.y += 0.1
        
        let treeNode5 = loadTree()
        treeNode5.scale = SCNVector3(0.15,0.15,0.15)
        treeNode5.position.z -= 0.6
        treeNode5.position.x += 2.2
        treeNode5.position.y += 0.1
        
        campusNode.runAction(    //buildingNode
            .repeatForever(
                .rotateBy(x: 0, y: -.pi, z: 0, duration: 10)
            )
        )
        
//        campusNode.position.z -= 3
//        campusNode.position.y -= 1.5
        campusNode.scale = SCNVector3(0.05,0.05,0.05)
        let center = anchor.center
        campusNode.position = SCNVector3(center.x, 0, center.y)
        
        campusNode.addChildNode(buildingNode)
        campusNode.addChildNode(treeNode)
        campusNode.addChildNode(treeNode1)
        campusNode.addChildNode(treeNode2)
        campusNode.addChildNode(treeNode3)
        campusNode.addChildNode(treeNode4)
        campusNode.addChildNode(treeNode5)
        
        return campusNode
    }
    
    func loadBuilding() -> SCNNode {
        //Node
        let buildingNode = SCNNode()
        //Creation of brown box
        let boxNode = SCNNode()
        boxNode.position.y += 0.5
        
        //Geometry
        let building = SCNBox(width: 3, height: 1, length: 1, chamferRadius: 0)
        
        //Material
        var materials = [SCNMaterial]()
        
        [UIColor.red, .orange, .yellow, .green, .blue, .purple].forEach { color in
            let material = SCNMaterial()
            material.diffuse.contents = color
            materials.append(material)
        }
        
        building.materials = materials
        boxNode.geometry = building
        buildingNode.addChildNode(boxNode)
        
        //Creation of green grass
        let grassNode = SCNNode(geometry: SCNPlane(width: 6, height: 2))
        grassNode.eulerAngles.x -= .pi / 2
        grassNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        buildingNode.addChildNode(grassNode)
        
        
        return buildingNode
    }
    
    
    func loadTree() -> SCNNode {
        let treeNode = SCNNode()
        let cylinderNode = loadCylinder()
        let sphereNode = loadSphere()
        
        
        treeNode.addChildNode(cylinderNode)
        treeNode.addChildNode(sphereNode)
        
        return treeNode
    }
    
    func loadCylinder() -> SCNNode {
        let cylinder = SCNNode(geometry: SCNCylinder(radius: 0.1, height: 2))
        cylinder.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        return cylinder
    }
    
    func loadSphere() -> SCNNode {
        let sphere = SCNNode(geometry: SCNSphere(radius: 1))
        sphere.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        sphere.position.y += 1.5
        return sphere
    }
    
    
}

