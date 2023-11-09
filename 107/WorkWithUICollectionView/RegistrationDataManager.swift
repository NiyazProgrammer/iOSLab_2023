//
//  RegistrationDataManager.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 07.11.2023.
//

import Foundation
import UIKit
protocol UpdateDataEverythingControllers: AnyObject {
    func updateData()
}
class RegistrationDataManager: UsersProtocol {
    func asyncCheckedUser(login: String, password: String, completion: @escaping (User?) -> Void) {

    }
    weak var delegate: UpdateDataEverythingControllers?
    weak var delegate1: UpdateDataEverythingControllers?
    weak var delegate2: UpdateDataEverythingControllers?
//    static var user: User = User(nickName: "", fullName: "", login: "", password: "", numberSubscribers: 0, numberSubscriptions: 0, description: "")
    static var user: User?
    var users: [User] = []
    static var shared = RegistrationDataManager()
    private init() {
        var user1 = User(
            nickName: "Cat1",
            fullName: "Cat junior",
            login: "Cat1",
            password: "123",
            imageAvatar: UIImage(named: "photo1"),
            numberSubscribers: 100,
            numberSubscriptions: 500,
            description: "I am junior developer"
        )

        var user2 = User(
            nickName: "Cat2",
            fullName: "Cat middle",
            login: "Cat2",
            password: "123",
            imageAvatar: UIImage(named: "photo2"),
            numberSubscribers: 500,
            numberSubscriptions: 300,
            description: "I am middle developer"
        )

        var user3 = User(
            nickName: "Cat3",
            fullName: "Cat senior",
            login: "Cat3",
            password: "123",
            imageAvatar: UIImage(named: "photo3"),
            numberSubscribers: 2200,
            numberSubscriptions: 200,
            description: "I am senior developer"
        )
        user1.subscriptions.append(user2)
        user2.subscriptions.append(user1)
        user3.subscriptions.append(user1)
        user3.subscriptions.append(user2)
        users.append(user1)
        users.append(user2)
        users.append(user3)

    }

    private func asyncCheckedUser(login: String, password: String) async -> User? {
        if let user = users.first(where: { $0.login == login && $0.password == password }) {
            return user
        } else {
            return nil
        }
    }
    func getCurrentUser() async -> User? {
        return RegistrationDataManager.user
    }
    func login(login: String, password: String) async {
        guard let newUser = await self.asyncCheckedUser(login: login, password: password) else { return }
        let publication = await PublicationDataManager.shared.asyncPublicationCurrentUser(user: newUser)
            RegistrationDataManager.user = newUser
            RegistrationDataManager.user?.publications = publication
    }
}
