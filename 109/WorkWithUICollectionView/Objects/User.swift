import Foundation
import UIKit
struct User: Codable {
    let nickName: String
    let fullName: String
    let login: String
    let password: String
    let imageAvatarData: Data?
    var publications: [Publication] = []
    var subscriptions: [User] = []
    var numberPublications: Int { return publications.count }
    var numberSubscribers: Int
    var numberSubscriptions: Int
    var description: String
}

