//
//  HeroesTablePresenter.swift
//  Heroes_MVP(UIKit)
//
//  Created by Nikos Galinos,   on 27/6/23.
//

import Foundation
import PromiseKit

protocol HeroesPresenterDelegate: AnyObject {
    // These method allow the presenter to inform the view controller about the list of heroes retrieved from the API
    func presentHero (hero: [SuperHero])
}

/* This means that any class conforming to
 HeroesPresenterDelegate must also be a subclass
 of UIViewController and implement the methods defined in UserHeroesPresenterDelegate.
 */

class HeroTablePresenter {
    weak var delegate: HeroesPresenterDelegate?
    var superHeroList: [SuperHero] = []
    var heroesService: HeroesServiceProtocol!
    // we dependency inject (DI) the HeroesService()
    init(heroesService: HeroesServiceProtocol = HeroesService()) {
        self.heroesService = heroesService
    }
    // I created the fetchData function beacause we have to
    // call the API 100 times in order to get the whole list of heroes
    func fetchData () {
        firstly {
            when(fulfilled: (1...100).map { iii in
                heroesService.getSuperHero(id: String(iii))
            })
        }.done { heroes in
            for hero in heroes {
                self.superHeroList.append(hero)
            }
            self.superHeroList.sort { Int($0.id)! < Int($1.id)! }
            self.delegate?.presentHero(hero: self.superHeroList)
        }.catch { _ in
            // Handle error
        }
    }
}
