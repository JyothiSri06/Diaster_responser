-- Enable PostGIS extension
CREATE EXTENSION IF NOT EXISTS postgis;

-- Create tables (see Database Schema section)
-- Set up Row Level Security
-- Create indexes for performance

-- Core Tables
-- Disasters table with geospatial support
CREATE TABLE disasters (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    location_name TEXT,
    location GEOGRAPHY(POINT, 4326),
    description TEXT,
    tags TEXT[],
    owner_id TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    audit_trail JSONB DEFAULT '[]'::jsonb
);

-- Reports table for user submissions
CREATE TABLE reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    disaster_id UUID REFERENCES disasters(id) ON DELETE CASCADE,
    user_id TEXT NOT NULL,
    content TEXT NOT NULL,
    image_url TEXT,
    verification_status TEXT DEFAULT 'pending',
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Resources table for emergency resources
CREATE TABLE resources (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    disaster_id UUID REFERENCES disasters(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    location_name TEXT,
    location GEOGRAPHY(POINT, 4326),
    type TEXT NOT NULL,
    description TEXT,
    contact_info TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Cache table for external API responses
CREATE TABLE cache (
    key TEXT PRIMARY KEY,
    value JSONB NOT NULL,
    expires_at TIMESTAMPTZ NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);
Indexes for Performance
-- Geospatial indexes
CREATE INDEX disasters_location_idx ON disasters USING GIST (location);
CREATE INDEX resources_location_idx ON resources USING GIST (location);

-- Query optimization indexes
CREATE INDEX disasters_tags_idx ON disasters USING GIN (tags);
CREATE INDEX disasters_owner_idx ON disasters (owner_id);
CREATE INDEX cache_expires_idx ON cache (expires_at);
