//
//  ViewController.swift
//  密碼檢查
//
//  Created by 蔡佳穎 on 2021/8/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var password1TextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var ruleLabel: UILabel!
    
    let tenMostCommonPasswords = [
        "123456",
        "password",
        "12345678",
        "qwerty",
        "12345",
        "123456789",
        "letmein",
        "1234567",
        "football",
        "iloveyou"
    ]
    let digits = "0123456789"
    let punctuation = "!@#$%^&*(),.<>;'`~[]{}\\|/?_-+= "
    
    var commonPassword = false
    var usernameText: String = ""
    var password1Text: String = ""
    var password2Text: String = ""
    var uppercaseCount = 0
    var lowercaseCount = 0
    var digitCount = 0
    var punctuationCount = 0
    var completed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ruleLabel.numberOfLines = 0
        ruleLabel.text = "密碼建立規則:\n1.至少16個字元\n2.大小寫字母至少各ㄧ個\n3.至少一個數字\n4.至少一個標點符號\n5.密碼不能包含帳號"
    }

    @IBAction func checkPassword(_ sender: UITextField) {
        uppercaseCount = 0
        lowercaseCount = 0
        digitCount = 0
        punctuationCount = 0
        
        //取得username
        usernameText = usernameTextField.text!

        //密碼檢查
        password1Text = password1TextField.text!
        password2Text = password2TextField.text!
        
        //檢查是否包含常用密碼
        for i in 0...tenMostCommonPasswords.count-1 {
            if password1Text.contains(tenMostCommonPasswords[i]) == true {
                commonPassword = true
                break
            } else {
                commonPassword = false
            }
        }
        
        //其他檢查
        for character in password1Text {
            if character.isUppercase {
                uppercaseCount += 1
            } else if character.isLowercase {
                lowercaseCount += 1
            } else if digits.contains(character) {
                digitCount += 1
            } else if punctuation.contains(character) {
                punctuationCount += 1
            }
        }
        
        //顯示帳號密碼問題
        alertLabel.textColor = .red
        print("commonPassword:\(commonPassword)")
        if password1Text == password2Text {
            if usernameText.count == 0 {
                alertLabel.text = "請輸入帳號"
            } else if password1Text.contains(usernameText) {
                alertLabel.text = "密碼不能包含帳號"
            } else if commonPassword == true {
                alertLabel.text = "此密碼太常使用，請選用其他密碼"
            } else if password1Text.count < 16 {
                alertLabel.text = "密碼至少包含16個字元"
            } else if uppercaseCount == 0 {
                alertLabel.text = "至少包含一個大寫字母"
            } else if lowercaseCount == 0 {
                alertLabel.text = "至少包含一個小寫字母"
            } else if digitCount == 0 {
                alertLabel.text = "至少包含一個數字"
            } else if punctuationCount == 0 {
                alertLabel.text = "至少包含一個符號"
            } else {
                completed = true
                alertLabel.text = ""
            }
        } else {
            alertLabel.text = "請輸入相同密碼"
        }
        
    }
    
    @IBAction func showResult(_ sender: Any) {
        if completed == true {
            alertLabel.textColor = .blue
            alertLabel.text = "註冊完成"
        }
    }
}

