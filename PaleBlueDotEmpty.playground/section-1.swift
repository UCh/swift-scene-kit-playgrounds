import Cocoa
import SceneKit
import QuartzCore
import XCPlayground

class MyScene : SCNScene  {
    
    let camera:SCNNode
    let earth:SCNNode
    
    var earthRotation:CGFloat
    let earthRotationSpeed:CGFloat
    
    init() {
        
        camera = SCNNode()
        camera.camera = SCNCamera()
        camera.position = SCNVector3(x: 0, y: 0, z: 15)
        
        earth = SCNNode(geometry: SCNSphere(radius: 5))
        
        earthRotationSpeed = M_PI_4/10
        earthRotation = 0
        
        super.init()
        
        rootNode.addChildNode(camera)
        rootNode.addChildNode(earth)
    }
    
    func rotateNodeLeft(node:SCNNode ,value:CGFloat, increase:CGFloat) -> CGFloat
    {
        var rotation = value
        
        if(value < -M_PI*2)
        {
            rotation = value + M_PI*2
            node.rotation = SCNVector4(x: 0, y: 1, z: 0, w: rotation)
        }
        
        return rotation - increase
    }
    
    func doAnimation(){
        
        earthRotation = rotateNodeLeft(earth, value: earthRotation, increase: earthRotationSpeed)
        
        XCPCaptureValue("Globe rotation", earthRotation)
        
        SCNTransaction.begin()
        SCNTransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear))
        SCNTransaction.setAnimationDuration(1)
        SCNTransaction.setCompletionBlock{
            self.doAnimation()
        }
        
        earth.rotation = SCNVector4(x: 0, y: 1, z: 0, w: earthRotation)
        
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
