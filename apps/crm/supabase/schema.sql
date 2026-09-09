-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Profiles Table
CREATE TABLE profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  email TEXT NOT NULL,
  full_name TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc', now()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc', now()) NOT NULL
);
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view own profile." ON profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile." ON profiles FOR UPDATE USING (auth.uid() = id);

-- 2. Contacts Table
CREATE TABLE contacts (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  name TEXT NOT NULL,
  email TEXT,
  phone TEXT,
  company TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc', now()) NOT NULL
);
ALTER TABLE contacts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view own contacts." ON contacts FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own contacts." ON contacts FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own contacts." ON contacts FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own contacts." ON contacts FOR DELETE USING (auth.uid() = user_id);

-- 3. Deals Table
-- Status enum mapping: 'lead', 'contacted', 'qualified', 'proposal', 'won', 'lost'
CREATE TABLE deals (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  contact_id UUID REFERENCES contacts(id) ON DELETE SET NULL,
  title TEXT NOT NULL,
  value_cents INTEGER DEFAULT 0 NOT NULL, -- Money stored as integer minor units (UAAF Foundation)
  status TEXT DEFAULT 'lead' NOT NULL CHECK (status IN ('lead', 'contacted', 'qualified', 'proposal', 'won', 'lost')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc', now()) NOT NULL
);
ALTER TABLE deals ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view own deals." ON deals FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own deals." ON deals FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own deals." ON deals FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own deals." ON deals FOR DELETE USING (auth.uid() = user_id);

-- 4. Notes Table
CREATE TABLE notes (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  deal_id UUID REFERENCES deals(id) ON DELETE CASCADE NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc', now()) NOT NULL
);
-- Notes RLS relies on the related deal's ownership
ALTER TABLE notes ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view notes of their deals." ON notes FOR SELECT USING (
  EXISTS (SELECT 1 FROM deals WHERE deals.id = notes.deal_id AND deals.user_id = auth.uid())
);
CREATE POLICY "Users can insert notes to their deals." ON notes FOR INSERT WITH CHECK (
  EXISTS (SELECT 1 FROM deals WHERE deals.id = notes.deal_id AND deals.user_id = auth.uid())
);
CREATE POLICY "Users can update notes of their deals." ON notes FOR UPDATE USING (
  EXISTS (SELECT 1 FROM deals WHERE deals.id = notes.deal_id AND deals.user_id = auth.uid())
);
CREATE POLICY "Users can delete notes of their deals." ON notes FOR DELETE USING (
  EXISTS (SELECT 1 FROM deals WHERE deals.id = notes.deal_id AND deals.user_id = auth.uid())
);
