//
//  SceneDelegate.swift
//  Catty App
//
//  Created by Vladimir Alyoshkin on 02.10.21.
//

import UIKit

extension NSNotification.Name {
    static let reloadRoot = NSNotification.Name("MyNotificationName")
    static let loadContentViewController = NSNotification.Name("ThisIsContentViewController")
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        loadAppropriateViewController(window: window)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadRootDidSend(_:)), name: NSNotification.Name.reloadRoot, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadRootDidSend(_:)), name: NSNotification.Name.loadContentViewController, object: nil)
    }
    
    
    @objc func reloadRootDidSend(_ anyNotification: Any) {
        guard let notification = anyNotification as? NSNotification else {return}
        
        if notification.name == NSNotification.Name.reloadRoot {
            if let win = self.window {
                loadAppropriateViewController(window: win)
            }
        } else if notification.name == NSNotification.Name.loadContentViewController {
            if let win = self.window {
                loadContentViewController(window: win)
        } else {
            fatalError()
        }
      }
    }
        
        private func loadAppropriateViewController(window: UIWindow) {
            let password = UserDefaults.standard.string(forKey: "This is password")
            
            if password == nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let instantiateViewController = storyboard.instantiateViewController(withIdentifier: "SetUpLockScreenViewController")

                window.rootViewController = instantiateViewController
            } else {
            let instantiateViewController = PasswordViewController(nibName: nil, bundle: nil)
                window.rootViewController = instantiateViewController
            }
            
            window.makeKeyAndVisible()
            self.window = window
        }

    @objc func loadContentViewController(window: UIWindow) {
        let vc = TagsViewController()
        let nc = UINavigationController(rootViewController: vc)
        
        window.rootViewController = nc
        window.makeKeyAndVisible()
        
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

