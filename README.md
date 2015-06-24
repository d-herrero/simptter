Steps to install the system:

* Install dependencies:

  - Ruby >= 2.2.1.
  - MySQL >= 5.5.43.

* Generate "secret_key_base":

  - Copy the result of the command "rake secret".
  - Open "/etc/profile" as superuser y add it at the end preceded by "export SECRET_KEY_BASE=".

  Doing that, the application obtains it without having it in the code. That's better for obviously security reasons.

* Install gems:

  bundle

* Run migrations:

  rake db:migrate

* Compile assets:

  rake assets:precompile RAILS_ENV=production

* Run the server:

  rails server -b 0.0.0.0 -e production