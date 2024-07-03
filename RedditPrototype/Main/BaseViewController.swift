//
//  ViewController.swift
//  RedditPrototype
//
//  Created by Bresnier Moreno on 4/4/24.
//

import UIKit

class BaseViewController: UIViewController {
    let titleView = UIView(frame: CGRect(x: -175, y: 0, width: 165, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func hideBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func setupBackButton() {
        let backButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_icon"),
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(self.backButtonClickedDismiss(sender:)))
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        let labelText = UILabel()

        labelText.textAlignment = .left
        
        self.navigationItem.leftBarButtonItem  = backButtonItem
        
        labelText.frame = CGRect(x: 0, y: 0, width: 300, height: 40)

        titleView.addSubview(labelText)
        titleView.backgroundColor = .clear
        
        self.navigationItem.titleView = titleView
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        labelText.textColor = UIColor.white
        
        let logo: UIImageView
        
        logo = UIImageView(image: UIImage(named: "Logo"))
        logo.frame = CGRect(x: 40, y: 0, width: 40, height: 30)
        logo.contentMode = .scaleAspectFill
        
        titleView.addSubview(logo)
        
    }
    
    @objc func backButtonClickedDismiss(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func settingsNavBar() {
        navigationController?.setBackground()
        
        let logoImage: UIImageView
        
        logoImage = UIImageView(image: UIImage(named: "Logo"))
        
       
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 35))
        
        logoImage.frame = CGRect(x: 40, y: 0, width: 40, height: 30)
        logoImage.contentMode = .scaleAspectFill
          
        titleView.addSubview(logoImage)
        
        let leftButton = UIBarButtonItem(customView: titleView)


        navigationItem.leftBarButtonItems = [leftButton]
    }
    
    func mostrarAlerta(messages: String) {
        let alertController = UIAlertController(title: "Error", message: messages, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension BaseViewController {
    func displaySimpleAlert(with title: String, message: String, titleButton: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: titleButton, style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func displaySimpleAlertTrue(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "True", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
