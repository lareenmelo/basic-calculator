//
//  RoundButtons.swift
//  basic-calculator
//
//  Created by Lareen Melo on 8/2/19.
//  Copyright © 2019 Lareen Melo. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
}
