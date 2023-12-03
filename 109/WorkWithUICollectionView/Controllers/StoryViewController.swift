import UIKit
class StoryViewController: UIViewController, UpdateDataDelegate, UpdateDataEverythingControllers {
    lazy var storyView = StoryView(frame: .zero)
    override func loadView() {
        super.loadView()
        storyView.actionAlertPresent = { [weak self] alert in
            self?.present(alert, animated: true, completion: nil)
        }
        view = storyView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        storyView.tableStoryPosts.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        RegistrationDataManager.shared.delegate = self
        updateData()
    }
    func setupNavigationBar() {
        navigationItem.title = "Catgram"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    func updateData() {
        Task {
            let cat = await RegistrationDataManager.shared.getCurrentUser()
            let publications = await PublicationDataManager.shared.asyncGetEverythingPublication()
            storyView.publication = publications
            storyView.cat = cat
            storyView.tableStoryPosts.reloadData()
        }
    }
}
