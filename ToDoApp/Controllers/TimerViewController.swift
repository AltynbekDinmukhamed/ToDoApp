//
//  TimerViewController.swift
//  ToDoApp
//
//  Created by Димаш Алтынбек on 26.12.2023.
//

import UIKit
import SnapKit

class TimerViewController: UIViewController {
    //MARK: -Variables
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    let timerView: TimerView = {
        let timer = TimerView()
        return timer
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Timer", for: .normal)
        button.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        return button
    }()
    
    lazy var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop Timer", for: .normal)
        button.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        return button
    }()
    
    let timePicker = UIPickerView()
    
    //MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        timerView.delegate = self
        timePicker.delegate = self
        timePicker.dataSource = self
    }
    //MARK: -Functions-

}
//MARK: -Extensions-
extension TimerViewController {
    private func setUpViews(){
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        view.addSubview(timerView)
        view.addSubview(startButton)
        view.addSubview(stopButton)
    }
    
    private func setUpConstraints() {
        timerView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(timerView.snp.bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        stopButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(startButton.snp.bottom).offset(20)
        }
    }
}
//MARK: -objc functions-
extension TimerViewController {
    @objc private func startTimer() {
        // Здесь укажите желаемую продолжительность таймера в секундах, например, 45 минут
        timerView.startTimer(duration: 45 * 60)
    }
    
    @objc private func stopTimer() {
            timerView.stopTimer()
    }
}

extension TimerViewController: TimerViewDelegate {
    func timerViewDidTap(_ timerView: TimerView) {
        let alertController = UIAlertController(title: "Set Timer", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        alertController.view.addSubview(timePicker)

        let setAction = UIAlertAction(title: "Set", style: .default) { [weak self] _ in
            let hours = self?.timePicker.selectedRow(inComponent: 0) ?? 0
            let minutes = self?.timePicker.selectedRow(inComponent: 1) ?? 0
            let totalSeconds = (hours * 3600) + (minutes * 60)
            self?.timerView.startTimer(duration: TimeInterval(totalSeconds))
        }

        alertController.addAction(setAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }
}
//MARK: -picker View delegate-
extension TimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? 24 : 60
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
}
