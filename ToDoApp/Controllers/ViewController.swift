//
//  ViewController.swift
//  ToDoApp
//
//  Created by Димаш Алтынбек on 02.11.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    //MARK: -Variables-
    let calendatImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "calendar.circle")
        img.tintColor = .black
        return img
    }()
    
    let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "To Do List"
        lbl.font = .systemFont(ofSize: 25, weight: .heavy)
        return lbl
    }()
    
    let taskLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "8 task, 3 completed"
        lbl.font = .systemFont(ofSize: 13, weight: .ultraLight)
        return lbl
    }()
    
    let searchBarBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    let topStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    
    let yesterdayBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Yesterday", for: .normal)
        btn.backgroundColor = .systemGray
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .black)
        btn.layer.cornerRadius = 40 / 2
        return btn
    }()
    
    let todayBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Today", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .black)
        btn.layer.cornerRadius = 40 / 2
        return btn
    }()
    
    let tomorrowBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Tomorrow", for: .normal)
        btn.backgroundColor = .systemGray
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .black)
        btn.layer.cornerRadius = 40 / 2
        return btn
    }()
    
    let table: UITableView = {
        let table = UITableView()
        table.register(ToDoTableViewCell.self, forCellReuseIdentifier: "Cell")
        table.backgroundColor = .white
        return table
    }()
    
    let addTaskBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        btn.backgroundColor = .black
        btn.tintColor = .white
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 60 / 2
        return btn
    }()
    
    //MARK: -LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setUpView()
        setUpConstraints()
    }
    //MARK: -Functions-
    
}

//MARK: -Exntension-
extension ViewController {
    private func setUpView() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        view.addSubview(calendatImg)
        view.addSubview(nameLbl)
        view.addSubview(taskLbl)
        view.addSubview(searchBarBtn)
        view.addSubview(topStack)
        topStack.addArrangedSubview(yesterdayBtn)
        topStack.addArrangedSubview(todayBtn)
        topStack.addArrangedSubview(tomorrowBtn)
        view.addSubview(table)
        view.addSubview(addTaskBtn)
    }
    
    private func setUpConstraints() {
        calendatImg.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        nameLbl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
        }
        taskLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        searchBarBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalToSuperview().offset(-5)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        topStack.snp.makeConstraints { make in
            make.top.equalTo(taskLbl.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(42)
        }
        table.snp.makeConstraints { make in
            make.top.equalTo(topStack.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        addTaskBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
    }
}
//MARK: -Extension UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoTableViewCell
        return cell
    }
}
//MARK: -Extension UITableViewDelegate-
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sections"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
