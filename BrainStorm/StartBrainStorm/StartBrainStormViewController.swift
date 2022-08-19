//
//  StartBrainStormViewController.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/14/22.
//  
//

import UIKit

final class StartBrainStormViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - Defenition
    
    private var themes: [String] = ["Математика", "Медицина", "Наука",
                                    "Физика", "Литература", "It",
                                    "Экология", "Философия", "Экономика",
                                    "Воспитание", "Психология", "Нумерология",
                                    "Астрология", "NFT", "Блокчейн",
                                    "Астрономия", "Биология", "Биоинформатика",
                                    "Медицина"]

    private var currentTheme: IndexPath?
    
    private let output: StartBrainStormViewOutput
    
    private var countOfPlayer: Int = 0
    
    private let openPickerButton: UIColorButton = UIColorButton(pressedColor: UIColor(red: 0.27, green: 0.373, blue: 0.913, alpha: 1),
                                                                notPressedColor: .white)
    
    private let chooseCountOfPeopleLable: UILabel = UILabel()
    
    private let brainStormNameTextField: UITextField = UITextField()
    
    private let brainStormTeamNameLabel: UILabel  = UILabel()
    
    private let brainStormBeginGameButton: UIButton = UIButton()
    
    private let themesCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 500), collectionViewLayout: layout)
        return collection
    }()
    
    private let boxWithplayersCollectionView: UIView = UIView()
    
    private let line = UIView()
    
    private var teamName: String?
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
    
    //MARK: - viewDidLayoutSubviews
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        brainStormNameTextField.pin
            .size(CGSize(width: UIScreen.screenWidth - 2 * Const.textFieldSideIndentation,
                         height: Const.textFieldHight))
            .top(view.pin.safeArea.top + 10)
            .hCenter()
        
        line.pin
            .below(of: brainStormNameTextField, aligned: .left)
            .size(CGSize(width: brainStormNameTextField.frame.width, height: 3))
        
        brainStormTeamNameLabel.pin
            .width(150)
            .height(15)
            .below(of: line, aligned: .left)
            .marginTop(10)
        
        chooseCountOfPeopleLable.pin
            .below(of: brainStormTeamNameLabel, aligned: .left)
            .marginTop(10)
            .sizeToFit()
        
        openPickerButton.pin
            .height(25)
            .width(UIScreen.screenWidth - chooseCountOfPeopleLable.frame.width - 5 - (UIScreen.screenWidth - brainStormNameTextField.frame.width))
            .topLeft(to: chooseCountOfPeopleLable.anchor.topRight)
            .marginLeft(5)
        
        brainStormBeginGameButton.pin
            .horizontally(16)
            .height(40)
            .bottom(view.pin.safeArea.bottom + 16)
    
        
        boxWithplayersCollectionView.pin
            .size(CGSize(width: UIScreen.screenWidth, height: 550))
            .left()
            .right()
            .marginTop(10)
            .marginBottom(10)
            .below(of: chooseCountOfPeopleLable)
            .bottom()
        themesCollectionView.pin.all()
    }
    
    //MARK: - setup
    
    func setup(){
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupPlayersCollectionView()
        setupBrainStormNameTextField()
        setupBbrainStormTeamNameLabel()
        setupChooseCountOfPeopleLable()
        setupOpenPickerButton()
        setupBrainStormBeginGameButton()
        setupLine()

    }
    
    func setupNavigationBar() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 24)
        let image = UIImage(systemName: "arrow.left.circle",  withConfiguration: configuration)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let backBTN = UIBarButtonItem(image: image,
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func setupLine() {
        line.backgroundColor = Color.defaultBlackAndWhiteColor
        view.addSubview(line)
        
    }
    
    func setupPlayersCollectionView(){
        themesCollectionView.delaysContentTouches = false
        boxWithplayersCollectionView.addSubview(themesCollectionView)
        themesCollectionView.delegate = self
        themesCollectionView.dataSource = self
        themesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        themesCollectionView.register(ThemeViewCell.self)
        
        view.addSubview(boxWithplayersCollectionView)
        
        
    }
    
    func setupOpenPickerButton(){
        openPickerButton.setTitle("\(countOfPlayer)", for: .normal)
        openPickerButton.setTitleColor(.black, for: .normal)
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
        chooseCountOfPeopleLable.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 10))
        chooseCountOfPeopleLable.text = "Количество игроков: "
        chooseCountOfPeopleLable.center = view.center
        view.addSubview(chooseCountOfPeopleLable)
    }
    
    func setupBrainStormNameTextField(){
        brainStormNameTextField.backgroundColor = .white
        brainStormNameTextField.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 15))
        brainStormNameTextField.textColor = .black
        brainStormNameTextField.delegate = self
        brainStormNameTextField.contentVerticalAlignment = .center
        brainStormNameTextField.textAlignment = .left
        brainStormNameTextField.borderStyle = .none
        
        view.addSubview(brainStormNameTextField)
    }
    
    func setupBbrainStormTeamNameLabel(){
        brainStormTeamNameLabel.text = "Название команды"
        brainStormTeamNameLabel.font = .systemFont(ofSize: 14)
        brainStormTeamNameLabel.textColor = .black
        view.addSubview(brainStormTeamNameLabel)
    }
    
    func setupBrainStormBeginGameButton(){
        brainStormBeginGameButton.setTitle("Начать", for: .normal)
        brainStormBeginGameButton.layer.cornerRadius = 10
        brainStormBeginGameButton.layer.borderWidth = 0
        brainStormBeginGameButton.backgroundColor = UIColor(red: 0.27, green: 0.373, blue: 0.913, alpha: 1)
        
        brainStormBeginGameButton.addTarget(self, action: #selector(beginGame), for: .touchUpInside)
        view.addSubview(brainStormBeginGameButton)
    }
    
    
    //MARK: - objc function
    
    @objc
    func tap(gesture: UITapGestureRecognizer) {
        brainStormNameTextField.resignFirstResponder()
    }
    
    @objc
    func beginGame(){
        if let sendName = teamName {
            output.startBrainStorm(name: sendName)
            brainStormNameTextField.text = ""
        }
        
        else{
            output.dismiss()
            brainStormNameTextField.text = ""
        }
    }
    
    //MARK: - OpenPicker
    
    @objc
    func openPicker(){
        let alert = UIAlertController(title: "", message:"\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPopover = true
        
        let chooseCountOfPlayerPicker: UIPickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 270, height: 140))
        
        chooseCountOfPlayerPicker.delegate = self
        chooseCountOfPlayerPicker.dataSource = self
        alert.view.addSubview(chooseCountOfPlayerPicker)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}


//MARK: - Const
private extension StartBrainStormViewController {
    struct Const{
        static let MaxCountOfPlayers: Int = 10
        static let textFieldHight: CGFloat = 30
        static let textFieldSideIndentation: CGFloat = 36
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


//MARK: - UITextFieldDelegate

extension StartBrainStormViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.brainStormNameTextField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let Name = brainStormNameTextField.text {
            teamName = Name
        }
        
    }
}


//MARK: -  UIPickerViewDataSource

extension StartBrainStormViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Const.MaxCountOfPlayers + 1
    }
    
    
}

extension StartBrainStormViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        countOfPlayer = row
        openPickerButton.setTitle("\(countOfPlayer)", for: .normal)
    }
}

//MARK: - UICollectionProtocols


extension StartBrainStormViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = themesCollectionView.dequeueReusableCell(ThemeViewCell.self, for: indexPath)
        cell.configure(theme: themes[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.frame.width - 3 * Const.textFieldSideIndentation)/2
        
        return .init(width: cellWidth, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 22,
                     left: Const.textFieldSideIndentation,
                     bottom: 22,
                     right: Const.textFieldSideIndentation)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ThemeViewCell {
            cell.contentView.backgroundColor = UIColor(red: 0.27, green: 0.373, blue: 0.913, alpha: 1)
            cell.newLabelTextColor(color: .white)
            if let current = currentTheme {
                let lastCell = collectionView.cellForItem(at: current) as? ThemeViewCell
                lastCell?.newLabelTextColor(color: UIColor(red: 0.506, green: 0.549, blue: 0.6, alpha: 1))
                lastCell?.contentView.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            }
            
        }
        currentTheme = indexPath
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
        themesCollectionView.reloadData()
    }
}


