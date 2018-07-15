//
//  File.swift
//  Stores
//
//  Created by ssion on 11/4/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import Foundation
import TableKit

extension TableDirector {
    private func tableRemoveUpdate(indexPaths: [IndexPath], withUpdate animation: UITableViewRowAnimation) {
        self.tableView?.beginUpdates()
        self.tableView?.deleteRows(at: indexPaths, with: animation)
        self.tableView?.endUpdates()
    }
    
    private func tableInsertUpdate(indexPaths: [IndexPath], withUpdate animation: UITableViewRowAnimation) {
        self.tableView?.beginUpdates()
        self.tableView?.insertRows(at: indexPaths, with: animation)
        self.tableView?.endUpdates()
    }
    
    //MARK - ROWS
    @discardableResult
    open func insert(row: Row, atIndex: Int, inSection section: Int, withUpdate animation: UITableViewRowAnimation) -> Self {
        self.sections[section].insert(row: row, at: atIndex)
        let indexPath = IndexPath.init(row: atIndex, section: section)
        tableInsertUpdate(indexPaths: [indexPath], withUpdate: animation)
        return self
    }
    
    func insert<CellType>(cellType: CellType.Type,
                                            items: [CellType.CellData],
                                            inSection section: Int,
                                            withUpdate animation: UITableViewRowAnimation,
                                            configure: (Cell<CellType>)->())
                                            where CellType.CellData: DocumentIdentifiable {
        items.forEach { (item) in
            let cell = Cell<CellType>(item: item)
            configure(cell)
            insert(row: cell, atIndex: Int(cell.item.indexRow), inSection: section, withUpdate: animation)
        }
    }
    
    
    @discardableResult
    open func append(rows: [Row], inSection section: Int, withUpdate animation: UITableViewRowAnimation) -> Self {
        var rowsCountBeforAdd = sections[section].rows.count
        sections[section].append(rows: rows)
        let indexPaths = rows.map { (row) -> IndexPath in
            rowsCountBeforAdd += 1
            return IndexPath(row: rowsCountBeforAdd, section: section)
        }
        tableInsertUpdate(indexPaths: indexPaths, withUpdate: animation)
        return self
    }
    
    @discardableResult
    open func append(row: Row, inSection section: Int, withUpdate animation: UITableViewRowAnimation) -> Self {
        append(rows: [row], inSection: section, withUpdate: animation)
        return self
    }
    
    @discardableResult
    open func remove(rowsIndexes: [UInt], inSection section: Int, withUpdate animation: UITableViewRowAnimation) -> Self {
        let indexPaths = rowsIndexes.map { (index) -> IndexPath in
            sections[section].remove(rowAt: Int(index))
            return IndexPath(row: Int(index), section: section)
        }
        tableRemoveUpdate(indexPaths: indexPaths, withUpdate: animation)
        return self
    }
    
    @discardableResult
    open func remove(item: DocumentIdentifiable, inSection section: Int, withUpdate animation: UITableViewRowAnimation) -> Self {
        remove(items: [item], inSection: section, withUpdate: animation)
        return self
    }
    
    @discardableResult
    open func remove(items: [DocumentIdentifiable], inSection section: Int, withUpdate: UITableViewRowAnimation) -> Self {
        let indexPaths = items.map { (item) -> IndexPath in
            sections[section].remove(item: item)
            return IndexPath(row: Int(item.indexRow), section: section)
        }
        self.tableView?.beginUpdates()
        self.tableView?.deleteRows(at: indexPaths, with: withUpdate)
        self.tableView?.endUpdates()
        return self
    }
    
    func modify<CellType: ConfigurableCell>(cellType: CellType.Type, items: [CellType.CellData], inSection section: Int)
        where CellType: UITableViewCell, CellType.CellData: DocumentIdentifiable {
            sections[section].modify(cellType: cellType, items: items)
    }
    
    func item<CellType: ConfigurableCell>(forCellType: CellType.Type, inSection section: Int, rowIndex row: Int) -> CellType.CellData?
        where CellType: UITableViewCell, CellType.CellData: DocumentIdentifiable {
        let cell = sections[section].rows[row] as? Cell<CellType>
        return cell?.item
    }
    
    //MARK - Sections
    @discardableResult
    open func append(section: TableSection, withUpdate: UITableViewRowAnimation) -> Self {
        
        append(sections: [section], withUpdate: withUpdate)
        return self
    }
    
    @discardableResult
    open func append(sections: [TableSection], withUpdate: UITableViewRowAnimation) -> Self {
        let countSectionsBeforAppend = self.sections.count
        append(sections: sections)
        let indexPaths = makeIndexPathsFor(sections: sections, indexStart: countSectionsBeforAppend)
        self.tableView?.beginUpdates()
        self.tableView?.insertSections(NSIndexSet(indexesIn: NSMakeRange(countSectionsBeforAppend, self.sections.count)) as IndexSet, with: withUpdate)
        self.tableView?.insertRows(at:indexPaths, with: withUpdate)
        self.tableView?.endUpdates()
        return self
    }
    
    @discardableResult
    open func insert(section: TableSection, atIndex index: Int, withUpdate: UITableViewRowAnimation) -> Self {
        insert(section: section, atIndex: index)
        let indexPaths = makeIndexPathsFor(sections: sections, indexStart: index)
        self.tableView?.beginUpdates()
        self.tableView?.insertSections(NSIndexSet(index: index) as IndexSet, with: withUpdate)
        self.tableView?.insertRows(at:indexPaths, with: withUpdate)
        self.tableView?.endUpdates()
        
        return self
    }

//    @discardableResult
//    open func replaceSection(at index: Int, with section: TableSection, withUpdate: UITableViewRowAnimation) -> Self
//    {
//        replaceSection(at: index, with: section)
//        self.tableView?.beginUpdates()
//        self.tableView?.reloadSections(NSIndexSet(index: index) as IndexSet, with: withUpdate)
//        self.tableView?.endUpdates()
//        return self
//    }
    
    @discardableResult
    open func delete(sectionAt index: Int, withUpdate: UITableViewRowAnimation) -> Self {
        delete(sectionAt: index)
        self.tableView?.beginUpdates()
        self.tableView?.deleteSections(NSIndexSet(index: index) as IndexSet, with: withUpdate)
        self.tableView?.endUpdates()
        return self
    }
 
    private func makeIndexPathsFor(sections: [TableSection], indexStart: Int) -> [IndexPath] {
        var indexPaths: [IndexPath] = []
        for iSection in 0..<sections.count {
            for iRow in 0..<sections[iSection].rows.count {
                indexPaths.append(IndexPath(row: iRow, section: indexStart + iSection))
            }
        }
        return indexPaths
    }
}

extension TableSection {
    open func remove(item: DocumentIdentifiable) {
        self.remove(rowAt: Int(item.indexRow))
    }
    
    func modify<CellType: ConfigurableCell>(cellType: CellType.Type, item: CellType.CellData) where CellType: UITableViewCell, CellType.CellData: DocumentIdentifiable {
        modify(cellType: cellType, items: [item])
    }
    
    func modify<CellType: ConfigurableCell>(cellType: CellType.Type, items: [CellType.CellData]) where CellType: UITableViewCell, CellType.CellData: DocumentIdentifiable {
        items.forEach { (item) in
            let cell = rows[Int(item.indexRow)] as! Cell<CellType>
            cell.configure(with: item)
        }
    }
}



public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}
