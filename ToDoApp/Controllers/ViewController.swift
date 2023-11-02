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
    
    //MARK: -LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpConstraints()
    }
    //MARK: -Functions-
}

//MARK: -Exntension-
extension ViewController {
    private func setUpView() {
        view.addSubview(calendatImg)
        view.addSubview(nameLbl)
        view.addSubview(taskLbl)
        view.addSubview(searchBarBtn)
    }
    
    private func setUpConstraints() {
        calendatImg.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(15)
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
        }
    }
}

