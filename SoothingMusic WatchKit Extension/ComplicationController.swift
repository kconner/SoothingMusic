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

    private var modularLargeTemplate: CLKComplicationTemplate {
        let template = CLKComplicationTemplateModularLargeTallBody()
        template.headerTextProvider = CLKTextProvider.localizableTextProvider(withStringsFileTextKey: "Joy of Painting")
        template.bodyTextProvider = CLKTextProvider.localizableTextProvider(withStringsFileTextKey: "RUINED")
        return template
    }

    // MARK: CLKComplicationDataSource

    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
    }

    func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
        let calendar = Calendar.current
        let lastHourComponents = calendar.dateComponents([.year, .month, .day, .hour], from: Date())
        let lastHour = calendar.date(from: lastHourComponents)
        var oneHour = DateComponents()
        oneHour.hour = 1
        let nextHour = calendar.date(byAdding: oneHour, to: lastHour ?? Date())
        handler(nextHour)
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
