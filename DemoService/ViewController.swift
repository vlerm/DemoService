//
//  ViewController.swift
//  DemoService
//
//  Created by Вадим Лавор on 29.07.22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var firstCheckBoxButton: UIButton!
    @IBOutlet weak var secondCheckBoxButton: UIButton!
    @IBOutlet weak var thirdCheckBoxButton: UIButton!
    @IBOutlet weak var firstCheckBoxLabel: UILabel!
    @IBOutlet weak var secondCheckBoxLabel: UILabel!
    @IBOutlet weak var thirdCheckBoxLabel: UILabel!
    @IBOutlet weak var currentTextView: UITextView!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var firstRadioButton: UIButton!
    @IBOutlet weak var secondRadioButton: UIButton!
    @IBOutlet weak var thirdRadioButton: UIButton!
    @IBOutlet weak var firstRadioButtonLabel: UILabel!
    @IBOutlet weak var secondRadioButtonLabel: UILabel!
    @IBOutlet weak var thirdRadioButtonLabel: UILabel!
    @IBOutlet weak var popUpButton: UIButton!
    @IBOutlet weak var showTextButton: UIButton!
    
    var firstFlagCheckBox = false
    var secondFlagCheckBox = false
    var thirdFlagCheckBox = false
    var firstFlagRadioButton = false
    var secondFlagRadioButton = true
    var thirdFlagRadioButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultConfigurationForView()
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
    
    @IBAction func firstRadioButtonClicked(_ sender: UIButton) {
        if firstFlagRadioButton == false {
            sender.setImage(UIImage(named: "correct"), for: .normal)
            secondRadioButton.setImage(UIImage(named: "circle"), for: .normal)
            thirdRadioButton.setImage(UIImage(named: "circle"), for: .normal)
            firstFlagRadioButton = true
            secondFlagRadioButton = false
            thirdFlagRadioButton = false
        } else {
            sender.setImage(UIImage(named: "circle"), for: .normal)
            firstFlagRadioButton = false
        }
        secondFlagRadioButton = false
        thirdFlagRadioButton = false
    }
    
    @IBAction func secondRadioButtonClicked(_ sender: UIButton) {
        if secondFlagRadioButton == false {
            sender.setImage(UIImage(named: "correct"), for: .normal)
            firstRadioButton.setImage(UIImage(named: "circle"), for: .normal)
            thirdRadioButton.setImage(UIImage(named: "circle"), for: .normal)
            secondFlagRadioButton = true
            firstFlagRadioButton = false
            thirdFlagRadioButton = false
        } else {
            sender.setImage(UIImage(named: "circle"), for: .normal)
            secondFlagRadioButton = false
        }
        firstFlagRadioButton = false
        thirdFlagRadioButton = false
    }
    
    @IBAction func thirdRadioButtonClicked(_ sender: UIButton) {
        if thirdFlagRadioButton == false {
            sender.setImage(UIImage(named: "correct"), for: .normal)
            firstRadioButton.setImage(UIImage(named: "circle"), for: .normal)
            secondRadioButton.setImage(UIImage(named: "circle"), for: .normal)
            thirdFlagRadioButton = true
            firstFlagRadioButton = false
            secondFlagRadioButton = false
        } else {
            sender.setImage(UIImage(named: "circle"), for: .normal)
            thirdFlagRadioButton = false
        }
        firstFlagRadioButton = false
        secondFlagRadioButton = false
    }
    
    @IBAction func showTextButtonClicked(_ sender: UIButton) {
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = String()
        
        let parameters = [
          [
            "key": "text",
            "value": "\(String(describing: currentTextView.text ?? "N/A"))",
            "type": "text"
          ],
          [
            "key": "checkbox1",
            "value": "\(String(describing: getSecretValueForCheckBox(firstFlagCheckBox)))",
            "type": "text"
          ],
          [
            "key": "checkbox2",
            "value": "\(String(describing: getSecretValueForCheckBox(secondFlagCheckBox)))",
            "type": "text"
          ],
          [
            "key": "checkbox3",
            "value": "\(String(describing: getSecretValueForCheckBox(thirdFlagCheckBox)))",
            "type": "text"
          ],
          [
            "key": "mode",
            "value": "\(String(describing: getSecretValueForRadioButton()))",
            "type": "text"
          ],
          [
            "key": "selector",
            "value": "\(String(describing: getSecretValueForOptions()))",
            "type": "text"
          ]] as [[String : Any]]

        for parameter in parameters {
          if parameter["disabled"] == nil {
            let parameterName = parameter["key"]!
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(parameterName)\""
            if parameter["contentType"] != nil {
              body += "\r\nContent-Type: \(parameter["contentType"] as! String)"
            }
            let parameterType = parameter["type"] as! String
            if parameterType == "text" {
              let parameterValue = parameter["value"] as! String
              body += "\r\n\r\n\(parameterValue)\r\n"
            } else {
              let parameterSrc = parameter["src"] as! String
              let fileData = try? NSData(contentsOfFile:parameterSrc, options:[]) as Data
              let fileContent = String(data: fileData ?? Data(), encoding: .utf8)!
              body += "; filename=\"\(parameterSrc)\"\r\n"
                + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
            }
          }
        }
        
        body += "--\(boundary)--\r\n"
        let postData = body.data(using: .utf8)
        let urlString = "https://corpus.by/ServiceDemonstrator/api.php"
        var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData

        AF.request(request).responseData { responce in
            switch responce.result {
            case .success:
                let responseJSON = try? JSONSerialization.jsonObject(with: responce.data ?? Data(), options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                DispatchQueue.main.async {
                    self.outputTextView.text = "\(String(describing: responseJSON["result"] ?? String()))"
                    print(String(describing: responseJSON["result"] ?? String()))
                }
            }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
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
    
    func getSecretValueForCheckBox(_ checkBox: Bool) -> Int {
        if checkBox == true {
            return 1
        } else {
            return 0
        }
    }
    
    func getSecretValueForRadioButton() -> String {
        let arrayFlagRadioButton = [firstFlagRadioButton,secondFlagRadioButton,thirdFlagRadioButton]
        let radioButtonText = "radiobutton"
        var selectedIndex = Int()
        var radioButtonIndex = Int()
        for flagRadioButton in arrayFlagRadioButton {
            if flagRadioButton == true {
                selectedIndex = radioButtonIndex
                if radioButtonIndex == 0 {
                    secondFlagRadioButton = false
                    thirdFlagRadioButton = false
                } else if radioButtonIndex == 1 {
                    firstFlagRadioButton = false
                    thirdFlagRadioButton = false
                } else if radioButtonIndex == 2{
                    firstFlagRadioButton = false
                    secondFlagRadioButton = false
                }
            }
            radioButtonIndex += 1
        }
        return radioButtonText+String(selectedIndex+1)
    }
    
    func getSecretValueForOptions() -> String {
        return (popUpButton.titleLabel?.text?.replacingOccurrences(of: " #", with: ""))!
    }

    func setupDefaultConfigurationForView(){
        setPopUpButton()
        setGradientBackground(view: self.view, colorTop: UIColor(red: 210/255, green: 109/255, blue: 180/255, alpha: 1).cgColor, colorBottom: UIColor(red: 52/255, green: 148/255, blue: 230/255, alpha: 1).cgColor)
        currentTextView.layer.cornerRadius = 10
        outputTextView.layer.cornerRadius = 10
        showTextButton.layer.cornerRadius = 10
        secondRadioButton.setImage(UIImage(named: "correct"), for: .normal)
    }
    
}
