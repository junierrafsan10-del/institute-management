-- Drop existing tables
DROP TABLE IF EXISTS attendance CASCADE;
DROP TABLE IF EXISTS fees CASCADE;
DROP TABLE IF EXISTS results CASCADE;
DROP TABLE IF EXISTS notices CASCADE;
DROP TABLE IF EXISTS faculty CASCADE;
DROP TABLE IF EXISTS students CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- ===== RECREATE TABLES =====

-- Users table
CREATE TABLE users (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  username text UNIQUE NOT NULL,
  password text NOT NULL,
  role text NOT NULL DEFAULT 'student' CHECK (role IN ('student', 'admin')),
  ref_id text,
  email text,
  created_at timestamptz DEFAULT now()
);

-- Students table
CREATE TABLE students (
  id text PRIMARY KEY,
  name text NOT NULL,
  email text,
  dept text NOT NULL,
  year text NOT NULL,
  sem int NOT NULL DEFAULT 1,
  phone text,
  address text,
  cgpa real DEFAULT 0,
  photo text,
  created_at timestamptz DEFAULT now()
);

-- Faculty table
CREATE TABLE faculty (
  id text PRIMARY KEY,
  name text NOT NULL,
  dept text NOT NULL,
  designation text,
  subjects text,
  email text,
  phone text,
  created_at timestamptz DEFAULT now()
);

-- Results table
CREATE TABLE results (
  id serial PRIMARY KEY,
  student_id text REFERENCES students(id) ON DELETE CASCADE,
  semester int NOT NULL,
  subject text NOT NULL,
  credits int NOT NULL,
  marks int NOT NULL,
  grade text,
  points int,
  created_at timestamptz DEFAULT now()
);

-- Fees table
CREATE TABLE fees (
  id serial PRIMARY KEY,
  student_id text REFERENCES students(id) ON DELETE CASCADE,
  description text NOT NULL,
  amount int NOT NULL,
  paid int DEFAULT 0,
  date date,
  status text DEFAULT 'unpaid' CHECK (status IN ('paid', 'partial', 'unpaid')),
  created_at timestamptz DEFAULT now()
);

-- Attendance table
CREATE TABLE attendance (
  id serial PRIMARY KEY,
  student_id text REFERENCES students(id) ON DELETE CASCADE,
  subject text NOT NULL,
  total int DEFAULT 0,
  attended int DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Notices table
CREATE TABLE notices (
  id serial PRIMARY KEY,
  title text NOT NULL,
  body text,
  date date DEFAULT CURRENT_DATE,
  created_at timestamptz DEFAULT now()
);

-- ===== INDEXES =====
CREATE INDEX idx_results_student ON results(student_id);
CREATE INDEX idx_fees_student ON fees(student_id);
CREATE INDEX idx_attendance_student ON attendance(student_id);
CREATE INDEX idx_users_username ON users(username);

-- ===== SEED DATA =====

INSERT INTO students (id, name, email, dept, year, sem, phone, address, cgpa) VALUES
  ('S1001', 'Arif Hossain', 'arif@uist.edu', 'CSE', '3rd', 5, '01711111111', 'Dhaka', 8.7),
  ('S1002', 'Fatima Begum', 'fatima@uist.edu', 'EEE', '2nd', 3, '01711111112', 'Chittagong', 8.2),
  ('S1003', 'Tanvir Ahmed', 'tanvir@uist.edu', 'BBA', '4th', 7, '01711111113', 'Sylhet', 7.9),
  ('S1004', 'Nusrat Jahan', 'nusrat@uist.edu', 'Civil', '3rd', 5, '01711111114', 'Rajshahi', 9.1),
  ('S1005', 'Mahbub Karim', 'mahbub@uist.edu', 'CSE', '1st', 1, '01711111115', 'Khulna', 8.5),
  ('S1006', 'Shamim Reza', 'shamim@uist.edu', 'EEE', '3rd', 5, '01711111116', 'Barisal', 8.9),
  ('S1007', 'Jannatul Ferdous', 'jannatul@uist.edu', 'BBA', '2nd', 3, '01711111117', 'Dhaka', 8.1),
  ('S1008', 'Hasan Mahmud', 'hasan@uist.edu', 'Civil', '4th', 7, '01711111118', 'Comilla', 7.7),
  ('S1009', 'Tahmina Akhter', 'tahmina@uist.edu', 'CSE', '2nd', 3, '01711111119', 'Mymensingh', 9.3),
  ('S1010', 'Rafiul Islam', 'rafiul@uist.edu', 'BBA', '1st', 1, '01711111120', 'Rangpur', 8.0);

INSERT INTO faculty (id, name, dept, designation, subjects, email, phone) VALUES
  ('F1001', 'Prof. Kamal Hossain', 'CSE', 'Professor & Head', 'Data Structures, Algorithms', 'kamal@uist.edu', '01711111121'),
  ('F1002', 'Dr. Farzana Akhter', 'EEE', 'Associate Professor', 'Circuit Analysis, Power Systems', 'farzana@uist.edu', '01711111122'),
  ('F1003', 'Mr. Shahidul Islam', 'BBA', 'Assistant Professor', 'Marketing, Finance', 'shahidul@uist.edu', '01711111123'),
  ('F1004', 'Dr. Mahmuda Begum', 'Civil', 'Professor', 'Structural Analysis, Geotechnical Engg', 'mahmuda@uist.edu', '01711111124');

INSERT INTO notices (title, body, date) VALUES
  ('Semester Final Exam Schedule', 'End semester examinations will begin from June 10, 2025.', '2025-04-01'),
  ('Tech Fest 2025', 'Annual inter-university tech fest. Prizes worth Tk. 2,00,000.', '2025-03-20'),
  ('Library Extended Hours', 'Library open until 11 PM during exam season.', '2025-03-15'),
  ('Internship Opportunity', 'Google Summer of Code 2025 — contact CSE department.', '2025-03-10'),
  ('Campus Placement Drive', 'Top recruiters visiting campus in June.', '2025-03-05');

INSERT INTO users (username, password, role, ref_id) VALUES
  ('admin', 'admin123', 'admin', NULL),
  ('S1001', 'pass123', 'student', 'S1001'),
  ('S1002', 'pass123', 'student', 'S1002'),
  ('S1003', 'pass123', 'student', 'S1003'),
  ('S1004', 'pass123', 'student', 'S1004'),
  ('S1005', 'pass123', 'student', 'S1005'),
  ('S1006', 'pass123', 'student', 'S1006'),
  ('S1007', 'pass123', 'student', 'S1007'),
  ('S1008', 'pass123', 'student', 'S1008'),
  ('S1009', 'pass123', 'student', 'S1009'),
  ('S1010', 'pass123', 'student', 'S1010');

SELECT 'Tables recreated successfully!' as status;