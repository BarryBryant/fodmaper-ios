//
//  FadeInTitleBarViewController.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/29/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation
import UIKit

class FadeInTitleBarViewController: UIViewController {

    @IBOutlet weak var titleBarContainer: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleBarContainer.alpha = 0.0
        backButton.alpha = 0.0
        titleLabel.alpha = 0.0
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleLabel.alpha = 1.0
        containerView.backgroundColor = UIColor.white
        self.titleBarContainer.alpha = 1.0
        self.backButton.alpha = 1.0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        titleLabel.alpha = 0.0
        containerView.backgroundColor = UIColor.clear
        self.titleBarContainer.alpha = 0.0
        self.backButton.alpha = 0.0
    }


    func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }


}
