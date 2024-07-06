<div align="center">
  <h1>Crypto Currency</h1>
</div>
 
Welcome to Crypto Currency. A simple crypto app that shows currencies.

## Table of Contents
- [Features](#features)
  - [Screenshots](#screenshots)
  - [Tech Stack](#tech-stack)
  - [Architecture](#architecture)
  - [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
- [Usage](#usage)
  - [Listing - Crypto Currencies](#listing---crypto-currencies)
  - [Coin Filtering](#coin-filtering)
  - [Chart](#chart)
- [Known Issues](#known-issues)
- [Improvements](#improvements)

## Features

 **Currencies:**
- It is a simple application where you can look at the current value, exchange amounts, exchange rates and graphs of all cryptocurrencies.
  
 **Filtering:**
- You can filter crypto coins according to 24-hour volume, market value, price and similar values.
  
 **Charts:**
- You can observe cryptocurrencies on line and column charts.

## Screenshots

| Image 1 | Image 2 | Image 3 |
|:-------:|:-------:|:-------:|
| <img src="https://github.com/FurkanMDemiray/TGYCriptoCurrency/blob/main/Gifs/main.gif" width="250"> | <img src="https://github.com/FurkanMDemiray/TGYCriptoCurrency/blob/main/Gifs/filtering.gif" width="250"> | <img src="https://github.com/FurkanMDemiray/TGYCriptoCurrency/blob/main/Gifs/charts.gif" width="250"> |
| Currencies | Filtering | Charts |



## Tech Stack

- **Xcode:** Version 15.3
- **Language:** Swift 5.10
- **Minimum iOS Version:** 15.0
- **Dependency Manager:** SPM

## Architecture

![Architecture](https://devnot.com/wp-content/uploads/2015/01/mvvm-pattern.gif)

In developing Crypto Currencies Project, MVVM (Model-View-View Model) architecture is used.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following:

- Xcode installed

Also, make sure that these dependencies are added in your project's target:

- [Kingfisher](https://github.com/onevcat/Kingfisher):  Kingfisher is a lightweight and pure Swift library for downloading and caching images from the web.
- [Alamofire](https://github.com/Alamofire/Alamofire): Alamofire is an HTTP networking library written in Swift.

## Usage

###  Listing - Crypto Currencies

1. Open the app on your simulator or device.
2. Browse and analyse the coins.
3. Navigate to Coin Detail by tapping on the relevant coin.

 <p align="left">
  <img src="https://github.com/FurkanMDemiray/TGYCriptoCurrency/blob/main/Gifs/main.gif" alt="Listing" width="200" height="400">
</p>

---

### Coin Filtering 

1. Click filter button to filter the crypto currencies.

   <p align="left">
  <img src="https://github.com/FurkanMDemiray/TGYCriptoCurrency/blob/main/Gifs/filtering.gif" alt="Listing" width="200" height="400">
</p>

---

## Chart

1. Click to line chart button or bar chart button to see the relevant chart.

<p align="left">
  <img src="https://github.com/FurkanMDemiray/TGYCriptoCurrency/blob/main/Gifs/charts.gif" alt="Listing" width="200" height="400">
</p>

## Known Issues
- Since the changes in the prices of coins are very small and the fractions are high, it is not fully detailed to show the changes in the graphs by printing them.
- Some change amounts are too small to be displayed on the main screen.

## Improvements
- Graphics can be made more beautiful and legible.
- Localization for other languages can be added to be able to reach more user.
