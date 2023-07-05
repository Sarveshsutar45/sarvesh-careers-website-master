-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 03, 2023 at 11:28 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sarvesh_career_website`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`) VALUES
(1, 'sarvesh', '1');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `location` text NOT NULL,
  `salary` int(20) DEFAULT NULL,
  `currency` text DEFAULT NULL,
  `responsibilities` text DEFAULT NULL,
  `requirements` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `title`, `location`, `salary`, `currency`, `responsibilities`, `requirements`) VALUES
(1, 'Data Analyst', 'Bengluru,India', 1500000, '₹', 'A data analyst is responsible for collecting, analyzing, and interpreting large sets of data to provide insights and support decision-making', 'Strong analytical and problem-solving skills, proficiency in data analysis tools, and ability to effectively communicate findings to stakeholders.'),
(2, 'Data Scientist', 'Amsterdam,Netherlands', 2000000, '$', 'Data scientists are responsible for collecting, analyzing, and interpreting large volumes of data to extract meaningful insights and patterns.', 'Data scientist uses statistical and machine learning techniques to extract insights and patterns from data for solving complex problems and driving business value.'),
(3, 'Software Developer', 'London,England', 1555555, '$', 'A software developer is responsible for writing and maintaining high-quality code to develop software applications based on project requirements.', 'Software developer designs, develops, and maintains software applications to meet user requirements and improve system functionality.'),
(7, 'Sales Manager', 'London', 4500, '$', 'Lead and motivate the sales team to achieve sales targets and goals\r\nDevelop and implement effective sales strategies and plans\r\nIdentify new business opportunities and target markets\r\nBuild and maintain strong relationships with clients and key stakeholders', 'Proven experience as a Sales Manager or in a similar sales leadership role\r\nStrong sales and negotiation skills with a track record of achieving targets\r\nExcellent communication and interpersonal skills\r\nAbility to build and maintain relationships with clients'),
(8, 'Barber', 'Kolhapur, Maharashtra', 30000, '₹', 'Don\'t injure the customer with blade. Customer must be satisfied with services.', '4 years experience as a barber.'),
(9, 'Full Stack Developer', 'San Francisco, CA', 12345, ' €', 'Follow company policies and procedures.\r\nMaintain accurate and up-to-date records.\r\nCommunicate effectively with clients, customers, or colleagues.', 'Education: Bachelor\'s degree in Computer Science, Software Engineering, or a related field.\r\nExperience: 2+ years of professional experience as a Full Stack Developer or in a similar role.\r\nFront-end Technologies: Proficiency in HTML, CSS, and JavaScript frameworks such as React, Angular, or Vue.js.'),
(10, ' AI Developer', 'San Francisco', 2000, '  ¥', 'Develop and implement AI models, analyze large datasets, collaborate with cross-functional teams, stay updated with AI trends and technologies.', 'Bachelor\'s or Master\'s degree in Computer Science, proficiency in programming languages like Python or Java, experience with machine learning frameworks, strong analytical and problem-solving skills.'),
(14, ' Graphic Designer', 'Tokyo, Japan', 100000, '¥', 'Collaborate with clients or project managers to understand design requirements, objectives, and target audience.\r\nCreate visually appealing and engaging designs that align with the brand\'s identity and message.\r\nUse industry-standard design software (e.g., Adobe Creative Suite) to create and manipulate digital images, illustrations, and typography.', 'Proven experience as a Graphic Designer or in a related role.\r\nStrong portfolio showcasing a diverse range of design projects.\r\nProficient in industry-standard design software, such as Adobe Photoshop, Illustrator, and InDesign.\r\nSolid understanding of design principles, typography, color theory, and layout techniques.\r\nExcellent attention to detail and ability to meet project deadlines.'),
(15, 'Civil Engineer', ' Bengaluru , Karnataka', 30000, '₹', 'Designing, planning, and overseeing construction and maintenance of civil engineering projects.\r\nConducting feasibility studies and site investigations.\r\nAnalyzing survey reports, maps, and data to plan projects.\r\nManaging budgets and resources to ensure project completion within time and cost constraints.', 'Proficiency in CAD software and other engineering tools.\r\nStrong analytical and problem-solving skills.\r\nExcellent project management and organizational abilities.\r\nEffective communication and teamwork skills.'),
(16, 'Ethical Hacker', 'Panaji, Goa', 30000, '₹', 'Conduct vulnerability assessments and penetration testing to identify security weaknesses in systems, networks, and applications.\r\nDevelop and implement strategies to mitigate vulnerabilities and improve the security posture of the organization.\r\nPerform ethical hacking activities to test the effectiveness of security controls and identify potential threats.', 'Bachelor\'s degree in Computer Science, Information Security, or a related field.\r\nProven experience as an Ethical Hacker or Penetration Tester.\r\nStrong knowledge of network protocols, operating systems, and security technologies.\r\nFamiliarity with ethical hacking methodologies and tools.');

-- --------------------------------------------------------

--
-- Table structure for table `job_applications`
--

CREATE TABLE `job_applications` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `job_id` int(11) NOT NULL,
  `resume_file` text NOT NULL,
  `applied_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_applications`
--

INSERT INTO `job_applications` (`id`, `name`, `email`, `job_id`, `resume_file`, `applied_date`) VALUES
(45, 'Sumit Mhakave', 'sumitmhakave25@gmail.com', 1, '4468acf1-9b42-4c4e-b1de-10d6b3f559f1resume2.pdf', '2023-06-27 17:46:10'),
(46, 'Umesh Sutar', 'umeshsutar06@gmail.com', 2, '4d466d7c-1c2f-4a61-a117-97626e8dd606umesh.pdf', '2023-06-27 17:49:35'),
(47, 'Vighnesh Sidhnerle', 'vighneshsid45@gmail.com', 2, '22a249df-f8cf-45d1-9028-f4e4c061493avighnesh.PNG', '2023-06-28 11:22:11'),
(48, 'Mobin George', 'mobing23@gmail.com', 3, '7b69b43f-7626-4b5f-b721-9804f40d3879mobin.PNG', '2023-06-28 12:53:32'),
(49, 'Narendra Patil', 'narendrapatil78@gmail.com', 9, 'cd0d033c-0fc4-4c8c-9609-31a7b818ef66narendra.jpg', '2023-06-28 12:55:05'),
(50, 'Gajanan Sutar', 'gajanansutar26@gmail.com', 14, 'a7fc55ad-8ad1-4eae-8f36-cc0487bc83d9gajanan.PNG', '2023-06-28 14:53:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `job_applications`
--
ALTER TABLE `job_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_id` (`job_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `job_applications`
--
ALTER TABLE `job_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
