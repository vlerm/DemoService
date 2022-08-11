//
//  ViewController.swift
//  DemoService
//
//  Created by Вадим Лавор on 29.07.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstCheckBoxButton: UIButton!
    @IBOutlet weak var secondCheckBoxButton: UIButton!
    @IBOutlet weak var thirdCheckBoxButton: UIButton!
    @IBOutlet weak var firstCheckBoxLabel: UILabel!
    @IBOutlet weak var secondCheckBoxLabel: UILabel!
    @IBOutlet weak var thirdCheckBoxLabel: UILabel!
    @IBOutlet weak var currentTextView: UITextView!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var firstSwitchButton: UIButton!
    @IBOutlet weak var secondSwitchButton: UIButton!
    @IBOutlet weak var thirdSwitchButton: UIButton!
    @IBOutlet weak var firstSwitchLabel: UILabel!
    @IBOutlet weak var secondSwitchLabel: UILabel!
    @IBOutlet weak var thirdSwitchLabel: UILabel!
    @IBOutlet weak var popUpButton: UIButton!
    @IBOutlet weak var showTextButton: UIButton!
    
    let defaultText = "- Карыстальнік абраў"
    
    var firstFlagCheckBox = false
    var secondFlagCheckBox = false
    var thirdFlagCheckBox = false
    var firstFlagSwitch = false
    var secondFlagSwitch = false
    var thirdFlagSwitch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopUpButton()
        setGradientBackground(view: self.view, colorTop: UIColor(red: 210/255, green: 109/255, blue: 180/255, alpha: 1).cgColor, colorBottom: UIColor(red: 52/255, green: 148/255, blue: 230/255, alpha: 1).cgColor)
        currentTextView.layer.cornerRadius = 10
        outputTextView.layer.cornerRadius = 10
        showTextButton.layer.cornerRadius = 10
    }
    
    @IBAction func firstCheckBoxButtonClicked(_ sender: UIButton) {
        flagCheckBoxChecked(flag: &firstFlagCheckBox, object: sender)
    }
    @IBAction func secondCheckBoxButtonClicked(_ sender: UIButton) {
        flagCheckBoxChecked(flag: &secondFlagCheckBox, object: sender)
    }
    
    @IBAction func thirdCheckBoxButtonClicked(_ sender: UIButton) {
        flagCheckBoxChecked(flag: &thirdFlagCheckBox, object: sender)
    }
    
    @IBAction func firstSwitchButtonClicked(_ sender: UIButton) {
        if firstFlagSwitch == false {
            sender.setImage(UIImage(named: "correct"), for: .normal)
            secondSwitchButton.setImage(UIImage(named: "circle"), for: .normal)
            thirdSwitchButton.setImage(UIImage(named: "circle"), for: .normal)
            firstFlagSwitch = true
            secondFlagSwitch = false
            thirdFlagSwitch = false
        } else {
            sender.setImage(UIImage(named: "circle"), for: .normal)
            firstFlagSwitch = false
        }
        secondFlagSwitch = false
        thirdFlagSwitch = false
    }
    
    @IBAction func secondSwitchButtonClicked(_ sender: UIButton) {
        if secondFlagSwitch == false {
            sender.setImage(UIImage(named: "correct"), for: .normal)
            firstSwitchButton.setImage(UIImage(named: "circle"), for: .normal)
            thirdSwitchButton.setImage(UIImage(named: "circle"), for: .normal)
            secondFlagSwitch = true
            firstFlagSwitch = false
            thirdFlagSwitch = false
        } else {
            sender.setImage(UIImage(named: "circle"), for: .normal)
            secondFlagSwitch = false
        }
        firstFlagSwitch = false
        thirdFlagSwitch = false
    }
    
    @IBAction func thirdSwitchButtonClicked(_ sender: UIButton) {
        if thirdFlagSwitch == false {
            sender.setImage(UIImage(named: "correct"), for: .normal)
            firstSwitchButton.setImage(UIImage(named: "circle"), for: .normal)
            secondSwitchButton.setImage(UIImage(named: "circle"), for: .normal)
            thirdFlagSwitch = true
            firstFlagSwitch = false
            secondFlagSwitch = false
        } else {
            sender.setImage(UIImage(named: "circle"), for: .normal)
            thirdFlagSwitch = false
        }
        firstFlagSwitch = false
        secondFlagSwitch = false
    }
    
    @IBAction func showTextButtonClicked(_ sender: UIButton) {
        var checkboxText = ""
        if firstFlagCheckBox == true {
            checkboxText += "\n* \(firstCheckBoxLabel.text ?? String())  \(defaultText) \(firstCheckBoxLabel.text ?? String())"
        }
        if secondFlagCheckBox == true {
            checkboxText += "\n* \(secondCheckBoxLabel.text ?? String()) \(defaultText) \(secondCheckBoxLabel.text ?? String())"
        }
        if thirdFlagCheckBox == true {
            checkboxText += "\n* \(thirdCheckBoxLabel.text ?? String())  \(defaultText) \(thirdCheckBoxLabel.text ?? String())"
        }
        var switchText = ""
        if firstFlagSwitch == true {
            switchText += "\n* \(firstSwitchLabel.text ?? String()) \(defaultText) \(firstSwitchLabel.text ?? String())"
            secondFlagSwitch = false
            thirdFlagSwitch = false
        }
        if secondFlagSwitch == true {
            switchText += "\n* \(secondSwitchLabel.text ?? String())  \(defaultText) \(secondSwitchLabel.text ?? String())"
            firstFlagSwitch = false
            secondFlagSwitch = false
        }
        if thirdFlagSwitch == true {
            switchText += "\n* \(thirdSwitchLabel.text ?? String())  \(defaultText) \(thirdSwitchLabel.text ?? String())"
            firstFlagSwitch = false
            secondFlagSwitch = false
        }
        var optionText = ""
        optionText = "\n* \(popUpButton.titleLabel?.text ?? String())  \(defaultText) \(popUpButton.titleLabel?.text ?? String())"
        outputTextView.text = "Карыстальнік увеў наступны тэкст: \n" + currentTextView.text + "\nКарыстальнік абраў наступныя наладкі:" + checkboxText + switchText + "\(optionText)"
    }
    
    func flagCheckBoxChecked(flag: inout Bool, object: UIButton){
        if flag == false {
            object.setImage(UIImage(named: "checked"), for: .normal)
            flag = true
        } else {
            object.setImage(UIImage(named: "unchecked"), for: .normal)
            flag = false
        }
    }
    
    func setPopUpButton(){
        let optionClosure = {(action: UIAction) in print(action.title)}
        popUpButton.menu = UIMenu(children: [
            UIAction(title:"опцыя #1",state: .on, handler: optionClosure),
            UIAction(title:"опцыя #2",state: .on, handler: optionClosure),
            UIAction(title:"опцыя #3", handler: optionClosure),
        ])
        popUpButton.showsMenuAsPrimaryAction = true
        popUpButton.changesSelectionAsPrimaryAction = true
    }
    
    func setGradientBackground(view: UIView, colorTop: CGColor = UIColor(red: 230.0/255.0, green: 30.0/255.0, blue: 100.0/255.0, alpha: 0.6).cgColor, colorBottom: CGColor = UIColor(red: 38.0/255.0, green: 0.0/255.0, blue: 6.0/255.0, alpha: 1.0).cgColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
