-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-07-2026 a las 21:23:39
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `enervida_lms`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria_logs`
--

CREATE TABLE `auditoria_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `usuario_id` bigint(20) UNSIGNED DEFAULT NULL,
  `accion` varchar(255) NOT NULL,
  `entidad` varchar(255) NOT NULL,
  `entidad_id` int(11) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `valores_anteriores` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`valores_anteriores`)),
  `valores_nuevos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`valores_nuevos`)),
  `direccion_ip` varchar(255) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `metodo_request` varchar(255) DEFAULT NULL,
  `endpoint` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `auditoria_logs`
--

INSERT INTO `auditoria_logs` (`id`, `usuario_id`, `accion`, `entidad`, `entidad_id`, `descripcion`, `valores_anteriores`, `valores_nuevos`, `direccion_ip`, `user_agent`, `metodo_request`, `endpoint`, `fecha_creacion`) VALUES
(46, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-06-22 19:49:30'),
(49, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-06-22 19:55:09'),
(50, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-06-23 01:17:12'),
(51, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-06-23 01:17:15'),
(52, 6, 'RECUPERACION_CONTRASENA', 'Usuario', 6, 'Solicitud de recuperacion de contrasena para: danielacopana@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/forgot-password', '2026-06-23 01:32:26'),
(53, 6, 'RECUPERACION_CONTRASENA', 'Usuario', 6, 'Solicitud de recuperacion de contrasena para: danielacopana@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/forgot-password', '2026-06-23 02:06:32'),
(54, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-06-23 02:39:19'),
(55, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-06-23 04:15:20'),
(56, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-06-23 04:37:19'),
(57, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 04:42:11'),
(58, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-06-23 05:11:27'),
(59, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-06-23 05:11:36'),
(60, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-06-23 05:11:49'),
(67, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 05:12:50'),
(68, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 05:12:52'),
(69, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 05:12:54'),
(70, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 05:12:56'),
(71, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 05:12:58'),
(72, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 05:12:59'),
(73, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 05:13:01'),
(75, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 13:36:00'),
(76, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 13:36:37'),
(77, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 13:40:34'),
(80, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 13:56:05'),
(81, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 13:56:45'),
(84, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 15:09:59'),
(85, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 15:41:14'),
(88, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 15:42:35'),
(89, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 15:42:57'),
(90, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 15:43:07'),
(91, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 15:43:14'),
(98, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 15:46:50'),
(99, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 15:48:26'),
(102, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 15:50:16'),
(103, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 15:50:59'),
(106, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 15:53:24'),
(107, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 15:54:17'),
(110, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 15:55:08'),
(111, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 15:55:23'),
(116, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 16:00:11'),
(117, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 18:19:50'),
(118, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 18:22:36'),
(121, 6, 'LOGIN_GOOGLE_DISPOSITIVO_NO_AUTORIZADO', 'Usuario', 6, 'Intento de acceso Google desde dispositivo no autorizado. IP: 127.0.0.1', NULL, '{\"fingerprint_intento\":\"23586a603ed75959420e347316fd1b49\",\"fingerprint_registrado\":\"580d06b833c946095cda7c271b0e07bf\"}', '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', 'POST', 'api/auth/google', '2026-07-02 18:24:23'),
(122, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 18:24:43'),
(123, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 18:24:55'),
(128, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 18:28:17'),
(129, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 18:29:03'),
(132, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 18:30:32'),
(133, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 18:32:35'),
(138, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 18:34:58'),
(139, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 19:01:07'),
(142, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 19:04:43'),
(143, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 19:05:12'),
(148, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 19:07:08'),
(149, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-02 19:11:10'),
(152, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-02 19:13:05'),
(153, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 12:53:26'),
(154, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 13:07:58'),
(157, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 13:11:05'),
(158, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 14:40:20'),
(159, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 14:41:38'),
(160, 6, 'ELIMINAR_USUARIO', 'Usuario', 46, 'Usuario eliminado: Angelica Collquehuanca (collquehuancaangelica@gmail.com)', '{\"nombres\":\"Angelica\",\"apellidos\":\"Collquehuanca\",\"correo\":\"collquehuancaangelica@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/46', '2026-07-03 14:42:23'),
(161, 6, 'ELIMINAR_USUARIO', 'Usuario', 45, 'Usuario eliminado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/45', '2026-07-03 14:42:27'),
(162, 6, 'ACTUALIZAR_CURSO', 'Curso', 10, 'Curso actualizado: \'Bombeo Solar\'', '{\"id\":10,\"categoria_id\":1,\"instructor_id\":6,\"titulo\":\"Bombeo Solar\",\"slug\":\"bombeo-solar\",\"descripcion_corta\":\"Curso te\\u00f3rico-pr\\u00e1ctico de la empresa Enervida para aprender a dise\\u00f1ar, dimensionar e instalar sistemas de bombeo solar fotovoltaico eficientes.\",\"descripcion\":\"\\u00a1Bienvenidos al Curso de Bombeo Solar de la empresa Enervida!\\n\\nEste programa de capacitaci\\u00f3n t\\u00e9cnica te brindar\\u00e1 todas las herramientas necesarias para dominar el uso de la energ\\u00eda solar en el transporte de agua. Est\\u00e1 dise\\u00f1ado especialmente para profesionales, t\\u00e9cnicos y personas del sector agr\\u00edcola que buscan implementar soluciones sostenibles y reducir costos operativos.\\n\\nLo que aprender\\u00e1s en este curso:\\n* Fundamentos de la energ\\u00eda solar fotovoltaica aplicada al bombeo de agua.\\n* C\\u00e1lculo y dimensionamiento de paneles solares seg\\u00fan la demanda de agua.\\n* Selecci\\u00f3n adecuada de bombas (corriente continua y alterna), controladores e inversores.\\n* Dise\\u00f1o hidr\\u00e1ulico, optimizaci\\u00f3n de caudales y p\\u00e9rdidas de carga en tuber\\u00edas.\\n* Buenas pr\\u00e1cticas de instalaci\\u00f3n, mantenimiento preventivo y seguridad el\\u00e9ctrica.\\n\\nOptimiza el uso del agua y aprovecha la energ\\u00eda del sol con la garant\\u00eda de aprendizaje de Enervida. \\u00a1Inscr\\u00edbete hoy mismo!\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1783005595_679475974-1577547564376963-2848436857219950621-n.jpg\",\"nivel\":\"Todos\",\"tipo_curso\":\"VOD\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":\"420.00\",\"fecha_creacion\":\"2026-07-02 11:20:24\",\"fecha_actualizacion\":\"2026-07-02 12:39:48\",\"edicion_actual\":2}', '{\"id\":10,\"categoria_id\":1,\"instructor_id\":6,\"titulo\":\"Bombeo Solar\",\"slug\":\"bombeo-solar\",\"descripcion_corta\":\"Curso te\\u00f3rico-pr\\u00e1ctico de la empresa Enervida para aprender a dise\\u00f1ar, dimensionar e instalar sistemas de bombeo solar fotovoltaico eficientes.\",\"descripcion\":\"\\u00a1Bienvenidos al Curso de Bombeo Solar de la empresa Enervida!\\n\\nEste programa de capacitaci\\u00f3n t\\u00e9cnica te brindar\\u00e1 todas las herramientas necesarias para dominar el uso de la energ\\u00eda solar en el transporte de agua. Est\\u00e1 dise\\u00f1ado especialmente para profesionales, t\\u00e9cnicos y personas del sector agr\\u00edcola que buscan implementar soluciones sostenibles y reducir costos operativos.\\n\\nLo que aprender\\u00e1s en este curso:\\n* Fundamentos de la energ\\u00eda solar fotovoltaica aplicada al bombeo de agua.\\n* C\\u00e1lculo y dimensionamiento de paneles solares seg\\u00fan la demanda de agua.\\n* Selecci\\u00f3n adecuada de bombas (corriente continua y alterna), controladores e inversores.\\n* Dise\\u00f1o hidr\\u00e1ulico, optimizaci\\u00f3n de caudales y p\\u00e9rdidas de carga en tuber\\u00edas.\\n* Buenas pr\\u00e1cticas de instalaci\\u00f3n, mantenimiento preventivo y seguridad el\\u00e9ctrica.\\n\\nOptimiza el uso del agua y aprovecha la energ\\u00eda del sol con la garant\\u00eda de aprendizaje de Enervida. \\u00a1Inscr\\u00edbete hoy mismo!\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1783005595_679475974-1577547564376963-2848436857219950621-n.jpg\",\"nivel\":\"Todos\",\"tipo_curso\":\"VOD\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":200,\"fecha_creacion\":\"2026-07-02 11:20:24\",\"fecha_actualizacion\":\"2026-07-02 12:39:48\",\"edicion_actual\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'PATCH', 'api/cursos/10', '2026-07-03 14:43:50'),
(163, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 14:54:35'),
(166, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 14:55:02'),
(167, 6, 'ACTUALIZAR_USUARIO', 'Usuario', 6, 'Usuario actualizado: Angel Ramos Colque (danielacopana@gmail.com)', '{\"nombres\":\"Angel\",\"apellidos\":\"Ramos Colque\",\"correo\":\"danielacopana@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":1}', '{\"nombres\":\"Angel\",\"apellidos\":\"Ramos Colque\",\"correo\":\"danielacopana@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":6}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/6', '2026-07-03 14:56:03'),
(168, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 14:56:36'),
(169, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 14:56:47'),
(170, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 14:58:03'),
(171, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 14:59:49'),
(172, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 15:21:47'),
(176, 6, 'LOGIN_GOOGLE_DISPOSITIVO_NO_AUTORIZADO', 'Usuario', 6, 'Intento de acceso Google desde dispositivo no autorizado. IP: 127.0.0.1', NULL, '{\"fingerprint_intento\":\"23586a603ed75959420e347316fd1b49\",\"fingerprint_registrado\":\"580d06b833c946095cda7c271b0e07bf\"}', '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1', 'POST', 'api/auth/google', '2026-07-03 15:35:10'),
(177, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 15:38:17'),
(178, 6, 'ELIMINAR_USUARIO', 'Usuario', 47, 'Usuario eliminado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/47', '2026-07-03 15:38:31'),
(179, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 15:40:04'),
(186, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 15:42:28'),
(187, 6, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 36, 'Inscripción actualizada: usuario_id=49 en curso_id=10', '{\"id\":36,\"usuario_id\":49,\"curso_id\":10,\"estado\":\"PENDIENTE\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-03 11:41:56\",\"fecha_completado\":null}', '{\"id\":36,\"usuario_id\":49,\"curso_id\":10,\"estado\":\"INACTIVO\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-03 11:41:56\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/36', '2026-07-03 15:48:30'),
(188, 6, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 35, 'Inscripción actualizada: usuario_id=48 en curso_id=10', '{\"id\":35,\"usuario_id\":48,\"curso_id\":10,\"estado\":\"PENDIENTE\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-03 11:40:44\",\"fecha_completado\":null}', '{\"id\":35,\"usuario_id\":48,\"curso_id\":10,\"estado\":\"INACTIVO\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-03 11:40:44\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/35', '2026-07-03 15:48:58'),
(189, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 15:49:02'),
(192, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 15:49:50'),
(193, 6, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 35, 'Inscripción actualizada: usuario_id=48 en curso_id=10', '{\"id\":35,\"usuario_id\":48,\"curso_id\":10,\"estado\":\"INACTIVO\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-03 11:40:44\",\"fecha_completado\":null}', '{\"id\":35,\"usuario_id\":48,\"curso_id\":10,\"estado\":\"ACTIVO\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-03 11:40:44\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/35', '2026-07-03 15:51:37'),
(194, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 15:52:04'),
(199, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 15:54:09'),
(200, 6, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 36, 'Inscripción actualizada: usuario_id=49 en curso_id=10', '{\"id\":36,\"usuario_id\":49,\"curso_id\":10,\"estado\":\"INACTIVO\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-03 11:41:56\",\"fecha_completado\":null}', '{\"id\":36,\"usuario_id\":49,\"curso_id\":10,\"estado\":\"ACTIVO\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-03 11:41:56\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/36', '2026-07-03 15:56:48'),
(201, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 15:56:57'),
(204, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 16:21:58'),
(205, 6, 'ELIMINAR_USUARIO', 'Usuario', 48, 'Usuario eliminado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/48', '2026-07-03 16:22:12'),
(206, 6, 'ELIMINAR_USUARIO', 'Usuario', 49, 'Usuario eliminado: Maria Pacosillo (maria@gmail.com)', '{\"nombres\":\"Maria\",\"apellidos\":\"Pacosillo\",\"correo\":\"maria@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/49', '2026-07-03 16:22:21'),
(207, 6, 'CREAR_USUARIO', 'Usuario', 50, 'Usuario creado: Jhonatan Ramos Collquehuanca (ramosjhonatan659@gmail.com)', NULL, '{\"nombres\":\"Jhonatan\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/usuarios', '2026-07-03 16:22:42'),
(208, 6, 'INSCRIBIR_ESTUDIANTE', 'Inscripcion', 37, 'Inscripción creada: usuario_id=50 en curso_id=10 — estado: ACTIVO', NULL, '{\"curso_id\":10,\"usuario_id\":50,\"estado\":\"ACTIVO\",\"id\":37}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/inscripciones', '2026-07-03 16:23:01'),
(209, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 16:23:08'),
(213, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 17:13:41'),
(214, 6, 'ELIMINAR_USUARIO', 'Usuario', 50, 'Usuario eliminado: Jhonatan Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"Jhonatan\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/50', '2026-07-03 17:14:47'),
(215, 6, 'CREAR_USUARIO', 'Usuario', 51, 'Usuario creado: Juan Mario Paredez Callisaya (ramosjhonatan659@gmail.com)', NULL, '{\"nombres\":\"Juan Mario\",\"apellidos\":\"Paredez Callisaya\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/usuarios', '2026-07-03 17:15:29'),
(216, 6, 'INSCRIBIR_ESTUDIANTE', 'Inscripcion', 38, 'Inscripción creada: usuario_id=51 en curso_id=10 — estado: ACTIVO', NULL, '{\"curso_id\":10,\"usuario_id\":51,\"estado\":\"ACTIVO\",\"id\":38}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/inscripciones', '2026-07-03 17:16:02'),
(217, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 17:16:07'),
(223, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 17:45:09'),
(224, 6, 'ELIMINAR_USUARIO', 'Usuario', 51, 'Usuario eliminado: Juan Mario Paredez Callisaya (ramosjhonatan659@gmail.com)', '{\"nombres\":\"Juan Mario\",\"apellidos\":\"Paredez Callisaya\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/51', '2026-07-03 17:45:22'),
(225, 6, 'CREAR_USUARIO', 'Usuario', 52, 'Usuario creado: Jhonatan Ramos Collquehuanca (ramosjhonatan659@gmail.com)', NULL, '{\"nombres\":\"Jhonatan\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/usuarios', '2026-07-03 17:45:45'),
(226, 6, 'INSCRIBIR_ESTUDIANTE', 'Inscripcion', 39, 'Inscripción creada: usuario_id=52 en curso_id=10 — estado: ACTIVO', NULL, '{\"curso_id\":10,\"usuario_id\":52,\"estado\":\"ACTIVO\",\"id\":39}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/inscripciones', '2026-07-03 17:45:58'),
(227, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 17:46:04'),
(236, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 18:16:59'),
(237, 6, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 40, 'Inscripción actualizada: usuario_id=53 en curso_id=10', '{\"id\":40,\"usuario_id\":53,\"curso_id\":10,\"estado\":\"PENDIENTE\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-03 14:03:55\",\"fecha_completado\":null}', '{\"id\":40,\"usuario_id\":53,\"curso_id\":10,\"estado\":\"ACTIVO\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-03 14:03:55\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/40', '2026-07-03 18:17:16'),
(238, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 18:17:18'),
(242, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 18:19:55'),
(243, 6, 'ELIMINAR_USUARIO', 'Usuario', 53, 'Usuario eliminado: Omar Ramos (omaramos1522@gmail.com)', '{\"nombres\":\"Omar\",\"apellidos\":\"Ramos\",\"correo\":\"omaramos1522@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/53', '2026-07-03 18:20:09'),
(244, 6, 'ELIMINAR_USUARIO', 'Usuario', 52, 'Usuario eliminado: Jhonatan Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"Jhonatan\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/52', '2026-07-03 18:20:11'),
(245, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 18:20:14'),
(246, 54, 'REGISTRO_GOOGLE', 'Usuario', 54, 'Registro nuevo via Google: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 18:20:27'),
(247, 54, 'INSCRIBIR_ESTUDIANTE', 'Inscripcion', 41, 'Inscripción creada: usuario_id=54 en curso_id=10 — estado: PENDIENTE', NULL, '{\"curso_id\":10,\"usuario_id\":54,\"estado\":\"PENDIENTE\",\"id\":41}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/inscripciones', '2026-07-03 18:20:43'),
(248, 54, 'LOGOUT', 'Usuario', 54, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 18:20:56'),
(249, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 18:21:07'),
(250, 6, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 41, 'Inscripción actualizada: usuario_id=54 en curso_id=10', '{\"id\":41,\"usuario_id\":54,\"curso_id\":10,\"estado\":\"PENDIENTE\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-03 14:20:43\",\"fecha_completado\":null}', '{\"id\":41,\"usuario_id\":54,\"curso_id\":10,\"estado\":\"ACTIVO\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-03 14:20:43\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/41', '2026-07-03 18:21:28'),
(251, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 18:21:34'),
(252, 54, 'LOGIN_GOOGLE', 'Usuario', 54, 'Login via Google: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 18:21:45'),
(253, 54, 'LOGOUT', 'Usuario', 54, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 18:36:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('enervida-lms-cache-0h4Iap0FTPZkCKy0', 'a:1:{s:11:\"valid_until\";i:1783102814;}', 1784312474),
('enervida-lms-cache-0Nq9nPhVMXo4FoHt', 'a:1:{s:11:\"valid_until\";i:1783004987;}', 1784210327),
('enervida-lms-cache-0PP1bMDKZcLBP7if', 'a:1:{s:11:\"valid_until\";i:1783083187;}', 1784229247),
('enervida-lms-cache-1dPyhrKylbzdwOP0', 'a:1:{s:11:\"valid_until\";i:1783007459;}', 1784217119),
('enervida-lms-cache-2egmoXyLK5JuP8L5', 'a:1:{s:11:\"valid_until\";i:1783093204;}', 1784302804),
('enervida-lms-cache-2KTt9F4rKyPuYqn2', 'a:1:{s:11:\"valid_until\";i:1782999360;}', 1783092180),
('enervida-lms-cache-30iiCXfp7FT2BrJb', 'a:1:{s:11:\"valid_until\";i:1783019074;}', 1784228734),
('enervida-lms-cache-3FpJg7dJSjxkasEL', 'a:1:{s:11:\"valid_until\";i:1783007388;}', 1784217048),
('enervida-lms-cache-43FsUUX1pk04mVFT', 'a:1:{s:11:\"valid_until\";i:1782999358;}', 1783092178),
('enervida-lms-cache-4BInPgZkdErmeFiU', 'a:1:{s:11:\"valid_until\";i:1783000605;}', 1784210265),
('enervida-lms-cache-7uRGSPAemonpcXDW', 'a:1:{s:11:\"valid_until\";i:1783093258;}', 1784302918),
('enervida-lms-cache-84DgC1a2B14KSsQG', 'a:1:{s:11:\"valid_until\";i:1783090491;}', 1784300151),
('enervida-lms-cache-8icsEFL7xtx5UlrX', 'a:1:{s:11:\"valid_until\";i:1783007593;}', 1784217193),
('enervida-lms-cache-9pFdkOmchsxjfjsK', 'a:1:{s:11:\"valid_until\";i:1783102780;}', 1784312320),
('enervida-lms-cache-BKQgEG8JdLixAOY9', 'a:1:{s:11:\"valid_until\";i:1782191551;}', 1783401211),
('enervida-lms-cache-BW5Fu3RMhwE3SMIM', 'a:1:{s:11:\"valid_until\";i:1783007698;}', 1784217359),
('enervida-lms-cache-bZJQsgAUEreaks51', 'a:1:{s:11:\"valid_until\";i:1783102894;}', 1784312554),
('enervida-lms-cache-cUkV5YUSILzDXYDm', 'a:1:{s:11:\"valid_until\";i:1783007936;}', 1784217416),
('enervida-lms-cache-dbEmPXDD7qDMsHjw', 'a:1:{s:11:\"valid_until\";i:1782191521;}', 1783401181),
('enervida-lms-cache-DQ0Uf4Pr4m0bLVEm', 'a:1:{s:11:\"valid_until\";i:1783092107;}', 1784300507),
('enervida-lms-cache-Dztnem4GgN77gRFy', 'a:1:{s:11:\"valid_until\";i:1783007159;}', 1784216699),
('enervida-lms-cache-e4olP0fjJMTZdZ8H', 'a:1:{s:11:\"valid_until\";i:1783017155;}', 1784226695),
('enervida-lms-cache-EqLZJ1CKeH6dXRga', 'a:1:{s:11:\"valid_until\";i:1783084216;}', 1784293816),
('enervida-lms-cache-F3hzHiraOSnFkjmm', 'a:1:{s:11:\"valid_until\";i:1783094217;}', 1784303757),
('enervida-lms-cache-fGDzmvL0L9qDfnkB', 'a:1:{s:11:\"valid_until\";i:1783093323;}', 1784302983),
('enervida-lms-cache-fqTzE0mEpXa6VvQ2', 'a:1:{s:11:\"valid_until\";i:1783102607;}', 1784312267),
('enervida-lms-cache-fZzVQMPMWoCAmERC', 'a:1:{s:11:\"valid_until\";i:1783007657;}', 1784217317),
('enervida-lms-cache-G4dBGQygUFci3jAq', 'a:1:{s:11:\"valid_until\";i:1783016943;}', 1784226603),
('enervida-lms-cache-gDUI5BUMNyr14J53', 'a:1:{s:11:\"valid_until\";i:1783093778;}', 1784303438),
('enervida-lms-cache-GgBOnpeJo7yfLU4o', 'a:1:{s:11:\"valid_until\";i:1783017284;}', 1784226884),
('enervida-lms-cache-gHTp3fdTPSf56QqJ', 'a:1:{s:11:\"valid_until\";i:1782191562;}', 1783401222),
('enervida-lms-cache-gmHCO0lOj8DI48bA', 'a:1:{s:11:\"valid_until\";i:1783101799;}', 1784310439),
('enervida-lms-cache-GnnnDf0lSXLDrjqw', 'a:1:{s:11:\"valid_until\";i:1783019112;}', 1784228773),
('enervida-lms-cache-GyvOyredsBLR5uW0', 'a:1:{s:11:\"valid_until\";i:1783102638;}', 1784312298),
('enervida-lms-cache-H7kbVqvcjlk7H8mj', 'a:1:{s:11:\"valid_until\";i:1783007306;}', 1784216906),
('enervida-lms-cache-HtC8IGwUljQvIKbT', 'a:1:{s:11:\"valid_until\";i:1783103776;}', 1784312596),
('enervida-lms-cache-hXGmRDE1GGPKRZwh', 'a:1:{s:11:\"valid_until\";i:1783102857;}', 1784312517),
('enervida-lms-cache-IC7mCkafYF6Y2wUm', 'a:1:{s:11:\"valid_until\";i:1783100699;}', 1784310359),
('enervida-lms-cache-IIz5lQEHa5t79zCN', 'a:1:{s:11:\"valid_until\";i:1783098967;}', 1784308507),
('enervida-lms-cache-Il4WtQ7i8VZnRZ6l', 'a:1:{s:11:\"valid_until\";i:1783018867;}', 1784226967),
('enervida-lms-cache-JanM07wbtvTcxOOi', 'a:1:{s:11:\"valid_until\";i:1783000549;}', 1784209369),
('enervida-lms-cache-KOMvCy8nF9I0aJFU', 'a:1:{s:11:\"valid_until\";i:1783090475;}', 1784299415),
('enervida-lms-cache-KTdG8qvwyTf8sS2i', 'a:1:{s:11:\"valid_until\";i:1783007177;}', 1784216837),
('enervida-lms-cache-Lb1SFRFMK21XaWjp', 'a:1:{s:11:\"valid_until\";i:1783092876;}', 1784301816),
('enervida-lms-cache-LgMBxgVc2tx5VRh1', 'a:1:{s:11:\"valid_until\";i:1783007197;}', 1784216857),
('enervida-lms-cache-LHwiDIe8egcj7Gx7', 'a:1:{s:11:\"valid_until\";i:1782191509;}', 1783401169),
('enervida-lms-cache-ltOQ2kiPOh5mW3cW', 'a:1:{s:11:\"valid_until\";i:1783100764;}', 1784310424),
('enervida-lms-cache-Mn706UlQvojuDWij', 'a:1:{s:11:\"valid_until\";i:1783007723;}', 1784217383),
('enervida-lms-cache-Mqgbhl9MRUVEfIBs', 'a:1:{s:11:\"valid_until\";i:1782191487;}', 1783399407),
('enervida-lms-cache-mUbe8W2J8WvFV9jT', 'a:1:{s:11:\"valid_until\";i:1783019470;}', 1784228890),
('enervida-lms-cache-nTBWp1OpjJuyTWHu', 'a:1:{s:11:\"valid_until\";i:1783004986;}', 1784210326),
('enervida-lms-cache-NthPSBeHrBp5I0Ay', 'a:1:{s:11:\"valid_until\";i:1783006945;}', 1784216605),
('enervida-lms-cache-oHzXyLwDrc1fahuq', 'a:1:{s:11:\"valid_until\";i:1783006994;}', 1784216654),
('enervida-lms-cache-pD4RxdYM3PgghOOy', 'a:1:{s:11:\"valid_until\";i:1783090683;}', 1784300283),
('enervida-lms-cache-PEOrgkJaXekCwIJc', 'a:1:{s:11:\"valid_until\";i:1783095698;}', 1784303918),
('enervida-lms-cache-PKFLE5v4hMA5JM8g', 'a:1:{s:11:\"valid_until\";i:1783093742;}', 1784303042),
('enervida-lms-cache-pl317g2oWMQMnsfk', 'a:1:{s:11:\"valid_until\";i:1783089620;}', 1784293940),
('enervida-lms-cache-QdIe7TTgxMYRbP0P', 'a:1:{s:11:\"valid_until\";i:1783016695;}', 1784226355),
('enervida-lms-cache-qky0M9qUPiJDXCbt', 'a:1:{s:11:\"valid_until\";i:1783084078;}', 1784292898),
('enervida-lms-cache-qvdgqJtGi1JQ0PI4', 'a:1:{s:11:\"valid_until\";i:1783016556;}', 1784226096),
('enervida-lms-cache-rFBHG4eONmi8eAD9', 'a:1:{s:11:\"valid_until\";i:1783090596;}', 1784300196),
('enervida-lms-cache-RI4Ykt6UYUSPBtHN', 'a:1:{s:11:\"valid_until\";i:1783006874;}', 1784214674),
('enervida-lms-cache-s2hd2bddZU30vc2a', 'a:1:{s:11:\"valid_until\";i:1783017196;}', 1784226856),
('enervida-lms-cache-S7s0uIxvPwn6ChOD', 'a:1:{s:11:\"valid_until\";i:1783094037;}', 1784303637),
('enervida-lms-cache-smJZrrXwIVfesHUq', 'a:1:{s:11:\"valid_until\";i:1783016653;}', 1784226253),
('enervida-lms-cache-SrdgB2lxKz1h9Sez', 'a:1:{s:11:\"valid_until\";i:1783008000;}', 1784217660),
('enervida-lms-cache-sXbctdlv0Pgr1VsB', 'a:1:{s:11:\"valid_until\";i:1783019182;}', 1784228782),
('enervida-lms-cache-t7ge2NbmGTVsXJwh', 'a:1:{s:11:\"valid_until\";i:1783016980;}', 1784226640),
('enervida-lms-cache-TGPw3peXr3ucOzSD', 'a:1:{s:11:\"valid_until\";i:1782999634;}', 1784209114),
('enervida-lms-cache-tPTttVvsblQfWXxk', 'a:1:{s:11:\"valid_until\";i:1783089611;}', 1784293931),
('enervida-lms-cache-tR9NYnLiw2MJ13ZY', 'a:1:{s:11:\"valid_until\";i:1783102584;}', 1784311524),
('enervida-lms-cache-UsGHN83EJYZfvKiX', 'a:1:{s:11:\"valid_until\";i:1783093924;}', 1784303464),
('enervida-lms-cache-uV2Wih44Tk1S0gd0', 'a:1:{s:11:\"valid_until\";i:1783016884;}', 1784226544),
('enervida-lms-cache-vRqRnB0O725F9u1t', 'a:1:{s:11:\"valid_until\";i:1783100677;}', 1784308657),
('enervida-lms-cache-vsbofOtwgLpahQ3x', 'a:1:{s:11:\"valid_until\";i:1783006977;}', 1784216637),
('enervida-lms-cache-W3U24JCCGANFwbNC', 'a:1:{s:11:\"valid_until\";i:1783098794;}', 1784305514),
('enervida-lms-cache-xJRz4Dh3pfNKl8zZ', 'a:1:{s:11:\"valid_until\";i:1783095788;}', 1784305388),
('enervida-lms-cache-xPwrlxCbcVJGX1JH', 'a:1:{s:11:\"valid_until\";i:1783016240;}', 1784217680),
('enervida-lms-cache-xWXFZGcnlTKrdRFu', 'a:1:{s:11:\"valid_until\";i:1783019575;}', 1784229175),
('enervida-lms-cache-ylWeZhe4N8PcnLXA', 'a:1:{s:11:\"valid_until\";i:1783019216;}', 1784228876),
('enervida-lms-cache-z8fp9e702Q3syira', 'a:1:{s:11:\"valid_until\";i:1783016864;}', 1784226404);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `fecha_creacion`) VALUES
(1, 'General', 'Categoría creada automáticamente', '2026-05-21 19:06:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificados`
--

CREATE TABLE `certificados` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `usuario_id` bigint(20) UNSIGNED NOT NULL,
  `curso_id` bigint(20) UNSIGNED NOT NULL,
  `codigo_certificado` varchar(255) NOT NULL,
  `pdf_url` varchar(255) NOT NULL,
  `fecha_emision` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificado_plantillas`
--

CREATE TABLE `certificado_plantillas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `curso_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `background_url` varchar(255) NOT NULL,
  `config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`config`)),
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `certificado_plantillas`
--

INSERT INTO `certificado_plantillas` (`id`, `curso_id`, `nombre`, `background_url`, `config`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(4, 10, 'Plantilla - Bombeo Solar', 'http://localhost:8000/uploads/general/1783006112_plantilla.png', '{\"elements\":[{\"id\":\"6vugiln8ymr3nt0yv\",\"type\":\"qr\",\"x\":843.1984,\"y\":535.512,\"size\":120,\"width\":120,\"height\":120,\"rotate\":0,\"opacity\":100},{\"id\":\"msk53eaeemr3nt72r\",\"type\":\"text\",\"x\":840.936,\"y\":661.0752000000001,\"content\":\"{{codigo}}\",\"size\":22,\"width\":231.4512,\"height\":100,\"color\":\"#1a1a1a\",\"fontFamily\":\"Helvetica\",\"bold\":false,\"italic\":false,\"textAlign\":\"left\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false},{\"id\":\"bm4m5we74mr3nu8w8\",\"type\":\"text\",\"x\":131.6736,\"y\":268.5488,\"content\":\"{{estudiante}}\",\"size\":24,\"width\":576.2977213346815,\"height\":100,\"color\":\"#1a1a1a\",\"fontFamily\":\"Dancing Script\",\"bold\":false,\"italic\":true,\"textAlign\":\"center\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false},{\"id\":\"4m6y7sjuumr3nv6do\",\"type\":\"text\",\"x\":131.6736,\"y\":389.5872,\"content\":\"{{curso}}\",\"size\":32,\"width\":764.2464,\"height\":100,\"color\":\"#1a1a1a\",\"fontFamily\":\"Open Sans\",\"bold\":true,\"italic\":false,\"textAlign\":\"center\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false},{\"id\":\"0a4e96ep9mr3nw4mb\",\"type\":\"text\",\"x\":217.6448,\"y\":483.4768,\"content\":\"{{fecha}}\",\"size\":18,\"width\":160.18670010111222,\"height\":100,\"color\":\"#c79adf\",\"fontFamily\":\"Helvetica\",\"bold\":true,\"italic\":false,\"textAlign\":\"left\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false}],\"logicalWidth\":1000,\"logicalHeight\":707,\"selectedFormat\":\"A4\",\"orientation\":\"landscape\"}', '2026-07-02 15:32:20', '2026-07-02 15:39:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clases_en_vivo`
--

CREATE TABLE `clases_en_vivo` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `curso_id` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `sala_jitsi` varchar(255) NOT NULL,
  `fecha_inicio` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_fin` timestamp NULL DEFAULT NULL,
  `creado_por` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `categoria_id` bigint(20) UNSIGNED NOT NULL,
  `instructor_id` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `descripcion_corta` text DEFAULT NULL,
  `descripcion` longtext DEFAULT NULL,
  `miniatura_url` varchar(255) DEFAULT NULL,
  `nivel` varchar(255) DEFAULT NULL,
  `tipo_curso` varchar(255) DEFAULT NULL,
  `certificado_habilitado` tinyint(1) NOT NULL DEFAULT 1,
  `publicado` tinyint(1) NOT NULL DEFAULT 0,
  `precio` decimal(10,2) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `edicion_actual` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Edición del curso (VV) – se reinicia al iniciar un nuevo año'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id`, `categoria_id`, `instructor_id`, `titulo`, `slug`, `descripcion_corta`, `descripcion`, `miniatura_url`, `nivel`, `tipo_curso`, `certificado_habilitado`, `publicado`, `precio`, `fecha_creacion`, `fecha_actualizacion`, `edicion_actual`) VALUES
(10, 1, 6, 'Bombeo Solar', 'bombeo-solar', 'Curso teórico-práctico de la empresa Enervida para aprender a diseñar, dimensionar e instalar sistemas de bombeo solar fotovoltaico eficientes.', '¡Bienvenidos al Curso de Bombeo Solar de la empresa Enervida!\n\nEste programa de capacitación técnica te brindará todas las herramientas necesarias para dominar el uso de la energía solar en el transporte de agua. Está diseñado especialmente para profesionales, técnicos y personas del sector agrícola que buscan implementar soluciones sostenibles y reducir costos operativos.\n\nLo que aprenderás en este curso:\n* Fundamentos de la energía solar fotovoltaica aplicada al bombeo de agua.\n* Cálculo y dimensionamiento de paneles solares según la demanda de agua.\n* Selección adecuada de bombas (corriente continua y alterna), controladores e inversores.\n* Diseño hidráulico, optimización de caudales y pérdidas de carga en tuberías.\n* Buenas prácticas de instalación, mantenimiento preventivo y seguridad eléctrica.\n\nOptimiza el uso del agua y aprovecha la energía del sol con la garantía de aprendizaje de Enervida. ¡Inscríbete hoy mismo!', 'http://localhost:8000/uploads/general/1783005595_679475974-1577547564376963-2848436857219950621-n.jpg', 'Todos', 'VOD', 1, 1, 200.00, '2026-07-02 15:20:24', '2026-07-03 14:43:50', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dispositivos_usuario`
--

CREATE TABLE `dispositivos_usuario` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `usuario_id` bigint(20) UNSIGNED NOT NULL,
  `nombre_dispositivo` varchar(255) DEFAULT NULL,
  `sistema_operativo` varchar(255) DEFAULT NULL,
  `navegador` varchar(255) DEFAULT NULL,
  `fingerprint` varchar(255) DEFAULT NULL,
  `direccion_ip` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `ultimo_acceso` timestamp NULL DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_agent` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `dispositivos_usuario`
--

INSERT INTO `dispositivos_usuario` (`id`, `usuario_id`, `nombre_dispositivo`, `sistema_operativo`, `navegador`, `fingerprint`, `direccion_ip`, `activo`, `ultimo_acceso`, `fecha_creacion`, `user_agent`) VALUES
(2, 6, 'Computadora', 'Windows 10/11', 'Chrome', '580d06b833c946095cda7c271b0e07bf', '127.0.0.1', 1, '2026-07-03 22:21:07', '2026-06-22 19:11:40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36'),
(28, 54, 'Computadora', 'Windows 10/11', 'Chrome', '580d06b833c946095cda7c271b0e07bf', '127.0.0.1', 1, '2026-07-03 22:21:45', '2026-07-03 18:20:27', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluaciones`
--

CREATE TABLE `evaluaciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `curso_id` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `nota_aprobacion` decimal(5,2) NOT NULL,
  `tiempo_limite` int(11) DEFAULT NULL,
  `intentos_permitidos` int(11) NOT NULL DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `evaluaciones`
--

INSERT INTO `evaluaciones` (`id`, `curso_id`, `titulo`, `descripcion`, `nota_aprobacion`, `tiempo_limite`, `intentos_permitidos`, `fecha_creacion`) VALUES
(5, 10, 'Evaluacion Final', 'Lea atentamente las preguntas', 70.00, 20, 2, '2026-07-02 15:40:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripciones`
--

CREATE TABLE `inscripciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `usuario_id` bigint(20) UNSIGNED NOT NULL,
  `curso_id` bigint(20) UNSIGNED NOT NULL,
  `estado` varchar(255) NOT NULL DEFAULT 'PENDIENTE',
  `porcentaje_progreso` decimal(5,2) NOT NULL DEFAULT 0.00,
  `fecha_inscripcion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_completado` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inscripciones`
--

INSERT INTO `inscripciones` (`id`, `usuario_id`, `curso_id`, `estado`, `porcentaje_progreso`, `fecha_inscripcion`, `fecha_completado`) VALUES
(41, 54, 10, 'COMPLETADO', 100.00, '2026-07-03 18:20:43', '2026-07-03 22:23:02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `intentos_evaluacion`
--

CREATE TABLE `intentos_evaluacion` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `evaluacion_id` bigint(20) UNSIGNED NOT NULL,
  `usuario_id` bigint(20) UNSIGNED NOT NULL,
  `nota` decimal(5,2) DEFAULT NULL,
  `fecha_inicio` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_fin` timestamp NULL DEFAULT NULL,
  `aprobado` tinyint(1) DEFAULT NULL,
  `respuestas_seleccionadas` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`respuestas_seleccionadas`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lecciones`
--

CREATE TABLE `lecciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `modulo_id` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `orden_leccion` int(11) NOT NULL,
  `tipo_contenido` varchar(255) NOT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `pdf_url` varchar(255) DEFAULT NULL,
  `contenido` longtext DEFAULT NULL,
  `duracion_minutos` int(11) DEFAULT NULL,
  `es_preview` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `lecciones`
--

INSERT INTO `lecciones` (`id`, `modulo_id`, `titulo`, `orden_leccion`, `tipo_contenido`, `video_url`, `pdf_url`, `contenido`, `duracion_minutos`, `es_preview`, `fecha_creacion`) VALUES
(12, 12, 'Introduccion a bombeo solares', 1, 'VIDEO', 'http://localhost:8000/uploads/general/1783005746_video.mp4', NULL, NULL, NULL, 0, '2026-07-02 15:22:31'),
(13, 13, 'Manual de instalacion pdf', 1, 'PDF', NULL, 'http://localhost:8000/uploads/general/1783005774_mp-cert-001.pdf', NULL, NULL, 0, '2026-07-02 15:22:58'),
(14, 14, 'Que es bombeo solar', 1, 'VIDEO', 'http://localhost:8000/uploads/general/1783005808_video.mp4', NULL, NULL, NULL, 0, '2026-07-02 15:23:31'),
(15, 15, 'Guia de instalacion', 1, 'VIDEO', 'http://localhost:8000/uploads/general/1783005847_video-prototipo-pg-jrc.mp4', NULL, NULL, NULL, 0, '2026-07-02 15:24:10'),
(16, 15, 'Reposiotrio de instalacion', 2, 'PDF', NULL, 'http://localhost:8000/uploads/general/1783005879_pg-jhonatan.pdf', NULL, NULL, 0, '2026-07-02 15:24:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '0001_01_01_000002_create_jobs_table', 1),
(3, '2026_05_21_180707_create_roles_table', 1),
(4, '2026_05_21_180709_create_usuarios_table', 1),
(5, '2026_05_21_180710_create_dispositivos_usuario_table', 1),
(6, '2026_05_21_180712_create_categorias_table', 1),
(7, '2026_05_21_180713_create_cursos_table', 1),
(8, '2026_05_21_180714_create_certificado_plantillas_table', 1),
(9, '2026_05_21_180716_create_modulos_table', 1),
(10, '2026_05_21_180717_create_lecciones_table', 1),
(11, '2026_05_21_180719_create_clases_en_vivo_table', 1),
(12, '2026_05_21_180720_create_participantes_clase_en_vivo_table', 1),
(13, '2026_05_21_180722_create_inscripciones_table', 1),
(14, '2026_05_21_180723_create_progreso_lecciones_table', 1),
(15, '2026_05_21_180725_create_evaluaciones_table', 1),
(16, '2026_05_21_180726_create_preguntas_table', 1),
(17, '2026_05_21_180727_create_respuestas_table', 1),
(18, '2026_05_21_180729_create_intentos_evaluacion_table', 1),
(19, '2026_05_21_180730_create_certificados_table', 1),
(20, '2026_05_21_180732_create_tokens_recuperacion_table', 1),
(21, '2026_05_21_180733_create_notificaciones_table', 1),
(22, '2026_05_21_180734_create_auditoria_logs_table', 1),
(23, '2026_06_23_012311_add_tipo_to_tokens_recuperacion_table', 2),
(24, '2026_07_02_000001_add_edicion_actual_to_cursos_table', 3),
(25, '2026_07_02_180735_add_respuestas_seleccionadas_to_intentos_evaluacion_table', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos`
--

CREATE TABLE `modulos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `curso_id` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `orden_modulo` int(11) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `modulos`
--

INSERT INTO `modulos` (`id`, `curso_id`, `titulo`, `orden_modulo`, `fecha_creacion`) VALUES
(12, 10, 'Introduccion al curso', 1, '2026-07-02 15:20:44'),
(13, 10, 'manual de instalacion', 2, '2026-07-02 15:21:04'),
(14, 10, 'Conceptos basicos de instalacion.', 3, '2026-07-02 15:21:23'),
(15, 10, 'Instalacion e implementacion', 4, '2026-07-02 15:21:38');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `usuario_id` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `mensaje` text NOT NULL,
  `leido` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `participantes_clase_en_vivo`
--

CREATE TABLE `participantes_clase_en_vivo` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `clase_en_vivo_id` bigint(20) UNSIGNED NOT NULL,
  `usuario_id` bigint(20) UNSIGNED NOT NULL,
  `hora_ingreso` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `hora_salida` timestamp NULL DEFAULT NULL,
  `minutos_asistencia` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas`
--

CREATE TABLE `preguntas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `evaluacion_id` bigint(20) UNSIGNED NOT NULL,
  `pregunta` text NOT NULL,
  `tipo_pregunta` varchar(255) NOT NULL,
  `puntos` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `preguntas`
--

INSERT INTO `preguntas` (`id`, `evaluacion_id`, `pregunta`, `tipo_pregunta`, `puntos`) VALUES
(5, 5, 'que es energia', 'TRUE_FALSE', 10),
(6, 5, 'jioanciancacnjas', 'MULTIPLE_CHOICE', 10),
(7, 5, 'ioacnajkcmals;cmsa', 'MULTIPLE_CHOICE', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `progreso_lecciones`
--

CREATE TABLE `progreso_lecciones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `usuario_id` bigint(20) UNSIGNED NOT NULL,
  `leccion_id` bigint(20) UNSIGNED NOT NULL,
  `completado` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_completado` timestamp NULL DEFAULT NULL,
  `segundos_vistos` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `progreso_lecciones`
--

INSERT INTO `progreso_lecciones` (`id`, `usuario_id`, `leccion_id`, `completado`, `fecha_completado`, `segundos_vistos`) VALUES
(124, 54, 12, 1, NULL, 0),
(125, 54, 13, 1, NULL, 0),
(126, 54, 14, 1, NULL, 0),
(127, 54, 15, 1, NULL, 0),
(128, 54, 16, 1, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas`
--

CREATE TABLE `respuestas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `pregunta_id` bigint(20) UNSIGNED NOT NULL,
  `respuesta` text NOT NULL,
  `es_correcta` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `respuestas`
--

INSERT INTO `respuestas` (`id`, `pregunta_id`, `respuesta`, `es_correcta`) VALUES
(11, 5, 'F', 0),
(12, 5, 'V', 1),
(13, 6, 'el es mamsmas', 1),
(14, 6, 'klnaklcnalsc', 0),
(15, 7, 'el es mdasdasndj', 1),
(16, 7, 'klncakcnjsc', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`, `descripcion`, `fecha_creacion`) VALUES
(1, 'admin', 'Administrador del sistema', '2026-05-21 18:40:02'),
(2, 'estudiante', '{\"info\":\"Estudiante del sistema\",\"permisos\":[\"CONFIG\",\"ARCHIVOS\"]}', '2026-05-21 18:40:02'),
(6, 'docente', '{\"info\":\"PODRA REALIZAR LOS CURSOS.\",\"permisos\":[\"CURSOS\",\"CLASES_VIVO\",\"CALIFICACIONES\",\"VERIFICACIONES QR\",\"CONFIG\",\"EVALUACIONES\",\"ARCHIVOS\",\"SOLICITUDES\"]}', '2026-07-03 14:55:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tokens_recuperacion`
--

CREATE TABLE `tokens_recuperacion` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `usuario_id` bigint(20) UNSIGNED NOT NULL,
  `token` varchar(255) NOT NULL,
  `tipo` varchar(255) NOT NULL DEFAULT 'RESET_PASSWORD',
  `expira_en` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `usado` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tokens_recuperacion`
--

INSERT INTO `tokens_recuperacion` (`id`, `usuario_id`, `token`, `tipo`, `expira_en`, `usado`, `fecha_creacion`) VALUES
(2, 6, 's1t6zoLH3h0aiQENcEXPsCFjcrCPPIt8Yk2IZqIFwY0No0NatkTajIv2dHUfzy35', 'RESET_PASSWORD', '2026-06-23 07:06:29', 0, '2026-06-23 02:06:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rol_id` bigint(20) UNSIGNED NOT NULL,
  `nombres` varchar(255) NOT NULL,
  `apellidos` varchar(255) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `contrasena_hash` varchar(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `imagen_perfil` varchar(255) DEFAULT NULL,
  `estado` varchar(255) NOT NULL DEFAULT 'ACTIVO',
  `correo_verificado` tinyint(1) NOT NULL DEFAULT 0,
  `ultimo_login` timestamp NULL DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `refresh_token` varchar(255) DEFAULT NULL,
  `ci` varchar(255) DEFAULT NULL,
  `google_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `rol_id`, `nombres`, `apellidos`, `correo`, `contrasena_hash`, `telefono`, `imagen_perfil`, `estado`, `correo_verificado`, `ultimo_login`, `fecha_creacion`, `fecha_actualizacion`, `refresh_token`, `ci`, `google_id`) VALUES
(6, 1, 'Angel', 'Ramos Colque', 'danielacopana@gmail.com', '$2y$12$krRZ5BrbklnKv/AXTzJWCOKtpipSakqQXc9BDbuBF5uR.2xeR3Tmy', NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJVoi_9IxipIq8ZCyKMX6IzdEhGTDPDgXWuPlHjYDCjEmIGYw=s96-c', 'ACTIVO', 1, '2026-07-03 22:21:06', '2026-05-21 19:03:57', '2026-07-03 18:21:06', NULL, NULL, '108515650607971543427'),
(54, 2, 'JHONATAN', 'Ramos Collquehuanca', 'ramosjhonatan659@gmail.com', '$2y$12$mxfj7yDdLxhxoc0RENh6dOVLYLJD04WA8.BK/o9nyFJLZegeUTTGa', '441665', 'https://lh3.googleusercontent.com/a/ACg8ocJddn9byvRrqboe0qx4Xmk7lYMSwFos3goeO5Yxk9enQPwOurcW=s96-c', 'ACTIVO', 1, '2026-07-03 22:21:45', '2026-07-03 18:20:27', '2026-07-03 18:21:45', NULL, '1325416854', '112034738939767958183');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auditoria_logs`
--
ALTER TABLE `auditoria_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `auditoria_logs_usuario_id_foreign` (`usuario_id`);

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categorias_nombre_unique` (`nombre`);

--
-- Indices de la tabla `certificados`
--
ALTER TABLE `certificados`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `certificados_codigo_certificado_unique` (`codigo_certificado`),
  ADD KEY `certificados_usuario_id_foreign` (`usuario_id`),
  ADD KEY `certificados_curso_id_foreign` (`curso_id`);

--
-- Indices de la tabla `certificado_plantillas`
--
ALTER TABLE `certificado_plantillas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `certificado_plantillas_curso_id_unique` (`curso_id`);

--
-- Indices de la tabla `clases_en_vivo`
--
ALTER TABLE `clases_en_vivo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clases_en_vivo_curso_id_foreign` (`curso_id`),
  ADD KEY `clases_en_vivo_creado_por_foreign` (`creado_por`);

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cursos_slug_unique` (`slug`),
  ADD KEY `cursos_categoria_id_foreign` (`categoria_id`),
  ADD KEY `cursos_instructor_id_foreign` (`instructor_id`);

--
-- Indices de la tabla `dispositivos_usuario`
--
ALTER TABLE `dispositivos_usuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dispositivos_usuario_usuario_id_foreign` (`usuario_id`);

--
-- Indices de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `evaluaciones_curso_id_foreign` (`curso_id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inscripciones_usuario_id_foreign` (`usuario_id`),
  ADD KEY `inscripciones_curso_id_foreign` (`curso_id`);

--
-- Indices de la tabla `intentos_evaluacion`
--
ALTER TABLE `intentos_evaluacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `intentos_evaluacion_evaluacion_id_foreign` (`evaluacion_id`),
  ADD KEY `intentos_evaluacion_usuario_id_foreign` (`usuario_id`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `lecciones`
--
ALTER TABLE `lecciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lecciones_modulo_id_foreign` (`modulo_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `modulos_curso_id_foreign` (`curso_id`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notificaciones_usuario_id_foreign` (`usuario_id`);

--
-- Indices de la tabla `participantes_clase_en_vivo`
--
ALTER TABLE `participantes_clase_en_vivo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `participantes_clase_en_vivo_clase_en_vivo_id_foreign` (`clase_en_vivo_id`),
  ADD KEY `participantes_clase_en_vivo_usuario_id_foreign` (`usuario_id`);

--
-- Indices de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `preguntas_evaluacion_id_foreign` (`evaluacion_id`);

--
-- Indices de la tabla `progreso_lecciones`
--
ALTER TABLE `progreso_lecciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `progreso_lecciones_usuario_id_foreign` (`usuario_id`),
  ADD KEY `progreso_lecciones_leccion_id_foreign` (`leccion_id`);

--
-- Indices de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `respuestas_pregunta_id_foreign` (`pregunta_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_nombre_unique` (`nombre`);

--
-- Indices de la tabla `tokens_recuperacion`
--
ALTER TABLE `tokens_recuperacion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tokens_recuperacion_token_unique` (`token`),
  ADD KEY `tokens_recuperacion_usuario_id_foreign` (`usuario_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuarios_correo_unique` (`correo`),
  ADD UNIQUE KEY `usuarios_ci_unique` (`ci`),
  ADD UNIQUE KEY `usuarios_google_id_unique` (`google_id`),
  ADD KEY `usuarios_rol_id_foreign` (`rol_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auditoria_logs`
--
ALTER TABLE `auditoria_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=254;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `certificados`
--
ALTER TABLE `certificados`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `certificado_plantillas`
--
ALTER TABLE `certificado_plantillas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `clases_en_vivo`
--
ALTER TABLE `clases_en_vivo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `dispositivos_usuario`
--
ALTER TABLE `dispositivos_usuario`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `intentos_evaluacion`
--
ALTER TABLE `intentos_evaluacion`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lecciones`
--
ALTER TABLE `lecciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `participantes_clase_en_vivo`
--
ALTER TABLE `participantes_clase_en_vivo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `progreso_lecciones`
--
ALTER TABLE `progreso_lecciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tokens_recuperacion`
--
ALTER TABLE `tokens_recuperacion`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `auditoria_logs`
--
ALTER TABLE `auditoria_logs`
  ADD CONSTRAINT `auditoria_logs_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `certificados`
--
ALTER TABLE `certificados`
  ADD CONSTRAINT `certificados_curso_id_foreign` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `certificados_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `certificado_plantillas`
--
ALTER TABLE `certificado_plantillas`
  ADD CONSTRAINT `certificado_plantillas_curso_id_foreign` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `clases_en_vivo`
--
ALTER TABLE `clases_en_vivo`
  ADD CONSTRAINT `clases_en_vivo_creado_por_foreign` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `clases_en_vivo_curso_id_foreign` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD CONSTRAINT `cursos_categoria_id_foreign` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`),
  ADD CONSTRAINT `cursos_instructor_id_foreign` FOREIGN KEY (`instructor_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `dispositivos_usuario`
--
ALTER TABLE `dispositivos_usuario`
  ADD CONSTRAINT `dispositivos_usuario_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD CONSTRAINT `evaluaciones_curso_id_foreign` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  ADD CONSTRAINT `inscripciones_curso_id_foreign` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inscripciones_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `intentos_evaluacion`
--
ALTER TABLE `intentos_evaluacion`
  ADD CONSTRAINT `intentos_evaluacion_evaluacion_id_foreign` FOREIGN KEY (`evaluacion_id`) REFERENCES `evaluaciones` (`id`),
  ADD CONSTRAINT `intentos_evaluacion_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `lecciones`
--
ALTER TABLE `lecciones`
  ADD CONSTRAINT `lecciones_modulo_id_foreign` FOREIGN KEY (`modulo_id`) REFERENCES `modulos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD CONSTRAINT `modulos_curso_id_foreign` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `participantes_clase_en_vivo`
--
ALTER TABLE `participantes_clase_en_vivo`
  ADD CONSTRAINT `participantes_clase_en_vivo_clase_en_vivo_id_foreign` FOREIGN KEY (`clase_en_vivo_id`) REFERENCES `clases_en_vivo` (`id`),
  ADD CONSTRAINT `participantes_clase_en_vivo_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD CONSTRAINT `preguntas_evaluacion_id_foreign` FOREIGN KEY (`evaluacion_id`) REFERENCES `evaluaciones` (`id`);

--
-- Filtros para la tabla `progreso_lecciones`
--
ALTER TABLE `progreso_lecciones`
  ADD CONSTRAINT `progreso_lecciones_leccion_id_foreign` FOREIGN KEY (`leccion_id`) REFERENCES `lecciones` (`id`),
  ADD CONSTRAINT `progreso_lecciones_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD CONSTRAINT `respuestas_pregunta_id_foreign` FOREIGN KEY (`pregunta_id`) REFERENCES `preguntas` (`id`);

--
-- Filtros para la tabla `tokens_recuperacion`
--
ALTER TABLE `tokens_recuperacion`
  ADD CONSTRAINT `tokens_recuperacion_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_rol_id_foreign` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
