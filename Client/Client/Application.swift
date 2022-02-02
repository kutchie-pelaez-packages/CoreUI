import UIKit

final class Application: UIApplication, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let rootViewController = ComponentsViewController()

        window = UIWindow()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        return true
    }
}
