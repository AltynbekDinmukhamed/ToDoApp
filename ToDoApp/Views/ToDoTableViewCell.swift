//
//  ToDoTableViewCell.swift
//  ToDoApp
//
//  Created by Димаш Алтынбек on 02.11.2023.
//

import Foundation
import UIKit
import SnapKit

class ToDoTableViewCell: UITableViewCell {
    //MARK: -Variable-
    let leftImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "list.dash.header.rectangle")
        img.tintColor = .systemGray
        img.clipsToBounds = true
        img.layer.cornerRadius = img.frame.height / 2
        return img
    }()
    
    let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Finish first task"
        lbl.font = .systemFont(ofSize: 20, weight: .heavy)
        lbl.textColor = .black
        return lbl
    }()
    
    let subAmountbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Finish first task"
        lbl.font = .systemFont(ofSize: 10, weight: .light)
        lbl.textColor = .black
        return lbl
    }()
    
    let threeSomeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        btn.tintColor = .systemGray
        return btn
    }()
    
    //MARK: -LifeCycle-
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: -functions-
}
extension ToDoTableViewCell {
    private func setUpViews() {
        addSubview(leftImage)
        addSubview(nameLbl)
        addSubview(subAmountbl)
        addSubview(threeSomeBtn)
    }
    
    private func setUpConstraints() {
        leftImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
        }
        
        nameLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalTo(leftImage.snp.trailing).offset(10)
        }
        
        subAmountbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(2)
            make.leading.equalTo(leftImage.snp.trailing).offset(10)
        }
        threeSomeBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailingMargin.equalToSuperview().offset(-10)
        }
    }
}
