//
//  SceneDelegate.swift
//  Instagram
//
//  Created by Jung Choi on 7/26/23.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    // TODO: Dependency Injection Container
    private lazy var storageClient = FirebaseStorage.Storage.storage()
    private lazy var storageManager = StorageManager(storageClient: storageClient)
    private lazy var databaseClient = Firestore.firestore()
    private lazy var databaseManager = DatabaseManager(databaseClient: databaseClient)
    private lazy var authClient = FirebaseAuth.Auth.auth()
    private lazy var authManager = AuthService(authClient: authClient, databaseManager: databaseManager, storageManager: storageManager)
    private lazy var postRepository = PostRepository(storageManager: storageManager, databaseManager: databaseManager)
    private lazy var userRepository = UserRepository(storageManager: storageManager, databaseManager: databaseManager)
    private lazy var notificationRepository = NotificationRepository(databaseManager: databaseManager)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        let notification = IGNotification(
            id: UUID().uuidString,
            type: .follow,
            profilePictureURL: "https://www.allprodad.com/wp-content/uploads/2021/03/05-12-21-happy-people.jpg",
            userID: "A948AF93-C92D-4302-857D-69A2BC579F8D",
            username: "zztopaz",
            postID: nil,
            postImageURL: nil,
            isFollowing: false,
            timestamp: String.date(from: Date())
        )
        Task {
            do {
                try await notificationRepository.createNotification(userID:"850CB200-FCEA-4B8E-9CC4-D5BC94D41956", notification:notification)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        coordinator = AppCoordinator(
            navigationController: navigationController,
            authManager: authManager,
            postRepository: postRepository,
            userRepository: userRepository,
            notificationRepository: notificationRepository
        )
        coordinator?.start()
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

