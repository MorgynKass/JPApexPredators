//
//  PredatorDetail.swift
//  JPApexPredators17
//
//  Created by Morgyn Peay on 6/13/24.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: Predator
    @State var position: MapCameraPosition
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    // Background image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.8),
                                Gradient.Stop(color: .black, location: 1)
                            ], startPoint: .top, endPoint: .bottom)
                        }
                    
                    // Dino image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3)
                        .scaleEffect(x: -1)
                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/,radius: 7)
                        .offset(y: 20)
                    
                }
                VStack(alignment: .leading) {
                    // Dino name
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    // Current location
                    NavigationLink {
                        PredatorMap(position:
                                .camera(MapCamera(centerCoordinate: predator.location,
                                                  distance: 30000,
                                                  heading: 250,
                                                  pitch: 80
                            )))
                    } label: {
                        Map(position: $position) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom, .top], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    
                    // Appears in movie
                    Text("Appears in:")
                        .font(.title3)
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                        .bold()
                    
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("•" + " " + movie)
                            .font(.subheadline)
                    }
                    
                    // Movie moments
                    Text("Movie Moments:")
                        .font(.title)
                        .padding(.top, 15)
                    
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                            .bold()
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    
                    // Link to webpage
                    Text("Read More:")
                        .font(.caption)
                        .bold()
                    
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                    
                }
                .padding()
                .padding(.bottom, 25)
                .frame(width: geo.size.width, alignment: .leading)
                
            }
            .ignoresSafeArea()
            .toolbarBackground(.automatic)
            .toolbarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        PredatorDetail(predator: DecodedPredators().predators[6],
                       position: .camera(MapCamera(centerCoordinate: DecodedPredators().predators[6].location,
                                                   distance: 30000))
        )
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/) 
    }
}
