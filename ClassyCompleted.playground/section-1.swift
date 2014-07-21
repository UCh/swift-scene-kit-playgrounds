import Cocoa
import SceneKit
import QuartzCore
import XCPlayground

class MyScene : SCNScene  {
    
    let camera:SCNNode
    let model:SCNNode
    var spin:CGFloat
    
    init() {
        
        camera = SCNNode()
        camera.camera = SCNCamera()
        camera.position = SCNVector3(x: 0, y: 0, z: 15)
        
        model = SCNNode(geometry: SCNTorus(ringRadius: 4, pipeRadius: 1))
        model.geometry.firstMaterial.diffuse.contents = NSColor.greenColor()

        spin = 0
        
        super.init()
        
        rootNode.addChildNode(camera)
        rootNode.addChildNode(model)
    }
    
    func doAnimation(){
        
        if(spin > M_PI*2)
        {
            spin -= M_PI*2
            model.rotation = SCNVector4(x: 1, y: 0, z: 0, w: spin)

        }
        spin += M_PI_2
        XCPCaptureValue("Spin rotation", spin)
        
        SCNTransaction.begin()
        SCNTransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear))
        SCNTransaction.setAnimationDuration(1)
        SCNTransaction.setCompletionBlock{
            self.doAnimation()
        }
        
        model.rotation = SCNVector4(x: 1, y: 0, z: 0, w: spin)
        
        SCNTransaction.commit()
    }
}

var sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
var scene = MyScene()

sceneView.autoenablesDefaultLighting = true
sceneView.scene = scene

scene.doAnimation()

XCPShowView("My Scene view", sceneView)
XCPExecutionShouldContinueIndefinitely()

