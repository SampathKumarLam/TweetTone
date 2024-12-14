# TweetTone

TweetTone is an iOS app built with Swift that fetches the latest tweets about a specific Twitter username and analyzes their sentiment using machine learning. It determines whether the sentiment is **positive**, **negative**, or **neutral**. The app leverages the [Twift](https://github.com/daneden/Twift) framework for Twitter API integration and integrates a Core ML model for text sentiment analysis.

---

## Features

- **Twitter Username Search**: Enter any Twitter username and fetch the latest tweets about that user.
- **Sentiment Analysis**: Analyze tweets' sentiment as positive, negative, or neutral using a pre-trained ML model.
- **Clean UI**: Simple and intuitive interface for a seamless user experience.

---

## Tech Stack

- **Language**: Swift
- **Frameworks**:
  - [Twift](https://github.com/daneden/Twift) for Twitter API interaction
  - UIKit (or SwiftUI, if used) for the user interface
- **Machine Learning**: Core ML model for sentiment analysis
- **Networking**: URLSession for API calls (if additional custom networking is required)

---

## Prerequisites

Before running the project, ensure you have the following:

1. **Twitter Developer Account**:  
   - Create a Twitter Developer account to obtain API keys.
   - Configure your app in the Twitter Developer portal and generate the required `Bearer Token` for API access.

2. **Twift Setup**:  
   - Follow the [Twift documentation](https://github.com/daneden/Twift) to integrate the library into your project.

3. **Core ML Model**:  
   - Add a pre-trained sentiment analysis model (e.g., Apple's `SentimentPolarity.mlmodel` or a custom one) to your project.
   - Ensure the model is properly configured in your Xcode project.

---

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/TweetTone.git
   cd TweetTone
