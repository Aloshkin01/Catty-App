//
//  PasswordViewController.swift
//  Catty App
//
//  Created by Vladimir Alyoshkin on 19.10.21.
//

import UIKit

class PasswordViewController: UIViewController {
    var currentPassword: String = ""
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button0: UIButton!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didTapAction(_ sender: Any) {
        if let button = sender as? UIButton, button == button1 {
            currentPassword = currentPassword + "1"
        } else if let button = sender as? UIButton, button == button2 {
            currentPassword = currentPassword + "2"
        } else if let button = sender as? UIButton, button == button3 {
            currentPassword = currentPassword + "3"
        } else if let button = sender as? UIButton, button == button4 {
            currentPassword = currentPassword + "4"
        } else if let button = sender as? UIButton, button == button5 {
            currentPassword = currentPassword + "5"
        } else if let button = sender as? UIButton, button == button6 {
            currentPassword = currentPassword + "6"
        } else if let button = sender as? UIButton, button == button7 {
            currentPassword = currentPassword + "7"
        } else if let button = sender as? UIButton, button == button8 {
            currentPassword = currentPassword + "8"
        } else if let button = sender as? UIButton, button == button9 {
            currentPassword = currentPassword + "9"
        } else if let button = sender as? UIButton, button == button0{
            currentPassword = currentPassword + "0"
        }
        
        if currentPassword.count == Constants.passwordLength {
            let recoverdPassword = UserDefaults.standard.string(forKey: Constants.savePasswordKey)
            
            if let password = recoverdPassword, currentPassword == password {
                showAlert(title: "Success", message: "Password is correct!", handler: { _ in
                    NotificationCenter.default.post(name: NSNotification.Name.loadContentViewController, object: nil)
                })
            } else {
                showAlert(title: "Erorr", message: "Password is wrong!", handler: { _ in })
//                print("Opps...somthing wrong!")
            }
            
            resetState()
            
        }
        
        if currentPassword.count >= 1 {
            imageView1.isHighlighted = true
        }
        if currentPassword.count >= 2 {
            imageView2.isHighlighted = true
        }
        if currentPassword.count >= 3 {
            imageView3.isHighlighted = true
      }
    }
    
    private func resetState() {
        currentPassword = ""
        
        imageView1.isHighlighted = false
        imageView2.isHighlighted = false
        imageView3.isHighlighted = false
        }
    
        
    private func showAlert(title: String, message: String, handler: @escaping (UIAlertAction) -> Void) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)  
            let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: handler)
            
            alert.addAction(closeAction)
        
            self.present(alert, animated: true, completion: nil)
        }
    }
