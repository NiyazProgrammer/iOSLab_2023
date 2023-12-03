import UIKit

class OptionsElementDataManager {
    static var shared = OptionsElementDataManager()
    private var optionsElements: [OptionElement]?
    private init() {
        optionsElements = [
            OptionElement(labelElement: "Настройки и конфиденциальность", imageElement: UIImage(named: "settingIcon")),
            OptionElement(labelElement: "Сохранено", imageElement: UIImage(named: "favoriteIcon")),
            OptionElement(labelElement: "Близкие друзья", imageElement: UIImage(named: "closersFriendsIcon")),
            OptionElement(labelElement: "Избранное", imageElement: UIImage(named: "favourites"))
        ]
    }
    func getOptionsElement() -> [OptionElement] {
        optionsElements ?? []
    }
}
