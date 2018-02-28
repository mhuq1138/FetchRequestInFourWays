//
//  DisplayViewController.swift
//  FetchRequestInFourWays
//
//  Created by Mazharul Huq on 2/24/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import UIKit
import CoreData

class DisplayViewController: UITableViewController {
    var coreDataStack:CoreDataStack!
    var fetchRequest:NSFetchRequest<Country>!
    var fetchOption = 0
    var countries:[Country] = []
    var titleString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.coreDataStack = CoreDataStack(modelName: "CountryList")

        getFetchRequest()
        do{
            countries = try coreDataStack.managedContext.fetch(fetchRequest)
        }
        catch
            let nserror  as NSError{
                print("Could not save \(nserror),(nserror.userInfo)")
        }
        self.title = self.titleString
    }
    
    
    func getFetchRequest(){
        
        switch fetchOption{
        case 0:
            self.titleString = "Using Designated Initializer"
            self.fetchRequest = NSFetchRequest()
            let entity = NSEntityDescription.entity(forEntityName: "Country", in: self.coreDataStack.managedContext)
            self.fetchRequest.entity = entity
        case 1:
            self.titleString = "Using Conveience Initializer"
            self.fetchRequest =  NSFetchRequest<Country>(entityName:"Country")
        case 2:
            self.titleString = "Using Subclass fetch() Method"
            self.fetchRequest = Country.fetchRequest()
        case 3:
            self.titleString = "Using Data Model Template"
            if let model = self.coreDataStack.managedContext.persistentStoreCoordinator?.managedObjectModel{
                self.fetchRequest = (model.fetchRequestTemplate(forName: "SimpleFetchRequest") as? NSFetchRequest<Country>)!
            }
        default:
            break
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let country = countries[indexPath.row]
        var nameString = ""
        var capitalString = ""
        
        if let name = country.name{
            nameString = name
        }
        if let capital = country.capital{
            capitalString = "Capital: \(capital)"
        }

        cell.textLabel?.text = nameString + " " + capitalString
        cell.detailTextLabel?.text = """
        Area: \(country.area) sq mi
        Population: \(country.population) millions
        """
        return cell
    }
}
