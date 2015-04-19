import Cocoa
import SceneKit
import QuartzCore
import XCPlayground

class MyScene : SCNScene  {
    
    var camera = SCNNode()
    var model = SCNNode ()
    var spin:CGFloat = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        
        camera = SCNNode()
        camera.camera = SCNCamera()
        camera.position = SCNVector3(x: 0, y: 0, z: 30)
        
        model = SCNNode(geometry: SCNTorus(ringRadius: 4, pipeRadius: 1))
        model.geometry?.firstMaterial?.diffuse.contents = NSColor.greenColor()

        spin = 10
        
        super.init()
        
        rootNode.addChildNode(camera)
        rootNode.addChildNode(model)
    }
    
    func doAnimation(){
        
        if spin > CGFloat(M_PI*2)
        {
            spin -= CGFloat(M_PI*2)
            model.rotation = SCNVector4(x: 1, y: 0, z: 0, w: spin)

        }
        spin += CGFloat(M_PI_2)
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

