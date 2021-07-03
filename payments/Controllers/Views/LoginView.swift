//
//  LoginView.swift
//  payments
//
//  Created by Ekaterina on 2.07.21.
//

import UIKit

class LoginView: UIView {
    
    // MARK: - Properties
    
    private lazy var contentViewSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 800)
    
    // MARK: - ScrollView
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.bounces = true
        scrollView.contentSize = contentViewSize
        return scrollView
    }()

    private(set) lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.frame.size = contentViewSize
        contentView.isUserInteractionEnabled = true
        return contentView
    }()

    // MARK: - Subviews
    
    private(set) lazy var nameLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .black
        textLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        textLabel.text = "Payments"
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    private(set) lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 15.0)
        textField.placeholder = "login"
        return textField
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 15.0)
        textField.placeholder = "password"
        textField.isSecureTextEntry = true
        return textField
    }()
        
    private(set) lazy var loginButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign in", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15.0)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - UI
    
    private func configureUI() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.loginTextField)
        self.contentView.addSubview(self.passwordTextField)
        self.contentView.addSubview(self.loginButton)
        
        setupConstraintsScrollView()
        setupConstraints()
    }
    
    // MARK: - Constraints
    
    private func setupConstraintsScrollView() {
        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.scrollView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            self.scrollView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, constant: 400.0),
            
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
        ])
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30.0),
            self.nameLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.nameLabel.widthAnchor.constraint(equalToConstant: 200.0),
            
            self.loginTextField.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 300.0),
            self.loginTextField.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5.0),
            self.loginTextField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5.0),
            
            self.passwordTextField.topAnchor.constraint(equalTo: self.loginTextField.bottomAnchor, constant: 4.0),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5.0),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5.0),
            
            self.loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 40.0),
            self.loginButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.loginButton.widthAnchor.constraint(equalToConstant: 250.0)
            ])
    }

}

