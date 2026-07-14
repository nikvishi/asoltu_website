# Firestore rules for marketing leads (console only)

The marketing website writes **only** to:

- `contacts/{id}`
- `demo_requests/{id}`

Do **not** grant website clients access to ERP collections (`schools`, `users`, `students`, etc.).

Add the following to Firebase Console → Firestore Rules **without** weakening ERP rules:

```
// Marketing website lead capture (asoltu.com)
match /contacts/{docId} {
  allow create: if request.resource.data.keys().hasAll([
      'fullName', 'schoolName', 'mobile', 'email', 'createdAt'
    ])
    && request.resource.data.email is string
    && request.resource.data.mobile is string
    && request.resource.data.fullName is string
    && request.resource.data.fullName.size() < 200
    && request.resource.data.message is string
    && request.resource.data.message.size() < 5000;
  allow read, update, delete: if false;
}

match /demo_requests/{docId} {
  allow create: if request.resource.data.keys().hasAll([
      'name', 'mobile', 'email', 'schoolName', 'createdAt'
    ])
    && request.resource.data.email is string
    && request.resource.data.mobile is string
    && request.resource.data.name is string
    && request.resource.data.name.size() < 200;
  allow read, update, delete: if false;
}
```

Until these rules are published in the console, form submits may fail with permission-denied (UI shows a friendly error).
