//
//  InfoViewController.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/29/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

final class InfoViewController: UIViewController {
    @IBOutlet var mainViewContainers: [UIView]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = mainViewContainers.map { $0.isUserInteractionEnabled = false }
    }
    
    @IBAction func sendEmail(_ sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("FODMAPer Feedback")
            mail.setToRecipients(["fodmaper.app@gmail.com"])
            mail.setMessageBody("Feedback and Suggestions:", isHTML: true)
            
            present(mail, animated: true)
        } else {
            let emailAlert = UIAlertController(title: "Email Error", message: "Email has not been configured on this device. Please set up your email and try again.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            emailAlert.addAction(action)
            self.present(emailAlert, animated: true)
            
        }
    }
    
    @IBAction func shareApp(_ sender: AnyObject) {
        let shareActivity = UIActivityViewController(activityItems: ["<html><body>Check out FODMAPer: <a href='http://apple.com'>iOS</a> <a href='https://play.google.com/store/apps/details?id=com.b3sk.fodmaper&hl=en!'>Android</a></body></html>"], applicationActivities: nil)
        present(shareActivity, animated: true)
    }
    
    @IBAction func showAppOnboarding(_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.generateOnboardingViewController()
    }
    
}

extension InfoViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
