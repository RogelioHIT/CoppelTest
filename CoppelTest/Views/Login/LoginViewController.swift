//
//  LoginViewController.swift
//  CoppelTest
//
//  Created by Rogelio on 07/07/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    var userNameField: CoppelTextField = {
        let userField = CoppelTextField()
        userField.placeholder = "User"
        userField.textContentType = .emailAddress
        userField.keyboardType = .emailAddress
        return userField
    }()
    
    var userPasswordField: CoppelTextField = {
        let passwordField = CoppelTextField()
        passwordField.placeholder = "Password"
        passwordField.textContentType = .password
        passwordField.isSecureTextEntry = true
        return passwordField
    }()
    
    var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .black)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    var stackContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16.0
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        return stackView
    }()
    
    var logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var errorMessage:UILabel = {
        let msg = UILabel()
        msg.textColor = .red
        msg.font = UIFont.systemFont(ofSize: 12, weight: .light)
        msg.isHidden = true
        msg.textAlignment = .center
        msg.numberOfLines = 0
        return msg
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        configLayout()
        addActions()
        
        // TODO: remove when tested
        fillWithDummyData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    private func configUI() {
        view.setGradientBackground(from: AppColors.darkGreen, to: AppColors.lightGreen)
        stackContainer.addArrangedSubview(logoImage)
        stackContainer.addArrangedSubview(userNameField)
        stackContainer.addArrangedSubview(userPasswordField)
        stackContainer.addArrangedSubview(loginButton)
        view.addSubview(stackContainer)
        view.addSubview(errorMessage)
    }
    
    private func configLayout() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.widthAnchor.constraint(equalTo: stackContainer.widthAnchor, multiplier: 0.35).isActive = true
        logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: stackContainer.centerXAnchor).isActive = true
        
        userNameField.widthAnchor.constraint(equalTo: stackContainer.widthAnchor).isActive = true
        userNameField.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

        userPasswordField.widthAnchor.constraint(equalTo: stackContainer.widthAnchor).isActive = true
        userPasswordField.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalTo: stackContainer.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
 
        
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorMessage.topAnchor.constraint(equalTo: stackContainer.bottomAnchor, constant: 8).isActive = true
        errorMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
    }

    private func addActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(login))
        loginButton.addGestureRecognizer(tapGesture)
    }
}


// MARK: actions
extension LoginViewController {
    @objc private func login() {
        print("try login")
        
        if invalidEntries() {
            errorMessage.isHidden = false
            // show alert
            return
        }
        
        // get requestToken
        requestToken { response, error in
            guard let resp = response, error == nil else {
                self.showErrorMessage(error!)
                return
            }
            
            DispatchQueue.main.async {
                print("you got your request token ", resp)
                self.forwardUserToValidateTheToken(resp)
            }
        }
    }
}

// MARK: Services
extension LoginViewController {
    private func requestToken(completion: @escaping (String?, AppError?) -> Void) {
        Service.shared.requestToken(username: userNameField.text!, password: userPasswordField.text!) { response, error in
            guard let resp = response, error == nil else {
                completion(nil, error)
                return
            }
            completion(resp.request_token, nil)
        }
    }
    
    private func getSessionId(token: String, completion: @escaping (String?, AppError?) -> Void) {
        Service.shared.getSessionId(token: token) { response, error in
            guard let resp = response, error == nil else {
                completion(nil, error)
                return
            }
            completion(resp.session_id, nil)
        }
    }
}

// MARK: Util
extension LoginViewController {
    private func invalidEntries() -> Bool {
        guard let username = userNameField.text, !username.isEmpty, let password = userPasswordField.text, !password.isEmpty else {
            // all fields are required
            print("all fields are required")
            return true
        }
        
        if username.isValidEmail() {
            // invalid email
            print("invalid email")
            return true
        }
        
        return false
    }
    
    private func fillWithDummyData() {
        userNameField.text = "RogelioTest"
        userPasswordField.text = "contraseñaTest"
    }
    
    private func showErrorMessage(_ error: AppError) {
        errorMessage.text = "invalid username and/or password. You did not provide a valid login."
        errorMessage.isHidden = false
    }
    
    private func forwardUserToValidateTheToken(_ token: String) {
        let webView = WebViewController()
        webView.webViewAuthDelegate = self
        webView.token = token
        webView.modalPresentationStyle = .formSheet
        webView.modalTransitionStyle = .coverVertical
        self.present(webView, animated: true)
    }
}

extension LoginViewController: WebViewAuthDelegate {
    func authDismissWith(token: String, allowed: Bool) {
        self.dismiss(animated: true)
        
        if allowed {
            self.getSessionId(token: token) { response, error in
                    if error != nil {
                        self.showErrorMessage(error!)
                        return
                    }
                
                guard let sessionId = response else {
                    print("error unknown")
                    return
                }
                    
                    // Login success
                    print("Login waws a success!")
                    print("Your session id is \(sessionId)")
                
                
            }
            
        }
    }
    
}
