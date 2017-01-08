//
//  ViewController.swift
//  FODMAPer
//
//  Created by Richard Bryant on 1/1/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let fodmapRepo: FodmapRepository = FodmapRepository.init()
        let fodmaps = fodmapRepo.getFodmaps()
        print(fodmaps.count)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

