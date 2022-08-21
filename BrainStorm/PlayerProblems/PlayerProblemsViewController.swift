//
//  PlayerProblemsViewController.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/20/22.
//  
//

import UIKit

protocol ProblemsIncr: AnyObject {
    func incrCountOfProblems()
}

final class PlayerProblemsViewController: UIViewController {
    private let output: PlayerProblemsViewOutput
    
    private var indexPathOfLastCell: IndexPath?
    
    private let themeLabel: UILabel = UILabel()
    
    private let descriptionLabel: UILabel = UILabel()
    
    private let continueButton: UIButton = UIButton()
    
    private var timer: Timer?
    
    private var timeLeft: Int = 180
    
    private let timeLabel: UILabel = UILabel()
    
    private let boxWithProblems: UIView = UIView()
    
    private let problemsCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 500), collectionViewLayout: layout)
        return collection
    }()
    
    private var countOfProblems: Int = 1

    init(output: PlayerProblemsViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        themeLabel.pin
            .size(CGSize(width: 300,
                         height: 40))
            .top(view.pin.safeArea.top)
            .left(20)
        
        timeLabel.pin
            .size(CGSize(width: 30, height: 30))
            .after(of: themeLabel)
            .margin(20)
        
        descriptionLabel.pin
            .size(CGSize(width: view.width - 40, height: 80))
            .below(of: themeLabel, aligned: .left)
            .marginRight(20)
        
        continueButton.pin
            .horizontally(16)
            .height(40)
            .bottom(view.pin.safeArea.bottom + 16)
        
        boxWithProblems.pin
            .size(CGSize(width: view.width, height: continueButton.frame.minY - descriptionLabel.frame.maxY - 10))
            .verticallyBetween(descriptionLabel, and: continueButton)
            .left()
            .right()
            .marginTop(10)
        
        problemsCollectionView.pin.all()
    }
    
    func setup(){
        
        setupThemeLabel()
        setupDescriptionLabel()
        setupContinueButton()
        setupProblemsCollectionView()
        setupBox()
        setupTimer()
        setupScreen()
    }
    
    func setupScreen() {
        navigationItem.setHidesBackButton(true, animated: true)
        
        navigationItem.setRightBarButton(UIBarButtonItem(customView: timeLabel), animated: true)
    }
    
    func setupThemeLabel() {
        themeLabel.text = "Астрология"
        themeLabel.font = .systemFont(ofSize: 40, weight: UIFont.Weight(rawValue: 1))
        themeLabel.textColor = .black
        
        view.addSubview(themeLabel)
    }
    
    func setupDescriptionLabel() {
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "Биба, какие проблемы Вы видите в выбранной теме, или что бы Вы хотели улучшить/привнести?"
        
        view.addSubview(descriptionLabel)
    }
    
    func setupContinueButton() {
        continueButton.setTitle("Далее", for: .normal)
        continueButton.layer.cornerRadius = 10
        continueButton.layer.borderWidth = 0
        continueButton.backgroundColor = UIColor(red: 0.27, green: 0.373, blue: 0.913, alpha: 1)
        
        continueButton.addTarget(self, action: #selector(nextField), for: .touchUpInside)
        view.addSubview(continueButton)
    }
    
    func setupBox() {
        //boxWithProblems.layer.cornerRadius = 15
        view.addSubview(boxWithProblems)
    }
    
    func setupProblemsCollectionView() {
        //problemsCollectionView.layer.cornerRadius = 15
        problemsCollectionView.delaysContentTouches = false
        problemsCollectionView.delegate = self
        problemsCollectionView.dataSource = self
        problemsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        problemsCollectionView.register(ProblemCell.self)
        problemsCollectionView.register(ButtonProblemCell.self)
        
        boxWithProblems.addSubview(problemsCollectionView)
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        timeLabel.text = "\(timeLeft)"
    }
    
    @objc
    func nextField() {
        
    }
    
    @objc func onTimerFires() {
        timeLeft -= 1
        timeLabel.text = "\(timeLeft)"
     
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            print("end")
            showAlert()
            
            
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "time is over", message:"", preferredStyle: .alert)

        let action = UIAlertAction(title: "Далее", style: .default) { _ in
            self.output.openNextScreen()
        }
        alert.addAction(action)
        addBlur()
        self.present(alert, animated: true)
    }
    
    func addBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(blurEffectView)
    }
}



//MARK: - Const
private extension PlayerProblemsViewController {
    struct Const {
        static let textFieldSideIndentation: CGFloat = 16
        static let cardHeight: CGFloat = 150
    }
}

//MARK: - CollectionView Protocols

extension PlayerProblemsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if countOfProblems == 8 {
            return countOfProblems
        }
        return countOfProblems + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == countOfProblems && countOfProblems < 9 {
            
            let cell = problemsCollectionView.dequeueReusableCell(ButtonProblemCell.self, for: indexPath)
            cell.configure(problems: self)
            return cell
        }
        
        let cell = problemsCollectionView.dequeueReusableCell(ProblemCell.self, for: indexPath)
        cell.configure(number: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.frame.width - 3 * Const.textFieldSideIndentation)/2
        
        return .init(width: cellWidth, height: Const.cardHeight)
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

extension PlayerProblemsViewController {
    func reloadProblems() {
        problemsCollectionView.reloadData()
    }
}

extension PlayerProblemsViewController: ProblemsIncr {
    func incrCountOfProblems() {
        countOfProblems += 1
        reloadProblems()
    }
}

extension PlayerProblemsViewController: PlayerProblemsViewInput {
}


