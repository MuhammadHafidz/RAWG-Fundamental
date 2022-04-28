//
//  GameProvider.swift
//  RAWGapp
//
//  Created by Enygma System on 15/04/22.
//

import Foundation
import CoreData

class GameProvider {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RAWG")

        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil

        return container
    }()

    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil

        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }

    func getAllGames(completion: @escaping(_ games: [GameModel]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var games: [GameModel] = []
                for result in results {
                    let game = GameModel(
                        id: (result.value(forKeyPath: "id") as? Int)!,
                        name: (result.value(forKeyPath: "name") as? String)!,
                        releaseDate: (result.value(forKeyPath: "releaseDate") as? String)!,
                        rating: (result.value(forKeyPath: "rating") as? Double)!,
                        imageBackground: (result.value(forKeyPath: "imageBackground") as? String)!
                    )

                    games.append(game)
                }
                completion(games)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }

    func getGame(_ id: Int, completion: @escaping(_ game: GameModel?) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if let result = try taskContext.fetch(fetchRequest).first {
                    let game = GameModel(
                        id: (result.value(forKeyPath: "id") as? Int)!,
                        name: (result.value(forKeyPath: "name") as? String)!,
                        releaseDate: (result.value(forKeyPath: "releaseDate") as? String)!,
                        rating: (result.value(forKeyPath: "rating") as? Double)!,
                        imageBackground: (result.value(forKeyPath: "imageBackground") as? String)!
                    )
                    completion(game)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                completion(nil)
            }
        }
    }

    func createGame(_ gameData: GameDetailModel, completion: @escaping(_ success: Bool) -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Game", in: taskContext) {
                let member = NSManagedObject(entity: entity, insertInto: taskContext)
                member.setValue(gameData.id, forKey: "id")
                member.setValue(gameData.name, forKey: "name")
                member.setValue(gameData.releaseDate, forKey: "releaseDate")
                member.setValue(gameData.rating, forKey: "rating")
                member.setValue(gameData.imageBackground, forKey: "imageBackground")
                do {
                    try taskContext.save()
                    completion(true)
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                    completion(false)
                }
            }
        }
    }

    func deleteGame(_ id: Int, completion: @escaping(_ success: Bool) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }

}
