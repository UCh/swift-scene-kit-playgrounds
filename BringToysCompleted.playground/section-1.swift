import Cocoa
import SceneKit
import QuartzCore
import XCPlayground

class MyScene : SCNScene, SCNProgramDelegate  {
    
    let camera:SCNNode
    let model:SCNNode
    let program:SCNProgram

    var spin:CGFloat
    
    init() {
        
        camera = SCNNode()
        camera.camera = SCNCamera()
        camera.position = SCNVector3(x: 0, y: 0, z: 10)
        
        model = SCNNode(geometry: SCNBox(width: 3, height: 3, length: 3, chamferRadius: 0.5))
       
        spin = 0
        
        program = SCNProgram()
        
        var error:NSErrorPointer = NSErrorPointer()
        var path = NSBundle.mainBundle().pathForResource("passthrough", ofType: "vert")
        let vertex = String.stringWithContentsOfFile(path, encoding: NSUTF8StringEncoding, error: error)

        if let vertexShader = vertex {
            program.vertexShader = vertexShader;
        }
        
        path = NSBundle.mainBundle().pathForResource("simplex", ofType: "frag")
        let frag = String.stringWithContentsOfFile(path, encoding: NSUTF8StringEncoding, error: error)
        
        if let fragShader = frag {
            program.fragmentShader = fragShader;
        }
        

        program.setSemantic(SCNGeometrySourceSemanticVertex, forSymbol: "a_vertex", options: nil)
        program.setSemantic(SCNModelViewProjectionTransform, forSymbol: "u_mvpMatrix", options: nil)
        
        model.geometry.program = program
        
        super.init()
        
        rootNode.addChildNode(camera)
        rootNode.addChildNode(model)
        program.delegate = self
    }
    
    func doAnimation(){
        
        if(spin > M_PI*2)
        {
            spin -= M_PI*2
            model.rotation = SCNVector4(x: 0, y: 1, z: 1, w: spin)
            
        }
        spin += M_PI_2
        XCPCaptureValue("Spin rotation", spin)
        
        SCNTransaction.begin()
        SCNTransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear))
        SCNTransaction.setAnimationDuration(1)
        SCNTransaction.setCompletionBlock{
            self.doAnimation()
        }
        
        model.rotation = SCNVector4(x: 0, y: 1, z: 1, w: spin)
        
        SCNTransaction.commit()
    }

    
}

var sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
var scene = MyScene()

sceneView.scene = scene
scene.doAnimation();

XCPShowView("My Scene view", sceneView)
XCPExecutionShouldContinueIndefinitely()

