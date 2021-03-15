//
//  LoginTextField.swift
//  OnTheMap
//
//  Created by Jimin Kim on 1/6/21.
//  Copyright © 2021 Jimin Kim. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5
        //tintColor = UIColor.white
        //backgroundColor = UIColor.primaryLight

    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let insetBounds = CGRect(x: bounds.origin.x + 8, y: bounds.origin.y, width: bounds.size.width - 16, height: bounds.size.height)
        return insetBounds
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let insetBounds = CGRect(x: bounds.origin.x + 8, y: bounds.origin.y, width: bounds.size.width - 16, height: bounds.size.height)
        return insetBounds
    }
}
