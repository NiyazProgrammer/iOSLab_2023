import UIKit

class ProfileViewController: UIViewController, UpdateDataDelegate, UpdateDataEverythingControllers {
    lazy var profileView = ProfileView(frame: .zero)
    var optionViewController: UIViewController?
    override func loadView() {
        super.loadView()
        profileView.optionsTapped = { [weak self] in
            let vcSheet = OptionsSheetViewController()
            vcSheet.optionsSheetView.delegate = self
            let navVC = UINavigationController(rootViewController: vcSheet)
            if let sheet = navVC.sheetPresentationController {
                sheet.preferredCornerRadius = 30
                sheet.detents = [.custom(resolver: { context in
                    0.4 * context.maximumDetentValue
                }), .large()]
                sheet.largestUndimmedDetentIdentifier = .large
            }
            self?.navigationController?.present(navVC, animated: true)
            self?.optionViewController = vcSheet
        }

        profileView.subscribersTapped = { [weak self] in
            self?.navigationController?.pushViewController(SubscribersViewController(), animated: false)
        }
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        profileView.gridCollectionView.delegate = self
        RegistrationDataManager.shared.delegate1 = self
        updateData()
    }
    func setupNavigationBar() {
        let buttonForOptionsProfile = profileView.buttonForOptionsProfile
        let customBarButtonItem = UIBarButtonItem(customView: buttonForOptionsProfile)
        navigationItem.rightBarButtonItem = customBarButtonItem
        navigationItem.title = "Profile"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    func updateData() {
        Task {
            let cat = await RegistrationDataManager.shared.getCurrentUser()
            profileView.count = cat?.publications.count ?? 0
            profileView.cat = cat
            profileView.gridCollectionView.reloadData()
        }
    }
}
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let piblicationViewController = PublicationViewController()
        piblicationViewController.selectedIndexPath = indexPath
        piblicationViewController.delegate = self
        present(piblicationViewController, animated: true, completion: nil)
    }
}
extension ProfileViewController: AccessingRootController {
    func pushNewController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
