//
//  CheckBox.swift
//  DemoService
//
//  Created by Вадим Лавор on 29.07.22.
//

import UIKit

class Checkbox: UIButton {

    let checkedImage = UIImage(systemName: "heart.fill")
    let uncheckedImage = UIImage(named: "heart")
    var action: ((Bool) -> Void)? = nil

    private(set) var isChecked: Bool = false {
        didSet{
            self.setImage(
                self.isChecked ? self.checkedImage : self.uncheckedImage,
                for: .normal
            )
        }
    }

    override func awakeFromNib() {
        self.addTarget(
            self,
            action:#selector(buttonClicked(sender:)),
            for: .touchUpInside
        )
        self.isChecked = false
    }

    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            self.action?(!self.isChecked)
        }
    }

    func update(checked: Bool) {
        self.isChecked = checked
    }
}
