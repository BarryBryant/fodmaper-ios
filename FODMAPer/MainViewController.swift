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
    
    fileprivate var searchHeight: NSLayoutConstraint!
    fileprivate var lowFodmapHeight: NSLayoutConstraint!
    fileprivate var moderateFodmapHeight: NSLayoutConstraint!
    fileprivate var highFodmapHeight: NSLayoutConstraint!
    fileprivate var containerHeight: CGFloat!

    fileprivate var selectedPage: SelectedPage = .none

    enum SelectedPage {
        case none
        case search
        case low
        case moderate
        case high
    }
    
    override func viewDidLoad() {
        for view in mainViewContainers {
            view.isUserInteractionEnabled = false
        }
        for button in backButtonPlaceholders {
            button.alpha = 0.0
        }
        generateConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            switch self.selectedPage {
            case .search:
                self.animateFromSearch()
            case .low:
                self.animatefromLow()
            case .moderate:
                self.animatefromModerate()
            case .high:
                self.animatefromHigh()
            default:
                return
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func searchAllPressed(_ sender: AnyObject) {
        animateToSearch()
        self.selectedPage = .search
    }

    fileprivate func animateToSearch() {
        self.searchHeight.constant = 44
        self.startConstraint[0].isActive = false
        self.endConstraint[0].isActive = true
        let otherLabels = sectionLabels.filter { $0 != sectionLabels[0] }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            for icon in self.icons {
                icon.alpha = 0.0
            }
            for label in otherLabels {
                label.alpha = 0.0
            }
            self.backButtonPlaceholders[0].alpha = 1.0
            self.lowFodmapContainer.isHidden = true
            self.moderateFodmapContainer.isHidden = true
            self.highFodmapContainer.isHidden = true
        }
    }

    fileprivate func animateFromSearch() {
        self.searchHeight.constant = containerHeight
        self.startConstraint[0].isActive = true
        self.endConstraint[0].isActive = false
        let otherLabels = sectionLabels.filter { $0 != sectionLabels[0] }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            for icon in self.icons {
                icon.alpha = 1.0
            }
            for label in otherLabels {
                label.alpha = 1.0
            }
            self.backButtonPlaceholders[0].alpha = 0.0
            self.lowFodmapContainer.isHidden = false
            self.moderateFodmapContainer.isHidden = false
            self.highFodmapContainer.isHidden = false
        }
    }

    @IBAction func lowFodmapPressed(_ sender: AnyObject) {
        animateToLow()
        self.selectedPage = .low
    }

    fileprivate func animateToLow() {
        self.lowFodmapHeight.constant = 44
        self.startConstraint[1].isActive = false
        self.endConstraint[1].isActive = true
        let otherLabels = sectionLabels.filter { $0 != sectionLabels[1] }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            for icon in self.icons {
                icon.alpha = 0.0
            }
            for label in otherLabels {
                label.alpha = 0.0
            }
            self.backButtonPlaceholders[1].alpha = 1.0
            self.searchAllContainer.isHidden = true
            self.moderateFodmapContainer.isHidden = true
            self.highFodmapContainer.isHidden = true
        }
    }

    fileprivate func animatefromLow() {
        self.lowFodmapHeight.constant = containerHeight
        self.startConstraint[1].isActive = true
        self.endConstraint[1].isActive = false
        let otherLabels = sectionLabels.filter { $0 != sectionLabels[1] }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            for icon in self.icons {
                icon.alpha = 1.0
            }
            for label in otherLabels {
                label.alpha = 1.0
            }
            self.backButtonPlaceholders[1].alpha = 0.0
            self.searchAllContainer.isHidden = false
            self.moderateFodmapContainer.isHidden = false
            self.highFodmapContainer.isHidden = false
        }
    }

    
    @IBAction func moderateFodmapPressed(_ sender: AnyObject) {
        animateToModerate()
        self.selectedPage = .moderate
    }

    fileprivate func animateToModerate() {
        self.moderateFodmapHeight.constant = 44
        self.startConstraint[2].isActive = false
        self.endConstraint[2].isActive = true
        let otherLabels = sectionLabels.filter { $0 != sectionLabels[2] }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            for icon in self.icons {
                icon.alpha = 0.0
            }
            for label in otherLabels {
                label.alpha = 0.0
            }
            self.backButtonPlaceholders[2].alpha = 1.0
            self.searchAllContainer.isHidden = true
            self.lowFodmapContainer.isHidden = true
            self.highFodmapContainer.isHidden = true
        }
    }

    fileprivate func animatefromModerate() {
        self.moderateFodmapHeight.constant = containerHeight
        self.startConstraint[2].isActive = true
        self.endConstraint[2].isActive = false
        let otherLabels = sectionLabels.filter { $0 != sectionLabels[2] }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            for icon in self.icons {
                icon.alpha = 1.0
            }
            for label in otherLabels {
                label.alpha = 1.0
            }
            self.backButtonPlaceholders[2].alpha = 0.0
            self.searchAllContainer.isHidden = false
            self.lowFodmapContainer.isHidden = false
            self.highFodmapContainer.isHidden = false
        }
    }

    @IBAction func highFodmapPressed(_ sender: AnyObject) {
        if highFodmapHeight.constant == 44 {
            animatefromHigh()
        } else {
            animateToHigh()
        }
        self.selectedPage = .high
    }

    fileprivate func animateToHigh() {
        self.highFodmapHeight.constant = 44
        self.startConstraint[3].isActive = false
        self.endConstraint[3].isActive = true
        let otherLabels = sectionLabels.filter { $0 != sectionLabels[3] }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            for icon in self.icons {
                icon.alpha = 0.0
            }
            for label in otherLabels {
                label.alpha = 0.0
            }
            self.backButtonPlaceholders[3].alpha = 1.0
            self.searchAllContainer.isHidden = true
            self.lowFodmapContainer.isHidden = true
            self.moderateFodmapContainer.isHidden = true
        }
    }

    fileprivate func animatefromHigh() {
        self.highFodmapHeight.constant = containerHeight
        self.startConstraint[3].isActive = true
        self.endConstraint[3].isActive = false
        let otherLabels = sectionLabels.filter { $0 != sectionLabels[3] }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            for icon in self.icons {
                icon.alpha = 1.0
            }
            for label in otherLabels {
                label.alpha = 1.0
            }
            self.backButtonPlaceholders[3].alpha = 0.0
            self.searchAllContainer.isHidden = false
            self.lowFodmapContainer.isHidden = false
            self.moderateFodmapContainer.isHidden = false
        }
    }
    
    fileprivate func generateConstraints() {
        containerHeight = (mainContainerView.bounds.height - 20) / 4
        
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
    
}
