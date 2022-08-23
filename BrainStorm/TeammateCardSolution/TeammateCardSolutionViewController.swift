//
//  TeammateCardSolutionViewController.swift
//  test
//
//  Created by Кирилл Санников on 22.08.2022.
//  
//

import UIKit

final class TeammateCardSolutionViewController: UIViewController {
    private let output: TeammateCardSolutionViewOutput
    var yLabel: CGFloat = 0.0
    let contWidth: CGFloat = 16
    var timer: Timer? = nil
    var timeLeft: Int = 180
    let timeLabel = UILabel()
    let textView = UITextView()
    let nextButton = UIButton()
    private let infoCard: (String, String)

    init(output: TeammateCardSolutionViewOutput) {
        self.output = output
        self.infoCard = (output.getPersonName(), output.getProblem())
        
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
        
        view.backgroundColor = .white
        yLabel = view.frame.height * 0.1
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupTimeLabel()
        setupTitleLabel(name: infoCard.0)
        setupTextLabel()
        setupProblemLabel()
        setupProblem(problem: infoCard.1)
        setupSolutionLabel()
        setupSulution()
        setupNextButton()
    }
    
    override func viewDidLayoutSubviews() {
        nextButton.pin
                    .horizontally(16)
                    .height(40)
                    .bottom(view.pin.safeArea.bottom + 16)
    }
    
    // MARK: Setups
    
    func setupTimeLabel() {
        timeLabel.text = "\(timeLeft)"
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        navigationItem.setRightBarButton(UIBarButtonItem(customView: timeLabel), animated: true)
    }
    
    func setupTitleLabel(name: String) {
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: contWidth, y: yLabel, width: view.bounds.width - contWidth * 2, height: 0)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
        titleLabel.text = name
        titleLabel.sizeToFit()
        view.addSubview(titleLabel)
        yLabel += titleLabel.frame.height
    }
    
    func setupTextLabel() {
        let textLabel = UILabel()
        textLabel.frame = CGRect(x: contWidth, y: yLabel, width: view.bounds.width - contWidth * 2, height: 0)
        textLabel.text = "Перед вами стикер, созданный вашим товарищем. С помощью чего бы вы с ней боролись, как бы подошли к реализации?"
        textLabel.numberOfLines = 0
        textLabel.sizeToFit()
        view.addSubview(textLabel)
        yLabel += textLabel.frame.height + 20
    }
    
    func setupProblemLabel() {
        let problemLabel = UILabel()
        problemLabel.frame = CGRect(x: contWidth, y: yLabel, width: view.bounds.width - contWidth * 2, height: 0)
        problemLabel.font = UIFont.boldSystemFont(ofSize: 23)
        problemLabel.text = "Проблема"
        problemLabel.sizeToFit()
        view.addSubview(problemLabel)
        yLabel += problemLabel.frame.height + 10
    }
    
    func setupProblem(problem: String) {
        let textView = UITextView()
        textView.frame = CGRect(x: contWidth,
                                y: yLabel,
                                width: view.bounds.width - contWidth * 2,
                                height: view.bounds.height / 4.5)
        textView.backgroundColor = UIColor(red: 0.8, green: 0.894, blue: 1, alpha: 1)
        textView.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        textView.layer.cornerRadius = 18
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.text = problem
        textView.isEditable = false
        view.addSubview(textView)
        yLabel += textView.frame.height + 20
    }
    
    func setupSolutionLabel() {
        let solutionLabel = UILabel()
        solutionLabel.frame = CGRect(x: contWidth, y: yLabel, width: view.bounds.width - contWidth * 2, height: 0)
        solutionLabel.font = UIFont.boldSystemFont(ofSize: 23)
        solutionLabel.text = "Решение"
        solutionLabel.sizeToFit()
        view.addSubview(solutionLabel)
        yLabel += solutionLabel.frame.height + 10
    }
    
    func setupSulution() {
        textView.frame = CGRect(x: contWidth,
                                y: yLabel,
                                width: view.bounds.width - contWidth * 2,
                                height: view.bounds.height / 5.5)
        textView.backgroundColor = UIColor(red: 0.949, green: 0.953, blue: 0.961, alpha: 1)
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.layer.cornerRadius = 18
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.delegate = self
        textView.text = "Введите текст"
        textView.textColor = UIColor.lightGray
        view.addSubview(textView)
        yLabel += textView.frame.height + 15
    }
    
    func setupNextButton() {
        nextButton.setTitle("Далее", for: .normal)
        nextButton.layer.cornerRadius = 10
        nextButton.layer.borderWidth = 0
        nextButton.backgroundColor = UIColor(red: 0.27, green: 0.373, blue: 0.913, alpha: 1)
        nextButton.setTitleColor(.gray, for: .highlighted)
        nextButton.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        view.addSubview(nextButton)
    }
    
    // MARK: functions for UI elements
    
    @objc
    func pressedButton() {
        timer?.invalidate()
        textView.resignFirstResponder()
        //print("go to next card")
        let alert = UIAlertController(title: "Готово!", message:"Передайте телефон следующему игроку", preferredStyle: .alert)

        let action = UIAlertAction(title: "Начать", style: .default) { _ in
            self.output.openNextScreen(solution: self.textView.text)
        }
        alert.addAction(action)
        addBlur()
        self.present(alert, animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y += (view.bounds.height - keyboardSize.height - yLabel)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc
    func onTimerFires() {
        timeLeft -= 1
        timeLabel.text = "\(timeLeft)"
        timeLabel.sizeToFit()
        
        if timeLeft <= 0 {
            timer?.invalidate()
            showAlert()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "time is over", message:"Передайте телефон следующему игроку", preferredStyle: .alert)

        let action = UIAlertAction(title: "Начать", style: .default) { _ in
            self.output.openNextScreen(solution: self.textView.text)
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
        blurEffectView.tag = 55
        view.addSubview(blurEffectView)
    }
    
    func deleteBlur() {
        UIView.animate(withDuration: 0.25) {
            self.view.viewWithTag(55)?.alpha = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.resignFirstResponder()
    }
}

extension TeammateCardSolutionViewController: TeammateCardSolutionViewInput {
}

// MARK: extensions

extension TeammateCardSolutionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Введите текст"
            textView.textColor = UIColor.lightGray
        }
    }
}
