//
//  ViewController.swift
//  TableStory
//
//  Created by Morales, Raegan E on 3/20/24.
//

import UIKit
import MapKit


//array objects of our data.
let data = [
    Item(name: "Ivar's River Pub", neighborhood: "Rio Vista", desc: "Casual indoor-outdoor restaurant overlooking the river with authentic Texas comfort food and drinks.", lat: 29.87889355018527,long: -97.93198220253186, imageName: "Ivars"),
    Item(name: "Railyard Bar & Grill", neighborhood: "Downtown Association", desc: "Chill meeting spot for drinking, sports, and American pub grill, with food, beer, and bar games.", lat: 29.881457007886922, long: -97.93891992951565, imageName: "Railyard"),
    Item(name: "Industry", neighborhood: "Downtown Association", desc: "An industrial looking indoor-outdoor bar/restuarant with American cuisine along with beers & cocktails.", lat: 29.8802, long: -97.94045, imageName: "Industry"),
    Item(name: "Bull Daddies", neighborhood: "Downtown Association", desc: "Local downtown indoor-outdoor bar with picnic tables, good for sports watching, and drinking with friends.", lat: 29.884638473425937, long: -97.9409419, imageName: "BullDaddies"),
    Item(name: "Taquitos Mi Rancho", neighborhood: "Rio Vista", desc: "Enjoy riverside vibes and generous portions at the local budget-friendly taco truck. Indulge in savory tacos while soaking up the sun in the inviting outdoor seating area.", lat: 29.87884681661158, long: -97.930612775548, imageName: "Taquitos")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var theTable: UITableView!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        let item = data[indexPath.row]
        cell?.textLabel?.text = item.name

        //Add image references
                     let image = UIImage(named: item.imageName)
                     cell?.imageView?.image = image
                     cell?.imageView?.layer.cornerRadius = 10
                     cell?.imageView?.layer.borderWidth = 5
                     cell?.imageView?.layer.borderColor = UIColor.white.cgColor

        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }
    
    
    // add this function to original ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ShowDetailSegue" {
          if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
              // Pass the selected item to the detail view controller
              detailViewController.item = selectedItem
          }
      }
  }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.'
        theTable.delegate = self
        theTable.dataSource = self
        
        //set center, zoom level and region of the map
             let coordinate = CLLocationCoordinate2D(latitude: 29.88180, longitude: -97.93576)
             let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
             mapView.setRegion(region, animated: true)
             
          // loop through the items in the dataset and place them on the map
              for item in data {
                 let annotation = MKPointAnnotation()
                 let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                 annotation.coordinate = eachCoordinate
                     annotation.title = item.name
                     mapView.addAnnotation(annotation)
                     }


    }


}

