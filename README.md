# Dad's Bill Book: setup

A simple bill tracker for Dad's phone. GitHub shows the website. Supabase (free) stores the bills and handles the password. Dad signs in once, then opens it with Face ID, his fingerprint, or his phone passcode.

About 20 minutes, one time.

## Part 1: Supabase (where the bills are saved)

1. Go to **supabase.com**, sign up, and click **New project**.
   - Name: `dads-bills`
   - Database password: make a strong one and save it somewhere (you won't need it day to day).
   - Region: **East US**.
2. When the project is ready, open **SQL Editor** → **New query**. Paste everything from `setup.sql`, then click **Run**. It should say "Success."
3. Stop strangers from making accounts: go to **Authentication** → **Sign In / Providers** (or **Settings**) and turn **off** "Allow new users to sign up." Leave the **Email** provider on.
4. Make Dad's login: **Authentication** → **Users** → **Add user** → **Create new user**.
   - Enter Dad's email and a password he'll remember.
   - Check **Auto Confirm User**.
5. Get your two connection details from **Project Settings** → **API** (sometimes called **Data API** or **API Keys**):
   - **Project URL** (looks like `https://abcdxyz.supabase.co`)
   - The **anon public** key or the **publishable** key.
   - Do **not** use the `service_role` or secret key. That one must never go on a website.

## Part 2: Put your details in the page

Open `index.html` in any text editor and find this near the top of the script:

```js
const CONFIG = {
  SUPABASE_URL: "PASTE_YOUR_PROJECT_URL_HERE",
  SUPABASE_KEY: "PASTE_YOUR_ANON_OR_PUBLISHABLE_KEY_HERE"
};
```

Replace the two PASTE values with your Project URL and key, keeping the quote marks. Save.

The anon/publishable key is meant to be public. Dad's bills are protected by his password and the rules in `setup.sql`, which only let each signed-in person see their own data.

## Part 3: GitHub (the website)

1. Go to **github.com**, sign up, and click **New repository**.
   - Name: `dads-bills`
   - Set it to **Public**. Free GitHub Pages needs a public repo; only the code is public, never Dad's bills.
2. Click **uploading an existing file**, drag in `index.html`, and click **Commit changes**.
3. Go to **Settings** → **Pages**. Under "Build and deployment," choose **Deploy from a branch**, pick **main** and **/(root)**, then **Save**.
4. Wait a minute or two. The site will be at `https://YOUR-GITHUB-NAME.github.io/dads-bills/`.

## Part 4: Dad's phone

1. Open the link in **Safari** (iPhone) or **Chrome** (Android).
2. Sign in with the email and password from Part 1, step 4.
3. Tap **Yes, turn it on** for phone unlock.
4. Add it to the home screen:
   - iPhone: Share button → **Add to Home Screen**
   - Android: ⋮ menu → **Add to Home screen**

After this, he taps the icon, taps **Unlock**, and uses Face ID, fingerprint, or his phone passcode. It locks itself again after 5 minutes away.

## Updating the app later

When something needs changing, bring `index.html` back to Claude. Then on GitHub, open the repo, click `index.html` → the pencil icon (or upload the new file), and commit. Dad's phone gets the new version the next time he opens it. His bills are stored in Supabase, so updates never erase them.

## Good to know

- **Free Supabase projects pause after about a week with no use.** If Dad opens the app at least once a week, it stays awake. If it ever says "No internet" when he does have internet, log in to supabase.com and click **Restore project**.
- **Forgot password:** in Supabase → Authentication → Users, click Dad's account and set a new password.
- **New phone:** open the link, sign in with the password, and turn phone unlock on again.
- The phone unlock is a lock on the app on his phone. The real protection for his bills is his password and the Supabase rules.
