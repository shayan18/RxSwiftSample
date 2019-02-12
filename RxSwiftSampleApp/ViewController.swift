//
//  ViewController.swift
//  RxSwiftSampleApp
//
//  Created by mac on 1/16/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController {
    @IBOutlet weak var favSwitch: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTerm: UITextField!
    fileprivate let bag = DisposeBag()

    fileprivate let dataList = ["daniyal","shayan","farooq","mk","shiraz","babar","ali","waqas"]

    fileprivate let allPersons = Variable<[Person]>([])
    fileprivate let filteredPersons = Variable<[Person]>([])

    override func viewDidLoad() {
        super.viewDidLoad()

        allPersons.value = dataList.enumerated().map{ index, name in
            return Person(name: name, isfavorite: index % 2 == 0)

        }


 bindUI()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func shouldDisplayPerson(person:Person, onlyFav: Bool, search: String) -> Bool {
        if onlyFav {
            if !search.isEmpty {
               return person.name.contains(search)

            }
            return person.isFavorite == onlyFav
        }

        else {
            if !search.isEmpty {
                return person.name.contains(search)
            }
            else {
               filteredPersons.value  = allPersons.value
                return true

            }

        }

    }

    func bindUI()  {

        Observable.combineLatest(allPersons.asObservable(),
                                 favSwitch.rx.isOn,
                                 searchTerm.rx.text,
                                 resultSelector:{  currentPersons, onlyFavorites, search in

                                  return  currentPersons.filter{ person -> Bool in

                                  return  self.shouldDisplayPerson(person: person, onlyFav: onlyFavorites, search: search!)
//                                    if onlyFavorites {
//
//                                        return  person.isFavorite == true
//                                    }
                                      // return person.name.contains(search!)

                                    }

        } )
            .bind(to: filteredPersons)
        .disposed(by: bag)

        filteredPersons.asObservable()
            .subscribe(onNext: { [weak self] value in
                self?.tableView.reloadData()

            })
        .disposed(by: bag)

    }

}


extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return filteredPersons.value.count > 0 ? filteredPersons.value.count : allPersons.value.count

        return filteredPersons.value.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "namesCell") as! NamesCell
                   cell.person = filteredPersons.value[indexPath.row]

//        if filteredPersons.value.count > 0 {
//            cell.person = filteredPersons.value[indexPath.row]
//
//        }
//        else {
//            cell.person = allPersons.value[indexPath.row]
//
//        }
        return cell
    }
}
