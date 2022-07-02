import Cocoa
import FlutterMacOS



@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  //FirebaseApp.configure()
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    //FirebaseApp.configure()
    return true
  }
}
