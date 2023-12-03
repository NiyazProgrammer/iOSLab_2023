//
//  ThemesViewController.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 02.12.2023.
//

import UIKit

class ThemesViewController: UIViewController {
    let themeView = ThemesView(frame: .zero)

    override func loadView() {
        super.loadView()
        view = themeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var themes = ThemesDataManager.shared.getThemesApp()
        themeView.setThemesApp(themes: themes)
    }

}
