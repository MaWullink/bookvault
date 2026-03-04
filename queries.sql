-- Book Vault database for personal project
-- Design decisions:
-- 1. Authors and categories are in separate tables to allow multiple authors/categories per book.
-- 2. Join tables (book_authors, book_categories) make filtering, sorting, and querying easier.
-- 3. Prevents duplicate data and keeps the database consistent.
-- 4. Ratings, descriptions, personal notes, and Amazon links are stored in the book table.
-- 5. This structure scales well if the library grows in size.

-- Stores all authors. First and last name combination must be unique.
CREATE TABLE author (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    UNIQUE (first_name, last_name)
);

-- Stores all categories for books.
CREATE TABLE category (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

-- Stores book details: title, description, personal notes, rating, Amazon link.
CREATE TABLE book (
    id SERIAL PRIMARY KEY,
    title TEXT UNIQUE NOT NULL,
    description TEXT NOT NULL,
    personal_note TEXT NOT NULL,
    rating SMALLINT CHECK (rating >= 0 AND rating <= 10),
    amazon_link TEXT
);

-- Join table: connects books to their authors (many-to-many relationship).
CREATE TABLE book_authors (
    id SERIAL PRIMARY KEY,
    book_id INTEGER REFERENCES book(id),
    author_id INTEGER REFERENCES author(id),
    UNIQUE (book_id, author_id)
);

-- Join table: connects books to categories (many-to-many relationship).
CREATE TABLE book_categories (
    id SERIAL PRIMARY KEY,
    book_id INTEGER NOT NULL REFERENCES book(id),
    category_id INTEGER NOT NULL REFERENCES category(id),
    UNIQUE (book_id, category_id)
);