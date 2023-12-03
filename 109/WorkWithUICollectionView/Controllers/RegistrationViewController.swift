import UIKit

class RegistrationViewController: UIViewController {
    lazy var registrationView = RegistrationView(frame: .zero)
    override func loadView() {
        super.loadView()
        registrationView.actionSendData = { [weak self] login, password in
            Task {
                await RegistrationDataManager.shared.tryLogin(login: login, password: password)
                if await RegistrationDataManager.shared.getCurrentUser() != nil {
                    UserDefaults.standard.setValue(true, forKey: "loggedIn")
                    RegistrationDataManager.shared.saveUser()
                    self?.showTabBarController()
                } else if login == "" || password == "" {
                    self?.registrationView.showAlert(title: "Внимание", message: "Заполните все поля")
                } else {
                    self?.registrationView.showAlert(title: "Внимание", message: "Введены некорректные данные")
                }
            }
        }
        registrationView.actionAlertPresent = { [weak self] alert in
            self?.present(alert, animated: true, completion: nil)
        }
        view = registrationView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    func showTabBarController() {
        let firstViewController = ProfileViewController()
        firstViewController.view.backgroundColor = .white
        firstViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "profile"),
            selectedImage: UIImage(named: "profile")
        )
        let secondViewController = StoryViewController()
        secondViewController.view.backgroundColor = .white
        secondViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "home"),
            selectedImage: UIImage(named: "home")
        )
        firstViewController.view.backgroundColor = .black
        secondViewController.view.backgroundColor = .black
        let firstNavigationController = UINavigationController(rootViewController: firstViewController)
        let secondNavigationController = UINavigationController(rootViewController: secondViewController)
        let tabBarController = UITabBarController()
        firstNavigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        secondNavigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        tabBarController.setViewControllers([firstNavigationController, secondNavigationController], animated: false)

        tabBarController.tabBar.barTintColor = .black
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .black
        tabBarController.tabBar.backgroundColor = .darkGray
        SceneDelegate.window?.rootViewController = tabBarController
        SceneDelegate.window?.makeKeyAndVisible()
    }
    func setupNavigationBar() {
        navigationItem.title = "Welcome to CatGram"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
}
