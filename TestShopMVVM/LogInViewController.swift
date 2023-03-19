//
//  LogInViewController.swift
//  TestShopMVVM
//
//  Created by Артем Павлов on 17.03.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    var users: [NewUser]?
    
    private let logInLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome back"
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
        return label
    }()
    
    private lazy var firstNameTextField: UITextField = {
        let name = UITextField()
        name.borderStyle = .roundedRect
        name.returnKeyType = .next
        name.placeholder = "First name"
        name.backgroundColor = UIColor(red: 0.90980, green: 0.90980, blue: 0.90980, alpha: 1)
        name.layer.masksToBounds = true
        name.layer.cornerRadius = 15
        return name
    }()
    
    private lazy var passwordTextField: UITextField = {
        let name = UITextField()
        name.borderStyle = .roundedRect
        name.returnKeyType = .next
        name.placeholder = "Password"
        name.enablePasswordToggle()
        name.isSecureTextEntry = true
        name.backgroundColor = UIColor(red: 0.90980, green: 0.90980, blue: 0.90980, alpha: 1)
        name.layer.masksToBounds = true
        name.layer.cornerRadius = 15
        return name
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .highlighted)
        button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        button.backgroundColor = UIColor(red: 0.30588, green: 0.33333, blue: 0.84314, alpha: 1)
        button.layer.cornerRadius = 15
        button.addTarget(
            self,
            action: #selector(logInButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = .fill
        stackView.spacing = 35.0
        stackView.addArrangedSubview(firstNameTextField)
        stackView.addArrangedSubview(passwordTextField)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupElements(logInLabel, textFieldStackView, logInButton)
        setupSubViews(logInLabel, textFieldStackView, logInButton)
        setupConstraints()
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let rightExOfMail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", rightExOfMail)
        return emailPred.evaluate(with: email)
    }
    
    private func checkUser(name: String, email: String) -> Bool {
        var result = false
        
        users?.map { user in
            if user.mail == email && user.firstName == name {
                result = true
                return
            }
        }
        return result
    }
    
    @objc private func logInButtonTapped() {
        guard let inputNameText = firstNameTextField.text, !inputNameText.isEmpty else { return }
        let inputNameTrimmingText = inputNameText.trimmingCharacters(in: .whitespaces)
        
        guard let inputEmailText = passwordTextField.text, !inputEmailText.isEmpty else { return }
        let inputeMailTrimmingText = inputEmailText.trimmingCharacters(in: .whitespaces)
        
        if isValidEmail(inputeMailTrimmingText) {
            print("Email is valid")
        } else {
            print("Email isn't valid")
            return
        }
        
        if checkUser(name: inputNameTrimmingText, email: inputeMailTrimmingText) {
            let page1VC = Page1ViewController()
            show(page1VC, sender: nil)
        } else {
            print("Wrong user")
        }
    }
    
    private func setupElements(_ subViews: UIView...) {
        subViews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupSubViews(_ subViews: UIView...) {
        subViews.forEach { view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        logInLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.height * 0.1).isActive = true
        logInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        textFieldStackView.topAnchor.constraint(equalTo: logInLabel.bottomAnchor, constant: view.bounds.height * 0.1).isActive = true
        textFieldStackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8).isActive = true
        textFieldStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        logInButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 60).isActive = true
        logInButton.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8).isActive = true
        logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}


