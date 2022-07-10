//
//  LoginViewController.swift
//  CoppelTest
//
//  Created by Rogelio on 07/07/22.
//

import UIKit
import ActivityIndicatorManager

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
    
    var loginViewModel: LoginViewModel!
    
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
        view.setGradientBackground(from: UIColor(named: "midGreen")!, to:  UIColor(named: "darkGreen")!)
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
    
    func showMainViewController() {
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            sd.window?.rootViewController = MainViewController()
            sd.window?.makeKeyAndVisible()
        }
    }
}


// MARK: actions
extension LoginViewController {
    @objc private func login() {
        errorMessage.isHidden = true
        loginViewModel = LoginViewModel(userName: userNameField.text, userPassword: userPasswordField.text)
        if loginViewModel.isInformationValid() {
            AIMActivityIndicatorManager.sharedInstance.shouldShowIndicator()
            loginViewModel.requestToken { token, error in
                AIMActivityIndicatorManager.sharedInstance.shouldHideIndicator()
                if let error = error {
                    self.showErrorMessage(error)
                    return
                }
                
                guard let token = token else {
                    self.showErrorMessage(.noData)
                    return
                }
                
                self.forwardUserToValidateTheToken(token)
    
            }
        }else {
            self.showErrorMessage(.badIncompleteData)
        }
    }
}


// MARK: Util
extension LoginViewController {
    private func fillWithDummyData() {
        userNameField.text = "RogelioTest"
        userPasswordField.text = "contraseñaTest"
    }
    
    private func forwardUserToValidateTheToken(_ token: String) {
        let webView = AuthWebViewController()
        webView.webViewAuthDelegate = self
        webView.token = token
        webView.modalPresentationStyle = .formSheet
        webView.modalTransitionStyle = .coverVertical
        self.present(webView, animated: true)
    }
    
    private func showErrorMessage(_ error: AppError) {
        switch error {
        case .badIncompleteData:
            errorMessage.text = "Invalid username and/or password."
        case .loginDenied:
            errorMessage.text = "Login denied."
        case .badRequest, .decodingError, .noData:
            errorMessage.text = "There was an error, try again."
        }
        errorMessage.isHidden = false
    }
}

// MARK: AuthWebViewDelegate
extension LoginViewController: AuthWebViewDelegate {
    func authDismissWith(token: String, allowed: Bool) {
        self.dismiss(animated: true)
        
        if allowed {
            AIMActivityIndicatorManager.sharedInstance.shouldShowIndicator()
            self.loginViewModel.requestSessionId(token: token) { sessionId, error in
                AIMActivityIndicatorManager.sharedInstance.shouldHideIndicator()
                if let error = error {
                    self.showErrorMessage(error)
                    return
                }
                guard let sessionId = sessionId else {
                    self.showErrorMessage(.noData)
                    return
                }
                                
                print("Login waws a success!")
                print("Your session id is \(sessionId)")
                SessionManager.shared.updateSessionId(sessionId)
                self.showMainViewController()
            }
        }else {
            self.showErrorMessage(.loginDenied)
            AIMActivityIndicatorManager.sharedInstance.shouldHideIndicator()
        }
    }
}
