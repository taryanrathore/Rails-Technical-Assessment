# README

This is a full-stack Ruby on Rails 8 application for managing courses, assignments, announcements, and terms. It includes authentication, real-time notifications, and responsive design.

Features

* User Authentication using Devise
* Course Management (CRUD operations)
* Assignment Management
* Announcement System
* Term Association
* Favorites & Bookmarks
* Real-Time Notifications using ActionCable
* Responsive UI with Bootstrap
* Role-based Access Control (Admin, Instructor, Student)
* Testing with RSpec and Capybara

Technologies Used

* Backend: Ruby 3.2.0, Rails 8, PostgreSQL
* Frontend: HTML, CSS, JavaScript, Bootstrap 5
* Authentication: Devise
* Real-Time Features: ActionCable, Redis
* Background Jobs: SolidQueue
* Testing: RSpec, Capybara, FactoryBot, Faker

Setup Instructions

Prerequisites

Ensure you have the following installed:

* Ruby 3.2.0
* Rails 8.0.1
* PostgreSQL
* Redis
* Node.js & Yarn

Installation

Clone the repository:

git clone https://github.com/taryanrathore/Rails-Technical-Assessment.git
cd technical_assessment

Install dependencies:

bundle install
yarn install

Set up the database:

rails db:create db:migrate db:seed

Start the development server:

rails server

Open http://localhost:3000 in your browser.

Run the test suite:

bundle exec rspec

Project Structure

app/
  controllers/
  models/
  views/
  channels/
  jobs/
config/
db/
spec/

Deployment

Deployment on Render
Create a PostgreSQL database on Render.

Create a Redis instance (for ActionCable).

Set up environment variables in Render:

DATABASE_URL
REDIS_URL
RAILS_MASTER_KEY (for credentials)
Deploy the Rails app:

Add a new Web Service on Render
bundle install && rails db:migrate

bundle exec puma -C config/puma.rb

Access the deployed app:


Run in Production:

RAILS_ENV=production rails assets:precompile
RAILS_ENV=production rails server
