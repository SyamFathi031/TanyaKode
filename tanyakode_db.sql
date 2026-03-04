-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 04 Mar 2026 pada 03.38
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tanyakode_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `content_progress`
--

CREATE TABLE `content_progress` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `enrollment_id` bigint(20) UNSIGNED NOT NULL,
  `content_id` bigint(20) UNSIGNED NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `completed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `courses`
--

CREATE TABLE `courses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `level` enum('pemula','menengah','expert','') DEFAULT NULL,
  `price` decimal(12,2) DEFAULT 0.00,
  `is_premium` tinyint(1) DEFAULT 0,
  `thumbnail_url` varchar(255) DEFAULT NULL,
  `has_merchandise_reward` tinyint(1) DEFAULT 0,
  `merchandise_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `courses`
--

INSERT INTO `courses` (`id`, `school_id`, `created_by`, `title`, `slug`, `description`, `level`, `price`, `is_premium`, `thumbnail_url`, `has_merchandise_reward`, `merchandise_name`, `created_at`, `updated_at`) VALUES
(3, NULL, 21, 'web coba', 'web-coba', NULL, 'pemula', 0.00, 0, NULL, 0, NULL, '2026-01-04 07:40:48', '2026-01-04 07:40:48'),
(4, NULL, 21, 'belajar tingkat menengah', 'belajar-tingkat-menengah', NULL, 'menengah', 450000000.00, 1, NULL, 1, 'boneka', '2026-01-08 00:48:53', '2026-01-08 00:48:53');

-- --------------------------------------------------------

--
-- Struktur dari tabel `course_enrollments`
--

CREATE TABLE `course_enrollments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `progress_percentage` decimal(5,2) DEFAULT 0.00,
  `last_accessed_content_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('active','completed') DEFAULT 'active',
  `is_paid` tinyint(1) DEFAULT 0,
  `enrolled_at` timestamp NULL DEFAULT current_timestamp(),
  `completed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `merchandise_requests`
--

CREATE TABLE `merchandise_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `shipping_address_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('pending','processing','shipped') DEFAULT 'pending',
  `tracking_number` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2025_12_29_094219_otp', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `modules`
--

CREATE TABLE `modules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `sort_order` int(11) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `modules`
--

INSERT INTO `modules` (`id`, `course_id`, `title`, `sort_order`, `created_at`, `updated_at`) VALUES
(2, 3, 'testing modul 1', 1, '2026-01-04 07:49:48', '2026-01-04 07:49:48'),
(3, 3, 'testing modul 2', 2, '2026-01-04 08:38:53', '2026-01-04 08:38:53'),
(4, 4, 'tes premium', 1, '2026-01-08 00:49:10', '2026-01-08 00:49:10');

-- --------------------------------------------------------

--
-- Struktur dari tabel `module_contents`
--

CREATE TABLE `module_contents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `module_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `type` enum('theory','practice') NOT NULL,
  `content_body` longtext NOT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `compiler_lang` enum('html','php','python','nodejs','javascript','css','sql','cpp','java') DEFAULT NULL,
  `practice_snippet` text DEFAULT NULL,
  `sort_order` int(11) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `module_contents`
--

INSERT INTO `module_contents` (`id`, `module_id`, `title`, `type`, `content_body`, `video_url`, `compiler_lang`, `practice_snippet`, `sort_order`, `created_at`, `updated_at`) VALUES
(3, 2, 'tes teori', 'theory', 'tes', 'https://youtu.be/oWRI6xKEZMk?si=SpxdhDwWpQnaCdVw', 'php', NULL, 1, '2026-01-04 08:27:43', '2026-01-04 08:27:43'),
(4, 2, 'html', 'theory', 'html', NULL, 'html', '<!DOCTYPE html>\n<html lang=\"id\">\n<head>\n    <meta charset=\"UTF-8\">\n    <title>HTML Sederhana</title>\n</head>\n<body>\n\n    <h1>Selamat Datang</h1>\n    <p>Ini adalah contoh halaman HTML sederhana.</p>\n\n    <h2>Tentang Saya</h2>\n    <p>Saya sedang belajar HTML dan CSS.</p>\n\n    <button>Klik Saya</button>\n\n</body>\n</html>', 2, '2026-01-04 08:29:36', '2026-01-04 08:29:36'),
(5, 3, 'testing modul 2', 'theory', 'testing', NULL, 'php', NULL, 1, '2026-01-04 08:39:10', '2026-01-04 08:39:10'),
(6, 4, 'tes', 'theory', 'tes', NULL, 'php', NULL, 1, '2026-01-08 00:49:25', '2026-01-08 00:49:25');

-- --------------------------------------------------------

--
-- Struktur dari tabel `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `otps`
--

CREATE TABLE `otps` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `otp_code` varchar(6) NOT NULL,
  `type` enum('verification','reset_password','login') NOT NULL DEFAULT 'verification',
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `schools`
--

CREATE TABLE `schools` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `npsn` varchar(50) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `token_code` varchar(20) DEFAULT NULL,
  `is_token_active` tinyint(1) DEFAULT 1,
  `subscription_status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `schools`
--

INSERT INTO `schools` (`id`, `npsn`, `name`, `address`, `phone`, `email`, `token_code`, `is_token_active`, `subscription_status`, `created_at`, `updated_at`) VALUES
(1, '10101010', 'SMAN 1 Coding Indonesia', NULL, NULL, NULL, 'SMAN1-CODE', 1, 'active', '2025-12-24 10:32:33', '2025-12-24 10:32:33'),
(3, '23333', 'SMAN 2', 'bekasi utara', NULL, NULL, NULL, 1, 'active', '2025-12-27 03:48:30', '2025-12-27 03:48:30');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('cJpCYl2sWUDSkOE40cloGrNeviGZb52Tc2LahdAz', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYUo1aG44N3ZwR09VOGh6S1ZQRTROVTRxQjZ5MGZ3YTdqU25ydHNsVyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1769094702),
('nKCyfBgoUyhHTB9hAOrp70JNoteknjXK1d6vrzyE', 22, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Avast/143.0.0.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiTmthY2haNGhZYm5BZ2VZTFlONEFwenpFVWUxeUlNTnBJWFZrR1BKUCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo1ODoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL3VzZXIvY291cnNlL2JlbGFqYXItdGluZ2thdC1tZW5lbmdhaCI7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjU4OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvdXNlci9jb3Vyc2UvYmVsYWphci10aW5na2F0LW1lbmVuZ2FoIjtzOjU6InJvdXRlIjtzOjE3OiJ1c2VyLmNvdXJzZXMuc2hvdyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjIyO30=', 1767978282),
('QEpF71uOkMSXKY7ecCzpXow5vpLCW2hOXhXRo5hF', 22, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Avast/143.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUEVlVjZsd3lpT2VSZDBFM2x2U3F0N2NINHJwZnIyc2pMV3ZDRVVsSyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NTg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC91c2VyL2NvdXJzZS9iZWxhamFyLXRpbmdrYXQtbWVuZW5nYWgiO3M6NToicm91dGUiO3M6MTc6InVzZXIuY291cnNlcy5zaG93Ijt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjI7fQ==', 1767974550);

-- --------------------------------------------------------

--
-- Struktur dari tabel `shipping_addresses`
--

CREATE TABLE `shipping_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `full_address` text NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `spin_logs`
--

CREATE TABLE `spin_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `spin_date` date NOT NULL,
  `result_type` enum('zonk','discount','free_course') DEFAULT NULL,
  `reward_detail` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_id` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `payment_status` enum('pending','paid','failed') DEFAULT 'pending',
  `snap_token` varchar(255) DEFAULT NULL,
  `payment_type` varchar(50) DEFAULT NULL,
  `va_number` varchar(50) DEFAULT NULL,
  `payment_proof` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `transactions`
--

INSERT INTO `transactions` (`id`, `reference_id`, `user_id`, `course_id`, `total_amount`, `payment_status`, `snap_token`, `payment_type`, `va_number`, `payment_proof`, `created_at`, `updated_at`) VALUES
(11, 'INV-1767978268-ZnZi2', 22, 4, 450000000.00, 'failed', 'dd145826-fd7b-4365-ba63-3ae07f6b085a', NULL, NULL, NULL, '2026-01-09 10:04:29', '2026-01-09 10:04:41'),
(12, 'INV-1767978281-a8ddA', 22, 4, 450000000.00, 'pending', '3e6fd47e-ec09-47a4-b1f4-fc84fcdf449f', NULL, NULL, NULL, '2026-01-09 10:04:42', '2026-01-09 10:04:42');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED DEFAULT NULL,
  `role` enum('super_admin','admin','school_admin','student') DEFAULT 'student',
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `nis` varchar(50) DEFAULT NULL,
  `nisn` varchar(50) DEFAULT NULL,
  `grade` enum('1','2','3') DEFAULT NULL,
  `school_name` varchar(255) DEFAULT NULL,
  `school_category` enum('SMP','SMA') DEFAULT NULL,
  `domisili` varchar(100) DEFAULT NULL,
  `current_level` int(11) DEFAULT 1,
  `avatar_url` varchar(255) DEFAULT NULL,
  `status` enum('active','verify') NOT NULL DEFAULT 'verify',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `school_id`, `role`, `username`, `email`, `password`, `full_name`, `nis`, `nisn`, `grade`, `school_name`, `school_category`, `domisili`, `current_level`, `avatar_url`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, 'super_admin', 'superadmin', 'owner@tanyakode.com', 'password', 'Owner TanyaKode', NULL, '', NULL, NULL, NULL, NULL, 1, NULL, 'active', '2025-12-24 10:32:33', '2025-12-29 10:11:57'),
(2, 1, 'school_admin', 'guru_sman1', 'guru@sman1.sch.id', 'password', 'Bapak Guru IT', NULL, '', NULL, NULL, NULL, NULL, 1, NULL, 'active', '2025-12-24 10:32:33', '2025-12-29 10:12:02'),
(4, NULL, 'super_admin', 'superadmin4', 'super@tanyakode.com', '$2y$12$GmdoEDotIR89M2xrA.If1O.xonNLG1o6DdZ2t11mUYHLc5oY3U5dy', 'Super Administrator', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'active', '2025-12-26 08:26:36', '2025-12-29 10:12:08'),
(8, NULL, 'student', 'budi_siswa', 'student@tanyakode.com', '$2y$12$MTw.25jDKwdli5Tm2Nulb.YNjl1GZ3omy8Yt8j2clS.pqSuDS4Nwm', 'Budi Santoso', '123456', '00987654321', '1', 'SMA Negeri 1 Jakarta', 'SMA', 'Jakarta Selatan', 1, 'default_avatar.png', 'active', '2025-12-26 08:31:28', '2025-12-29 10:12:13'),
(9, NULL, 'student', 'TES', 'tes@gmail.com', '$2y$12$JMvOucuLExrbkkdBiEnyAOXPk8s4hyMfjKFaWzAjnodO0qVCJX1mS', 'Husein Akmal Hidayat', '2344', '2444', '1', 'adada', 'SMA', 'bekasi', 1, NULL, 'active', '2025-12-26 09:16:29', '2025-12-29 10:12:18'),
(10, NULL, 'student', 'tes lewat postman', 'postman@gmail.com', '$2y$12$zWxGxxRzndy/aDqfcqHBtORNn5Lln0NgBmK/FPCzV2MjKNCIb6ddu', 'postman', NULL, NULL, NULL, NULL, NULL, 'jateng', 0, NULL, 'active', '2025-12-27 01:47:32', '2025-12-29 10:12:23'),
(12, NULL, 'admin', 'admin ganti pake postman', 'adminpostman@gmail.com', '$2y$12$Lc7.U.e2ApGk6G57xWECd.JuktAvLKkwD1VyKP.b9Tx3cZN5V79..', 'postman22', NULL, NULL, NULL, NULL, NULL, 'jabar', 0, NULL, 'active', '2025-12-27 01:57:23', '2025-12-29 10:12:28'),
(13, 1, 'school_admin', 'admin_baru_coba', 'admin@sekolah.com', '$2y$12$3eHv4bwuJ4dnKEQtQyTKueItlMjOshmJIL6UrL0thyB4Iy5t50eLK', 'Admin Percobaan', NULL, NULL, NULL, NULL, NULL, 'Jakarta', 0, NULL, 'active', '2025-12-27 03:47:45', '2025-12-29 10:12:32'),
(14, 3, 'school_admin', 'admin_sman2baru', 'admin@sekolah2.com', '$2y$12$nHYicqtZsWhshBXYXuq12.MfNmiuloPjHLOtsXVGZt5pF6K05mNr2', 'Admin sman2 baru', NULL, NULL, NULL, NULL, NULL, 'Jakarta', 0, NULL, 'active', '2025-12-27 03:48:59', '2025-12-29 10:12:38'),
(20, NULL, 'admin', 'minggu', 'minggu@gmail.com', '$2y$12$WCjnVmD90B9B38gdUBWO8OSFVFEMqz3E9LkMtA5yrzmivSJQ6KK2S', 'MINGGU', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'verify', '2026-01-04 03:52:37', '2026-01-04 03:57:06'),
(21, NULL, 'admin', 'husein', 'huseinhidayat730@gmail.com', '$2y$12$0dSoHlpioolX/PdGIz500.QAHVZdclE6LwPcagoReWcu75dc5f102', 'Husein Akmal Hidayat', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'active', '2026-01-04 07:11:10', '2026-01-04 07:13:07'),
(22, NULL, 'student', 'Husein Akmal', 'husein.akm@gmail.com', '$2y$12$WEjuf9P/Cxm6zr6DVrl3Wu3ERz2snS2b0EN.YVDJOttF/AHyOZvJO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'active', '2026-01-07 08:30:42', '2026-01-08 01:48:07');

-- --------------------------------------------------------

--
-- Struktur dari tabel `vouchers`
--

CREATE TABLE `vouchers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `discount_amount` decimal(12,2) NOT NULL,
  `discount_type` enum('percent','fixed') DEFAULT 'percent',
  `valid_until` datetime NOT NULL,
  `is_used` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `content_progress`
--
ALTER TABLE `content_progress`
  ADD PRIMARY KEY (`id`),
  ADD KEY `content_progress_ibfk_1` (`enrollment_id`),
  ADD KEY `content_progress_ibfk_2` (`content_id`);

--
-- Indeks untuk tabel `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `school_id` (`school_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indeks untuk tabel `course_enrollments`
--
ALTER TABLE `course_enrollments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `last_accessed_content_id` (`last_accessed_content_id`);

--
-- Indeks untuk tabel `merchandise_requests`
--
ALTER TABLE `merchandise_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `shipping_address_id` (`shipping_address_id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `modules`
--
ALTER TABLE `modules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indeks untuk tabel `module_contents`
--
ALTER TABLE `module_contents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `module_id` (`module_id`);

--
-- Indeks untuk tabel `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `otps`
--
ALTER TABLE `otps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `otps_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `schools`
--
ALTER TABLE `schools`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `npsn` (`npsn`),
  ADD UNIQUE KEY `token_code` (`token_code`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indeks untuk tabel `shipping_addresses`
--
ALTER TABLE `shipping_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `spin_logs`
--
ALTER TABLE `spin_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reference_id` (`reference_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `school_id` (`school_id`);

--
-- Indeks untuk tabel `vouchers`
--
ALTER TABLE `vouchers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `content_progress`
--
ALTER TABLE `content_progress`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `courses`
--
ALTER TABLE `courses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `course_enrollments`
--
ALTER TABLE `course_enrollments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `merchandise_requests`
--
ALTER TABLE `merchandise_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `modules`
--
ALTER TABLE `modules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `module_contents`
--
ALTER TABLE `module_contents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `otps`
--
ALTER TABLE `otps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `schools`
--
ALTER TABLE `schools`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `shipping_addresses`
--
ALTER TABLE `shipping_addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `spin_logs`
--
ALTER TABLE `spin_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT untuk tabel `vouchers`
--
ALTER TABLE `vouchers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `content_progress`
--
ALTER TABLE `content_progress`
  ADD CONSTRAINT `content_progress_ibfk_1` FOREIGN KEY (`enrollment_id`) REFERENCES `course_enrollments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `content_progress_ibfk_2` FOREIGN KEY (`content_id`) REFERENCES `module_contents` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `courses_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `course_enrollments`
--
ALTER TABLE `course_enrollments`
  ADD CONSTRAINT `course_enrollments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `course_enrollments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `course_enrollments_ibfk_3` FOREIGN KEY (`last_accessed_content_id`) REFERENCES `module_contents` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `merchandise_requests`
--
ALTER TABLE `merchandise_requests`
  ADD CONSTRAINT `merchandise_requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `merchandise_requests_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `merchandise_requests_ibfk_3` FOREIGN KEY (`shipping_address_id`) REFERENCES `shipping_addresses` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `modules`
--
ALTER TABLE `modules`
  ADD CONSTRAINT `modules_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `module_contents`
--
ALTER TABLE `module_contents`
  ADD CONSTRAINT `module_contents_ibfk_1` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `otps`
--
ALTER TABLE `otps`
  ADD CONSTRAINT `otps_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `shipping_addresses`
--
ALTER TABLE `shipping_addresses`
  ADD CONSTRAINT `shipping_addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `spin_logs`
--
ALTER TABLE `spin_logs`
  ADD CONSTRAINT `spin_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `vouchers`
--
ALTER TABLE `vouchers`
  ADD CONSTRAINT `vouchers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
