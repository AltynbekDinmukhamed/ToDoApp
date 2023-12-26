//
//  TimerView.swift
//  ToDoApp
//
//  Created by Димаш Алтынбек on 26.12.2023.
//

import Foundation
import SnapKit

protocol TimerViewDelegate: AnyObject {
    func timerViewDidTap(_ timerView: TimerView)
}

class TimerView: UIView {
    //MARK: -Variables
    private var timer: Timer?
    private var duration: TimeInterval?
    private let shapeLayer = CAShapeLayer()
    private let timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.text = String(format: "00:00:00")
        lbl.font = UIFont.systemFont(ofSize: 20)
        return lbl
    }()
    
    weak var delegate: TimerViewDelegate?
    //MARK: -LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
        setupShapeLayer()
        setupTapGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        
    }
    //MARK: -Functions
    private func setupShapeLayer() {
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1 // it's like a alpha but for CAShapeLayer()
        layer.addSublayer(shapeLayer)
    }
    
    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
    }

    func startTimer(duration: TimeInterval) {
        self.duration = duration
        startAnimations(duration: duration)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc private func updateTimer() {
        guard let duration = duration else { return }
        
        self.duration! -= 1
        
        if self.duration! <= 0 {
            timer?.invalidate()
            DispatchQueue.main.async {
                self.timeLabel.text = "00:00:00"
                // Таймер окончен. Действия после завершения таймера.
            }
        } else {
            let progress = self.duration! / duration
                DispatchQueue.main.async {
                
                    let hours = Int(self.duration!) / 3600
                    let minutes = Int(self.duration!) / 60 % 60
                    let seconds = Int(self.duration!) % 60
                    self.timeLabel.text = String(format: "%02i:%02i:%02i", hours, minutes, seconds)
            }
        }
    }
    
    private func startAnimations(duration: TimeInterval) {
        // Анимация уменьшения
        let shrinkAnimation = CABasicAnimation(keyPath: "strokeEnd")
        shrinkAnimation.fromValue = 1
        shrinkAnimation.toValue = 0
        shrinkAnimation.duration = duration
        shrinkAnimation.isRemovedOnCompletion = false
        shrinkAnimation.fillMode = .forwards
        
        // Анимация изменения цвета
        let colorChangeAnimation = CAKeyframeAnimation(keyPath: "strokeColor")
        colorChangeAnimation.values = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor]
        colorChangeAnimation.duration = duration
        colorChangeAnimation.isRemovedOnCompletion = false
        colorChangeAnimation.fillMode = .forwards

        shapeLayer.add(shrinkAnimation, forKey: "shrinkAnimation")
        shapeLayer.add(colorChangeAnimation, forKey: "colorChangeAnimation")
    }
    func stopTimer() {
            timer?.invalidate()
            timer = nil
            shapeLayer.strokeEnd = 1
            timeLabel.text = "00:00:00"
            // Вы можете добавить здесь любые другие действия, необходимые при остановке таймера
    }
}

//MARK: -extension-
extension TimerView {
    private func setUpViews() {
        addSubview(timeLabel)
    }
    
    private func setUpConstraints() {
        timeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension TimerView {
    @objc func handleTap(_ gesture: UIGestureRecognizer) {
        delegate?.timerViewDidTap(self)
    }
}

