import Cocoa
import SceneKit
import QuartzCore
import XCPlayground

var sceneView = SCNView(frame: CGRect(x:0,y:0,width:300,height:300))
var scene = SCNScene()

sceneView.scene = scene;

//That's create the playground viewport
XCPShowView("my view", sceneView);

sceneView.autoenablesDefaultLighting = true;

var camera = SCNCamera()
var cameraNode = SCNNode()

cameraNode.camera = camera
cameraNode.position = SCNVector3(x:0,y:0,z:10)
scene.rootNode.addChildNode(cameraNode)

var globe = SCNSphere(radius: 2)
var globeNode = SCNNode(geometry: globe)

scene.rootNode.addChildNode(globeNode)

globe.firstMaterial.diffuse.contents = NSColor.redColor()
globe.firstMaterial.specular.contents = NSColor.whiteColor()






