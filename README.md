# BrokenMultipleListSelection

Demonstrates how having a Context Menu on a NavigationLink breaks the lists multiple selection.

**Feedback ID:** FB9760625

**System Info:**
* Xcode 13.1 (13A1030d)
* iPad Pro 11 (2018, iOS 15.1)
* iPhone 13 Simulator


**Reproduction steps:**
1. Run app on an iPhone in the simulator
2. In "working" mode, hit "Edit"
3. Start selecting items
4. Hit "Done"
5. Change to "broken" mode
6. Hit "Edit"
7. Start selecting items


**Actual Results:**
In "working" mode, the selection works properly. In "broken" mode, you can see the list flicker when items are selected and then the highlight state disappears.

This is caused by having the list items wrapped in a NavigationLink with a Context Menu.

```swift
struct BrokenList: View {
    @Binding var selection: Set<Int>
    
    var body: some View {
        List(selection: $selection){
            ForEach(0..<20){ i in
                NavigationLink {
                    Text("This is row \(i)")
                } label: {
                    Text("This is row \(i)")
                }
                .contextMenu{
                    Button("Print Title"){
                        print("This is row \(i)")
                    }
                }
            }
        }
    }
}
```



https://user-images.githubusercontent.com/42879920/141813146-c64e6fac-be55-4b0b-bd85-5403c1a220f8.mp4




**Expected Results:**
Both modes should work as it does in "working" mode.


**Work Around**

Tap into the editMode environment variable, and use an if statement on the button in the context menu.


```swift
struct WorkAroundList: View {
    @Binding var selection: Set<Int>
    @Environment(\.editMode) var editMode
    
    var body: some View {
        List(selection: $selection){
            ForEach(0..<20){ i in
                NavigationLink {
                    Text("This is row \(i)")
                } label: {
                    Text("This is row \(i)")
                }
                .contextMenu{
                    if editMode?.wrappedValue == .inactive{
                        Button("Print Title"){
                            print("This is row \(i)")
                        }
                    }
                }
            }
        }
    }
}
```
