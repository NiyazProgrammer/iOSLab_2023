//
//  SubscribersViewController.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 02.12.2023.
//

import UIKit

class SubscribersViewController: UIViewController {
    let subscribersView = SubscribersView(frame: .zero)
    override func loadView() {
        super.loadView()
        view = subscribersView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let subscribers = RegistrationDataManager.shared.obtainUser().subscriptions
        subscribersView.setSubscribers(subscribers: subscribers)
    }
}
