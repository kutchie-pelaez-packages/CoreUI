import UIKit

final class Application: UIApplication, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let rootViewController = SystemViewsViewController()

        let navigationController = UINavigationController(
            rootViewController: rootViewController
        )
        navigationController.navigationBar.prefersLargeTitles = true

        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
