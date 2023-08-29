//
//  HeroesTableRxPresenter.swift
//  Heroes_MVP(UIKit)
//
//  Created by Nikos Galinos on 28/8/23.
//

import Foundation
import PromiseKit
import RxSwift
import RxCocoa

/* We use reactive programming in order to implement our
 data flow.In this example Rx replaces the need of delegates
 */

class HeroTableRxPresenter {
    var superHeroList: [SuperHero] = []
    var superHeroes = PublishSubject<[SuperHero]>()
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
            self.superHeroes.onNext(self.superHeroList)
            self.superHeroes.onCompleted()
        }.catch { _ in
            // Handle error
        }
    }
}
