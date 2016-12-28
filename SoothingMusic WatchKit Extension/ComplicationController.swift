//
//  ComplicationController.swift
//  SoothingMusic WatchKit Extension
//
//  Created by Kevin Conner on 12/28/16.
//  Copyright © 2016 Kevin Conner. All rights reserved.
//

import ClockKit

final class ComplicationController: NSObject, CLKComplicationDataSource {

    // MARK: Helpers

    private var randomTitleLines: (first: String, second: String) {
        let lines = Titles.random.components(separatedBy: "\n")
        let first = 1 <= lines.count ? lines[0] : ""
        let second = 2 <= lines.count ? lines[1] : ""
        return (first: first, second: second)
    }

    private var modularLargeTemplate: CLKComplicationTemplate {
        let lines = randomTitleLines
        
        let template = CLKComplicationTemplateModularLargeStandardBody()
        template.headerTextProvider = CLKTextProvider.localizableTextProvider(withStringsFileTextKey: "Joy of Painting")
        template.body1TextProvider = CLKTextProvider.localizableTextProvider(withStringsFileTextKey: lines.first)
        template.body2TextProvider = CLKTextProvider.localizableTextProvider(withStringsFileTextKey: lines.second)
        return template
    }

    // MARK: CLKComplicationDataSource

    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
    }

    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        var template: CLKComplicationTemplate?

        if case .modularLarge = complication.family {
            template = modularLargeTemplate
        }

        let entry = template.map { CLKComplicationTimelineEntry(date: Date(), complicationTemplate: $0) }

        handler(entry)
    }

    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        var template: CLKComplicationTemplate?

        if case .modularLarge = complication.family {
            template = modularLargeTemplate
        }

        handler(template)
    }
    
}
