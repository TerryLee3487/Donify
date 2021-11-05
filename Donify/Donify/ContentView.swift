//
//  ContentView.swift
//  Donify
//
//  Created by Terry Li on 2021-11-05.
//

//
//  ContentView.swift
//  hack_week
//
//  Created by Terry Li on 2021-11-01.
//

import SwiftUI

struct Transaction: Identifiable {
    var id = UUID()
    var name: String
    var amount: Double
    var time: String
    var flagged: Bool
    var locked: Bool
    var src: String
}



struct HomeView: View {
    @State var todaysTransactions = [Transaction(name: "Timothy Hill", amount: 20, time: "9:52 AM", flagged: false, locked: true, src: "twitch"),
                                     Transaction(name: "Jill Biles", amount: 220, time: "7:11 AM", flagged: false, locked: true, src: "youtube")]
    @State var yesterdayTransactions = [Transaction(name: "John Smith", amount: 20, time: "5:52 PM", flagged: true, locked: false, src: "twitch"),
                                        Transaction(name: "Anthony Bill", amount: 200, time: "11:02 AM", flagged: false, locked: true, src: "insta"),
                                        Transaction(name: "Tyler Barrie", amount: 200, time: "7:11 PM", flagged: true, locked: true, src: "twitch"),
                                        Transaction(name: "Jennifer Gates", amount: 10, time: "2:11 PM", flagged: false, locked: false, src: "youtube"),
                                        Transaction(name: "Katie Gates", amount: 10, time: "8:03 AM", flagged: false, locked: false, src: "twitch"),
                                        Transaction(name: "Elizabeth Kat", amount: 10, time: "7:00 AM", flagged: false, locked: false, src: "youtube"),
                                        Transaction(name: "Jennifer Gates", amount: 10, time: "6:45 AM", flagged: false, locked: false, src: "youtube")]
    
    @State var flaggedTransactions = [Transaction(name: "John Smith", amount: 20, time: "5:52 PM", flagged: true, locked: false, src: "twitch"), Transaction(name: "Tyler Barrie", amount: 200, time: "7:11 PM", flagged: true, locked: true, src: "twitch")]
    @State var highToLowTranscations = [Transaction(name: "Jill Biles", amount: 220, time: "11/02/2021 7:11 AM", flagged: false, locked: true, src: "youtube"),
                                        Transaction(name: "Anthony Bill", amount: 200, time: "11/01/2021 11:02 AM", flagged: false, locked: true, src: "insta"),
                                        Transaction(name: "Tyler Barrie", amount: 200, time: "11/01/2021 7:11 PM", flagged: true, locked: true, src: "twitch"),
                                        Transaction(name: "Timothy Hill", amount: 20, time: "11/02/2021 9:52 AM", flagged: false, locked: true, src: "twitch"),
                                        Transaction(name: "John Smith", amount: 20, time: "11/01/2021 5:52 PM", flagged: true, locked: false, src: "twitch"),
                                        Transaction(name: "Jennifer Gates", amount: 10, time: "11/01/2021 2:11 PM", flagged: false, locked: false, src: "youtube"),
                                        Transaction(name: "Katie Gates", amount: 10, time: "11/01/2021 8:03 AM", flagged: false, locked: false, src: "twitch"),
                                        Transaction(name: "Elizabeth Kat", amount: 10, time: "11/01/2021 7:00 AM", flagged: false, locked: false, src: "youtube"),
                                        Transaction(name: "Jennifer Gates", amount: 10, time: "11/01/2021 6:45 AM", flagged: false, locked: false, src: "youtube")
    ]
    
    @State var totalDoations: Double = 0
    @State var lockedFunds: Double = 0
    @State var numberFlagged: Int = 0;
    @State var bufferAmount: Double = 300;
    @State var pageSelected: Int = 0;
    
    
    @State var isChangingBuffer: Bool = false
    @State var showMoreInfo: Bool = false
    @State var newBufferAmount:String = ""
    
    @State var showFilter:Bool = false
    @State var filterNum: Int = 0
    @State var filterSelected: Int = 0
    
    var body: some View {
            VStack {
                ZStack {
                    Image("background").resizable().frame(width: UIScreen.main.bounds.width, height: showFilter ? 330 : 260, alignment: .top)
                    VStack {
                        HStack {
                            Text("Donation History").font(.system(size: 24)).foregroundColor(Color.white)
                            Spacer()
                            Button {
                                showFilter.toggle()
                            } label: {
                                Image("filter_list").resizable().frame(width: 24, height: 24, alignment: .center).padding(.trailing, 12)
                            }
                        }.padding(.horizontal, 16).padding(.top)
                        
                        VStack(spacing: 10) {
                            HStack {
                                Text("Overview")
                                    .font(.system(size: 14)).foregroundColor(Color.white)
                                    Spacer()
                            }.padding(.horizontal, 20).padding(.top)
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    Banner(colour: "blue", firstLine: "$\(totalDoations)", secondLine: "Donations")
                                    Banner(colour: "purple", firstLine: "$\(lockedFunds)", secondLine: "Locked Funds")
                                    Banner(colour: "orange", firstLine: "\(numberFlagged) Donations", secondLine: "Flagged")
                                    Banner(colour: "green", firstLine: "$\(bufferAmount)", secondLine: "Buffer")
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                    
                    if showFilter {
                        HStack {
                            Spacer()
                        
                            VStack {
                                HStack {
                                    Text("Filter").font(.system(size: 18))
                                    Spacer()
                                }.padding(.leading,20)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    FilterItem(filterSelected: $filterSelected, actualNum: 0, text: "Newest - Olderst")
                                    FilterItem(filterSelected: $filterSelected, actualNum: 1, text: "Oldest - Newest")
                                    FilterItem(filterSelected: $filterSelected, actualNum: 2, text: "Amount: High to Low")
                                    FilterItem(filterSelected: $filterSelected, actualNum: 3, text: "Amount: Low to high")
                                    FilterItem(filterSelected: $filterSelected, actualNum: 4, text: "Flagged Transactions")
                                }
                                
                                Button {
                                    filterNum = filterSelected
                                    showFilter = false
                                } label: {
                                    VStack {
                                        Text("Done").font(.system(size: 14)).foregroundColor(Color.white)
                                    }.frame(width: 150, height: 30, alignment: .center).background(Color("darkGreen")).cornerRadius(12)
                                }
                            
                            }.frame(width: 180, height: 210, alignment: .center).background(Color.white).cornerRadius(8).padding(.trailing, 24).offset(y:35)
                        }
                    }
                    
                }.edgesIgnoringSafeArea(.all)
                
                
                
                ScrollView {
                
                    if filterNum == 0 {
                        HStack {
                            Text("Today")
                            Spacer()
                        }.padding(.horizontal, 16)
                    
                        VStack(spacing: 12){
                            ForEach(todaysTransactions) { transaction in
                                TransactionView(transaction: transaction, totalDoations: $totalDoations, lockedFunds: $lockedFunds)
                            }
                        }
                        
                    
                        HStack {
                            Text("Yesterday")
                            Spacer()
                        }.padding(.horizontal, 16).padding(.top)
                        
                        VStack(spacing: 12){
                            ForEach(yesterdayTransactions) { transaction in
                              TransactionView(transaction: transaction, totalDoations: $totalDoations, lockedFunds: $lockedFunds)
                            }
                        }
                    } else if filterNum == 1 {
                        HStack {
                            Text("Yesterday")
                            Spacer()
                        }.padding(.horizontal, 16)
                    
                        VStack(spacing: 12){
                            ForEach(yesterdayTransactions.reversed()) { transaction in
                                TransactionView(transaction: transaction, totalDoations: $totalDoations, lockedFunds: $lockedFunds)
                            }
                        }
                        
                        HStack {
                            Text("Today")
                            Spacer()
                        }.padding(.horizontal, 16).padding(.top)
                        
                        VStack(spacing: 12){
                            ForEach(todaysTransactions.reversed()) { transaction in
                              TransactionView(transaction: transaction, totalDoations: $totalDoations, lockedFunds: $lockedFunds)
                            }
                        }
                    } else if filterNum == 2 {
                        HStack {
                            Text("Amount: High to Low")
                            Spacer()
                        }.padding(.horizontal, 16)
                    
                        VStack(spacing: 12){
                            ForEach(highToLowTranscations) { transaction in
                                TransactionView(transaction: transaction, totalDoations: $totalDoations, lockedFunds: $lockedFunds)
                            }
                        }
                    } else if filterNum == 3 {
                        HStack {
                            Text("Amount: Low to High")
                            Spacer()
                        }.padding(.horizontal, 16)
                    
                        VStack(spacing: 12){
                            ForEach(highToLowTranscations.reversed()) { transaction in
                                TransactionView(transaction: transaction, totalDoations: $totalDoations, lockedFunds: $lockedFunds)
                            }
                        }
                    } else if filterNum == 4 {
                        HStack {
                            Text("Flagged Transactions")
                            Spacer()
                        }.padding(.horizontal, 16)
                    
                        VStack(spacing: 12){
                            ForEach(flaggedTransactions) { transaction in
                                TransactionView(transaction: transaction, totalDoations: $totalDoations, lockedFunds: $lockedFunds)
                            }
                        }
                    }
                
                }.padding(.bottom, 12).padding(.top, -50)
                
                Spacer()
                HStack {
                    VStack {
                        Button {
                            pageSelected = 0;
                        } label: {
                            Image("home").resizable().resizable().frame(width: 35, height: 30, alignment: .center)
                        }.padding(.leading, 30)
                    }.padding(.leading, 16)
                    
                    Spacer()
                    
                    VStack {
                        Button {
                            pageSelected = 1;
                        } label: {
                            Image("dispute").resizable().resizable().frame(width: 35, height: 30, alignment: .center)
                        }
                    }
                    
                    
                    Spacer()
                    
                    VStack {
                        Button {
                            pageSelected = 2;
                        } label: {
                            Image("evidence").resizable().resizable().frame(width: 30, height: 30, alignment: .center)
                        }.padding(.trailing, 30)
                    }.padding(.trailing, 16)
                    
                }.frame(height: 50).padding(.bottom, 16)
            }.ignoresSafeArea(edges: .bottom).onAppear() {
                for transaction in todaysTransactions {
                    if transaction.locked {
                        lockedFunds += transaction.amount
                    } else {
                        totalDoations += transaction.amount
                    }
                    
                    if transaction.flagged {
                        numberFlagged += 1
                    }
                }
                
                for transaction in yesterdayTransactions {
                    if transaction.locked {
                        lockedFunds += transaction.amount
                    } else {
                        totalDoations += transaction.amount
                    }
                    
                    if transaction.flagged {
                        numberFlagged += 1
                    }
                }
            }
            /*if isChangingBuffer {
                PopUpView(isChangingBuffer: $isChangingBuffer, showMoreInfo: $showMoreInfo, newAmount: newBufferAmount)
            }*/
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct Banner:View {
    var colour: String
    var firstLine:String
    var secondLine: String

    var body: some View {
        VStack {
            Text(firstLine).font(.system(size: 16)).foregroundColor(Color("darkGreen"))
            Spacer().frame(height:10)
            Text(secondLine).font(.system(size: 14))
            
        }.frame(width: 116, height: 101, alignment: .center).background(LinearGradient(gradient: Gradient(colors: [Color("\(colour)1"), Color("\(colour)2"), Color("\(colour)3")]), startPoint: .top, endPoint: .bottom)).cornerRadius(24)
        
    }
}

struct TransactionView: View {
    @State var transaction:Transaction
    
    @Binding var totalDoations: Double
    @Binding var lockedFunds: Double
    var body: some View {
        VStack {
            HStack {
                if transaction.src == "twitch" {
                    Image("twitch").resizable().frame(width: 12, height: 14, alignment: .center).offset(y:1.5)
                } else if transaction.src == "youtube" {
                    Image("youtube").resizable().frame(width: 24, height: 14, alignment: .center)
                } else if transaction.src == "insta" {
                    Image("insta").resizable().frame(width: 15, height: 15, alignment: .center)
                }
                Text(transaction.name).foregroundColor(transaction.flagged ? Color("alertRed") : Color.black).font(.system(size: 16))
                Spacer()
                Text("$ \(transaction.amount, specifier: "%.2f")").foregroundColor(transaction.flagged ? Color("alertRed") : Color.black).font(.system(size: 16))
            }.padding(.horizontal, 16)
            HStack {
                Text(transaction.time).foregroundColor(transaction.flagged ? Color("alertRed") : Color.black).font(.system(size: 12))
                Spacer()
                Button {
                    transaction.locked.toggle()
                    if transaction.locked {
                        lockedFunds += transaction.amount
                        totalDoations -= transaction.amount
                    } else {
                        lockedFunds -= transaction.amount
                        totalDoations += transaction.amount
                    }
                } label: {
                    if transaction.locked {
                        Image("lock").resizable().frame(width: 22, height: 22, alignment: .center)
                    } else {
                        Image("lock_open").resizable().frame(width: 22, height: 22, alignment: .center)
                    }
                }
                
            }.padding(.horizontal, 16)
            if transaction.flagged {
                HStack {
                    Image("error_outline").resizable().frame(width: 15, height: 15, alignment: .center)
                    Text("Flagged for chargeback history").foregroundColor(Color("alertRed")).font(.system(size: 10))
                    Spacer()
                }.padding(.horizontal, 16)
            }
            
        }.frame(width: UIScreen.main.bounds.width-30, height: transaction.flagged ? 109 : 84, alignment: .center).background(Color("backgroundGray")).cornerRadius(6).shadow(color: Color.black.opacity(0.09), radius: 4, x: 0, y: 4)
    }
}

struct PopUpView:View {
    @Binding var isChangingBuffer:Bool
    @Binding var showMoreInfo:Bool
    @State var newAmount: String
    var body: some View {
        
        Color.black.opacity((isChangingBuffer || showMoreInfo) ? 0.3 : 0).edgesIgnoringSafeArea(.all)
        
        VStack {
            if isChangingBuffer {
                Text("Enter new buffer amount").padding(.top)
                TextField("Buffer", text: $newAmount).padding(.horizontal)
                Button {
                    withAnimation(.linear(duration: 0.3)) {
                        isChangingBuffer = false
                    }
                } label: {
                    Text("Enter")
                }.padding(.bottom)
            } else if showMoreInfo {
                
            }
        }.frame(width: 240, height: 160, alignment: .center).background(Color("blue")).cornerRadius(12)
    }
}


struct FilterItem:View {
    @Binding var filterSelected:Int
    @State var actualNum: Int
    @State var text:String
    var body: some View {
        
            Button {
                filterSelected = actualNum;
            } label: {
                HStack {
                    if filterSelected == actualNum {
                        Image("filledBox").resizable().frame(width: 18, height: 18, alignment: .center)
                    } else {
                        Image("box").resizable().frame(width: 18, height: 18, alignment: .center)
                    }
                    Text(text).font(.system(size: 12)).foregroundColor(Color.black)
                }
            }
    }
}

