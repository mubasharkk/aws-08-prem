## Software Requirements Specification (SRS) for Kommy

### 1. Introduction

Kommy is a mobile application designed to connect users with sports groups or teams in their vicinity. Users can join
existing groups or create new events for various sports activities, such as soccer, beach volleyball, basketball, etc.
The app serves as a platform for organizing sports events, finding team members, and coordinating activities.

### 2. Functional Requirements

#### 2.1 User Registration and Authentication

1. **User Registration:** Users can create an account on Kommy by providing necessary details such as name, email, and
   password.
2. **User Authentication:** Secure authentication mechanisms should be implemented to ensure user privacy and data
   security.

#### 2.2 Creating and Joining Groups/Teams

1. **Group Creation:** Users can create new sports groups by specifying the sport, location, date, and time of the
   event.
2. **Group Joining:** Users can search for existing groups/events based on sport, location, and time, and request to
   join them.
3. **Guest Participation:** Group admins can accept guest players who want to join the team for a specific event.

#### 2.3 Search and Filtering

1. **Search Functionality:** Users can search for sports events based on the sport type and location.
2. **Location Services:** Utilize location services to automatically detect the user's current location and suggest
   nearby sports events.

#### 2.4 My Teams/Events

1. **View My Teams:** Users can view a list of sports teams or events they are currently involved in.
2. **Upcoming Events:** Display upcoming events for each team, including date, time, and location.
3. **Event Reminders:** Allow users to set reminders for upcoming events they are interested in attending.

#### 2.5 Backend Development

1. **REST API Development:** Develop the backend of the application using Symfony framework and MySQL database.
2. **API Endpoints:** Implement necessary API endpoints for user authentication, group creation, event management, and
   user interactions.
3. **Data Security:** Ensure secure data transmission and storage using encryption and other security measures.

### 3. Non-functional Requirements

#### 3.1 Performance

1. **Response Time:** The application should respond promptly to user actions, with minimal loading times.
2. **Scalability:** Design the application to handle a large number of concurrent users and scale as the user base
   grows.

#### 3.2 Usability

1. **Intuitive UI:** Design a user-friendly interface with clear navigation and intuitive controls.
2. **Accessibility:** Ensure accessibility features are implemented to cater to users with disabilities.

#### 3.3 Compatibility

1. **Cross-platform Compatibility:** Develop the frontend using React or VueJS to ensure compatibility with both Android
   and iOS devices.
2. **Browser Compatibility:** Ensure the web application is compatible with popular web browsers, including Chrome,
   Firefox, and Safari.

#### 3.4 Security

1. **Data Encryption:** Implement end-to-end encryption to secure user data during transmission.
2. **Authorization:** Enforce role-based access control to restrict unauthorized access to sensitive features and data.

### 4. Technologies Used

1. **Backend:** Symfony framework for REST API development, MySQL database for data storage.
2. **Frontend:** React or VueJS for mobile application development.
3. **Security:** Utilize encryption algorithms and secure authentication mechanisms.
4. **Location Services:** Integrate location services APIs for automatic location detection.

### 5. Conclusion

Kommy aims to provide a convenient platform for sports enthusiasts to connect with like-minded individuals and organize
sports events effortlessly. By following the specified requirements and utilizing modern technologies, Kommy will offer
a seamless user experience while promoting an active and healthy lifestyle.