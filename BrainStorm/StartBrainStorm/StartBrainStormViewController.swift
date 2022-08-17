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
    
    private let chooseCountOfPlayerPicker: UIPickerView = UIPickerView(frame: CGRect(x: 7, y: 0, width: 250, height: 140))
    
    private var countOfPlayer: Int = 0
    
    private let openPickerButton: UIColorButton = UIColorButton(pressedColor: .red, notPressedColor: .white)
    
    private let chooseCountOfPeopleLable: UILabel = UILabel(frame: CGRect(x: 0,
                                                                          y: 0,
                                                                          width: UIScreen.screenWidth * 3/5,
                                                                          height: 20))
    
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
    
    private let playersCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 800, width: 200, height: 300), collectionViewLayout: layout)
        return collection
    }()
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
        
        setup()
        
        output.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        brainStormNameTextField.pin
            .top(view.pin.safeArea.top + 32)
            .right(10)
            .left(10)
        
        brainStormDescriptionTextField.pin
            .below(of: brainStormNameTextField)
            .margin(10)
        
        chooseCountOfPeopleLable.pin
            .below(of: brainStormDescriptionTextField, aligned: .left)
            .marginTop(10)
        
        openPickerButton.pin
            .width(UIScreen.screenWidth - chooseCountOfPeopleLable.frame.width - 20)
            .topLeft(to: chooseCountOfPeopleLable.anchor.topRight)
            .marginLeft(5)
            .marginRight(5)
        
        playersCollectionView.pin
            .below(of: chooseCountOfPeopleLable)
            .left()
            .right()
            .bottom()
            .marginTop(10)
    }
    
    func setup(){
        view.backgroundColor = .blue
        
        setupPlayersCollectionView()
        setupBrainStormNameTextField()
        setupBrainStormDescriptionTextField()
        setupChooseCountOfPeopleLable()
        setupOpenPickerButton()
        setupBrainStormSendNameAndDescriptionButton()
    }
    
    func setupPlayersCollectionView(){
        playersCollectionView.delegate = self
        playersCollectionView.dataSource = self
        playersCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        playersCollectionView.register(PlayersViewCell.self)
        
        view.addSubview(playersCollectionView)
        
    }
    
    func setupOpenPickerButton(){
        openPickerButton.setTitle("\(countOfPlayer)", for: .normal)
        openPickerButton.setTitleColor(.black, for: .normal)
        openPickerButton.frame.size = CGSize(width: UIScreen.screenWidth * 1/4,
                                                  height: 25)
        openPickerButton.backgroundColor = .white
        openPickerButton.layer.cornerRadius = 10
        openPickerButton.layer.borderWidth = 1
        openPickerButton.center = view.center
        openPickerButton.center.x = UIScreen.screenWidth * 3/4
        
        openPickerButton.addTarget(self, action: #selector(openPicker), for: .touchUpInside)
        self.view.addSubview(openPickerButton)
    }
    
    func setupChooseCountOfPeopleLable(){
        chooseCountOfPeopleLable.numberOfLines = 0
        chooseCountOfPeopleLable.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 15))
        chooseCountOfPeopleLable.text = "Количество играков: "
        chooseCountOfPeopleLable.center = view.center
        view.addSubview(chooseCountOfPeopleLable)
    }
    func setupChooseCountOfPlayerPicker(){

        chooseCountOfPlayerPicker.delegate = self
        chooseCountOfPlayerPicker.dataSource = self
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
        brainStormSendNameAndDescriptionButton.setTitle("Начать", for: .normal)
        brainStormSendNameAndDescriptionButton.frame.size = CGSize(width: Const.brainStormSendNameAndDescriptionButtonWidth,
                                                                   height: Const.brainStormSendNameAndDescriptionButtonHight)
        brainStormSendNameAndDescriptionButton.layer.cornerRadius = 10
        brainStormSendNameAndDescriptionButton.layer.borderWidth = 4
        brainStormSendNameAndDescriptionButton.backgroundColor = .blue
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
    
    @objc
    func openPicker(){
        let alert = UIAlertController(title: "", message:"\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPopover = true
        
        setupChooseCountOfPlayerPicker()
        alert.view.addSubview(chooseCountOfPlayerPicker)
        let action = UIAlertAction(title: "OK", style: .cancel)
        //alert.view.addSubview(chooseCountOfPlayerPicker)
        alert.addAction(action)
        self.present(alert, animated: true)
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


extension StartBrainStormViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 11
    }
    
    
}

extension StartBrainStormViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        countOfPlayer = row
        
        self.reloadData()
        openPickerButton.setTitle("\(countOfPlayer)", for: .normal)
    }
}



// --------------------------

extension StartBrainStormViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countOfPlayer
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = playersCollectionView.dequeueReusableCell(PlayersViewCell.self, for: indexPath)
        cell.configure()
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = collectionView.frame.width - 2 * 8
        
        return .init(width: cellWidth, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 8, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8
    }
    
}

extension StartBrainStormViewController{
    func reloadData(){
        playersCollectionView.reloadData()
    }
}

extension StartBrainStormViewController{
    @objc
    func tap(gesture: UITapGestureRecognizer) {
        brainStormNameTextField.resignFirstResponder()
        brainStormDescriptionTextField.resignFirstResponder()
    }
}
