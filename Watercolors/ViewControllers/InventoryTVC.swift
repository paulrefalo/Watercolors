//
//  InventoryTVC.swift
//  Watercolors
//
//  Created by Paul Refalo on 4/10/17.
//  Copyright © 2017 ReFalo. All rights reserved.
//

import UIKit
import CoreData
class InventoryTVC: UITableViewController, NSFetchedResultsControllerDelegate {

var managedContext: NSManagedObjectContext!
        // MARK: - Properties
    var fetchedResultsController : NSFetchedResultsController<Paint>!
 // MARK: - IBOutlets
    @IBOutlet var inventorySegmentedControl: UISegmentedControl!

    @IBAction func inventoryControlPressed(_ sender: Any) {
    }

        // MARK: - View Life Cycle
        func initializeFetchedResultsController() {
            let request = NSFetchRequest<Paint>(entityName: "Paint")
            let pigmentSort = NSSortDescriptor(key: "paint_name", ascending: true)
            request.sortDescriptors = [pigmentSort]
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self

            do {
                try fetchedResultsController.performFetch()
            } catch {
                fatalError("Failed to initialize FetchedResultsController: \(error)")
            }
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem()
            self.initializeFetchedResultsController()
        }




        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        // MARK: - Table view data source

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryPaintCell", for: indexPath) as! InventoryTableViewCell

            // Set up the cell
            guard let object = self.fetchedResultsController?.object(at: indexPath) else {
                fatalError("Attempt to configure cell without a managed object")
            }

            let this_paint = object as Paint
            let image_name = String(stringInterpolationSegment: this_paint.paint_number)
            cell.swatchImageView.image = UIImage(named: image_name )
            cell.nameLabelOutlet.text = this_paint.paint_name

            if this_paint.have == true {
                cell.haveImageView.image = UIImage(named: "Have")

            } else {
 cell.haveImageView.image = UIImage(named: "Have-Not")
            }

            if this_paint.need == true {
                cell.needImageView.image = UIImage(named: "Need")

            } else {
                cell.needImageView.image = UIImage(named: "Need-Not")
            }



            //Populate the cell from the object
            return cell
        }

        override func numberOfSections(in tableView: UITableView) -> Int {
            return fetchedResultsController.sections!.count
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            guard let sections = fetchedResultsController.sections else {
                fatalError("No sections in fetchedResultsController")
            }
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80.0
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
}
