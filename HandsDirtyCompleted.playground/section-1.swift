import Cocoa
import SceneKit
import QuartzCore
import XCPlayground

var sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 700, height: 500))
var scene = SCNScene()

sceneView.autoenablesDefaultLighting = true
sceneView.scene = scene;

XCPShowView("My 3D Scene", sceneView)

var cameraNode = SCNNode()
cameraNode.camera = SCNCamera()
cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)

scene.rootNode.addChildNode(cameraNode)

var model = SCNNode(geometry: SCNTorus(ringRadius: 3, pipeRadius: 1))
var color = NSColor.greenColor()

model.geometry.firstMaterial.diffuse.contents = color;

scene.rootNode.addChildNode(model)

var spin = CABasicAnimation(keyPath: "rotation")
spin.toValue = NSValue(SCNVector4: SCNVector4(x: 0.0, y: 1.0, z: 1.0, w: CGFloat(2.0*M_PI)))
spin.duration = 5
spin.repeatCount = HUGE
spin.delegate

model.addAnimation(spin, forKey: "spin me!")






