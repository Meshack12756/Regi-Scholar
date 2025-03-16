create schema registration;
use registration;
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    year_of_study INT CHECK (year_of_study BETWEEN 1 AND 4)
);
CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL,
    office_room VARCHAR(50),
    phone_extension VARCHAR(20),
    email VARCHAR(255) UNIQUE NOT NULL
);
CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    designation VARCHAR(50) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    year_of_study INT CHECK (year_of_study BETWEEN 1 AND 4),
    classroom VARCHAR(50),
    instructor_id INT NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);
CREATE TABLE TutorialSections (
    tutorial_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    ta_id INT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (ta_id) REFERENCES Instructors(instructor_id) -- TA shares attributes with Instructors
);
CREATE TABLE LabSections (
    lab_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    la_id INT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (la_id) REFERENCES Instructors(instructor_id) -- LA shares attributes with Instructors
);
CREATE TABLE Prerequisites (
    course_id INT NOT NULL,
    prerequisite_id INT NOT NULL,
    PRIMARY KEY (course_id, prerequisite_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (prerequisite_id) REFERENCES Courses(course_id)
);
CREATE TABLE AntiRequisites (
    course_id INT NOT NULL,
    anti_requisite_id INT NOT NULL,
    PRIMARY KEY (course_id, anti_requisite_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (anti_requisite_id) REFERENCES Courses(course_id)
);
CREATE TABLE Registrations (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    status ENUM('Registered', 'Completed') NOT NULL,
    grade ENUM('Pass', 'Fail') NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
CREATE TABLE TAs (
    ta_id INT PRIMARY KEY,
    FOREIGN KEY (ta_id) REFERENCES Instructors(instructor_id)
);

CREATE TABLE LAs (
    la_id INT PRIMARY KEY,
    FOREIGN KEY (la_id) REFERENCES Instructors(instructor_id)
);

INSERT INTO Students (name, year_of_study)
VALUES
('Alice Wendo', 1),
('Bob Maina', 2),
('Carol Wangari', 3),
('David Nyongesa', 4),
('Eve Mito', 2);

INSERT INTO Instructors (name, department, office_room, phone_extension, email)
VALUES
('Dr. John Nyaga', 'Computer Science', 'CS101', '1234', 'jnyaga@jkuat.ac.ke'),
('Dr. Emily Maina', 'Mathematics', 'MATH202', '5678', 'emaina@jkuat.ac.ke'),
('Dr. Sarah Grace', 'Physics', 'PHY303', '9101', 'sgrace@jkuat.ac.ke'),
('Dr. Peter Muita', 'Engineering', 'ENG404', '1122', 'pmuita@jkuat.ac.ke');

INSERT INTO Courses (designation, title, description, year_of_study, classroom, instructor_id)
VALUES
('CS101', 'Introduction to Computer Science', 'Basic programming concepts', 1, 'Room A1', 1),
('MATH202', 'Calculus II', 'Advanced integral calculus', 2, 'Room B2', 2),
('PHY303', 'Mechanics', 'Principles of mechanics and motion', 3, 'Room C3', 3),
('ENG404', 'Thermodynamics', 'Heat and energy systems', 4, 'Room D4', 4);

INSERT INTO TutorialSections (course_id, ta_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

INSERT INTO LabSections (course_id, la_id)
VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 1);

INSERT INTO Prerequisites (course_id, prerequisite_id)
VALUES
(2, 1), -- MATH202 requires CS101
(3, 2), -- PHY303 requires MATH202
(4, 3); -- ENG404 requires PHY303

registrationsINSERT INTO AntiRequisites (course_id, anti_requisite_id)
VALUES
(2, 3), -- MATH202 and PHY303 are anti-requisites
(4, 1); -- ENG404 and CS101 are anti-requisites

INSERT INTO Registrations (student_id, course_id, status, grade)
VALUES
(1, 1, 'Completed', 'Pass'),
(2, 2, 'Registered', NULL),
(3, 3, 'Completed', 'Fail'),
(4, 4, 'Registered', NULL),
(5, 1, 'Completed', 'Pass');

INSERT INTO TAs (ta_id)
VALUES
(1),
(2),
(3),
(4);

INSERT INTO LAs (la_id)
VALUES
(1),
(2),
(3),
(4);

alter table tas
    add name VARCHAR(255) NOT NULL,
    add department VARCHAR(255) NOT NULL,
    add office_room VARCHAR(50),
    add phone_extension VARCHAR(20),
    add email VARCHAR(255)NOT NULL;
   
    
INSERT INTO Courses (designation, title, description, year_of_study, classroom, instructor_id)
VALUES
('CS102', 'Data Structures', 'Introduction to data structures', 1, 'Room A2', 5),
('MATH203', 'Linear Algebra', 'Matrix theory and linear equations', 2, 'Room B3', 6),
('PHY304', 'Electricity and Magnetism', 'Fundamentals of electromagnetism', 3, 'Room C4', 7),
('ENG405', 'Fluid Dynamics', 'Study of fluid motion', 4, 'Room D5', 8),
('CS103', 'Algorithms', 'Algorithm design and analysis', 1, 'Room A3', 9),
('MATH204', 'Probability', 'Introduction to probability theory', 2, 'Room B4', 10),
('PHY305', 'Optics', 'Study of light and optical systems', 3, 'Room C5', 11),
('ENG406', 'Materials Science', 'Properties of engineering materials', 4, 'Room D6', 12),
('CS104', 'Operating Systems', 'Concepts of operating systems', 1, 'Room A4', 13),
('MATH205', 'Statistics', 'Descriptive and inferential statistics', 2, 'Room B5', 14),
('PHY306', 'Quantum Mechanics', 'Foundations of quantum theory', 3, 'Room C6', 15),
('ENG407', 'Control Systems', 'Theory and design of control systems', 4, 'Room D7', 16),
('CS105', 'Computer Networks', 'Networking principles and protocols', 1, 'Room A5', 17),
('MATH206', 'Numerical Methods', 'Numerical computation techniques', 2, 'Room B6', 18),
('PHY307', 'Thermal Physics', 'Thermal properties of matter', 3, 'Room C7', 19),
('ENG408', 'Engineering Economics', 'Economic principles in engineering', 4, 'Room D8', 20),
('CS106', 'Machine Learning', 'Basics of machine learning algorithms', 1, 'Room A6', 21),
('MATH207', 'Graph Theory', 'Study of graphs and their applications', 2, 'Room B7', 22),
('PHY308', 'Nuclear Physics', 'Study of atomic nuclei', 3, 'Room C8', 23),
('ENG409', 'Robotics', 'Fundamentals of robotics systems', 4, 'Room D9', 24),
('CS107', 'Artificial Intelligence', 'AI principles and applications', 1, 'Room A7', 25),
('MATH208', 'Differential Equations', 'Theory of differential equations', 2, 'Room B8', 26),
('PHY309', 'Astrophysics', 'Study of stars and galaxies', 3, 'Room C9', 27),
('ENG410', 'Environmental Engineering', 'Sustainability and environmental impact', 4, 'Room D10', 28),
('CS108', 'Web Development', 'Designing and developing websites', 1, 'Room A8', 29),
('MATH209', 'Discrete Mathematics', 'Logic, set theory, and combinatorics', 2, 'Room B9', 30),
('PHY310', 'Solid State Physics', 'Properties of solid materials', 3, 'Room C10', 31),
('ENG411', 'Structural Analysis', 'Principles of structural engineering', 4, 'Room D11', 32),
('CS109', 'Database Systems', 'Database design and SQL', 1, 'Room A9', 33),
('MATH210', 'Complex Analysis', 'Theory of complex variables', 2, 'Room B10', 34),
('PHY311', 'Plasma Physics', 'Properties of ionized gases', 3, 'Room C11', 35),
('ENG412', 'Transportation Engineering', 'Planning and design of transport systems', 4, 'Room D12', 36),
('CS110', 'Cybersecurity', 'Foundations of security and privacy', 1, 'Room A10', 37),
('MATH211', 'Topology', 'Study of topological spaces', 2, 'Room B11', 38),
('PHY312', 'Biophysics', 'Physical principles of biological systems', 3, 'Room C12', 39),
('ENG413', 'Energy Systems', 'Design of renewable energy systems', 4, 'Room D13', 40),
('CS111', 'Mobile App Development', 'Developing applications for mobile devices', 1, 'Room A11', 41),
('MATH212', 'Game Theory', 'Mathematics of strategic interaction', 2, 'Room B12', 42),
('PHY313', 'Geophysics', 'Physics of Earth systems', 3, 'Room C13', 43),
('ENG414', 'Project Management', 'Managing engineering projects effectively', 4, 'Room D14', 44),
('CS112', 'Computer Graphics', 'Fundamentals of visual computing', 1, 'Room A12', 45),
('MATH213', 'Operations Research', 'Optimization and decision-making techniques', 2, 'Room B13', 46),
('PHY314', 'Classical Mechanics', 'Advanced study of mechanics', 3, 'Room C14', 47),
('ENG415', 'Automation Engineering', 'Design of automated systems', 4, 'Room D15', 48),
('CS113', 'Cloud Computing', 'Concepts of cloud infrastructure', 1, 'Room A13', 49),
('MATH214', 'Applied Mathematics', 'Mathematics for real-world applications', 2, 'Room B14', 50),
('PHY315', 'Acoustics', 'Study of sound and its properties', 3, 'Room C15', 51),
('ENG416', 'Biomedical Engineering', 'Engineering solutions in healthcare', 4, 'Room D16', 52);

INSERT INTO Students (name, year_of_study)
VALUES
('Faith Chepkorir', 1),
('George Mwangi', 2),
('Hannah Nduta', 3),
('Ian Omondi', 4),
('Joyce Atieno', 1),
('Kennedy Kiptoo', 2),
('Lydia Njeri', 3),
('Mark Wanjala', 4),
('Naomi Cherono', 1),
('Peter Onyango', 2),
('Quincy Barasa', 3),
('Rachel Achieng', 4),
('Stephen Kiprotich', 1),
('Tracy Wanjiku', 2),
('Victor Nyaga', 3),
('Winnie Mutiso', 4),
('Brian Kiplagat', 1),
('Catherine Mwende', 2),
('Dennis Ochieng', 3),
('Esther Wairimu', 4),
('Francis Njogu', 1),
('Grace Mbogo', 2),
('Henry Ngeno', 3),
('Irene Wambui', 4),
('James Mutua', 1),
('Kevin Chege', 2),
('Linda Akinyi', 3),
('Margaret Cheruiyot', 4),
('Nicholas Otieno', 1),
('Paul Njiru', 2),
('Rose Naliaka', 3),
('Samuel Kiplangat', 4),
('Titus Kariuki', 1),
('Ursula Amollo', 2),
('Violet Kemunto', 3),
('Walter Njoroge', 4),
('Yvonne Njambi', 1),
('Zachary Korir', 2),
('Ann Muthoni', 3),
('Benson Okello', 4),
('Christine Waceke', 1),
('Dominic Were', 2),
('Eunice Mwikali', 3),
('Felix Oduor', 4),
('Gloria Nanyama', 1),
('Harrison Kibet', 2),
('Isabella Ndungu', 3),
('Joseph Mwiti', 4),
('Keziah Njau', 1);
('Lionel Nteebe', 3);

INSERT INTO Instructors (name, department, office_room, phone_extension, email)
VALUES





('Dr. Alice Wanjiku', 'Computer Science', 'CS102', '1235', 'awanjiku@jkuat.ac.ke'),
('Dr. Brian Kiptoo', 'Mathematics', 'MATH203', '5679', 'bkiptoo@jkuat.ac.ke'),
('Dr. Carol Naliaka', 'Physics', 'PHY304', '9102', 'cnaliaka@jkuat.ac.ke'),
('Dr. Daniel Mutua', 'Engineering', 'ENG405', '1123', 'dmutua@jkuat.ac.ke'),
('Dr. Esther Omondi', 'Computer Science', 'CS103', '1236', 'eomondi@jkuat.ac.ke'),
('Dr. Francis Mwangi', 'Mathematics', 'MATH204', '5680', 'fmwangi@jkuat.ac.ke'),
('Dr. Grace Chepkemoi', 'Physics', 'PHY305', '9103', 'gchepkemoi@jkuat.ac.ke'),
('Dr. Henry Wekesa', 'Engineering', 'ENG406', '1124', 'hwekesa@jkuat.ac.ke'),
('Dr. Irene Mutiso', 'Computer Science', 'CS104', '1237', 'imutiso@jkuat.ac.ke'),
('Dr. James Ochieng', 'Mathematics', 'MATH205', '5681', 'jochieng@jkuat.ac.ke'),
('Dr. Kevin Kiprotich', 'Physics', 'PHY306', '9104', 'kkiprotich@jkuat.ac.ke'),
('Dr. Linda Atieno', 'Engineering', 'ENG407', '1125', 'latieno@jkuat.ac.ke'),
('Dr. Mark Baraza', 'Computer Science', 'CS105', '1238', 'mbaraza@jkuat.ac.ke'),
('Dr. Nancy Cherono', 'Mathematics', 'MATH206', '5682', 'ncherono@jkuat.ac.ke'),
('Dr. Oscar Onyango', 'Physics', 'PHY307', '9105', 'oonyango@jkuat.ac.ke'),
('Dr. Peninah Wanjiru', 'Engineering', 'ENG408', '1126', 'pwanjiru@jkuat.ac.ke'),
('Dr. Quincy Wekesa', 'Computer Science', 'CS106', '1239', 'qwekesa@jkuat.ac.ke'),
('Dr. Rachel Nduta', 'Mathematics', 'MATH207', '5683', 'rnduta@jkuat.ac.ke'),
('Dr. Samuel Kiplangat', 'Physics', 'PHY308', '9106', 'skiplangat@jkuat.ac.ke'),
('Dr. Tracy Mburu', 'Engineering', 'ENG409', '1127', 'tmburu@jkuat.ac.ke'),
('Dr. Victor Njoroge', 'Computer Science', 'CS107', '1240', 'vnjoroge@jkuat.ac.ke'),
('Dr. Winnie Waceke', 'Mathematics', 'MATH208', '5684', 'wwaceke@jkuat.ac.ke'),
('Dr. Xavier Mutua', 'Physics', 'PHY309', '9107', 'xmutua@jkuat.ac.ke'),
('Dr. Yvonne Chebet', 'Engineering', 'ENG410', '1128', 'ychebet@jkuat.ac.ke'),
('Dr. Zachary Kipkirui', 'Computer Science', 'CS108', '1241', 'zkipkirui@jkuat.ac.ke'),
('Dr. Ann Wambui', 'Mathematics', 'MATH209', '5685', 'awambui@jkuat.ac.ke'),
('Dr. Benjamin Okello', 'Physics', 'PHY310', '9108', 'bokello@jkuat.ac.ke'),
('Dr. Catherine Mwende', 'Engineering', 'ENG411', '1129', 'cmwende@jkuat.ac.ke'),
('Dr. David Njau', 'Computer Science', 'CS109', '1242', 'dnjau@jkuat.ac.ke'),
('Dr. Eunice Wairimu', 'Mathematics', 'MATH210', '5686', 'ewairimu@jkuat.ac.ke'),
('Dr. Felix Oduor', 'Physics', 'PHY311', '9109', 'foduor@jkuat.ac.ke'),
('Dr. Gloria Akinyi', 'Engineering', 'ENG412', '1130', 'gakinyi@jkuat.ac.ke'),
('Dr. Harrison Mwangi', 'Computer Science', 'CS110', '1243', 'hmwangi@jkuat.ac.ke'),
('Dr. Isabella Ndungu', 'Mathematics', 'MATH211', '5687', 'indungu@jkuat.ac.ke'),
('Dr. Joseph Wanjala', 'Physics', 'PHY312', '9110', 'jwanjala@jkuat.ac.ke'),
('Dr. Keziah Njeri', 'Engineering', 'ENG413', '1131', 'knjeri@jkuat.ac.ke'),
('Dr. Lucy Korir', 'Computer Science', 'CS111', '1244', 'lkorir@jkuat.ac.ke'),
('Dr. Martin Njogu', 'Mathematics', 'MATH212', '5688', 'mnjogu@jkuat.ac.ke'),
('Dr. Naomi Chebet', 'Physics', 'PHY313', '9111', 'nchebet@jkuat.ac.ke'),
('Dr. Oscar Mutiso', 'Engineering', 'ENG414', '1132', 'omutiso@jkuat.ac.ke'),
('Dr. Pauline Mbogo', 'Computer Science', 'CS112', '1245', 'pmbogo@jkuat.ac.ke'),
('Dr. Quincy Njau', 'Mathematics', 'MATH213', '5689', 'qnjau@jkuat.ac.ke'),
('Dr. Rose Wanjiku', 'Physics', 'PHY314', '9112', 'rwanjiku@jkuat.ac.ke'),
('Dr. Samuel Kiprotich', 'Engineering', 'ENG415', '1133', 'skiprotich@jkuat.ac.ke'),
('Dr. Timothy Otieno', 'Computer Science', 'CS113', '1246', 'totieno@jkuat.ac.ke'),
('Dr. Ursula Mwikali', 'Mathematics', 'MATH214', '5690', 'umwikali@jkuat.ac.ke'),
('Dr. Violet Kimani', 'Physics', 'PHY315', '9113', 'vkimani@jkuat.ac.ke'),
('Dr. Walter Ndegwa', 'Engineering', 'ENG416', '1134', 'wndegwa@jkuat.ac.ke');

INSERT INTO Prerequisites (course_id, prerequisite_id)
VALUES
(101, 4), -- CS102 requires ENG404
(102, 101), -- MATH203 requires CS102
(103, 102), -- PHY304 requires MATH203
(104, 103), -- ENG405 requires PHY304
(105, 104), -- CS103 requires ENG405
(106, 105), -- MATH204 requires CS103
(107, 106), -- PHY305 requires MATH204
(108, 107), -- ENG406 requires PHY305
(109, 108), -- CS104 requires ENG406
(110, 109), -- MATH205 requires CS104
(111, 110), -- PHY306 requires MATH205
(112, 111), -- ENG407 requires PHY306
(113, 112), -- CS105 requires ENG407
(114, 113), -- MATH206 requires CS105
(115, 114), -- PHY307 requires MATH206
(116, 115), -- ENG408 requires PHY307
(117, 116), -- CS106 requires ENG408
(118, 117), -- MATH207 requires CS106
(119, 118), -- PHY308 requires MATH207
(120, 119), -- ENG409 requires PHY308
(121, 120), -- CS107 requires ENG409
(122, 121), -- MATH208 requires CS107
(123, 122), -- PHY309 requires MATH208
(124, 123), -- ENG410 requires PHY309
(125, 124), -- CS108 requires ENG410
(126, 125), -- MATH209 requires CS108
(127, 126), -- PHY310 requires MATH209
(128, 127), -- ENG411 requires PHY310
(129, 128), -- CS109 requires ENG411
(130, 129), -- MATH210 requires CS109
(131, 130), -- PHY311 requires MATH210
(132, 131), -- ENG412 requires PHY311
(133, 132), -- CS110 requires ENG412
(134, 133), -- MATH211 requires CS110
(135, 134), -- PHY312 requires MATH211
(136, 135), -- ENG413 requires PHY312
(137, 136), -- CS111 requires ENG413
(138, 137), -- MATH212 requires CS111
(139, 138), -- PHY313 requires MATH212
(140, 139), -- ENG414 requires PHY313
(141, 140), -- CS112 requires ENG414
(142, 141), -- MATH213 requires CS112
(143, 142), -- PHY314 requires MATH213
(144, 143), -- ENG415 requires PHY314
(145, 144), -- CS113 requires ENG415
(146, 145); -- MATH214 requires CS113

INSERT INTO AntiRequisites (course_id, anti_requisite_id)
VALUES
(101, 102), -- CS102 and MATH203 are anti-requisites
(103, 104), -- PHY304 and ENG405 are anti-requisites
(105, 106), -- CS103 and MATH204 are anti-requisites
(107, 108), -- PHY305 and ENG406 are anti-requisites
(109, 110), -- CS104 and MATH205 are anti-requisites
(111, 112), -- PHY306 and ENG407 are anti-requisites
(113, 114), -- CS105 and MATH206 are anti-requisites
(115, 116), -- PHY307 and ENG408 are anti-requisites
(117, 118), -- CS106 and MATH207 are anti-requisites
(119, 120), -- PHY308 and ENG409 are anti-requisites
(121, 122), -- CS107 and MATH208 are anti-requisites
(123, 124), -- PHY309 and ENG410 are anti-requisites
(125, 126), -- CS108 and MATH209 are anti-requisites
(127, 128), -- PHY310 and ENG411 are anti-requisites
(129, 130), -- CS109 and MATH210 are anti-requisites
(131, 132), -- PHY311 and ENG412 are anti-requisites
(133, 134), -- CS110 and MATH211 are anti-requisites
(135, 136), -- PHY312 and ENG413 are anti-requisites
(137, 138), -- CS111 and MATH212 are anti-requisites
(139, 140), -- PHY313 and ENG414 are anti-requisites
(141, 142), -- CS112 and MATH213 are anti-requisites
(143, 144), -- PHY314 and ENG415 are anti-requisites
(145, 146), -- CS113 and MATH214 are anti-requisites
(147, 148), -- PHY315 and ENG416 are anti-requisites
(1, 4), -- CS101 and ENG404 are anti-requisites
(2, 101), -- MATH202 and CS102 are anti-requisites
(3, 102), -- PHY303 and MATH203 are anti-requisites
(4, 103), -- ENG404 and PHY304 are anti-requisites
(101, 104), -- CS102 and ENG405 are anti-requisites
(103, 106), -- PHY304 and MATH204 are anti-requisites
(105, 107); -- CS103 and PHY305 are anti-requisites




INSERT INTO Registrations (student_id, course_id, status, grade)
VALUES
(6, 2, 'Completed', 'Pass'),
(7, 3, 'Registered', NULL),
(8, 4, 'Completed', 'Pass'),
(9, 101, 'Completed', 'Fail'),
(10, 102, 'Registered', NULL),
(11, 103, 'Completed', 'Pass'),
(12, 104, 'Registered', NULL),
(13, 105, 'Completed', 'Pass'),
(14, 106, 'Completed', 'Fail'),
(15, 107, 'Registered', NULL),
(16, 108, 'Completed', 'Pass'),
(17, 109, 'Registered', NULL),
(18, 110, 'Completed', 'Pass'),
(19, 111, 'Completed', 'Fail'),
(20, 112, 'Registered', NULL),
(21, 113, 'Completed', 'Pass'),
(22, 114, 'Registered', NULL),
(23, 115, 'Completed', 'Fail'),
(24, 116, 'Registered', NULL),
(25, 117, 'Completed', 'Pass'),
(26, 118, 'Completed', 'Pass'),
(27, 119, 'Registered', NULL),
(28, 120, 'Completed', 'Fail'),
(29, 121, 'Registered', NULL),
(30, 122, 'Completed', 'Pass'),
(31, 123, 'Completed', 'Pass'),
(32, 124, 'Registered', NULL),
(33, 125, 'Completed', 'Pass'),
(34, 126, 'Registered', NULL),
(35, 127, 'Completed', 'Fail'),
(36, 128, 'Registered', NULL),
(37, 129, 'Completed', 'Pass'),
(38, 130, 'Registered', NULL),
(39, 131, 'Completed', 'Pass'),
(40, 132, 'Registered', NULL),
(41, 133, 'Completed', 'Pass'),
(42, 134, 'Registered', NULL),
(43, 135, 'Completed', 'Pass'),
(44, 136, 'Registered', NULL),
(45, 137, 'Completed', 'Fail'),
(46, 138, 'Registered', NULL),
(47, 139, 'Completed', 'Pass'),
(48, 140, 'Registered', NULL),
(49, 141, 'Completed', 'Pass'),
(50, 142, 'Registered', NULL),
(51, 143, 'Completed', 'Pass'),
(52, 144, 'Registered', NULL),
(53, 145, 'Completed', 'Pass'),
(54, 146, 'Registered', NULL);

use registration;
create table las (
    la_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL,
    office_room VARCHAR(50),
    phone_extension VARCHAR(20),
    email VARCHAR(255) UNIQUE NOT NULL);
    
create table tas (
    ta_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL,
    office_room VARCHAR(50),
    phone_extension VARCHAR(20),
    email VARCHAR(255) UNIQUE NOT NULL);

INSERT INTO las (name, department, office_room, phone_extension, email)
VALUES
('Mercy Wanjiru', 'Computer Science', 'Room A1', '2001', 'mwanjiru@jkuat.ac.ke'),
('James Ochieng', 'Mathematics', 'Room B1', '2002', 'jochieng@jkuat.ac.ke'),
('Alice Njeri', 'Physics', 'Room C1', '2003', 'anjeri@jkuat.ac.ke'),
('Samuel Otieno', 'Engineering', 'Room D1', '2004', 'sotieno@jkuat.ac.ke'),
('Beatrice Muthoni', 'Computer Science', 'Room A2', '2005', 'bmuthoni@jkuat.ac.ke'),
('Joseph Mwangi', 'Mathematics', 'Room B2', '2006', 'jmwangi@jkuat.ac.ke'),
('Caroline Achieng', 'Physics', 'Room C2', '2007', 'cachieng@jkuat.ac.ke'),
('Patrick Kamau', 'Engineering', 'Room D2', '2008', 'pkamau@jkuat.ac.ke'),
('Grace Wambui', 'Computer Science', 'Room A3', '2009', 'gwambui@jkuat.ac.ke'),
('Peter Njoroge', 'Mathematics', 'Room B3', '2010', 'pnjoroge@jkuat.ac.ke'),
('Lucy Wafula', 'Physics', 'Room C3', '2011', 'lwafula@jkuat.ac.ke'),
('David Mutua', 'Engineering', 'Room D3', '2012', 'dmutua@jkuat.ac.ke'),
('Susan Njoki', 'Computer Science', 'Room A4', '2013', 'snjoki@jkuat.ac.ke'),
('Stephen Mwenda', 'Mathematics', 'Room B4', '2014', 'smwenda@jkuat.ac.ke'),
('Esther Chepkemoi', 'Physics', 'Room C4', '2015', 'echepkemoi@jkuat.ac.ke'),
('George Kiprono', 'Engineering', 'Room D4', '2016', 'gkiprono@jkuat.ac.ke'),
('Anne Cherono', 'Computer Science', 'Room A5', '2017', 'acherono@jkuat.ac.ke'),
('Francis Kilonzo', 'Mathematics', 'Room B5', '2018', 'fkilonzo@jkuat.ac.ke'),
('Janet Nyaboke', 'Physics', 'Room C5', '2019', 'jnyaboke@jkuat.ac.ke'),
('Henry Onyango', 'Engineering', 'Room D5', '2020', 'honyango@jkuat.ac.ke'),
('Catherine Wairimu', 'Computer Science', 'Room A6', '2021', 'cwairimu@jkuat.ac.ke'),
('Michael Karanja', 'Mathematics', 'Room B6', '2022', 'mkaranja@jkuat.ac.ke'),
('Irene Nduta', 'Physics', 'Room C6', '2023', 'induta@jkuat.ac.ke'),
('Daniel Nyambane', 'Engineering', 'Room D6', '2024', 'dnyambane@jkuat.ac.ke'),
('Nancy Wamalwa', 'Computer Science', 'Room A7', '2025', 'nwamalwa@jkuat.ac.ke'),
('John Kipngeno', 'Mathematics', 'Room B7', '2026', 'jkipngeno@jkuat.ac.ke'),
('Mary Atieno', 'Physics', 'Room C7', '2027', 'matieno@jkuat.ac.ke'),
('Robert Kariuki', 'Engineering', 'Room D7', '2028', 'rkariuki@jkuat.ac.ke'),
('Agnes Otieno', 'Computer Science', 'Room A8', '2029', 'aotieno@jkuat.ac.ke'),
('Kelvin Mutuku', 'Mathematics', 'Room B8', '2030', 'kmutuku@jkuat.ac.ke'),
('Sharon Wanjala', 'Physics', 'Room C8', '2031', 'swanjala@jkuat.ac.ke'),
('Anthony Kimani', 'Engineering', 'Room D8', '2032', 'akimani@jkuat.ac.ke'),
('Emily Chebet', 'Computer Science', 'Room A9', '2033', 'echebet@jkuat.ac.ke'),
('Brian Mwangi', 'Mathematics', 'Room B9', '2034', 'bmwangi@jkuat.ac.ke'),
('Hannah Nthenya', 'Physics', 'Room C9', '2035', 'hnthenya@jkuat.ac.ke'),
('Charles Waithaka', 'Engineering', 'Room D9', '2036', 'cwaithaka@jkuat.ac.ke'),
('Rose Akinyi', 'Computer Science', 'Room A10', '2037', 'rakinyi@jkuat.ac.ke'),
('Patrick Cheruiyot', 'Mathematics', 'Room B10', '2038', 'pcheruiyot@jkuat.ac.ke'),
('Lucy Wanjiru', 'Physics', 'Room C10', '2039', 'lwanjiru@jkuat.ac.ke'),
('Victor Odhiambo', 'Engineering', 'Room D10', '2040', 'vodhiambo@jkuat.ac.ke'),
('Jane Nyamweya', 'Computer Science', 'Room A11', '2041', 'jnyamweya@jkuat.ac.ke'),
('Andrew Kibet', 'Mathematics', 'Room B11', '2042', 'akibet@jkuat.ac.ke'),
('Faith Nyaguthii', 'Physics', 'Room C11', '2043', 'fnyaguthii@jkuat.ac.ke'),
('George Wekesa', 'Engineering', 'Room D11', '2044', 'gwekesa@jkuat.ac.ke'),
('Margaret Moraa', 'Computer Science', 'Room A12', '2045', 'mmoraa@jkuat.ac.ke'),
('Dennis Gachoka', 'Mathematics', 'Room B12', '2046', 'dgachoka@jkuat.ac.ke'),
('Ruth Nanjala', 'Physics', 'Room C12', '2047', 'rnanjala@jkuat.ac.ke'),
('Felix Kibaki', 'Engineering', 'Room D12', '2048', 'fkibaki@jkuat.ac.ke');
INSERT INTO tas (name, department, office_room, phone_extension, email)
VALUES
('Simon Mbugua', 'Computer Science', 'Room E1', '3001', 'smbugua@jkuat.ac.ke'),
('Grace Achieng', 'Mathematics', 'Room F1', '3002', 'gachieng@jkuat.ac.ke'),
('Cynthia Nyaguthii', 'Physics', 'Room G1', '3003', 'cnyaguthii@jkuat.ac.ke'),
('Peter Ndungu', 'Engineering', 'Room H1', '3004', 'pndungu@jkuat.ac.ke'),
('Joyce Njeri', 'Computer Science', 'Room E2', '3005', 'jnjeri@jkuat.ac.ke'),
('Tom Mwangi', 'Mathematics', 'Room F2', '3006', 'tmwangi@jkuat.ac.ke'),
('Eunice Wairimu', 'Physics', 'Room G2', '3007', 'ewairimu@jkuat.ac.ke'),
('George Kariuki', 'Engineering', 'Room H2', '3008', 'gkariuki@jkuat.ac.ke'),
('Caroline Chebet', 'Computer Science', 'Room E3', '3009', 'cchebet@jkuat.ac.ke'),
('Mark Odhiambo', 'Mathematics', 'Room F3', '3010', 'modhiambo@jkuat.ac.ke'),
('Lilian Nyambura', 'Physics', 'Room G3', '3011', 'lnyambura@jkuat.ac.ke'),
('Kennedy Kiprono', 'Engineering', 'Room H3', '3012', 'kkiprono@jkuat.ac.ke'),
('Agnes Moraa', 'Computer Science', 'Room E4', '3013', 'amoraa@jkuat.ac.ke'),
('Felix Wekesa', 'Mathematics', 'Room F4', '3014', 'fwekesa@jkuat.ac.ke'),
('Pauline Akinyi', 'Physics', 'Room G4', '3015', 'pakinyi@jkuat.ac.ke'),
('Stephen Mungai', 'Engineering', 'Room H4', '3016', 'smungai@jkuat.ac.ke'),
('Emily Wambui', 'Computer Science', 'Room E5', '3017', 'ewambui@jkuat.ac.ke'),
('Victor Ochieng', 'Mathematics', 'Room F5', '3018', 'vochieng@jkuat.ac.ke'),
('Sarah Wanjala', 'Physics', 'Room G5', '3019', 'swanjala@jkuat.ac.ke'),
('Daniel Mutiso', 'Engineering', 'Room H5', '3020', 'dmutiso@jkuat.ac.ke'),
('Janet Wanjiru', 'Computer Science', 'Room E6', '3021', 'jwanjiru@jkuat.ac.ke'),
('Brian Kamau', 'Mathematics', 'Room F6', '3022', 'bkamau@jkuat.ac.ke'),
('Mary Wafula', 'Physics', 'Room G6', '3023', 'mwafula@jkuat.ac.ke'),
('Anthony Nthenge', 'Engineering', 'Room H6', '3024', 'anthenge@jkuat.ac.ke'),
('Lucy Atieno', 'Computer Science', 'Room E7', '3025', 'latieno@jkuat.ac.ke'),
('Nicholas Kigen', 'Mathematics', 'Room F7', '3026', 'nkigen@jkuat.ac.ke'),
('Betty Cheruiyot', 'Physics', 'Room G7', '3027', 'bcheruiyot@jkuat.ac.ke'),
('Allan Muthui', 'Engineering', 'Room H7', '3028', 'amuthui@jkuat.ac.ke'),
('Joyce Wamalwa', 'Computer Science', 'Room E8', '3029', 'jwamalwa@jkuat.ac.ke'),
('Kelvin Kipchirchir', 'Mathematics', 'Room F8', '3030', 'kkipchirchir@jkuat.ac.ke'),
('Nancy Wairimu', 'Physics', 'Room G8', '3031', 'nwairimu@jkuat.ac.ke'),
('Robert Mwiti', 'Engineering', 'Room H8', '3032', 'rmwiti@jkuat.ac.ke'),
('Judith Nyaboke', 'Computer Science', 'Room E9', '3033', 'jnyaboke@jkuat.ac.ke'),
('Francis Ngugi', 'Mathematics', 'Room F9', '3034', 'fngugi@jkuat.ac.ke'),
('Esther Nyambane', 'Physics', 'Room G9', '3035', 'enyambane@jkuat.ac.ke'),
('Charles Njoroge', 'Engineering', 'Room H9', '3036', 'cnjoroge@jkuat.ac.ke'),
('Ann Nyakio', 'Computer Science', 'Room E10', '3037', 'anyakio@jkuat.ac.ke'),
('Samuel Kiprotich', 'Mathematics', 'Room F10', '3038', 'skiprotich@jkuat.ac.ke'),
('Dorothy Muthoka', 'Physics', 'Room G10', '3039', 'dmuthoka@jkuat.ac.ke'),
('Collins Mburu', 'Engineering', 'Room H10', '3040', 'cmburu@jkuat.ac.ke'),
('Faith Wekesa', 'Computer Science', 'Room E11', '3041', 'fawekesa@jkuat.ac.ke'),
('Martin Mutua', 'Mathematics', 'Room F11', '3042', 'mmutua@jkuat.ac.ke'),
('Edith Wanjiku', 'Physics', 'Room G11', '3043', 'ewanjiku@jkuat.ac.ke'),
('Patrick Gichuki', 'Engineering', 'Room H11', '3044', 'pgichuki@jkuat.ac.ke'),
('Angela Chege', 'Computer Science', 'Room E12', '3045', 'achege@jkuat.ac.ke'),
('Philip Nduta', 'Mathematics', 'Room F12', '3046', 'pnduta@jkuat.ac.ke'),
('Ruth Nyakundi', 'Physics', 'Room G12', '3047', 'rnyakundi@jkuat.ac.ke'),
('Dennis Otieno', 'Engineering', 'Room H12', '3048', 'dotieno@jkuat.ac.ke');

CREATE VIEW `Fourth Years` AS
SELECT 
    students.student_id, 
    students.name, 
    registrations.status, 
    registrations.grade
FROM 
    students
JOIN 
    registrations 
ON 
    students.student_id = registrations.student_id
WHERE 
    students.year_of_study = 4;
    
SELECT * FROM `Fourth Years`;

select count(anti_requisite_id)
from antirequisites;

SELECT course_id FROM courses WHERE course_id NOT IN (
    SELECT course_id FROM AntiRequisites
);



