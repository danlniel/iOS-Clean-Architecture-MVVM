//
//  TVPresenter.swift
//  ExampleMVVM
//
//  Created by Daniel Sunarjo on 28/07/22.
//

import UIKit

protocol TVPresenterInterface: UITableViewDataSource, UITableViewDelegate {
    typealias TVDelegateClosure = (UITableView, UITableViewCell, IndexPath) -> Void
    typealias ScrollViewClosure = (UIScrollView) -> Void
    
    var onCellWillDisplay: TVDelegateClosure? { set get }
    var onCellWillEndDisplay: TVDelegateClosure? { set get }
    var onScrollViewDidScroll: ScrollViewClosure? { set get }
    
    func add(items: [TVItemInterface])
    func lastIndexPath() -> IndexPath
}

final class TVPresenter: NSObject, TVPresenterInterface {
    // UITableView variables
    var onCellWillDisplay: TVDelegateClosure?
    var onCellWillEndDisplay: TVDelegateClosure?
    
    // UIScrollView variables
    var onScrollViewDidScroll: ScrollViewClosure?
    
    private var section: [TVSectionInterface]
    
    override init() {
        self.section = []
    }
    
    func add(items: [TVItemInterface]) {
        for item in items {
            guard var currentSection: TVSectionInterface = getSection(index: item.section) else {
                section.append(createSection(item: item))
                continue
            }
            currentSection.items.append(item)
        }
    }
    
    func lastIndexPath() -> IndexPath {
        let lastSection: TVSectionInterface? = section.max { first, second in
            first.index < second.index
        }
        guard let _lastSection: TVSectionInterface = lastSection else {
            return IndexPath(row: 0, section: 0)
        }
        let row: Int = max(0, _lastSection.items.count - 1)
        return IndexPath(row: row, section: _lastSection.index)
    }
    
    private func createSection(item: TVItemInterface) -> TVSectionInterface {
        var newSection: TVSectionInterface = TVSection(index: item.section)
        newSection.items.append(item)
        return newSection
    }
    
    private func getSection(index: Int) -> TVSectionInterface? {
        guard let currentSection: TVSectionInterface = section.first(where: { section in
            section.index == index
        }) else { return nil }
        return currentSection
    }
    
    private func getItem(indexPath: IndexPath) -> TVItemInterface? {
        guard let tvSection: TVSectionInterface = getSection(index: indexPath.section),
              let tvItem: TVItemInterface = tvSection.items[safe: indexPath.row]
        else { return nil }
        return tvItem
    }
}

extension TVPresenter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tvSection: TVSectionInterface = getSection(index: section) else { return 0 }
        return tvSection.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tvItem: TVItemInterface = getItem(indexPath: indexPath) else { return EmptyTVItem() }
        tvItem.setupLayout(tableViewSize: tableView)
        return tvItem.asCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Not implemented yet
        return nil
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        // Not implemented yet
        return nil
    }
}

extension TVPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Implemented select on TVItem here
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        onCellWillDisplay?(tableView, cell, indexPath)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        onCellWillEndDisplay?(tableView, cell, indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let tvItem: TVItemInterface = getItem(indexPath: indexPath) else { return 0 }
        return tvItem.heightCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // Not implemented yet
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Not implemented yet
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Not implemented yet
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // Not implemented yet
        return nil
    }
}

extension TVPresenter: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onScrollViewDidScroll?(scrollView)
    }
}
