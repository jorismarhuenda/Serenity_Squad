//
//  ThemeEditor.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 08/06/2024.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    
    var body: some View {
        Form {
            nameSection
            addEmojisSection
            editNumberOfPairs
            editThemeColor
            removeEmojiSection
        }
        .navigationTitle("Edit \(theme.name)")
        .frame(minWidth: 300, minHeight: 350)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
        }
    }
    
    @State private var emojisToAdd = ""
    
    var addEmojisSection: some View {
        Section(header: Text("Add Emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    addEmojis(emojis)
                }
        }
    }
    
    func addEmojis(_ emojis: String) {
        withAnimation {
            emojis.forEach { emoji in
                if emoji.isEmoji && !theme.items.contains(String(emoji)) {
                    theme.items.insert(String(emoji), at: 0)
                }
            }
        }
    }
    
    var editNumberOfPairs: some View {
        Section(header: Text("Playable Pairs")) {
            Stepper("\(theme.pairsToShow)", value: $theme.pairsToShow, in: min(2, theme.items.count)...(theme.items.count))
        }
    }

    var editThemeColor: some View {
        Section(header: Text("Theme Color")) {
            ColorPicker("Color", selection: $theme.cColor)
        }
    }
    
    var removeEmojiSection: some View {
        Section(header: Text("Remove Emoji")) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(theme.items, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                theme.items.removeAll(where: { $0 == emoji })
                            }
                        }
                }
            }
            .font(.system(size: 40))
        }
    }
}

struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(theme: .constant(ThemeStore(named: "Preview").themes[4]))
            .previewLayout(.fixed(width: 300, height: 350))
        ThemeEditor(theme: .constant(ThemeStore(named: "Preview").themes[2]))
            .previewLayout(.fixed(width: 300, height: 600))
    }
}

extension Character {
    var isEmoji: Bool {
        if let firstScalar = unicodeScalars.first, firstScalar.properties.isEmoji {
            return (firstScalar.value >= 0x238d || unicodeScalars.count > 1)
        } else {
            return false
        }
    }
}
