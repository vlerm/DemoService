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
    
    let defaultTextOne = "- The user has selected"
    let defaultTextTwo = "User entered the following text: \n"
    let defaultTextThree = "\nUser has selected the following settings:"
    
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
        let arrayFlagCheckBox = [firstFlagCheckBox, secondFlagCheckBox, thirdFlagCheckBox]
        let arrayCheckBoxLabel = [firstCheckBoxLabel,secondCheckBoxLabel,thirdCheckBoxLabel]
        let arrayFlagSwitch = [firstFlagSwitch,secondFlagSwitch,thirdFlagSwitch]
        let arraySwithLabel = [firstSwitchLabel,secondSwitchLabel,thirdSwitchLabel]
        var checkboxText = String()
        var checkBoxIndex = Int()
        var switchText = String()
        var switchIndex = Int()
        var optionText = String()
        for flagCheckBox in arrayFlagCheckBox {
                if flagCheckBox == true {
                    checkboxText += "\n* \(arrayCheckBoxLabel[checkBoxIndex]?.text ?? String()) \(defaultTextOne) \(arrayCheckBoxLabel[checkBoxIndex]?.text ?? String())"
            }
            checkBoxIndex += 1
        }
        for flagSwitch in arrayFlagSwitch {
            if flagSwitch == true {
                switchText += "\n* \(arraySwithLabel[switchIndex]?.text ?? String()) \(defaultTextOne) \(arraySwithLabel[switchIndex]?.text ?? String())"
                if switchIndex == 0 {
                    secondFlagSwitch = false
                    thirdFlagSwitch = false
                } else if switchIndex == 1 {
                    firstFlagSwitch = false
                    thirdFlagSwitch = false
                } else if switchIndex == 2{
                    firstFlagSwitch = false
                    secondFlagSwitch = false
                }
            }
            switchIndex += 1
        }
        optionText = "\n* \(popUpButton.titleLabel?.text ?? String())  \(defaultTextOne) \(popUpButton.titleLabel?.text ?? String())"
        outputTextView.text = defaultTextTwo + currentTextView.text + defaultTextThree + checkboxText + switchText + "\(optionText)"
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
            UIAction(title:"option #1",state: .on, handler: optionClosure),
            UIAction(title:"option #2",state: .on, handler: optionClosure),
            UIAction(title:"option #3", handler: optionClosure),
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
