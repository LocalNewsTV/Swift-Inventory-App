//
//  Lab1_2023UITests.swift
//  Lab1_2023UITests
//
//  Created by ICS 224 on 2023-01-11.
//

import XCTest

final class Lab1_2023UITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCharCount() throws {
        let app = XCUIApplication()
        app.launch()
        app.collectionViews.buttons.firstMatch.tap()
        let detailText = app.staticTexts["DetailText"]
        XCTAssertEqual(detailText.label, "4/150")
        
        let detailTextEditor = app.textViews["DetailTextEditor"]
        detailTextEditor.tap()
        
        let keyH = app.keys["H"]
        keyH.tap()
        XCTAssertTrue(detailText.waitForExistence(timeout: 5))
        XCTAssertEqual(detailText.label, "5/150")
        
        let keyi = app.keys["i"]
        keyi.tap()
        XCTAssertEqual(detailText.label, "6/150")
    }
    func testCharLimits() throws {
        let app = XCUIApplication()
        app.launch()
        app.collectionViews.buttons.firstMatch.tap()
        let detailText = app.staticTexts["DetailText"]
        //        XCTAssertEqual(detailText.label, "0/150")
        
        let detailTextEditor = app.textViews["DetailTextEditor"]
        detailTextEditor.tap()
        
        let keyH = app.keys["H"]
        let keyE = app.keys["e"]
        keyH.tap()
        keyE.tap()
        
        //        XCTAssertEqual(detailText.label, "2/150")
        var manyY = ""
        for _ in 0...450{
            manyY += "y"
        }
        detailTextEditor.typeText(manyY)
        XCTAssertTrue(detailText.waitForExistence(timeout: 5))
        XCTAssertEqual(detailText.label, "150/150")
    }
    func testStepperFunctionality() throws {
        //Grab all relevent component references
        let app = XCUIApplication()
        let detailText = app.staticTexts["DetailText"]
        let settingsToggle = app.buttons["NavigationButton"]
        let detailTextEditor = app.textViews["DetailTextEditor"]
        let back = app.buttons["Back"]
        //        app.collectionViews.buttons.firstMatch.tap()
        
        app.launch()
        
        //toggle into settings and bring attempt bringing stepper below minimum value
        settingsToggle.tap()
        while app.steppers["MaxCountStepper"].label != "Value: 10"{
            app.steppers["MaxCountStepper"].buttons["Decrement"].tap()
        }
        app.steppers["MaxCountStepper"].buttons["Decrement"].tap()
        settingsToggle.tap()
        app.collectionViews.buttons.firstMatch.tap()
        XCTAssertEqual(detailText.label, "4/10")
        
        //relaunch app to verify changes remained
        app.terminate()
        app.launch()
        app.collectionViews.buttons.firstMatch.tap()
        XCTAssertEqual(detailText.label, "4/10")
        
        //test new character limit is in effect
        detailTextEditor.tap()
        detailTextEditor.typeText("Testing 10 character Limit")
        XCTAssertEqual(detailText.label, "10/10")
        back.tap()
        settingsToggle.tap()
        
        //attempt to bring stepper above maxiumum value
        while app.steppers["MaxCountStepper"].label != "Value: 300"{
            print(app.steppers["MaxCountStepper"].label)
            app.steppers["MaxCountStepper"].buttons["Increment"].tap()
        }
        app.steppers["MaxCountStepper"].buttons["Increment"].tap()
        settingsToggle.tap()
        app.collectionViews.buttons.firstMatch.tap()
        XCTAssertEqual(detailText.label, "10/300")
        back.tap()
        settingsToggle.tap()
        
        //Bring stepper back to 150
        while app.steppers["MaxCountStepper"].label != "Value: 150"{
            app.steppers["MaxCountStepper"].buttons["Decrement"].tap()
        }
        settingsToggle.tap()
        app.collectionViews.buttons.firstMatch.tap()
        XCTAssertEqual(detailText.label, "10/150")
    }
    func testFavourites(){
        let app = XCUIApplication()
        let favouriteToggle = app.switches["FavouriteToggle"]
        let back = app.buttons["Back"]
        let secondEntry = app.collectionViews.buttons.element(boundBy: 1)
        let thirdEntry = app.collectionViews.buttons.element(boundBy: 2)
        app.launch()
        
        app.collectionViews.buttons.firstMatch.tap()
        favouriteToggle.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "1") // 1 == enabled
        back.tap()
        //Check second item is not fave'd
        secondEntry.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "0")
        back.tap()
        //Fave third item in list
        thirdEntry.tap()
        favouriteToggle.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "1")
        back.tap()
        //Check second entry still not triggered
        secondEntry.tap()
        XCTAssertEqual(favouriteToggle.value as? String, "0")
        back.tap()
        
    }
}
