//
//  ChooseMealsViewController.swift
//  MealPlanner
//
//  Created by Eleni Georgiou on 6/27/18.
//  Copyright © 2018 Eleni Georgiou. All rights reserved.
//

import Foundation
import UIKit

class ChooseMealsController: UITableViewController {
    @IBOutlet var choosemeals: [UITableViewCell]!
    var breakfast = MealPlanDao.getBreakfastOptions()
    var lunch = MealPlanDao.getLunchOptions()
    var dinner = MealPlanDao.getDinnerOptions()
    var breakfastMeal: Meal = Meal()
    var lunchMeal: Meal = Meal()
    var dinnerMeal: Meal = Meal()
    var chosenMeals: [Meal] = [Meal]()
   
    override func viewDidAppear(_ animated: Bool) {
        breakfast = MealPlanDao.getBreakfastOptions()
        lunch = MealPlanDao.getLunchOptions()
        dinner = MealPlanDao.getDinnerOptions()
        self.tableView.reloadData()
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        
        self.clearsSelectionOnViewWillAppear = false
        super.viewDidLoad()
        //self.clearsSelectionOnViewWillAppear = false
        
        // Do any additional setup after loading the view.
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section == 0) {
            return breakfast.count
        }
        if (section == 1) {
            return lunch.count
        }
        if (section == 2) {
            return dinner.count
        }
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath)
        //the right arrow
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        
        // Configure the cell...
        if (indexPath.section == 0) {
            cell.textLabel?.text = self.breakfast[indexPath.row].key
        }
        
        if (indexPath.section == 1) {
            cell.textLabel?.text = self.lunch[indexPath.row].key
        }
        
        if (indexPath.section == 2) {
            cell.textLabel?.text = self.dinner[indexPath.row].key
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var mealType = ""
        
        if (section == 0) {
            mealType = "Day 1 : Breakfast"
        }
        
        if (section == 1) {
            mealType = "Day 1 : Lunch"
        }
        
        if (section == 2) {
            mealType = "Day 1 : Dinner"
        }
        
        return mealType
    }
    
    //be able to check the boxes
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
//            if cell.accessoryType == .checkmark {
//                cell.accessoryType = .none
//                //right arrow
//               // cell.accessoryType = .disclosureIndicator
//            } else {
//                //selected
//                cell.accessoryType = .checkmark
//            }
//        }
//
//
//    }
   
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.allowsMultipleSelection = true
       
        if indexPath.section == 0 {
            breakfastMeal = self.breakfast[indexPath.row].value
        }
        if indexPath.section == 1 {
            lunchMeal = self.lunch[indexPath.row].value
        }
        if indexPath.section == 2 {
            dinnerMeal = self.dinner[indexPath.row].value
        }
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
            for selectedIndexPath in selectedIndexPaths {
                if selectedIndexPath.section == indexPath.section {
                    tableView.deselectRow(at: selectedIndexPath, animated: true)
                }
            }
        }
        
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        chosenMeals  = [breakfastMeal, lunchMeal, dinnerMeal]
        if segue.identifier == "toMealPlan" {
                let controller = segue.destination as! MealPlanNavigationController
                print(chosenMeals)
                controller.chosenMeals = chosenMeals
                let mealView = controller.viewControllers.first as! MealPlanTableViewController
                mealView.chosenMeals = chosenMeals
            }
        if segue.identifier == "toCreateOwnMeal" {
            let controller = segue.destination as! CreateMealController
            print(chosenMeals)
            controller.chosenMeals = chosenMeals
           
            
        }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    //
    //    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    //        return 1
    //    }
    //
    //    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    //        return 2
    //    }
    //
    //    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    //        return 60
    //    }
    //
    //
    //    // MARK: UIPickerViewDelegate
    //
    //    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
    //
    //        let myView = UIView()
    //        let myImageView = UIImageView()
    //
    //        var rowString = String()
    //        switch row {
    //        case 0:
    //            rowString = "Buttermilk Pancakes"
    //            myImageView.image = UIImage(named:"pancakes.jpg")
    //        case 1:
    //            rowString = "Scrambled Eggs"
    //            myImageView.image = UIImage(named:"eggs.jpg")
    //        default:
    //            rowString = "Error: too many rows"
    //            myImageView.image = nil
    //        }
    //        let myLabel = UILabel()
    //        myLabel.text = rowString
    //
    //        myView.addSubview(myLabel)
    //        myView.addSubview(myImageView)
    //
    //        return myView
    //    }
    //
    //    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //
    //        // do something with selected row
    //    }
    //
    
}
