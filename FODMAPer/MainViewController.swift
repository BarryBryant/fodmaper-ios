//
//  MainViewController.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/27/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation
import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet var endConstraint: [NSLayoutConstraint]!
    @IBOutlet var startConstraint: [NSLayoutConstraint]!
    @IBOutlet var icons: [UIImageView]!
    @IBOutlet var mainViewContainers: [UIView]!
    @IBOutlet var sectionStackView: UIStackView!
    @IBOutlet var sectionLabels: [UILabel]!
    @IBOutlet var mainContainerView: UIView!
    @IBOutlet var searchAllContainer: UIView!
    @IBOutlet var lowFodmapContainer: UIView!
    @IBOutlet var moderateFodmapContainer: UIView!
    @IBOutlet var highFodmapContainer: UIView!
    @IBOutlet var backButtonPlaceholders: [UIButton]!
    @IBOutlet var navigationBarConstraint: NSLayoutConstraint!
    @IBOutlet var navigationBarLabel: UILabel!
    @IBOutlet var navigationBarInfoButton: UIButton!
    @IBOutlet var navigationBarBackButtonPlaceholder: UIButton!

    fileprivate var sectionContainers: [UIView]! {
        return [searchAllContainer, lowFodmapContainer, moderateFodmapContainer, highFodmapContainer]
    }

    fileprivate var sectionHeightConstraints: [NSLayoutConstraint]! {
        return [searchHeight, lowFodmapHeight, moderateFodmapHeight, highFodmapHeight]
    }

    fileprivate var searchHeight: NSLayoutConstraint!
    fileprivate var lowFodmapHeight: NSLayoutConstraint!
    fileprivate var moderateFodmapHeight: NSLayoutConstraint!
    fileprivate var highFodmapHeight: NSLayoutConstraint!
    fileprivate var containerHeight: CGFloat!
    fileprivate var infoContainerHeight: CGFloat!

    fileprivate var selectedPage: SelectedPage = .none

    enum SelectedPage: Int {
        case none = -1
        case info = -2
        case search = 0
        case low = 1
        case moderate = 2
        case high = 3
    }
    
    override func viewDidLoad() {
        _ = mainViewContainers.map { $0.isUserInteractionEnabled = false }
        _ = backButtonPlaceholders.map { $0.alpha = 0.0 }
        navigationBarBackButtonPlaceholder.alpha = 0.0
        generateConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard selectedPage != .none else { return }
        if selectedPage == .info {
            animateFromInfo()
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.animateFromSelectedPage(page: self.selectedPage)
        }
    }
    
    @IBAction func searchAllPressed(_ sender: AnyObject) {
        animateToSelectedPage(page: .search)
        selectedPage = .search
    }

    @IBAction func lowFodmapPressed(_ sender: AnyObject) {
        animateToSelectedPage(page: .low)
        selectedPage = .low
    }

    @IBAction func moderateFodmapPressed(_ sender: AnyObject) {
        animateToSelectedPage(page: .moderate)
        selectedPage = .moderate
    }

    @IBAction func highFodmapPressed(_ sender: AnyObject) {
        animateToSelectedPage(page: .high)
        selectedPage = .high
    }

    fileprivate func animateInNavigationBar() {
        navigationBarConstraint.constant = 44
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.navigationBarLabel.alpha = 1.0
            self.navigationBarInfoButton.alpha = 1.0
        }
    }

    fileprivate func animateOutNavigationBar() {
        navigationBarConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.navigationBarLabel.alpha = 0.0
            self.navigationBarInfoButton.alpha = 0.0
        }
    }

    fileprivate func animateToSelectedPage(page: SelectedPage) {
        let index = page.rawValue
        animateOutNavigationBar()
        sectionHeightConstraints[index].constant = 44
        startConstraint[index].isActive = false
        endConstraint[index].isActive = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            _ = self.icons.map { $0.alpha = 0.0 }
            _ = self.sectionLabels.filter { $0 != self.sectionLabels[index] }.map { $0.alpha = 0.0 }
            self.backButtonPlaceholders[index].alpha = 1.0
            _ = self.sectionContainers.filter { $0 != self.sectionContainers[index] }.map { $0.isHidden = true }
        }
    }

    fileprivate func animateFromSelectedPage(page: SelectedPage) {
        let index = page.rawValue
        animateInNavigationBar()
        sectionHeightConstraints[index].constant = containerHeight
        startConstraint[index].isActive = true
        endConstraint[index].isActive = false
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            _ = self.icons.map { $0.alpha = 1.0 }
            _ = self.sectionLabels.filter { $0 != self.sectionLabels[index] }.map { $0.alpha = 1.0 }
            self.backButtonPlaceholders[index].alpha = 0.0
            _ = self.sectionContainers.filter { $0 != self.sectionContainers[index] }.map { $0.isHidden = false }
        }
    }

    fileprivate func generateConstraints() {
        containerHeight = (mainContainerView.bounds.height - 64) / 4
        infoContainerHeight = (mainContainerView.bounds.height - 64) / 3
        
        searchHeight = NSLayoutConstraint(item: searchAllContainer,
                                          attribute: .height,
                                          relatedBy: .equal,
                                          toItem: nil,
                                          attribute: .notAnAttribute,
                                          multiplier: 1.0,
                                          constant: containerHeight)
        searchAllContainer.addConstraint(searchHeight)

        lowFodmapHeight = NSLayoutConstraint(item: lowFodmapContainer,
                                             attribute: .height,
                                             relatedBy: .equal,
                                             toItem: nil,
                                             attribute: .notAnAttribute,
                                             multiplier: 1.0,
                                             constant: containerHeight)
        lowFodmapContainer.addConstraint(lowFodmapHeight)

        moderateFodmapHeight = NSLayoutConstraint(item: moderateFodmapContainer,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1.0,
                                                  constant: containerHeight)
        moderateFodmapContainer.addConstraint(moderateFodmapHeight)

        highFodmapHeight = NSLayoutConstraint(item: highFodmapContainer,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .notAnAttribute,
                                              multiplier: 1.0,
                                              constant: containerHeight)
        highFodmapContainer.addConstraint(highFodmapHeight)
    }
    
    
    @IBAction func onPressInfo(_ sender: AnyObject) {
        selectedPage = .info
        animateToInfo()
    }
    
    fileprivate func animateToInfo() {
        searchHeight.constant = infoContainerHeight
        lowFodmapHeight.constant = infoContainerHeight
        moderateFodmapHeight.constant = infoContainerHeight
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.highFodmapContainer.isHidden = true
            self.sectionLabels[3].alpha = 0.0
            self.icons[3].alpha = 0.0
            self.navigationBarInfoButton.alpha = 0.0
            self.navigationBarBackButtonPlaceholder.alpha = 1.0
        }
        crossDissolve(label: sectionLabels[0], text: "Watch App Introduction")
        crossDissolve(label: sectionLabels[1], text: "Feedback")
        crossDissolve(label: sectionLabels[2], text: "Share")
        crossDissolve(label: navigationBarLabel, text: "FODMAPer Info")
        
        crossDissolveImage(imageView: icons[0], image: UIImage(named: "ic_home_white_48px")!)
        crossDissolveImage(imageView: icons[1], image: UIImage(named: "ic_mail_white_48px")!)
        crossDissolveImage(imageView: icons[2], image: UIImage(named: "ic_share_white_48px")!)
    }
    
    fileprivate func animateFromInfo() {
        searchHeight.constant = containerHeight
        lowFodmapHeight.constant = containerHeight
        moderateFodmapHeight.constant = containerHeight
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.highFodmapContainer.isHidden = false
            self.sectionLabels[3].alpha = 1.0
            self.icons[3].alpha = 1.0
            self.navigationBarInfoButton.alpha = 1.0
            self.navigationBarBackButtonPlaceholder.alpha = 0.0
        }
        crossDissolve(label: sectionLabels[0], text: "Search All")
        crossDissolve(label: sectionLabels[1], text: "Low FODMAP")
        crossDissolve(label: sectionLabels[2], text: "Moderate FODMAP")
        crossDissolve(label: navigationBarLabel, text: "FODMAPer")
        
        crossDissolveImage(imageView: icons[0], image: UIImage(named: "ic_search_black_48px")!)
        crossDissolveImage(imageView: icons[1], image: UIImage(named: "ic_tag_faces_black_48px")!)
        crossDissolveImage(imageView: icons[2], image: UIImage(named: "ic_warning_black_48px")!)
    }
    
    fileprivate func crossDissolve(label: UILabel, text: String) {
        UIView.transition(with: label,
                          duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            
                            label.text = text
            }, completion: nil)
    }
    
    fileprivate func crossDissolveImage(imageView: UIImageView, image: UIImage) {
        UIView.transition(with: imageView,
                          duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            
                            imageView.image = image
            }, completion: nil)
    }

}
