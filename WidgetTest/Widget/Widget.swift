//
//  Widget.swift
//  Widget
//
//  Created by Michael Brünen on 28.04.21.
//

import WidgetKit
import SwiftUI
import Intents

struct Entry: TimelineEntry {
    let date: Date
    let targetDate: Date
}

struct TimeProvider: TimelineProvider {
    func placeholder(in context: Context) -> Entry {
        Entry(date: Date(), targetDate: Date().addingTimeInterval(3600))
    }

    /// Provides a sample of the data for preview purposes
    /// - Parameters:
    ///   - context: The context
    ///   - completion: The completion handler
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        let date = Date()
        let model = Entry(date: date, targetDate: Date().addingTimeInterval(6000))
        completion(model)
    }

    /// Returns an array of entries with increasing dates for future display
    /// - Parameters:
    ///   - context: The context
    ///   - completion: The completion handler
    /// - Returns: An array of entries
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries = [Entry]()

        let date = Date()
        let targetDate = Date().addingTimeInterval(3600)

        let model = Entry(date: date, targetDate: targetDate)
        entries.append(model)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetView: View {
    @Environment(\.widgetFamily) var family

    let data: Entry
    var font: Font {
        if family == .systemSmall {
            return .title
        } else {
            return .largeTitle
        }
    }

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .inset(by: 15)
                .fill(Color.blue)
            Text(data.targetDate, style: .timer)
                .multilineTextAlignment(.center)
                .font(font)
                .padding()
        }
        .background(Color(white: 0.1))
        .foregroundColor(.white)
    }
}

@main
struct Config: Widget {
    @Environment(\.widgetFamily) var family

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "com.oddmagnet.timer", provider: TimeProvider()) { data in
            WidgetView(data: data)
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .description(Text("Timer"))
    }
}

struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(data: Entry(date: Date(), targetDate: Date().addingTimeInterval(3600)))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

//struct Widget_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
