//
//  ViewController.swift
//  payments
//
//  Created by Ekaterina on 2.07.21.
//

import UIKit

class LoginViewController: UIViewController {
    
    let networkManager = NetworkManager()
    
    private var loginView: LoginView {
        return self.view as! LoginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginTextField.text = "demo"
        loginView.passwordTextField.text = "12345"
        loginView.loginButton.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: nil, action: nil)
    }
    
    override func loadView() {
        self.view = LoginView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Autorization
    
    @objc func loginButtonDidTap() {
        
        guard let login = loginView.loginTextField.text, let password = loginView.passwordTextField.text else {
            loginView.loginTextField.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            return
        }
        guard !login.isEmpty else {
            loginView.loginTextField.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            return
        }
        guard !password.isEmpty else {
            loginView.passwordTextField.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            return
        }
        authorization(login: login, password: password)
    }
    
    func authorization(login: String, password: String) {
        if login == "demo" && password == "12345" {
            networkManager.login(login: login, password: password) { [weak self] token in
                guard let self = self else { return }
                let controller = PaymentsViewController()
                controller.token = token
                self.navigationController?.pushViewController(controller, animated: true)
            }
        } else {
            DispatchQueue.main.async {
                self.showAlert(title: "Error!", message: "Autorization error")
            }
        }        
    }
}
