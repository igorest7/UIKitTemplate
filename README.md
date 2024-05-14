# UIKitTemplate

## Introduction

This template is intended to demonstrate the main parts of an iOS app written in UIKit. It can either be used as a template for starting a new app or as reference for implementing good architecture patterns in existing codebases.

The template does not account for very complex projects so some form of modularisation would need to happen when getting to that stage depending on the specific project requirements.

The main parts so far are the MVVM-C and unit testing. The implementation is a take on Clean Architecture and I generally follow SOLID and Clean Code principles.

I generally prefer to keep the code simple and minimise external frameworks dependencies to reduce the learning curve for any developer coming on board or taking over the projects I work on so there is only one external dependency to facilitate snapshot testing.

There is a sister project for SwiftUI that does the same thing although this template does not include some things like sheet view as it is more straightforward in UIKit [here](https://github.com/igorest7/SwiftUITemplate). 

## Architecture overview

### MVVM-C

![Diagram](Template%20architecture.png)

Navigation logic is designed to be isolated from the views and viewModels. This is achieved by containing it in the Coordinators. Usually apps are split into separate user journeys that can contain any number of screens. Coordinators follow that structure except for the first one. That is the DeeplinkCoordinator to facilitate navigating to arbitrary screens after opening deeplinks. 

In this app the MainMenuCoordinator is a single view coordinator but the DetailsCoordinator contains two different views with navigation happening both between individual screens and different user journeys.

Routers are separate from Coordinators to remove UI code references from the ViewModel.

### Dependency injection

ViewModelFactory is injected into the cooordinators to create the viewModels as needed. It is extended along with each view to provide new viewModels. Concrete implementation contains the AppDependencyProvider that has all the services that might be needed by the viewModels in one place.

## Tests

There are unit test examples for the ConcreteMainMenuViewModel as well as the RemoteTodoService. 

## Localisation

This is done through the usual strings catalogue with the additional Localizable struct to keep the actual strings names in one place.

## Theming

Fonts are setup in the Font extension to support a common approach to the design system and to allow easy app wide customisation of fonts and sizes.

Colours are set through the Colors asset catalogue and the Color extension to also keep the string names in one place. 
