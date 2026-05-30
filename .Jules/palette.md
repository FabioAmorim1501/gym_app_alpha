## 2024-05-30 - Form Submission Loading States
**Learning:** Asynchronous form submission buttons (like login or signup) without loading states allow users to submit the form multiple times, leading to confusing duplicate requests and a poor user experience as they wait without feedback.
**Action:** Always implement a loading state (e.g., displaying a `CircularProgressIndicator`) and disable the submission button while the async request is processing to prevent duplicate submissions and provide clear visual feedback.
