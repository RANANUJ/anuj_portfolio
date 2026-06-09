# 📊 Google Sheets Setup - NO BACKEND NEEDED

## 🎯 What Happens
```
User submits form in app
        ↓
Submission auto-saved to Google Sheet
        ↓
You can view online anytime
```

---

## ⚡ Setup (5 Minutes)

### 1️⃣ Create Google Sheet
- Go to: https://sheets.google.com
- Create new spreadsheet: "Portfolio Submissions"
- Add these columns in Row 1:
  - **Name**
  - **Email**
  - **Message**
  - **Timestamp**
  - **Source**
- Save it

### 2️⃣ Create Google Apps Script
- In your Google Sheet
- Go to: **Extensions → Apps Script**
- Delete all code
- Paste this:

```javascript
function doPost(e) {
  try {
    const sheet = SpreadsheetApp.getActiveSheet();
    const data = JSON.parse(e.postData.contents);
    
    sheet.appendRow([
      data.name,
      data.email,
      data.message,
      new Date().toLocaleString(),
      'Portfolio App'
    ]);
    
    return ContentService.createTextOutput(
      JSON.stringify({success: true})
    ).setMimeType(ContentService.MimeType.JSON);
  } catch(e) {
    return ContentService.createTextOutput(
      JSON.stringify({success: false, error: e.toString()})
    ).setMimeType(ContentService.MimeType.JSON);
  }
}
```

### 3️⃣ Deploy Script
- Click **Deploy** button
- Click **New Deployment**
- Type: Select **Web app**
- Execute as: **Your Gmail**
- Who has access: **Anyone**
- Click **Deploy**

### 4️⃣ Copy the URL
You'll see a popup with:
```
https://script.google.com/macros/d/ABC123XYZ123ABC/userweb/v1/exec
```

**Copy the entire URL**

### 5️⃣ Update Flutter App
Open: `lib/services/notification_service.dart`

Find this line:
```dart
static const String googleSheetUrl =
    'https://script.google.com/macros/d/YOUR_SCRIPT_ID/userweb/v1/exec';
```

Replace with your URL from Step 4:
```dart
static const String googleSheetUrl =
    'https://script.google.com/macros/d/ABC123XYZ123ABC/userweb/v1/exec';
```

### 6️⃣ Test It!
```bash
flutter run
```

1. Go to **Contact** tab
2. Fill the form
3. Click **Send**
4. Open your Google Sheet
5. See the submission appear! ✅

---

## 📊 View Your Submissions

- Go to: https://sheets.google.com
- Open "Portfolio Submissions"
- See all submissions in real-time
- Can sort, filter, export as CSV, etc.

---

## 🔒 Privacy
- ✅ No data in app
- ✅ Recruiters can't see submissions
- ✅ Only you can access Google Sheet
- ✅ No backend needed

---

## ❓ Troubleshooting

**Submissions not appearing?**
- Check Google Sheet is shared with "Anyone"
- Make sure script was deployed (not just saved)
- Check browser console for errors
- Test the script: https://script.google.com/home/start

**Need to modify the script?**
- Go back to Apps Script
- Edit the code
- Click **Deploy** → **Manage Deployments**
- Click the deployment, update, save

---

**That's it! Your portfolio now saves submissions to Google Sheets without any backend!** 🚀
