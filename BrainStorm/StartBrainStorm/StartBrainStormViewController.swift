//
//  StartBrainStormViewController.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/14/22.
//  
//

import UIKit

final class StartBrainStormViewController: UIViewController {
    private let output: StartBrainStormViewOutput
    
    private let brainStormNameTextField: UITextField = UITextField(frame: CGRect(x: 150,
                                                                                 y: 200,
                                                                                 width: UIScreen.screenWidth -
                                                                                 2 * Const.textFieldSideIndentation,
                                                                                 height: Const.textFieldHight))
    private let brainStormDescriptionTextField: UITextField = UITextField(frame: CGRect(x: 150,
                                                                                        y: 300,
                                                                                        width: UIScreen.screenWidth -
                                                                                        2 * Const.textFieldSideIndentation,
                                                                                        height: Const.textFieldHight))
    private let brainStormSendNameAndDescriptionButton: UIButton = UIButton(frame: CGRect(x: 150, y: 300, width: 350, height: 30))
    
    private var name: String?
    private var Description: String?
    
    init(output: StartBrainStormViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        output.viewDidLoad()
    }
    
    func setup(){
        view.backgroundColor = .blue
        
        setupBrainStormNameTextField()
        setupBrainStormDescriptionTextField()
        setupBrainStormSendNameAndDescriptionButton()
    }
    
    func setupBrainStormNameTextField(){
        brainStormNameTextField.delegate = self
        brainStormNameTextField.borderStyle = .roundedRect
        brainStormNameTextField.contentVerticalAlignment = .center
        brainStormNameTextField.textAlignment = .center
        brainStormNameTextField.placeholder = "Name"
        brainStormNameTextField.center = self.view.center
        brainStormNameTextField.center.y = self.view.center.y - 100
        
        view.addSubview(brainStormNameTextField)
    }
    
    func setupBrainStormDescriptionTextField(){
        brainStormDescriptionTextField.delegate = self
        brainStormDescriptionTextField.borderStyle = .roundedRect
        brainStormDescriptionTextField.contentVerticalAlignment = .center
        brainStormDescriptionTextField.textAlignment = .center
        brainStormDescriptionTextField.placeholder = "Description"
        brainStormDescriptionTextField.center.x = self.view.center.x
        brainStormDescriptionTextField.center.y = self.view.center.y - 50
        
        view.addSubview(brainStormDescriptionTextField)
    }
    
    func setupBrainStormSendNameAndDescriptionButton(){
        brainStormSendNameAndDescriptionButton.setTitle("send", for: .normal)
        brainStormSendNameAndDescriptionButton.frame.size = CGSize(width: Const.brainStormSendNameAndDescriptionButtonWidth,
                                                                   height: Const.brainStormSendNameAndDescriptionButtonHight)
        brainStormSendNameAndDescriptionButton.layer.cornerRadius = 10
        brainStormSendNameAndDescriptionButton.layer.borderWidth = 4
        brainStormSendNameAndDescriptionButton.center.x = self.view.center.x
        brainStormSendNameAndDescriptionButton.center.y = Const.brainStormSendNameAndDescriptionButtonY
        
        brainStormSendNameAndDescriptionButton.addTarget(self, action: #selector(sentNameAndDescription), for: .touchUpInside)
        view.addSubview(brainStormSendNameAndDescriptionButton)
    }
    
    @objc
    func sentNameAndDescription(){
        if let sendName = name, let sendDescription = Description{
            output.send(name: sendName, description: sendDescription)
            brainStormNameTextField.text = ""
            brainStormDescriptionTextField.text = ""
        }
        
        else{
            output.dismiss()
            brainStormNameTextField.text = ""
            brainStormDescriptionTextField.text = ""
        }
    }
}

private extension StartBrainStormViewController {
    struct Const{
        static let textFieldHight: CGFloat = 30
        static let textFieldSideIndentation: CGFloat = 8
        static let brainStormSendNameAndDescriptionButtonWidth: CGFloat = UIScreen.screenWidth/2 + UIScreen.screenWidth/4
        static let brainStormSendNameAndDescriptionButtonHight: CGFloat = 50
        static let brainStormSendNameAndDescriptionButtonY: CGFloat = UIScreen.screenHeight/2
                                                                    + UIScreen.screenHeight/4
                                                                    + UIScreen.screenHeight/8
                                                                    - UIScreen.screenHeight/32
                                                                    + UIScreen.screenHeight/64
        
    }
    
}

extension StartBrainStormViewController: StartBrainStormViewInput {
}


extension StartBrainStormViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == brainStormNameTextField {
            self.brainStormNameTextField.resignFirstResponder()
        }
        else{
            self.brainStormDescriptionTextField.resignFirstResponder()
            
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == brainStormNameTextField {
            if let Name = brainStormNameTextField.text {
                name = Name
            }
        }
        else{
            if let description = brainStormDescriptionTextField.text {
                Description = description
            }
            
        }
    }
}
