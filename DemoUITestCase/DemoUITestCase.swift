//
//  DemoUITestUITests.swift
//  DemoUITestUITests
//
//  Created by Bhumika Patel on 22/06/17.
//  Copyright © 2017 Bhumika Patel. All rights reserved.
//

import XCTest
import Foundation

extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        
        let deleteString = stringValue.characters.map { _ in XCUIKeyboardKeyDelete }.joined(separator: "")
        
        self.typeText(deleteString)
        self.typeText(text)
        self.typeText("\n")
    }
}

class DemoUITestCase: UITestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testADashboard()
    {
        
        waitForElementToAppear(app.images["Team"])
        
        XCTAssert(app.images["Team"].exists)
       
        XCTAssert(app.staticTexts["Teamwork is the ability to work together toward a common vision"].exists)

        XCTAssertEqual(app.tables.cells.count, 2)
        
        app.buttons["More Info"].tap()
        
        
        sleep(15)
        waitForElementToAppear(app.webViews.staticTexts["Team"])
        XCTAssert(app.webViews.staticTexts["Team"].exists)
        
        
        

        
    }
    func testBNewRecord()
    {
        
        waitForElementToAppear(app.images["Team"])
        
        XCTAssert(app.images["Team"].exists)
        
        XCTAssert(app.staticTexts["Teamwork is the ability to work together toward a common vision"].exists)
        
        XCTAssertEqual(app.tables.cells.count, 2)
        
        app.tables.cells.staticTexts["Add New Team"].tap() //tap on table first cell
        
    
        waitForElementToAppear(app.textFields ["Team Name"]) // wait for controller to be appeared
        
        XCTAssertEqual(app.textFields.count, 3)  //check the UI bt counting the textfields

        
        app.textFields["Team Name"].clearAndEnterText(text: "TeamB")  // clear text and enter value
        
        app.textFields["Department"].clearAndEnterText(text:"IT")
        
        app.buttons["btnCountry"].tap() // we have one button above the country textfield  we will tap that for country list
        
        
        waitForElementToAppear(app.alerts["Choose distance"]) //wait for list to be appeared

        let chooseDistanceAlert = app.alerts["Choose distance"] //choose value from list
        
        chooseDistanceAlert.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "INDIA")
        chooseDistanceAlert.buttons["Done"].tap()
        
        XCTAssertEqual(app.textFields["Country"] .value as! String, "INDIA") //check the value of textfield is equal to selected value from list
        
        app.sliders["SliderSize"].adjust(toNormalizedSliderPosition: 0.6) //choose value from slider
        
        sleep(2) //pause for 2 minutew
        
        XCTAssert(app.staticTexts ["6 Team Size"].exists) //check the size vvalue is equal to slider value
        
        app.buttons["Submit"].tap()
        
        waitForElementToAppear(app.alerts["Great!"])
        app.alerts["Great!"].buttons["OK"].tap() //tap submit button to record data
        sleep(5)
        waitForElementToAppear(app.images["Team"])


    }
    
    func testCManageRecord()
    {
        
        waitForElementToAppear(app.images["Team"])
        
        XCTAssert(app.images["Team"].exists)
        
        XCTAssert(app.staticTexts["Teamwork is the ability to work together toward a common vision"].exists)
        
        XCTAssertEqual(app.tables.cells.count, 2)
        
        app.tables.cells.staticTexts["Manage Team"].tap() //tap on table first cell
        
        waitForElementToAppear(app.tables.cells.staticTexts["INDIA"])
        XCTAssert(app.tables.cells.element(boundBy: 0).staticTexts.matching(NSPredicate(format: "label CONTAINS 'TeamB'")).element(boundBy: 0).exists)// check the first index of table view contain team word using NSPredicate
        
        
        app.tables.cells.element(boundBy: 0).swipeLeft()
        app.tables.cells.element(boundBy: 0).buttons["Delete"].tap()
        
      //  XCTAssert(app.tables.cells.element(boundBy: 0).staticTexts.matching(NSPredicate(format: "label CONTAINS 'TeamA'")).element(boundBy: 0).exists)// check the first index of table view contain team word using NSPredicate


        
    }
    
}
