Simple Description: This app is being created as part of a project for a Human-Computer Interactions Course.
             The project doesn't require actual coding an ios app, but I'm not great at drawing and wanted practice with swift and Xcode.

## Backend Plan

To make the prototype behave more like a real app, consider implementing a lightweight backend:

1. **Data Storage** – Use CloudKit or Firebase to store restaurant menus, user favorites and profile information.
2. **Authentication** – Integrate Sign in with Apple to keep things simple and secure.
3. **Ordering** – Provide basic order objects stored in the database and update restaurant wait times based on submitted orders.
4. **Payments** – For a real build you could integrate Apple Pay. During development, mock payment processing to avoid sensitive data handling.
5. **Analytics & Logging** – Track user interactions to help refine the interface and catch crashes or errors.

The current project structure already includes Core Data stubs, so hooking in a remote database and syncing with local storage would be a natural next step.
