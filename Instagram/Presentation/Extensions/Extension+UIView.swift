//
//  Extension + UIView.swift
//  Instagram
//
//  Created by Jung Choi on 7/27/23.
//

import UIKit

extension UIView {
    var top: CGFloat {
        return frame.origin.y
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
    
    var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var width: CGFloat {
        return frame.size.width
    }
}
