import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = UIWindow()
    var mainCoordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        mainCoordinator = MainCoordinator()
        mainCoordinator?.start()
        window!.rootViewController = mainCoordinator?.navigationController
        window!.makeKeyAndVisible()
        return true
    }
}
