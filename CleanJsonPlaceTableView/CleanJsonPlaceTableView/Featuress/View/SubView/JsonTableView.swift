//
//  JsonTableView.swift
//  CleanJsonPlaceTableView
//
//  Created by Mehmet Nafi ISLEK on 1.07.2021.
//

import Foundation
import UIKit

protocol JsonTableViewProtocol {
    func update(items: [PostModel])
}

protocol JsonTableViewOutput: AnyObject {
    func onSelected(item: PostModel)
}

final class JsonTableView: NSObject {
    
    private lazy var items: [PostModel] = [] // çağırıldığında değer alsın diye lazy
    
    weak var delegate: JsonTableViewOutput? //çağırıldığında değer alacak
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row].title
        cell.detailTextLabel?.text = items[indexPath.row].body
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onSelected(item: items[indexPath.row])
    }
}
extension JsonTableView: UITableViewDelegate, UITableViewDataSource {}
extension JsonTableView: JsonTableViewProtocol{
    func update(items: [PostModel]) {
        self.items = items
    }
}

