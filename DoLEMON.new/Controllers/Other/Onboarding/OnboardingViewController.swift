//
//  OnboardingViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/12/01.
//

import UIKit


class OnboardingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK:- outlets for the viewController
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var getStartedButton: UIButton!
    
    // data for the Onboarding Screens
    let pages: [Page] = [Page(animationName: "findPlace", title: "Find Favorite Place", description: "「ずっと興味はあったけど、まだ行けてないんだよな...。」そういう場所って沢山あるよね.."),
                         Page(animationName: "friendFind", title: "Add Pins", description: "ツイートする感覚で行きたい場所にピンを立てよう。一言も添えてね。"),
                         Page(animationName: "addPin", title: "Friends find your pin", description: "あとは友達が君のピンを見つけるのを待つだけ。友達の魅力的なピンも探してみる？")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to make the button rounded
        self.getStartedButton.layer.cornerRadius = 20
        
        // register the custom CollectionViewCell and assign the delegates to the ViewController
        self.collectionView.backgroundColor = .white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: OnboardingCollectionViewCell.identifier, bundle: Bundle.main),
                                     forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
        
        // set the number of pages to the number of Onboarding Screens
        self.pageControl.numberOfPages = self.pages.count
    }
    
    
    // MARK:- outlet functions for the viewController
    @IBAction func pageChanged(_ sender: Any) {
        let pc = sender as! UIPageControl
        
        // scrolling the collectionView to the selected page
        collectionView.scrollToItem(at: IndexPath(item: pc.currentPage, section: 0),
                                    at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        // move the user to the other view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let TabBarController = storyboard.instantiateViewController(identifier: "rootVC")
        TabBarController.modalPresentationStyle = .fullScreen
        self.present(TabBarController, animated: true, completion: nil)
    }


    
    // MARK:- collectionView dataSource & collectionView FlowLayout delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier,
                                                      for: indexPath) as! OnboardingCollectionViewCell
        // function for configuring the cell, defined in the Custom cell class
        cell.configureCell(page: pages[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    // to update the UIPageControl
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
