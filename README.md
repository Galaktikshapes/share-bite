# ShareBite

**Turning Surplus Into Support**  
A community-focused mobile application built using Flutter and Firebase. ShareBite connects donors and recipients to reduce food and clothing waste while helping shelters, orphanages, and families in need.

---

## Project Purpose

This project was built as part of the PLP Mobile Development Specialization. It aligns with key Sustainable Development Goals (SDGs):

- SDG 2: Zero Hunger  
- SDG 12: Responsible Consumption and Production

The goal is to offer a fast, simple way for individuals and businesses to donate surplus food or clothing, and for those in need to request items quickly and respectfully.

---

## Tech Stack

- Flutter (UI and cross-platform development)
- Firebase Authentication (user sign-up and login)
- Cloud Firestore (real-time NoSQL database)
- Material Design 3 (clean, minimal interface)

---

## MVP Features

- Email and password authentication
- Role selection (Donor or Recipient) after login
- Individual and Business donor support
- Donation form: item type, quantity, optional notes
- Request form: quick entry for clothing or food needs
- Minimal dashboards for both roles
- Smooth UI transitions and responsive layout

---

## Project Structure

lib/
├── main.dart
├── screens/
│ ├── login_screen.dart
│ ├── home_screen.dart
│ ├── donation_form.dart
│ ├── request_form.dart
│ └── recipient_dashboard.dart
├── models/
│ └── donation_model.dart
├── services/
│ └── firebase_service.dart
└── widgets/
└── custom_buttons.dart





