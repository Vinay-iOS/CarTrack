//
//  LoginVC.swift
//  CarTrack
//
//  Created by SCTT CDMS on 6/5/21.
//

import UIKit

class LoginVC: UIViewController, ListPickerVCDelegate, UITextFieldDelegate {
    
    let loginVM     = LoginVM()
    let pickerView  = PickerListVC()
    
    @IBOutlet weak var animatedView:UIView!
    {
        didSet{
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.duration = 3.0
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            animatedView.layer.add(animation, forKey: "fade")
        }
    }
    @IBOutlet weak var usernameTF: UITextField!
    {
        didSet{
            updateView(imageName: "person.circle.fill", textfield: usernameTF)
        }
    }
    @IBOutlet weak var passwordTF: UITextField!
    {
        didSet{
            updateView(imageName: "lock", textfield: passwordTF)
        }
    }
    
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var loginBtn:UIButton!
    @IBOutlet weak var selectCountryBtn:UIButton!
    
    func updateView(imageName:String, textfield:UITextField) {

        textfield.leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 60, height: 60))
        imageView.image = UIImage(systemName: imageName)
        imageView.tintColor = UIColor.orange
        textfield.leftView = imageView
        textfield.backgroundColor = UIColor.white
        textfield.addBottomBorder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addGradientBG()
        loginVM.fetchCountries()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    func addGradientBG(){
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.orange.cgColor]
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    // MARK: - IBAction Methods
    @IBAction func countryBtnAction(_sender: UIButton) {
     
        self.pickerView.listArray = loginVM.countries
        self.pickerView.delegate = self
        self.pickerView.barTitle = "Select Country"
        self.present(self.pickerView, animated: true)
    }
    
    @IBAction func loginBtnAction(_sender: UIButton) {
     
        let request = LoginRequest(userName: usernameTF.text!, password: passwordTF.text!)
        do {
             try loginVM.validate(request: request)
            
            // if validation sucessfully done then call user authentication
            loginVM.userAuthentication(requestFields: request) { result in
                switch result {
                        case .success:
                            self.navigateToUsers()
                        case .failure(let authError):
                            if authError == AuthenticationError.credentialNotMatch {
                                self.displayAlert(alertMessage: "credentials not match")
                            }
                            else if authError == AuthenticationError.noRecordExist {
                                self.displayAlert(alertMessage: "there is no record exist in database, please add some records")
                            }
                            else if authError == AuthenticationError.featchingDataFailed {
                                print("Featching data failed")
                            }
                    }
                }
            
        }catch TextFieldValidationError.userNameEmpty {
            self.displayAlert(alertMessage: "username is empty!")
        }
        catch TextFieldValidationError.pwdNameEmpty {
            self.displayAlert(alertMessage: "password is empty!")
        }
        catch {
            print("unknown error at login validation")
        }
    }
    
    func navigateToUsers()  { }
    
    
    // MARK: - Delegates
    func didSelectRow(selectedValue: String) {
        self.countryTF.text = selectedValue
    }
    
    
    // MARK: - Textfield Delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}