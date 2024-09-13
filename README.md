### Versions
Ruby 3.3.5

Rails 7.2.1

### Preparation
The application is Dockerized to streamline development and maintenance

1. **Build Docker Images**

   Build the Docker images by running:
   ```sh
   docker compose build
   ```

2. **Seed database**

   Run
   ```sh
   bin/db_setup
   ```

### Tests & Console
Tests can be run by
```sh
bin/tests
```

For console access type
```sh
bin/console
```

### Running server
Start server by
```sh
bin/server
```
After initialization you can find the app at port 3000
```sh
http://localhost:3000
```

To sign-in a user you need to choose one from selector in the top right corner

## Q&A

Q: What fields should a comment have?
A: Comments should have fields for content.

Q: How should comments be displayed?
A: Chronologically, with newest comments on top, including author and creation time.

Q: Can comments be edited or deleted?
A: Initially, comments can only be created; editing and deletion can be added later if needed.

Q: Should the UI update in real time for comments or status changes when two users view the same project?
A: Yes.

Q: What statuses are available for a project?
A: Planned, started, paused, review, completed, cancelled

Q: Who can leave comments and change the project status?
A: Users who are assigned to the project.

## App
The app enables users to create comments on projects.

**Models:** `User` and `Project` are included primarily to demonstrate the commenting feature and may be extended in the future as needed.

### User capabilities:
* reate comments directly on the project show page without navigating away
* Change the status of a project
* View projects assigned to them

### Getting Started:
1. After accessing the main page, select a user from the top-right corner of the nav bar and navigate to the Projects section.
2. If no projects are visible, ensure the database is seeded by running:
    ```sh
    bin/db_setup
    ```

### Using the App:
- Select a specific project to view its details.
- On the project page, you can add comments or change the project status using the provided selector.

### Real-Time Updates:
- Open the same project page in a different browser and log in as a different user using the selector in the top-right corner. This will demonstrate real-time updates across sessions.

### Authentication
Currently, there is no sign-up system implemented.

To simulate different users, a selector in the top right corner of the nav bar allows switching between existing users without needing a password.

This mock authorization is solely for demonstrating the ability to add comments by different users with real-time updates.
Future implementation will include a complete sign-up and authentication system with protected sessions.


### Updates
Some of the updates are performed by Turbo streams and Stimulus to enhance the user experience with real-time interactions and seamless updates.


## Extending the Commenting System

Commenting system can be extended adding features such as:

1. Editing comment
2. Deleting comment
3. Enable replies to comments to create a threaded conversation view
4. Allow users to mention others using `@username` syntax.
5. Add options for users to react to or vote on comments.

## App Refinements

The app needs further refinement in various aspects to ensure readiness for production.
Examples:

- **Security:** Implement strong authentication and authorization.
- **UI/UX:** Enhance design for usability and responsiveness.
- **Logging:** Add comprehensive logging for monitoring and debugging.
- **Monitoring:** Integrate tools to track performance and health.
- **Error Handling:** Improve handling and messaging for errors.

This initial version serves as a foundation for what can be further developed and polished.
