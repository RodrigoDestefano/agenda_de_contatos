## Contact's Book

Contact's Book is a simple application designed to simulate a common address book (like the one that comes on cell phones by default). However, not only the handling of contacts in the phonebook but the requests and the database for this were also developed.

In the current state of the project it is possible:
* Register users, contacts, address and a group of contacts (but you can't update them by app, just create and delete).
* Address search by zip code using a werbservice.
* Send an email when registering on app.
* Categorize and group contacts.
* Search dynamically added contacts.
* Add multiple addresses and phone numbers per contact.
* Has token authentication (only use after login to the app).
* When registering forms, validate emails and phone numbers.

### Built With and Installation

For the development, Apache and MySQL Workbench were used as server side and database. For the back end Node.js with Sequelize and finally the application was developed using Flutter and Dart language.

* [Apache](https://www.apachefriends.org/index.html)
* [MySQL Workbench](https://dev.mysql.com/downloads/workbench/)
* [Node.js](https://nodejs.org/en/download/)
* [Flutter](https://flutter.dev/docs/get-started/install)

## Getting Started

If you want to get a local copy installed and working, some prerequisites must also be installed in addition to those mentioned above. Follow the steps.

### Prerequisites

Basically they are node packages that will allow all methods used in the project to work correctly.

* npm
  ```sh
  npm install npm@latest -g
  ```
* express
  ```sh
  npm install express --save
  ```
* sequelize
  ```sh
  npm i sequelize
  ```
* sequelize-cli
  ```sh
  npm install --save-dev sequelize-cli
  ```
* mysql2
  ```sh
  npm install --save mysql2
  ```
* nodemon
  ```sh
  npm install -g nodemon
  ```
* bcrypt
  ```sh
  npm install bcrypt
  ```
* nodemailer
  ```sh
  npm install nodemailer
  ```
  * ejs
  ```sh
  npm install ejs
  ```

### Initialization

1. You need to create an empty database Workbench named 'db_contactbook' or change the the
agenda_de_contatos/contact_book_back_end/src/config/database.js file and enter with your database name 
2. Next clone the repo:
   ```sh
   git clone https://github.com/RodrigoDestefano/agenda_de_contatos.git
   ```
3. Install NPM packages
   ```sh
   npm install
   ```
4. Migrate the database tables
   ```sh
   npx sequelize db:migrate
   ```
5. Run the back end
   ```sh
   npm run dev
   ```
5. Go to agenda_de_contatos/contact_book_mobile/lib/core/services/config/config.dart and change to your IPv4 address
6. After making sure that the flutter is lurking on some device and that there are no problems, just:
  ```sh
  flutter run
  ```
