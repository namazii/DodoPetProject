//
//  OrderProgressVC.swift
//  
//
//  Created by Назар Ткаченко on 14.12.2022.
//

import UIKit
import SnapKit
import WebKit

final class OrderProgressVC: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25)
        label.text = "Приняли"
        
        return label
    }()
    
    private let progressView: UIProgressView = {
       let progressView = UIProgressView()
        
        progressView.progressViewStyle = .default
        progressView.setProgress(0.0, animated: false)
        progressView.progressTintColor = UIColor.tabBarItemAccent
//        progressView.trackTintColor =
        
        return progressView
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 40)
        
        return label
    }()
    
    private let typingLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.textColor = .black
        label.text = ""
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
        
        return label
    }()
    
//    lazy var playerWebView: WKWebView = {
//        let webView = WKWebView()
//
//        webView.navigationDelegate = self
//
//        return webView
//    }()
    
//    private let activeIndicator = UIActivityIndicatorView(style: .large)
//
//    private let timer = Timer.scheduledTimer(timeInterval: 1.0, target: OrderProgressVC.self, selector: #selector(runTimer), userInfo: nil, repeats: false)
    
    private let typingstring = "Оцените заказ"
    private var seconds = 59
    private var minutes = 2
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()

        createDisplayLink()
//        startPlayer()
    }
    
    private func createDisplayLink() {
        let displayLink = CADisplayLink(target: self, selector: #selector(runTimer))
        displayLink.add(to: .current, forMode: .default)
        displayLink.preferredFramesPerSecond = 10
    }
    
    //MARK: - Actions
    private func typingText() {

        guard var text = typingLabel.text else { return }

        for char in typingstring {
            text += "\(char)"
            typingLabel.text = text
            RunLoop.current.run(until: Date() + 0.15)
        }
    }
    
    @objc private func runTimer(displayLink: CADisplayLink) {
        seconds -= 1
        
        if seconds == 0 {
            if minutes == 0 {
                progressView.progress += 0.4
                titleLabel.text = "Поддано"
                displayLink.invalidate()
                timerLabel.text = "\(minutes) : \(seconds)"
                typingText()
            } else {
                titleLabel.text = "Готовим"
                minutes -= 1
                seconds = 59
                progressView.setProgress(progressView.progress + 0.3, animated: true)
            }
        }
        
        timerLabel.text = "\(minutes) : \(seconds)"
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        title = "Заказ №42 в 14:02"
        timerLabel.text = "\(minutes) : \(seconds)"
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.right.equalToSuperview().inset(18)
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.left.right.equalToSuperview().inset(18)
        }
        
        view.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(18)
        }
        
        view.addSubview(typingLabel)
        typingLabel.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(18)
        }
        
//        view.addSubview(playerWebView)
//        playerWebView.snp.makeConstraints { make in
//            make.top.equalTo(progressView.snp.bottom).offset(20)
//            make.left.right.equalToSuperview().inset(18)
//            make.height.equalToSuperview().multipliedBy(0.7)
//        }
//
//        playerWebView.addSubview(activeIndicator)
//        activeIndicator.snp.makeConstraints { make in
//            make.center.equalTo(playerWebView.snp.center)
//        }
//        activeIndicator.startAnimating()
    }
    
//    private func startPlayer() {
//        guard let url = URL(string: "https://tv.ivideon.com/camera/100-26ee075587d571e9dcf129de58e8cd61/0/?lang=ru") else { return }
//        let request = URLRequest(url: url)
//        playerWebView.load(request)
////        let queue = DispatchQueue.global(qos: .default)
////        queue.async {
////            self.playerWebView.load(request)
////        }
//    }
}

//extension OrderProgressVC: WKNavigationDelegate {
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        activeIndicator.stopAnimating()
//    }
//}
