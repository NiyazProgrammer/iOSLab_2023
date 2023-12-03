//
//  SubscribersTableViewCell.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 02.12.2023.
//

import UIKit
class SubscribersTableViewCell: UITableViewCell {

    private lazy var imageAvatar: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var buttonDelete: UIButton = {
        let action = UIAction { _ in
            // реализация удаления подписчика
        }
        let button = UIButton(type: .custom, primaryAction: action)
        button.setTitle("Удалить", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        contentView.addSubview(imageAvatar)
        contentView.addSubview(labelName)
        contentView.addSubview(buttonDelete)
        setupLayout()
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            imageAvatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageAvatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageAvatar.widthAnchor.constraint(equalToConstant: 30),
            imageAvatar.heightAnchor.constraint(equalToConstant: 30),
            labelName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelName.leadingAnchor.constraint(equalTo: imageAvatar.trailingAnchor, constant: 5),
            buttonDelete.widthAnchor.constraint(equalToConstant: 100),
            buttonDelete.heightAnchor.constraint(equalToConstant: 20),
            buttonDelete.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonDelete.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUser(with user: User) {
        labelName.text = user.login
        if let image = user.imageAvatarData {
            imageAvatar.image = UIImage(data: image)
        }
    }
}
