//
//  DiscussionViewController.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 20.08.2022.
//
//

import UIKit
import PinLayout

final class DiscussionViewController: UIViewController {
    private let output: DiscussionViewOutput
    private var timer: Timer?
    
    private var timeLeft: Int = 1000
    
    private let timeLabel: UILabel = UILabel()
    
    private var problems: [String] = []
    
    private let themeLabel: UILabel = UILabel()
    private let themesCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 500), collectionViewLayout: layout)
        return collection
    }()
    
    private let continueButton: UIButton = UIButton()
    private var currentTapped: Set<IndexPath?> = []
    
    private let descriptionLabel: UILabel = UILabel()
    
    init(output: DiscussionViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        
        problems = output.getProblems().shuffled()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.setRightBarButton(UIBarButtonItem(customView: timeLabel), animated: true)
        navigationItem.setHidesBackButton(true, animated: true)
        
        setup()
        
        themesCollectionView.backgroundColor = .white
    }
    
    func setup() {
        setupPlayersCollectionView()
        setupTimer()
        setupThemeLabel()
        setupContinueButton()
        setupDescriptionLabel()
    }
    
    func setupPlayersCollectionView(){
        themesCollectionView.delaysContentTouches = false
        themesCollectionView.delegate = self
        themesCollectionView.dataSource = self
        themesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        themesCollectionView.register(ProblemDiscussionCell.self)
        
        ProblemDiscussionCell.count = output.getCountOfProblems()
        
        view.addSubview(themesCollectionView)
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        timeLabel.text = "\(timeLeft)"
    }
    
    @objc
    func nextField() {
        if ProblemDiscussionCell.tappedCells.count != output.getCountOfProblems() {
            showCanselAlert()
            return
        }
        for index in ProblemDiscussionCell.tappedCells {
            output.addProblem(problem: problems[index])
        }
        output.openNextField()
    }
    
    @objc func onTimerFires() {
        timeLeft -= 1
        timeLabel.text = "\(timeLeft)"
        
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            showAlert()
            
            
        }
    }
    
    
    func showAlert(blur: Bool = true) {
        let alert = UIAlertController(title: "time is over", message:"", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Далее", style: .default) { _ in
        }
        alert.addAction(action)
        if blur {
            addBlur()
        }
        self.present(alert, animated: true)
    }
    
    func addBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(blurEffectView)
    }
    
    
    func setupDescriptionLabel() {
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "\(output.getTeamName()), обсудите информацию на стикерах и выберите \(output.getCountOfProblems()) заметок для перехода на следующий этап"
        
        view.addSubview(descriptionLabel)
    }
    
    func setupContinueButton() {
        continueButton.setTitle("Далее", for: .normal)
        continueButton.layer.cornerRadius = 10
        continueButton.layer.borderWidth = 0
        continueButton.backgroundColor = UIColor(red: 0.27, green: 0.373, blue: 0.913, alpha: 1)
        continueButton.setTitleColor(.gray, for: .highlighted)
        
        continueButton.addTarget(self, action: #selector(nextField), for: .touchUpInside)
        view.addSubview(continueButton)
    }
    
    func setupThemeLabel() {
        themeLabel.text = output.getTheme()
        themeLabel.font = .systemFont(ofSize: 40, weight: UIFont.Weight(rawValue: 1))
        themeLabel.textColor = .black
        
        view.addSubview(themeLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        themeLabel.pin
            .size(CGSize(width: 300,
                         height: 40))
            .top(view.pin.safeArea.top)
            .left(20)
        descriptionLabel.pin
            .size(CGSize(width: view.width - 40, height: 80))
            .below(of: themeLabel, aligned: .left)
            .marginRight(20)
        
        continueButton.pin
            .horizontally(16)
            .height(40)
            .bottom(view.pin.safeArea.bottom + 16)
        themesCollectionView.pin
            .verticallyBetween(descriptionLabel, and: continueButton)
            .width(view.width)
            .maxHeight(1000)
            .top(10)
            .all()
        
    }
}

extension DiscussionViewController: DiscussionViewInput {
}


//MARK: - Const
private extension DiscussionViewController {
    struct Const{
        static let MaxCountOfPlayers: Int = 10
        static let textFieldHight: CGFloat = 30
        static let textFieldSideIndentation: CGFloat = 16
        static let brainStormSendNameAndDescriptionButtonWidth: CGFloat = UIScreen.screenWidth/2 + UIScreen.screenWidth/4
        static let brainStormSendNameAndDescriptionButtonHight: CGFloat = 50
        static let brainStormSendNameAndDescriptionButtonY: CGFloat = UIScreen.screenHeight/2
        + UIScreen.screenHeight/4
        + UIScreen.screenHeight/8
        - UIScreen.screenHeight/32
        + UIScreen.screenHeight/64
    }
}


//MARK: - UICollectionProtocols

extension DiscussionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return problems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = themesCollectionView.dequeueReusableCell(ProblemDiscussionCell.self, for: indexPath)
        cell.configure(number: indexPath.row, text: problems[indexPath.row], problemAlert: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.frame.width - 3 * Const.textFieldSideIndentation)/2
        
        return .init(width: cellWidth, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 22,
                     left: Const.textFieldSideIndentation,
                     bottom: 22,
                     right: Const.textFieldSideIndentation)
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


extension DiscussionViewController: ProblemAlert {
    func showCanselAlert() {
        let alert = UIAlertController(title: "Неверный выбор", message: "Выбрано неверное количество проблем", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Далее", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func reloadData(){
        themesCollectionView.reloadData()
    }
}
