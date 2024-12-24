# E-Commerce App

A modern e-commerce application built with Flutter, featuring a clean architecture, BLoC pattern for state management, and a responsive UI that adapts to different screen sizes.

## Features

- **Product Catalog**
  - Browse products with infinite scroll
  - Search products by name
  - Filter products by category
  - Responsive grid layout (1-3 columns based on screen size)

- **Shopping Cart**
  - Add/remove products
  - Update quantities
  - Real-time total calculation

- **Checkout Process**
  - User information collection
  - Order summary
  - Simple checkout flow

- **Clean Architecture**
  - BLoC pattern for state management
  - Repository pattern for data access
  - Separation of concerns

## Getting Started

### Installation

1. Clone the repository:
```bash
git clone [repository-url]
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Architecture

The app follows a clean architecture pattern with the following layers:

- **Presentation Layer** (UI)
  - Screens
  - Widgets
  - BLoC

- **Domain Layer**
  - Models
  - Repositories (Abstract)

- **Data Layer**
  - Repositories (Implementation)
  - Data Sources

## State Management

The app uses the BLoC (Business Logic Component) pattern for state management:

- **ProductBloc**: Manages product listing, searching, and filtering
- **CartBloc**: Handles shopping cart operations
- **CheckoutBloc**: Manages the checkout process

## API Integration

The app integrates with the Fake Store API (https://fakestoreapi.com) for product data:

- Product listing
- Product categories
- Product details

## Responsive Design

The app adapts to different screen sizes:

- **Mobile**: Single column layout
- **Tablet**: Two-column layout
- **Desktop**: Three-column layout

3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
