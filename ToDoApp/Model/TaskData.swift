//
//  TaskData.swift
//  ToDoApp
//
//  Created by Димаш Алтынбек on 03.11.2023.
//
import Foundation
import UIKit

struct TaskData: Codable {
    var title: String
    var subtitle: String
    var date: Date
    var imageData: Data?
    
    // Эта функция позволяет инициализировать TaskData с UIImage
    init(title: String, subtitle: String, date: Date, image: UIImage?) {
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.imageData = image?.jpegData(compressionQuality: 1.0)
    }
    
    // Вы можете добавить вычисляемое свойство для получения UIImage обратно из Data
    var image: UIImage? {
        if let data = imageData {
            return UIImage(data: data)
        }
        return nil
    }
}
