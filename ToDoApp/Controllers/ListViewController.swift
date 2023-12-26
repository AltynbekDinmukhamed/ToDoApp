//
//  ViewController.swift
//  ToDoApp
//
//  Created by Димаш Алтынбек on 02.11.2023.
//

import UIKit
import SnapKit

class ListViewController: UIViewController {
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
    
    var modelData: [TaskData] = [TaskData]()
    //MARK: -LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setUpView()
        setUpConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(newTaskAdded), name: NSNotification.Name("NewTaskAdded"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadsTasks()
    }
    //MARK: -Functions-
    private func taskForDate(_ date: Date) -> [TaskData] {
        return modelData.filter { Calendar.current.isDate($0.date, inSameDayAs: date)}
    }
    
    private func dateForSection(_ section: Int) -> Date {
        switch section {
        case 0: return Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        case 1: return Date()
        case 2: return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        default: return Date()
        }
    }
    
    private func updateTaskCount() {
        let totalTasks = modelData.count
        //let completedTask = modelData.filter { _ in }.count
        taskLbl.text = "\(totalTasks) task, 0 completed"
    }
    
    private func loadsTasks() {
        if let data = UserDefaults.standard.data(forKey: "tasks") {
            do {
                modelData = try JSONDecoder().decode([TaskData].self, from: data)
                table.reloadData()
            } catch {
                print("Unable to decode tasks (\(error))")
            }
        }
    }
    
    private func saveTasks() {
        do {
            let data = try JSONEncoder().encode(modelData)
            UserDefaults.standard.set(data, forKey: "tasks")
        } catch {
            print("Unable to encode tasks (\(error))")
        }
    }
    
}

//MARK: -Exntension-
extension ListViewController {
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
        
    }
}

//MARK: -Objc functions extension
extension ListViewController {
    @objc private func newTaskAdded() {
            loadsTasks()
        }
}

//MARK: -Extension UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = dateForSection(section)
        let task = taskForDate(date)
        return task.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoTableViewCell
        let date = dateForSection(indexPath.section)
        let tasks = taskForDate(date)
        let task = tasks[indexPath.row]
        cell.configureWith(item: task)
        return cell
    }
}
//MARK: -Extension UITableViewDelegate-
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Yesterday"
        case 1: return "Today"
        case 2: return "Tomorrow"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let date = dateForSection(indexPath.section)
            // Отфильтровать задачи для этой даты
            let taskForDates = taskForDate(date)
            // Убедиться, что индекс не выходит за пределы
            if indexPath.row < taskForDates.count {
                // Удалить задачу из общего массива
                if let index = modelData.firstIndex(where: { task in
                    task.id == taskForDates[indexPath.row].id
                }) {
                    modelData.remove(at: index)
                    saveTasks()
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

