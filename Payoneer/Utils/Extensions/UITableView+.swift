//
//  UITableView+.swift
//  Payoneer
//
//  Created by Rotimi Joshua on 06/05/2021.
//

import UIKit

extension UITableView {
    func dequeueCellAtIndexPath<T: UITableViewCell>(indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: T.identity, for: indexPath) as? T {
            return cell
        } else {
            fatalError("cell with \"\(T.identity)\" identifier is not registered!")
        }
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        if let view = dequeueReusableHeaderFooterView(withIdentifier: T.identity) as? T {
            return view
        } else {
            fatalError("cell with \"\(T.identity)\" identifier is not registered!")
        }
    }

    func firstCell() -> UITableViewCell? {
        return cellForRow(at: IndexPath(row: 0, section: 0))
    }
}
