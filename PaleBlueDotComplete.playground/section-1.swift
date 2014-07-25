// Pale Blue Dot demo completed

import Cocoa
import SceneKit
import QuartzCore
import XCPlayground

class MyScene : SCNScene  {
    
    let camera:SCNNode
    let sun:SCNNode
    let earth:SCNNode
    
    var sunRotation:CGFloat
    let sunRotationSpeed:CGFloat
    
    var earthRotation:CGFloat
    let earthRotationSpeed:CGFloat
    
    init() {
        
        camera = SCNNode()
        camera.camera = SCNCamera()
        camera.position = SCNVector3(x: 0, y: 0, z: 15)
        camera.light = SCNLight()
        camera.light.type = SCNLightTypeAmbient
        camera.light.color =  NSColor(white: 0.0005, alpha: 1.0)
        
        sun = SCNNode()
        sun.light = SCNLight()
        sun.light.type = SCNLightTypeDirectional
        
        earth = SCNNode(geometry: SCNSphere(radius: 5))
        
        var material = earth.geometry.firstMaterial;
        
        earth.geometry.firstMaterial.ambient.contents = NSImage(named:"earthmap1k.jpg")
        earth.geometry.firstMaterial.diffuse.contents = earth.geometry.firstMaterial.ambient.contents
        earth.geometry.firstMaterial.specular.contents = NSImage(named: "earthspec1k")
        earth.geometry.firstMaterial.specular.intensity = 0.25
        earth.geometry.firstMaterial.emission.contents = NSImage(named: "earthlights1k")
        
        sunRotationSpeed = CGFloat(M_PI_4/2)
        sunRotation = CGFloat(M_PI_2)
        sun.rotation = SCNVector4(x: 0.0, y: 1.0, z: 0.0, w: sunRotation)
        
        earthRotationSpeed = CGFloat(M_PI_4/10)
        earthRotation = 0
        
        super.init()
        
        rootNode.addChildNode(camera)
        rootNode.addChildNode(sun)
        rootNode.addChildNode(earth)
    }
    
    func rotateNodeLeft(node:SCNNode ,value:CGFloat, increase:CGFloat) -> CGFloat
    {
        var rotation = value
        
        if value < CGFloat(-M_PI*2)
        {
            rotation = value + CGFloat(M_PI*2)
            node.rotation = SCNVector4(x: 0.0, y: 1.0, z: 0.0, w: rotation)
        }
        
        return rotation - increase
    }
    
    func doAnimation(){
        
        sunRotation = rotateNodeLeft(sun, value: sunRotation, increase: sunRotationSpeed)
        earthRotation = rotateNodeLeft(earth, value: earthRotation, increase: earthRotationSpeed)
        
        XCPCaptureValue("Sun rotation", sunRotation)
        XCPCaptureValue("Earth rotation", earthRotation)
        
        SCNTransaction.begin()
        SCNTransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear))
        SCNTransaction.setAnimationDuration(1)
        SCNTransaction.setCompletionBlock{
            self.doAnimation()
        }
        
        sun.rotation = SCNVector4(x: 0.0, y: 1.0, z: 0.0, w: sunRotation)
        earth.rotation = SCNVector4(x: 0.0, y: 1.0, z: 0.0, w: earthRotation)
        
        SCNTransaction.commit()
    }
}

var sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 900, height: 700))
var scene = MyScene()

sceneView.backgroundColor = NSColor.blackColor()
sceneView.autoenablesDefaultLighting = true
sceneView.scene = scene

scene.doAnimation()

XCPShowView("The pale blue dot", sceneView)
XCPExecutionShouldContinueIndefinitely()

