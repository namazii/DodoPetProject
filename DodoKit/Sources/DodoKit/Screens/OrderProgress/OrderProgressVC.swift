//
//  OrderProgressVC.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 14.12.2022.
//

import UIKit
import SnapKit

final class OrderProgressVC: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        label.text = "Готовим"
        
        return label
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(frame: .zero)
        
        progressView.progressViewStyle = .default
        progressView.setProgress(0.0, animated: false)
        progressView.progressTintColor = UIColor.tabBarItemAccent
        
        return progressView
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 40)
        
        return label
    }()
    
    private let typingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.textAlignment = .center
        label.textColor = .black
        label.text = ""
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
        
        return label
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton(frame: .zero)
        
        button.setTitle("Закрыть", for: .normal)
        button.isHidden = true
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 1, green: 0.4541721344, blue: 0.01430354454, alpha: 1)
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let typingstring = "Приятного аппетита"
    private var seconds = 59
    private var minutes = 14
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
        
        createDisplayLink()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        exitButton.layer.cornerRadius = exitButton.bounds.height / 2
    }
        
    //MARK: - Actions
    @objc private func runTimer(displayLink: CADisplayLink) {
        seconds -= 1
        progressView.setProgress(progressView.progress + 0.00114, animated: true)
        
        if seconds == 0 {
            if minutes == 0 {
                titleLabel.animateViewPress()
                titleLabel.text = "Поддано"
                displayLink.invalidate()
                timerLabel.text = "\(minutes) : \(seconds)"
                typingText()
                exitButton.isHidden = false
                exitButton.animateViewPress()
            } else {
                minutes -= 1
                seconds = 59
            }
        }
        timerLabel.text = "\(minutes) : \(seconds)"
    }
    
    @objc private func exitButtonTapped() {
        dismiss(animated: true)
    }
    
    private func createDisplayLink() {
        let displayLink = CADisplayLink(target: self, selector: #selector(runTimer))
        displayLink.add(to: .current, forMode: .default)
        displayLink.preferredFramesPerSecond = 50
    }
    
    private func typingText() {
        guard var text = typingLabel.text else { return }

        for char in typingstring {
            text += "\(char)"
            typingLabel.text = text
            RunLoop.current.run(until: Date() + 0.15)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Заказ №42 в 14:02"
        timerLabel.text = "\(minutes) : \(seconds)"
    }
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(progressView)
        view.addSubview(timerLabel)
        view.addSubview(typingLabel)
        view.addSubview(exitButton)
    }
}

extension OrderProgressVC {
    
    private struct Appearance {
        static let leftPadding = 18
        static let topPadding = 20
        static let bottomPadding = -20
        static let timerLabelTopPadding = 40
        static let exitButtonHeight = 0.07
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Appearance.topPadding)
            make.leading.trailing.equalToSuperview().inset(Appearance.leftPadding)
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Appearance.leftPadding)
            make.leading.trailing.equalToSuperview().inset(Appearance.leftPadding)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(Appearance.timerLabelTopPadding)
            make.leading.trailing.equalToSuperview().inset(Appearance.leftPadding)
        }
        
        typingLabel.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(Appearance.topPadding)
            make.leading.trailing.equalToSuperview().inset(Appearance.leftPadding)
        }
        
        exitButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(Appearance.bottomPadding)
            make.leading.equalToSuperview().offset(Appearance.topPadding)
            make.trailing.equalToSuperview().offset(Appearance.bottomPadding)
            make.height.equalToSuperview().multipliedBy(Appearance.exitButtonHeight)
        }
    }
}
