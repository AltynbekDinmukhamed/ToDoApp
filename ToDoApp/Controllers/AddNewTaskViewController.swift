//
//  AddNewTaskViewController.swift
//  ToDoApp
//
//  Created by Димаш Алтынбек on 03.11.2023.
//

import Foundation
import UIKit
import SnapKit

class AddNewTaskViewController: UIViewController {
    //MARK: -Varibeles-
    let taskLblTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter your task"
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.black.cgColor
        txt.layer.cornerRadius = 10
        txt.font = .systemFont(ofSize: 30, weight: .bold)
        return txt
    }()
    
    let subTitleTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter your task"
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.black.cgColor
        txt.layer.cornerRadius = 10
        txt.font = .systemFont(ofSize: 30, weight: .bold)
        return txt
    }()
    
    let picker: UIDatePicker = {
        let pick = UIDatePicker()
        pick.datePickerMode = .date
        pick.preferredDatePickerStyle = .wheels
        return pick
    }()
    
    lazy var imgPickBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Choose image", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        btn.addTarget(self, action: #selector(choseImgTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var addBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add new Task", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor.black.cgColor
        btn.addTarget(self, action: #selector(didAddTapped), for: .touchUpInside)
        return btn
    }()
    //MARK: -LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
    }
    //MARK: -Functions-
    private func saveTask(task: TaskData) {
        var tasks = getTask()
        
        tasks.append(task)
        do {
            let data = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(data, forKey: "tasks")
        }catch{
            print("Unable to encode tasks (\(error))")
        }
    }
    
    private func getTask() -> [TaskData] {
        if let data = UserDefaults.standard.data(forKey: "tasks") {
            do {
                let task = try JSONDecoder().decode([TaskData].self, from: data)
                return task
            } catch {
                print("Unable to decode tasks (\(error))")
            }
        }
        return []
    }
}

//MARK: -Exntension with objc func-
extension AddNewTaskViewController {
    @objc func didAddTapped(_ sender: UIButton) {
        guard let titl = taskLblTextField.text, !titl.isEmpty, let subtitle = subTitleTextField.text, !subtitle.isEmpty else {
            print("Task title or subtitle is empty")
            return
        }
        
        let newTask = TaskData(title: titl, subtitle: subtitle, date: picker.date, image: nil)
        saveTask(task: newTask)
        
        let vc = ViewController()
        vc.modelData = [newTask]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func choseImgTapped(_ sender: UIButton) {
        
    }
}

//MARK: -Exntesion-
extension AddNewTaskViewController {
    private func setUpViews() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        view.addSubview(taskLblTextField)
        view.addSubview(subTitleTextField)
        view.addSubview(picker)
        view.addSubview(imgPickBtn)
        view.addSubview(addBtn)
    }
    
    private func setUpConstraints() {
        taskLblTextField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(35)
        }
        
        subTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(taskLblTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(35)
        }
        
        picker.snp.makeConstraints { make in
            make.top.equalTo(subTitleTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(150)
        }
        imgPickBtn.snp.makeConstraints { make in
            make.top.equalTo(picker.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(60)
        }
        addBtn.snp.makeConstraints { make in
            make.top.equalTo(imgPickBtn.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(60)
        }
    }
}
