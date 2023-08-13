//
//  UIImagePickerControllerAdapter.swift
//  Instagram
//
//  Created by Jung Choi on 7/29/23.
//

import UIKit

class UIImagePickerControllerAdapter {
    
    func getCameraPickerController() -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .camera
        return controller
    }
    
    func getLibraryPickerController() -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        return controller
    }
}
