//
//  InfoViewController.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/29/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation
import UIKit

final class InfoViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var mainViewContainers: [UIView]!
    @IBOutlet var labels: [UILabel]!
    @IBOutlet var icons: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = mainViewContainers.map { $0.isUserInteractionEnabled = false }
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        containerView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        containerView.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.containerView.isHidden = true
    }
    
    func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showAppOnboarding(_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        dismiss(animated: false) {
            appDelegate?.generateOnboardingViewController()
        }
    }
}
