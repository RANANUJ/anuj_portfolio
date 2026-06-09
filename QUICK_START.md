# 📧 Email & SMS Setup - QUICK START

## Current Status
- ❌ FormSubmit.co (unreliable - not working)
- ✅ Firebase + Twilio (reliable - ready to setup)

---

## 🎯 Your Next Steps (Choose ONE)

### Option 1: 🏆 RECOMMENDED - Firebase (5 mins)
**Best for:** Professional, reliable, secure

```bash
# 1. Get App Password from Gmail
#    Go to: https://myaccount.google.com/apppasswords

# 2. Deploy Firebase Function
firebase init functions
firebase deploy --only functions

# 3. Update Flutter app with Function URL
# Open: lib/services/notification_service.dart
# Replace: https://us-central1-YOUR_PROJECT_ID.cloudfunctions.net/sendContactEmail

# 4. Test
flutter run
```

**See:** `SETUP_GUIDE.md` in your project for detailed steps

---

### Option 2: 🚀 QUICK - Just SMS (2 mins)
**Best for:** Instant notifications only

Comment out email, keep only SMS. Still working!

---

### Option 3: 💾 SPREADSHEET - Google Sheets (3 mins)
**Best for:** Keep records automatically**

Form submissions auto-saved to Google Sheet

---

## 📍 Files You Have

- ✅ `SETUP_GUIDE.md` - Complete setup instructions
- ✅ `FIREBASE_CLOUD_FUNCTION_SETUP.js` - Function code
- ✅ `lib/services/notification_service.dart` - Updated for Firebase
- ✅ `lib/core/constants/twilio_config.dart` - SMS credentials ready
- ✅ `lib/presentation/contact/contact_screen.dart` - Form ready

---

## ⚡ TL;DR - Firebase Setup

```
1️⃣  Get Gmail App Password
    → https://myaccount.google.com/apppasswords

2️⃣  Update function code
    → Update your email & password in FIREBASE_CLOUD_FUNCTION_SETUP.js

3️⃣  Deploy
    → firebase deploy --only functions

4️⃣  Get URL
    → Copy the function URL from deployment message

5️⃣  Update app
    → Paste URL into notification_service.dart

6️⃣  Test & Done! ✅
```

---

## 🆘 Need Help?

**Email not working?**
- Check Gmail allows App Passwords
- Verify credentials in function code
- Check Firebase logs: `firebase functions:log`

**Need to skip setup?**
- Comment out email, use SMS only
- SMS still works and you get notifications!

---

**Read `SETUP_GUIDE.md` for complete, step-by-step instructions!** 📖
