//
//  ComplicationController.swift
//  SoothingMusic WatchKit Extension
//
//  Created by Kevin Conner on 12/28/16.
//  Copyright © 2016 Kevin Conner. All rights reserved.
//

import ClockKit

final class ComplicationController: NSObject, CLKComplicationDataSource {

    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        // No time travel
        handler([])
    }
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        var template: CLKComplicationTemplate?

        switch complication.family {
        case .circularSmall:
            break
        case .modularLarge:
            let modularLarge = CLKComplicationTemplateModularLargeTallBody()
            modularLarge.headerTextProvider = CLKTextProvider.localizableTextProvider(withStringsFileTextKey: "Joy of Painting")
            modularLarge.bodyTextProvider = CLKTextProvider.localizableTextProvider(withStringsFileTextKey: "RUINED")
            template = modularLarge
        case .modularSmall:
            break
        case .utilitarianLarge:
            break
        case .utilitarianSmall, .utilitarianSmallFlat:
            break
        case .extraLarge:
            break
        }

        let entry = template.map { CLKComplicationTimelineEntry(date: Date(), complicationTemplate: $0) }

        handler(entry)
    }
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // No text
        handler(nil)
    }
    
}
