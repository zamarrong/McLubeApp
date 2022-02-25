//
//  UITextFieldWithPickerView.swift
//  McLube
//
//  Created by Jorge Zamarrón on 08/04/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation
import UIKit

class UITextFieldWithPickerView: UITextField {
    
    var pickViewOptions: Array<String> = []
    private let pickerView = UIPickerView()
    
    required init(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)!
    
        pickerView.delegate = self

        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Ok", style: UIBarButtonItemStyle.Plain , target: self, action: #selector(UITextFieldWithPickerView.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        let item : UITextInputAssistantItem = self.inputAssistantItem
        item.leadingBarButtonGroups = []
        item.trailingBarButtonGroups = []
        
        self.inputView = pickerView
        self.inputAccessoryView = toolBar
        if self.pickViewOptions.count > 0 {
            self.text = pickViewOptions[0]
        }
    }
    
    func defaultSelectedRow(row: Int) {
        self.text = pickViewOptions[row]
    }
    
    func selectedRow() -> Int {
        return self.pickerView.selectedRowInComponent(0)
    }
}

extension UITextFieldWithPickerView : UIPickerViewDataSource, UIPickerViewDelegate {
    func donePicker() {
        self.endEditing(true)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickViewOptions.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickViewOptions[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text = pickViewOptions[row]
    }
}

