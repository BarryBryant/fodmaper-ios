//
//  AppDelegate.swift
//  FODMAPer
//
//  Created by Richard Bryant on 1/1/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import UIKit
import CoreData
import Onboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    fileprivate let userHasOnboardedKey = "User_Has_Onboarded"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }
        
        window.backgroundColor = UIColor.white
        
        let userHasOnboarded = UserDefaults.standard.bool(forKey: userHasOnboardedKey)
        
        if (userHasOnboarded) {
            setUpNormalRootViewController()
        } else {
            generateOnboardingViewController()
        }
        
        application.statusBarStyle = .lightContent;
        window.makeKeyAndVisible()
        return true;
    }
    
    fileprivate func setUpNormalRootViewController() {
        let viewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FODMAPer") as UIViewController
        window?.rootViewController = viewController
        
    }
    
    fileprivate func handleOnboardingCompletion() {
        UserDefaults.standard.set(true, forKey: userHasOnboardedKey)
        setUpNormalRootViewController()
    }
    
    func generateOnboardingViewController() {
        //God help me
        let lowAttachment = NSTextAttachment()
        lowAttachment.image = UIImage(named: "ic_tag_faces_black_48px")?.tintWithColor(color: UIColor.white)
        let lowString = NSAttributedString(attachment: lowAttachment)
        
        let moderateAttachment = NSTextAttachment()
        moderateAttachment.image = UIImage(named: "ic_warning_black_48px")?.tintWithColor(color: UIColor.white)
        let moderateString = NSAttributedString(attachment: moderateAttachment)
        
        let highAttachment = NSTextAttachment()
        highAttachment.image = UIImage(named: "ic_clear_white_48pt")?.tintWithColor(color: UIColor.white)
        let highString = NSAttributedString(attachment: highAttachment)
        
        let myString = NSMutableAttributedString(string: "")
        myString.append(highString)
        myString.append(NSMutableAttributedString(string: "\nHigh FODMAPs\n\n"))
        myString.append(moderateString)
        myString.append(NSMutableAttributedString(string: "\nModerate FODMAPs"))
        myString.append(NSMutableAttributedString(string: "\nLimit these!\n\n"))
        myString.append(lowString)
        myString.append(NSMutableAttributedString(string: "\nLow FODMAPs\n\n"))
        
        let firstPage = OnboardingContentViewController(title: "FODMAPer", body: "A pocket reference for the low FODMAP diet.", image: UIImage(named: "onboarding_icon"), buttonText: nil) { }
        firstPage.view.backgroundColor = UIColor(red:0.77, green:0.50, blue:0.85, alpha:1.0)
        
        let secondPage = OnboardingContentViewController(title: "What is a FODMAP?", body: "Fermentable \nOligosaccharides \nDisaccharides \nMonosaccharides \nAnd Polyols \n(Indigestible Sugars)", image: nil, buttonText: nil) { }
        secondPage.view.backgroundColor = UIColor(red:0.70, green:0.87, blue:0.47, alpha:1.0)
        secondPage.topPadding = 0.0
        
        let thirdPage = OnboardingContentViewController(title: nil, body: nil, image: nil, buttonText: "Got it!") {
            self.handleOnboardingCompletion()
        }
        thirdPage.view.backgroundColor = UIColor(red:1.00, green:0.52, blue:0.65, alpha:1.0)
        thirdPage.bodyLabel.attributedText = myString
        thirdPage.topPadding = 0.0
        thirdPage.underTitlePadding = 0.0
        thirdPage.underIconPadding = 0.0
        
        guard let onboardingVC = OnboardingViewController(backgroundImage: nil, contents: [firstPage, secondPage, thirdPage]) else { return }
        
        onboardingVC.shouldFadeTransitions = true
        onboardingVC.fadeSkipButtonOnLastPage = true
        
        onboardingVC.allowSkipping = false
        onboardingVC.skipHandler = {
            self.handleOnboardingCompletion()
        }
        
        if window?.rootViewController != nil {
            window?.rootViewController?.dismiss(animated: true)
        }
        window?.rootViewController = onboardingVC
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "FODMAPer")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
