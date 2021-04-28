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
}

struct TimeProvider: TimelineProvider {
    func placeholder(in context: Context) -> Entry {
        Entry(date: Date())
    }

    /// Provides a sample of the data for preview purposes
    /// - Parameters:
    ///   - context: The context
    ///   - completion: The completion handler
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        let date = Date()
        let model = Entry(date: date)
        completion(model)
    }

    /// Returns an array of entries with increasing dates for future display
    /// - Parameters:
    ///   - context: The context
    ///   - completion: The completion handler
    /// - Returns: An array of entries
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries = [Entry]()

        // ensure the date's seconds are set to 0
        var components = Calendar.current.dateComponents([.era, .year, .month, .day, .hour, .minute, .second], from: Date())
        components.second = 0
        let roundedDate = Calendar.current.date(from: components) ?? Date()

        // create an entry for each minute
        for minute in 0 ..< 60 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minute, to: roundedDate)!
            let entry = Entry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct TimeZoneView: View {
    let sourceDate: Date
    let timeZone: String

    var body: some View {
        Link(destination: URL(string: timeZone)!) {
            VStack {
                Text(timeZone)
                    .font(.caption)
                Text(dateString(for: timeZone))
                    .font(.title)
            }
        }
    }

    func dateString(for timeZone: String) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(abbreviation: timeZone)
        return formatter.string(from: sourceDate)
    }
}

struct WidgetView: View {
    @Environment(\.widgetFamily) var family
    var data: Entry

    var body: some View {
        switch family {
            case .systemSmall:
                TimeZoneView(sourceDate: data.date, timeZone: "CEST")
            case .systemMedium:
                HStack(spacing: 20) {
                    TimeZoneView(sourceDate: data.date, timeZone: "CEST")
                    TimeZoneView(sourceDate: data.date, timeZone: "PST")
                }
            case .systemLarge:
                VStack(spacing: 40) {
                    HStack(spacing: 20) {
                        TimeZoneView(sourceDate: data.date, timeZone: "CEST")
                        TimeZoneView(sourceDate: data.date, timeZone: "PST")
                    }

                    HStack(spacing: 20) {
                        TimeZoneView(sourceDate: data.date, timeZone: "EST")
                        TimeZoneView(sourceDate: data.date, timeZone: "JST")
                    }
                }
            @unknown default:
                fatalError("Add support for new widgetFamily size case")
        }
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
        WidgetView(data: Entry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}

//struct Widget_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
