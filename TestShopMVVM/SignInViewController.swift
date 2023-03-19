//
//  ViewController.swift
//  TestShopMVVM
//
//  Created by Артем Павлов on 11.03.2023.
//

import UIKit

class SignInViewController: UIViewController {
    
    private var users: [NewUser] = []
    
    private let singInLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in"
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
        return label
    }()
    
    private lazy var firstNameTextField: UITextField = {
        let name = UITextField()
        name.borderStyle = .roundedRect
        name.returnKeyType = .next
        name.placeholder = "First name"
        name.textAlignment = .center
        name.backgroundColor = UIColor(red: 0.90980, green: 0.90980, blue: 0.90980, alpha: 1)
        name.layer.masksToBounds = true
        name.layer.cornerRadius = 15
        return name
    }()
    
    private lazy var secondNameTextField: UITextField = {
        let name = UITextField()
        name.borderStyle = .roundedRect
        name.returnKeyType = .next
        name.placeholder = "Last name"
        name.textAlignment = .center
        name.backgroundColor = UIColor(red: 0.90980, green: 0.90980, blue: 0.90980, alpha: 1)
        name.layer.masksToBounds = true
        name.layer.cornerRadius = 15
        return name
    }()
    
    private lazy var emailTextField: UITextField = {
        let name = UITextField()
        name.borderStyle = .roundedRect
        name.returnKeyType = .next
        name.placeholder = "Email"
        name.textAlignment = .center
        name.backgroundColor = UIColor(red: 0.90980, green: 0.90980, blue: 0.90980, alpha: 1)
        name.layer.masksToBounds = true
        name.layer.cornerRadius = 15
        return name
    }()
    
    private lazy var sigInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .highlighted)
        button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        button.backgroundColor = UIColor(red: 0.30588, green: 0.33333, blue: 0.84314, alpha: 1)
        button.layer.cornerRadius = 15
        button.addTarget(
            self,
            action: #selector(signInButtonTapped),
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
        stackView.addArrangedSubview(secondNameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(sigInButton)
        return stackView
    }()
    
    private let haveAccountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue", size: 10)
        label.text = "Already have an acount?"
        return label
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name:"HelveticaNeue", size: 10)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .highlighted)
        button.addTarget(
            self,
            action: #selector(logInButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var haveAccountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.spacing = 5.0
        stackView.addArrangedSubview(haveAccountLabel)
        stackView.addArrangedSubview(logInButton)
        return stackView
    }()
    
    
    
    private let googleIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "GoogleImage")
        return icon
    }()
    
    private lazy var sigInGoogleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in with Google", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .highlighted)
        button.addTarget(
            self,
            action: #selector(logInButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var signInGoogleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = .center
        stackView.spacing = 5.0
        stackView.addArrangedSubview(googleIcon)
        stackView.addArrangedSubview(sigInGoogleButton)
        return stackView
    }()
    
    private let appleIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "AppleImage")
        return icon
    }()
    
    private lazy var sigInAppleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in with Apple", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .highlighted)
        button.addTarget(
            self,
            action: #selector(logInButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var signInAppleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = .center
        stackView.spacing = 5.0
        stackView.addArrangedSubview(appleIcon)
        stackView.addArrangedSubview(sigInAppleButton)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupElements(singInLabel, textFieldStackView, haveAccountStackView, signInGoogleStackView, signInAppleStackView)
        setupSubViews(singInLabel, textFieldStackView, haveAccountStackView, signInGoogleStackView, signInAppleStackView)
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUsers()
    }
    
    private func loadUsers() {
        StorageManager.shared.fetchUsers { result in
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let rightExOfMail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", rightExOfMail)
        return emailPred.evaluate(with: email)
    }
    
    private func checkNewUserEmail(_ email: String) -> Bool {
        var result = false
        users.map { user in
            if user.mail == email {
                result = true
                return
            }
        }
        return result
    }
    
    @objc private func logInButtonTapped() {
        let logInVC = LogInViewController()
        logInVC.users = users
        show(logInVC, sender: nil)
    }
    
    @objc private func signInButtonTapped() {
        guard let inputNameText = firstNameTextField.text, !inputNameText.isEmpty else {return}
        let inputNameTrimmingText = inputNameText.trimmingCharacters(in: .whitespaces)

        guard let inputSecondNameText = secondNameTextField.text, !inputSecondNameText.isEmpty else {return}
        let inpetSecondNameTrimmingText = inputSecondNameText.trimmingCharacters(in: .whitespaces)

        guard let inputMailText = emailTextField.text, !inputMailText.isEmpty else {return}
        let inputeMailTrimmingText = inputMailText.trimmingCharacters(in: .whitespaces)
        
        if isValidEmail(inputeMailTrimmingText) {
            print("Email is valid")
        } else {
            print("Email isn't valid")
            return
        }
                  
        if checkNewUserEmail(inputeMailTrimmingText) {
            print("You have an account")
        } else {
            StorageManager.shared.saveUser(name: inputNameTrimmingText, secondName: inpetSecondNameTrimmingText, mail: inputeMailTrimmingText)
            
            let page1VC = Page1ViewController()
            show(page1VC, sender: nil)
        }
    }
    
    func setupElements(_ subViews: UIView...) {
        subViews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupSubViews(_ subViews: UIView...) {
        subViews.forEach { view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        singInLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.height * 0.1).isActive = true
        singInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        textFieldStackView.topAnchor.constraint(equalTo: singInLabel.bottomAnchor, constant: view.bounds.height * 0.1).isActive = true
        textFieldStackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8).isActive = true
        textFieldStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        haveAccountStackView.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 8).isActive = true
        haveAccountStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.1).isActive = true
        
        googleIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        googleIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        signInGoogleStackView.topAnchor.constraint(equalTo: haveAccountStackView.bottomAnchor, constant: 40).isActive = true
        signInGoogleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        appleIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        appleIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        signInAppleStackView.topAnchor.constraint(equalTo: signInGoogleStackView.bottomAnchor, constant: 30).isActive = true
        signInAppleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

