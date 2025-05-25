## 1. What is PostgreSQL?
PostgreSQL is a powerful and enterprise-grade open source relational database. It allows the use of relational SQL and non-relational JSON data and queries. PostgreSQL has a strong community behind it. PostgreSQL is a highly reliable database management system with excellent levels of support, security, and accuracy. Several mobile and web applications use PostgreSQL as their default database. Many geospatial and analytics solutions also use PostgreSQL. Its latest version is PostgreSQL 17. PostgreSQL supports sophisticated data types. The database was built with a large number of data types in mind. Its database performance is comparable to that of its competitors, such as Oracle and SQL Server. AWS provides fully maintained database services for PostgreSQL with its Amazon Relational Database Service. PostgreSQL is also used to construct Amazon Aurora.

## 2. What is the purpose of a database schema in PostgreSQL?
In PostgreSQL, a database schema is an organized structure that groups objects such as tables, views, functions, indexes, etc. within a database. It essentially creates a separate logical space within the database, where different data and objects can be stored under a specific user. Using a schema can avoid naming conflicts in the database, such as having two schemas with the same name in the same database. It ensures modularity and security in large projects because different permissions can be set for each schema. Therefore, using a schema in PostgreSQL makes database management and organization much more efficient and secure.

## 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.
In PostgreSQL, **Primary Key** and **Foreign Key** are fundamental concepts used to maintain data integrity and establish relationships between tables. Here's a clear explanation of both:


### 🔑 **Primary Key**:

* A **Primary Key** is a column (or a set of columns) in a table that uniquely identifies each row in that table.
* It **must contain unique values** and **cannot contain NULLs**.
* Each table can have **only one primary key**, but it can be composed of multiple columns (called a **composite key**).
* When you define a primary key, PostgreSQL automatically creates a **unique index** on that column to enforce uniqueness.

**Example**:

```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    age INT
);
```

Here, `student_id` is the primary key and will uniquely identify each student.

### 🔗 **Foreign Key**:

* A **Foreign Key** is a column (or set of columns) that establishes a link between the data in two tables.
* It refers to the **primary key** in another table (or the same table in case of self-reference).
* It ensures **referential integrity**, meaning you can't insert a value into the foreign key column that doesn't exist in the referenced primary key column.
* You can also set rules like **ON DELETE CASCADE** or **ON UPDATE RESTRICT** to define what happens when referenced data changes.

**Example**:

```sql
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_name TEXT NOT NULL
);
```

Here, `student_id` in `enrollments` is a foreign key that references the `student_id` in the `students` table. It ensures that only existing students can be added to the `enrollments` table.

### Summary:

* **Primary Key** = uniquely identifies a row within its own table.
* **Foreign Key** = references a primary key in another table to link data between tables.


## 4. What is the difference between the VARCHAR and CHAR data types?
In PostgreSQL, both `VARCHAR` and `CHAR` are data types used to store text or character strings. However, there are some important differences between them in how they store and manage the data.

#### **1. Length and Storage**

* `CHAR(n)` is a **fixed-length** data type. This means it always stores exactly `n` characters. If the input is shorter than `n`, PostgreSQL will add extra **spaces** at the end to make it `n` characters long.
* `VARCHAR(n)` is a **variable-length** data type. It stores only the characters you give it, up to a maximum of `n` characters. It does **not** add extra spaces.

#### **2. Usage**

* `CHAR` is usually used when the length of the data is always the same. For example, a country code like “US” or “IN” could be stored in `CHAR(2)` because it always has 2 characters.
* `VARCHAR` is used when the length of the data can be different. For example, a person’s name can be short like “Ali” or long like “Alexander”, so `VARCHAR(50)` would be better.

#### **3. Example**

```sql
-- Using CHAR(5)
CREATE TABLE test_char (
    code CHAR(5)
);

INSERT INTO test_char (code) VALUES ('AB');
-- The value is stored as 'AB   ' (with 3 extra spaces)

-- Using VARCHAR(5)
CREATE TABLE test_varchar (
    code VARCHAR(5)
);

INSERT INTO test_varchar (code) VALUES ('AB');
-- The value is stored as 'AB' (no extra spaces)
```

#### **4. Performance**

In earlier systems, `CHAR` and `VARCHAR` had performance differences, but in modern PostgreSQL, there is **almost no difference** in speed. However, `VARCHAR` is generally preferred because it is more flexible and uses space more efficiently.

---

### **Conclusion**

The main difference between `VARCHAR` and `CHAR` is that `CHAR` always stores a fixed number of characters by adding spaces, while `VARCHAR` stores only the characters you enter. In most cases, `VARCHAR` is a better choice for text data because it is more flexible and does not waste space.

## 5. Explain the purpose of the WHERE clause in a SELECT statement.
In SQL (Structured Query Language), the `SELECT` statement is used to retrieve data from a table. The **`WHERE` clause** is an important part of the `SELECT` statement. It is used to **filter the rows** and return **only those that meet a specific condition**.

#### **Purpose of the WHERE Clause**

The main purpose of the `WHERE` clause is to **limit the result** of a query by applying conditions. Without the `WHERE` clause, a `SELECT` statement returns **all rows** from a table. But in most cases, we only want to see specific data, not the whole table. That’s where the `WHERE` clause is used.

#### **Example**

Suppose we have a table called `students`:

```sql
CREATE TABLE students (
    id SERIAL,
    name TEXT,
    age INT
);
```

And the table has the following data:

| id | name    | age |
| -- | ------- | --- |
| 1  | Alice   | 18  |
| 2  | Bob     | 20  |
| 3  | Charlie | 18  |

If we want to select only the students who are 18 years old, we use the `WHERE` clause:

```sql
SELECT * FROM students
WHERE age = 18;
```

**Result:**

| id | name    | age |
| -- | ------- | --- |
| 1  | Alice   | 18  |
| 3  | Charlie | 18  |

This query returns only the rows where the age is 18.

#### **Uses of WHERE Clause**

* Filter rows based on values (e.g., `age = 18`)
* Combine multiple conditions using `AND` / `OR`
* Use comparison operators like `=`, `<`, `>`, `<=`, `>=`, `<>`
* Use pattern matching (e.g., `LIKE 'A%'`)
* Work with `IN`, `BETWEEN`, and `IS NULL`

---

### **Conclusion**

The `WHERE` clause in a `SELECT` statement is used to **filter the data** and return only the rows that match a given condition. It helps in retrieving **specific and meaningful results** from large datasets, making queries more useful and efficient.

## 6. What are the LIMIT and OFFSET clauses used for?
In SQL, especially in PostgreSQL, the **`LIMIT`** and **`OFFSET`** clauses are used with the `SELECT` statement to **control how many rows are returned** and **from which row the result starts**. These clauses are helpful when working with large datasets, allowing us to fetch only a part of the data at a time.


### **1. LIMIT Clause**

The `LIMIT` clause is used to **restrict the number of rows** returned by a query.

#### **Purpose**:

To return **only a specific number of rows**, instead of all rows from a table.

#### **Example**:

```sql
SELECT * FROM students
LIMIT 5;
```

This query will return **only the first 5 rows** from the `students` table.


### **2. OFFSET Clause**

The `OFFSET` clause is used to **skip a specific number of rows** before starting to return the result.

#### **Purpose**:

To **skip rows** and start displaying results from a certain position.

#### **Example**:

```sql
SELECT * FROM students
OFFSET 5;
```

This query skips the **first 5 rows** and returns the rest.


### **Using LIMIT and OFFSET Together**

The `LIMIT` and `OFFSET` clauses are often used **together for pagination** (breaking data into smaller pages).

#### **Example**:

```sql
SELECT * FROM students
LIMIT 5 OFFSET 10;
```

This means:

* Skip the first **10 rows**
* Then return the **next 5 rows**

This is commonly used in applications to show data page by page (e.g., 10 students per page).


### **Conclusion**

* `LIMIT` is used to **control how many rows** you want to get.
* `OFFSET` is used to **skip rows** before starting to return the result.
  Together, they help in managing large amounts of data efficiently, especially for **pagination** in web applications.

## 7. How can you modify data using UPDATE statements?
In PostgreSQL, the `UPDATE` statement is used to **change existing data** in a table. It allows you to **modify one or more columns** of one or more rows at a time. This is helpful when you need to correct information or change values based on certain conditions.

### **Basic Syntax**:

```sql
UPDATE table_name
SET column1 = value1,
    column2 = value2,
    ...
WHERE condition;
```

* **`table_name`** – the name of the table where you want to update the data.
* **`SET`** – lists the columns to be changed and the new values.
* **`WHERE`** – specifies which rows should be updated. Without a `WHERE` clause, **all rows** in the table will be updated (which can be dangerous if not intended).

### **Example 1: Update a single row**

Suppose you have a `students` table:

```sql
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name TEXT,
    age INT
);
```

Now, if you want to change the age of the student with `id = 1` to 20:

```sql
UPDATE students
SET age = 20
WHERE id = 1;
```

Only the student with ID 1 will have their age updated to 20.

### **Example 2: Update multiple columns**

```sql
UPDATE students
SET name = 'Alice', age = 22
WHERE id = 2;
```

This updates both the name and age of the student with ID 2.

### **Example 3: Update multiple rows**

```sql
UPDATE students
SET age = age + 1
WHERE age < 20;
```

This query increases the age of all students who are younger than 20 by 1.

### **Important Notes**:

* Always use the `WHERE` clause carefully to avoid updating the wrong rows.
* You can use subqueries and conditions in the `SET` or `WHERE` clauses.
* Use transactions (`BEGIN`, `COMMIT`, `ROLLBACK`) for large or critical updates to prevent accidental data loss.


### **Conclusion**

The `UPDATE` statement is used to **modify existing records** in a table. By using the `SET` clause to assign new values and the `WHERE` clause to specify which rows to update, you can efficiently and safely change data in a PostgreSQL database.



---
---
---


# Answer in Bengali

## 1. What is PostgreSQL?
PostgreSQL একটি শক্তিশালী এবং ব্যবসা-স্তরের ওপেন সোর্স রিলেশনাল ডাটাবেস। এটি রিলেশনাল এসকিউএল এবং নন-রিলেশনাল JSON ডেটা এবং কোয়েরি ব্যবহারের অনুমতি দেয়। PostgreSQL এর পিছনে একটি শক্তিশালী সম্প্রদায় রয়েছে। PostgreSQL হল একটি অত্যন্ত নির্ভরযোগ্য ডাটাবেস ম্যানেজমেন্ট সিস্টেম যেখানে চমৎকার স্তরের সমর্থন, নিরাপত্তা এবং নির্ভুলতা রয়েছে। বেশ কিছু মোবাইল এবং ওয়েব অ্যাপ্লিকেশন তাদের ডিফল্ট ডাটাবেস হিসাবে PostgreSQL ব্যবহার করে। অনেক ভূ-স্থানিক এবং বিশ্লেষণ সমাধানও PostgreSQL ব্যবহার করে। এর সর্বশেষ সংস্করণ হল PostgreSQL ১৭। PostgreSQL অত্যাধুনিক ডেটা প্রকার সমর্থন করে। আসলে, ডাটাবেস তৈরি করা হয়েছিল প্রচুর পরিমাণে ডেটা টাইপের কথা মাথায় রেখে। এর ডাটাবেস কর্মক্ষমতা তার প্রতিযোগীদের মত, যেমন ওরাকল এবং SQL সার্ভার। AWS তার Amazon Relational Database Service সহ PostgreSQL-এর জন্য সম্পূর্ণরূপে রক্ষণাবেক্ষণ করা ডাটাবেস পরিষেবা প্রদান করে। PostgreSQL এছাড়াও Amazon Aurora নির্মাণে ব্যবহৃত হয়। 

## 2. What is the purpose of a database schema in PostgreSQL?
PostgreSQL-এ একটি **ডেটাবেস স্কিমা** হলো একটি সংগঠিত কাঠামো, যা ডেটাবেসের মধ্যে টেবিল, ভিউ, ফাংশন, ইনডেক্স ইত্যাদি অবজেক্টগুলোকে গ্রুপ করে রাখে। এটি মূলত ডেটাবেসের ভিতরে একটি আলাদা লজিক্যাল স্পেস তৈরি করে, যেখানে নির্দিষ্ট ব্যবহারকারীর অধীনে বিভিন্ন ডেটা ও অবজেক্ট সংরক্ষণ করা যায়। স্কিমা ব্যবহারের মাধ্যমে ডেটাবেসে নামের সংঘর্ষ (naming conflict) এড়ানো যায়, যেমন—একই ডেটাবেসে দুইটি স্কিমায় একই নামে টেবিল থাকতে পারে। এটি বড় প্রজেক্টে মডিউলারিটি এবং নিরাপত্তা নিশ্চিত করে, কারণ প্রতিটি স্কিমার জন্য আলাদা পারমিশন সেট করা যায়। সুতরাং, PostgreSQL-এ স্কিমা ব্যবহার করলে ডেটাবেস পরিচালনা ও সংগঠন অনেক বেশি কার্যকর ও নিরাপদ হয়।

## 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.
PostgreSQL-এ, **Primary Key** এবং **Foreign Key** হল মৌলিক ধারণা যা ডেটা অখণ্ডতা বজায় রাখতে এবং টেবিলের মধ্যে সম্পর্ক স্থাপন করতে ব্যবহৃত হয়। এখানে উভয়ের স্পষ্ট ব্যাখ্যা দেওয়া হল:

### 🔑 **Primary Key**:

* **Primary Key** হল একটি টেবিলের একটি কলাম (অথবা কলামের একটি সেট) যা সেই টেবিলের প্রতিটি সারিকে অনন্যভাবে চিহ্নিত করে।
* এতে অবশ্যই **unique values** থাকতে হবে এবং **NULL** থাকতে পারবে না।
* প্রতিটি টেবিলে শুধুমাত্র একটি **Primary Key** থাকতে পারে, তবে এটি একাধিক কলাম (যাকে **Foreign Key** বলা হয়) দিয়ে তৈরি হতে পারে।
* যখন আপনি একটি Primary Key সংজ্ঞায়িত করেন, তখন PostgreSQL স্বয়ংক্রিয়ভাবে স্বতন্ত্রতা প্রয়োগের জন্য সেই কলামে একটি **unique index** তৈরি করে।

**উদাহরণ**:

```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    age INT
);
```

এখানে, `student_id` হল প্রাথমিক কী এবং প্রতিটি শিক্ষার্থীকে uniquely identify করবে।

### 🔗 **Foreign Key**:

* **Foreign Key** হল একটি কলাম (অথবা কলামের সেট) যা দুটি টেবিলের ডেটার মধ্যে একটি লিংক স্থাপন করে।
* এটি অন্য টেবিলের **primary key** (অথবা স্ব-রেফারেন্সের ক্ষেত্রে একই টেবিল) বোঝায়।
* এটি **referential integrity** নিশ্চিত করে, যার অর্থ আপনি foreign key কলামে এমন কোনও মান সন্নিবেশ করতে পারবেন না যা রেফারেন্স করা primary key কলামে বিদ্যমান নেই।
* আপনি **ON DELETE CASCADE** বা **ON UPDATE RESTRICT** এর মতো নিয়মও সেট করতে পারেন যাতে রেফারেন্স করা ডেটা পরিবর্তন হলে কী ঘটে তা নির্ধারণ করা যায়।

**উদাহরণ**:

```sql
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_name TEXT NOT NULL
);
```

এখানে, `enrollments`-এ `student_id` হল একটি foreign key যা `students` টেবিলে `student_id` উল্লেখ করে। এটি নিশ্চিত করে যে শুধুমাত্র বিদ্যমান শিক্ষার্থীদের `enrollments` টেবিলে যোগ করা যেতে পারে।

### সারাংশ:
* **Primary Key:** নিজস্ব টেবিলের মধ্যে একটি সারিকে অনন্যভাবে চিহ্নিত করে।
* **Foreign Key:** টেবিলের মধ্যে ডেটা লিঙ্ক করার জন্য অন্য টেবিলের একটি প্রাথমিক কী উল্লেখ করে।

## 4. What is the difference between the VARCHAR and CHAR data types?
PostgreSQL-এ, `VARCHAR` এবং `CHAR` উভয়ই text বা character strings সংরক্ষণের জন্য ব্যবহৃত ডেটা টাইপ। তবে, ডেটা কীভাবে সংরক্ষণ এবং পরিচালনা করে তার মধ্যে কিছু গুরুত্বপূর্ণ পার্থক্য রয়েছে।

#### **1. Length and Storage**

* `CHAR(n)` হল একটি **fixed-length** ডেটা টাইপ। এর অর্থ হল এটি সর্বদা ঠিক `n` অক্ষর সংরক্ষণ করে। যদি ইনপুট `n` এর চেয়ে ছোট হয়, তাহলে PostgreSQL শেষে অতিরিক্ত **spaces** যোগ করবে যাতে এটি `n` অক্ষর দীর্ঘ হয়।

* `VARCHAR(n)` হল একটি **variable-length** ডেটা টাইপ। এটি কেবলমাত্র আপনার দেওয়া অক্ষরগুলি সংরক্ষণ করে, সর্বাধিক `n` অক্ষর পর্যন্ত। এটি অতিরিক্ত স্পেস যোগ করে **না**।

#### **2. ব্যবহার**

* `CHAR` সাধারণত তখন ব্যবহৃত হয় যখন ডেটার দৈর্ঘ্য সর্বদা একই থাকে। উদাহরণস্বরূপ, "US" বা "IN" এর মতো একটি দেশের কোড `CHAR(2)` তে সংরক্ষণ করা যেতে পারে কারণ এতে সর্বদা 2টি অক্ষর থাকে।
* `VARCHAR` ব্যবহার করা হয় যখন ডেটার দৈর্ঘ্য ভিন্ন হতে পারে। উদাহরণস্বরূপ, একজন ব্যক্তির নাম "Ali" এর মতো ছোট বা "Alexander" এর মতো লম্বা হতে পারে, তাই `VARCHAR(50)` ভালো হবে।

#### **3. উদাহরণ**

```sql
-- Using CHAR(5)
CREATE TABLE test_char (
    code CHAR(5)
);

INSERT INTO test_char (code) VALUES ('AB');
-- The value is stored as 'AB   ' (with 3 extra spaces)

-- Using VARCHAR(5)
CREATE TABLE test_varchar (
    code VARCHAR(5)
);

INSERT INTO test_varchar (code) VALUES ('AB');
-- The value is stored as 'AB' (no extra spaces)
```

#### **4. কর্মক্ষমতা**

পূর্ববর্তী সিস্টেমগুলিতে, `CHAR` এবং `VARCHAR` এর কর্মক্ষমতার পার্থক্য ছিল, কিন্তু আধুনিক PostgreSQL এ, গতিতে **প্রায় কোনও পার্থক্য** নেই। তবে, `VARCHAR` সাধারণত পছন্দ করা হয় কারণ এটি আরও নমনীয় এবং স্থান আরও দক্ষতার সাথে ব্যবহার করে।

---

### **উপসংহার**

`VARCHAR` এবং `CHAR` এর মধ্যে প্রধান পার্থক্য হল যে `CHAR` সর্বদা স্থান যোগ করে একটি নির্দিষ্ট সংখ্যক অক্ষর সংরক্ষণ করে, যখন `VARCHAR` শুধুমাত্র আপনার প্রবেশ করা অক্ষর সংরক্ষণ করে। বেশিরভাগ ক্ষেত্রে, `VARCHAR` টেক্সট ডেটার জন্য একটি ভাল পছন্দ কারণ এটি আরও নমনীয় এবং স্থান নষ্ট করে না।




## 5. Explain the purpose of the WHERE clause in a SELECT statement.
SQL (Structured Query Language) -এ, `SELECT` statement একটি টেবিল থেকে ডেটা পুনরুদ্ধার করতে ব্যবহৃত হয়। **`WHERE` clause** হল `SELECT` statement এর একটি গুরুত্বপূর্ণ অংশ। এটি **row filter** করতে এবং **শুধুমাত্র সেইগুলি return করতে ব্যবহৃত হয় যা একটি নির্দিষ্ট শর্ত পূরণ করে**।

#### **Purpose of the WHERE Clause**

`WHERE` ধারার মূল উদ্দেশ্য হল শর্ত প্রয়োগ করে একটি প্রশ্নের ফলাফল **সীমাবদ্ধ** করা। `WHERE` clause ছাড়া, একটি `SELECT` statement একটি টেবিল থেকে **সমস্ত সারি** return করে। কিন্তু বেশিরভাগ ক্ষেত্রে, আমরা কেবল নির্দিষ্ট ডেটা দেখতে চাই, পুরো টেবিল নয়। সেখানেই `WHERE` clause ব্যবহার করা হয়।

#### **উদাহরণ**

ধরুন আমাদের `students` নামে একটি টেবিল আছে:

```sql
CREATE TABLE students (
    id SERIAL,
    name TEXT,
    age INT
);
```

এবং টেবিলটিতে নিম্নলিখিত তথ্য রয়েছে:

| id | name    | age |
| -- | ------- | --- |
| 1  | Alice   | 18  |
| 2  | Bob     | 20  |
| 3  | Charlie | 18  |

যদি আমরা শুধুমাত্র 18 বছর বয়সী শিক্ষার্থীদের নির্বাচন করতে চাই, তাহলে আমরা `WHERE` clause ব্যবহার করি:

```sql
SELECT * FROM students
WHERE age = 18;
```

**ফলাফল:**

| id | name    | age |
| -- | ------- | --- |
| 1  | Alice   | 18  |
| 3  | Charlie | 18  |

এই কোয়েরিটি শুধুমাত্র সেই সারিগুলি return করে যেখানে বয়স 18 বছর।

#### **Uses of WHERE Clause**

* Filter rows based on values (e.g., `age = 18`)
* Combine multiple conditions using `AND` / `OR`
* Use comparison operators like `=`, `<`, `>`, `<=`, `>=`, `<>`
* Use pattern matching (e.g., `LIKE 'A%'`)
* Work with `IN`, `BETWEEN`, and `IS NULL`

### **উপসংহার**

`SELECT` statement-এ `WHERE` clause-টি **ডেটা ফিল্টার** করতে এবং শুধুমাত্র সেই সারিগুলি return করতে ব্যবহৃত হয় যা একটি নির্দিষ্ট শর্তের সাথে মেলে। এটি বৃহৎ ডেটাসেট থেকে **নির্দিষ্ট এবং অর্থপূর্ণ ফলাফল** পুনরুদ্ধার করতে সাহায্য করে, কোয়েরিগুলিকে আরও কার্যকর এবং দক্ষ করে তোলে।


## 6. What are the LIMIT and OFFSET clauses used for?
SQL-এ, বিশেষ করে PostgreSQL-এ, **`LIMIT`** এবং **`OFFSET`** clauses গুলো `SELECT` statement এর সাথে ব্যবহার করা হয় **কতগুলি row return করতে হবে** এবং **কোন row থেকে ফলাফল শুরু হবে** তা নিয়ন্ত্রণ করার জন্য। এই ধারাগুলি বৃহৎ ডেটাসেটগুলির সাথে কাজ করার সময় সহায়ক, যা আমাদের একবারে কেবলমাত্র ডেটার একটি অংশ আনতে দেয়।


### **1. LIMIT Clause**

`LIMIT` ধারাটি একটি কোয়েরি দ্বারা ফেরত আসা **সারির সংখ্যা সীমাবদ্ধ** করতে ব্যবহৃত হয়।

#### **Purpose**:

একটি টেবিল থেকে সমস্ত সারি না দিয়ে **শুধুমাত্র একটি নির্দিষ্ট সংখ্যক সারি** return করা।

#### **উদাহরণ**:

```sql
SELECT * FROM students
LIMIT 5;
```

এই কোয়েরি `students` টেবিল থেকে **শুধুমাত্র প্রথম 5টি row** return করবে।


### **2. OFFSET Clause**

`OFFSET` Clause-টি **নির্দিষ্ট সংখ্যক সারি এড়িয়ে** ফলাফল return করতে ব্যবহার করা হয়।

#### **Purpose**:

**skip rows** এবং একটি নির্দিষ্ট অবস্থান থেকে ফলাফল প্রদর্শন শুরু করা।

#### **উদাহরণ**:

```sql
SELECT * FROM students
OFFSET 5;
```

এই কোয়েরি **প্রথম 5টি সারি** এড়িয়ে যায় এবং বাকিগুলি return করে।


### **LIMIT এবং OFFSET একসাথে ব্যবহার করা**

`LIMIT` এবং `OFFSET` clauses গুলি প্রায়শই **একসাথে pagination করার** (ডেটা ছোট পৃষ্ঠায় ভাঙার) জন্য ব্যবহৃত হয়।

#### **উদাহরণ**:

```sql
SELECT * FROM students
LIMIT 5 OFFSET 10;
```

এর অর্থ হল:

* Skip the first **10 rows**
* Then return the **next 5 rows**

এটি সাধারণত অ্যাপ্লিকেশনগুলিতে পৃষ্ঠা অনুসারে ডেটা দেখানোর জন্য ব্যবহৃত হয় (যেমন, প্রতি পৃষ্ঠায় ১০ জন শিক্ষার্থী)।


### **উপসংহার**

* আপনি কতগুলি rows পেতে চান তা নিয়ন্ত্রণ করতে `LIMIT` ব্যবহার করা হয়।
* ফলাফল ফেরত দেওয়ার আগে rows এড়িয়ে যেতে `OFFSET` ব্যবহার করা হয়।

একত্রে, তারা প্রচুর পরিমাণে ডেটা দক্ষতার সাথে করতে সাহায্য করে, বিশেষ করে ওয়েব অ্যাপ্লিকেশনগুলিতে **pagination** এর জন্য।


## 7. How can you modify data using UPDATE statements?
PostgreSQL-এ, `UPDATE` স্টেটমেন্টটি একটি টেবিলের **existing data** পরিবর্তন করতে ব্যবহৃত হয়। এটি আপনাকে এক বা একাধিক সারির **এক বা একাধিক কলাম change** করতে দেয়। নির্দিষ্ট শর্তের উপর ভিত্তি করে তথ্য সংশোধন বা মান পরিবর্তন করার সময় এটি সহায়ক।

### **Basic Syntax**:

```sql
UPDATE table_name
SET column1 = value1,
    column2 = value2,
    ...
WHERE condition;
```

* **`table_name`** – the name of the table where you want to update the data.
* **`SET`** – lists the columns to be changed and the new values.
* **`WHERE`** – specifies which rows should be updated. Without a `WHERE` clause, **all rows** in the table will be updated (which can be dangerous if not intended).

### **Example 1: Update a single row**

ধরুন আপনার একটি `students` টেবিল আছে:

```sql
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name TEXT,
    age INT
);
```

এখন, যদি আপনি `id = 1` সহ শিক্ষার্থীর বয়স 20-তে পরিবর্তন করতে চান:

```sql
UPDATE students
SET age = 20
WHERE id = 1;
```

শুধুমাত্র যাদের আইডি ১ আছে তাদের বয়স ২০ বছর করা হবে।

### **Example 2: Update multiple columns**

```sql
UPDATE students
SET name = 'Alice', age = 22
WHERE id = 2;
```

এটি আইডি ২ আছে তাদের নাম এবং বয়স উভয়ই আপডেট করে।

### **Example 3: Update multiple rows**

```sql
UPDATE students
SET age = age + 1
WHERE age < 20;
```

এই কোয়েরিটি ২০ বছরের কম বয়সী সকল শিক্ষার্থীর বয়স ১ করে বৃদ্ধি করে।

### **Important Notes**:

* Always use the `WHERE` clause carefully to avoid updating the wrong rows.
* You can use subqueries and conditions in the `SET` or `WHERE` clauses.
* Use transactions (`BEGIN`, `COMMIT`, `ROLLBACK`) for large or critical updates to prevent accidental data loss.


### **উপসংহার**
`UPDATE` স্টেটমেন্টটি একটি টেবিলে **বিদ্যমান রেকর্ড পরিবর্তন** করতে ব্যবহৃত হয়। নতুন মান নির্ধারণের জন্য `SET` ধারা এবং কোন সারি আপডেট করতে হবে তা নির্দিষ্ট করার জন্য `WHERE` ধারা ব্যবহার করে, আপনি একটি PostgreSQL ডাটাবেসে দক্ষতার সাথে এবং নিরাপদে ডেটা পরিবর্তন করতে পারেন।
