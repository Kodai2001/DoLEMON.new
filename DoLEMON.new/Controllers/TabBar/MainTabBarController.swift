

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTab()
    }

    func setupTab() {
        let mapVC = MapViewController()
        let SearchFriendVC = SearchFriendViewController()
        
        // それぞれのVCにnavigationControllerを埋め込む
        let mapNav = UINavigationController(rootViewController: mapVC)
        let SearchFriendNav = UINavigationController(rootViewController: SearchFriendVC)
        
        mapNav.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        SearchFriendVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        
        setViewControllers([mapNav, SearchFriendNav], animated: false)
    }

}
