-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-07-2026 a las 22:55:45
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
(249, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-03 18:21:07'),
(250, 6, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 41, 'Inscripción actualizada: usuario_id=54 en curso_id=10', '{\"id\":41,\"usuario_id\":54,\"curso_id\":10,\"estado\":\"PENDIENTE\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-03 14:20:43\",\"fecha_completado\":null}', '{\"id\":41,\"usuario_id\":54,\"curso_id\":10,\"estado\":\"ACTIVO\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-03 14:20:43\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/41', '2026-07-03 18:21:28'),
(251, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-03 18:21:34'),
(254, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-06 13:53:37'),
(255, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-07 14:19:59'),
(256, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-07 14:21:19'),
(258, 6, 'LOGIN_GOOGLE_DISPOSITIVO_NO_AUTORIZADO', 'Usuario', 6, 'Intento de acceso Google desde dispositivo no autorizado. IP: 127.0.0.1', NULL, '{\"fingerprint_intento\":\"06606101dcf37c0e67adb1071e8a548d\",\"fingerprint_registrado\":\"580d06b833c946095cda7c271b0e07bf\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-09 13:25:13'),
(267, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-10 12:54:43'),
(268, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-10 12:55:22'),
(269, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-10 12:55:44'),
(270, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-10 12:56:03'),
(271, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-10 12:57:01'),
(272, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-10 12:57:19'),
(273, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: danielacopana@gmail.com', NULL, '{\"correo\":\"danielacopana@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-10 14:58:05'),
(274, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: danielacopana@gmail.com', NULL, '{\"correo\":\"danielacopana@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-10 14:58:15'),
(275, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-10 14:58:22'),
(276, 6, 'ELIMINAR_USUARIO', 'Usuario', 54, 'Usuario eliminado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/54', '2026-07-10 14:59:04'),
(277, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-10 14:59:09'),
(278, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-10 14:59:55'),
(279, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-10 15:00:12'),
(280, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-10 15:01:02'),
(281, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0', 'POST', 'api/auth/login', '2026-07-10 15:01:22'),
(285, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-10 15:18:16'),
(286, 6, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 42, 'Inscripción actualizada: usuario_id=55 en curso_id=10', '{\"id\":42,\"usuario_id\":55,\"curso_id\":10,\"estado\":\"PENDIENTE\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-10 11:17:23\",\"fecha_completado\":null}', '{\"id\":42,\"usuario_id\":55,\"curso_id\":10,\"estado\":\"ACTIVO\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-10 11:17:23\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/42', '2026-07-10 15:19:06'),
(287, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-10 15:19:11'),
(292, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-10 15:38:07'),
(293, 6, 'ELIMINAR_USUARIO', 'Usuario', 55, 'Usuario eliminado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/55', '2026-07-10 15:38:25'),
(294, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-10 15:38:44'),
(298, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-10 15:42:52'),
(299, 6, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 43, 'Inscripción actualizada: usuario_id=56 en curso_id=10', '{\"id\":43,\"usuario_id\":56,\"curso_id\":10,\"estado\":\"PENDIENTE\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-10 11:40:24\",\"fecha_completado\":null}', '{\"id\":43,\"usuario_id\":56,\"curso_id\":10,\"estado\":\"ACTIVO\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-10 11:40:24\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/43', '2026-07-10 15:43:08'),
(300, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-10 15:43:15'),
(305, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-10 18:42:28'),
(306, 6, 'ELIMINAR_USUARIO', 'Usuario', 56, 'Usuario eliminado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/56', '2026-07-10 18:42:56'),
(307, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-10 18:43:00'),
(308, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-10 18:43:40'),
(309, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-10 18:43:49'),
(313, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-10 18:44:53');
INSERT INTO `auditoria_logs` (`id`, `usuario_id`, `accion`, `entidad`, `entidad_id`, `descripcion`, `valores_anteriores`, `valores_nuevos`, `direccion_ip`, `user_agent`, `metodo_request`, `endpoint`, `fecha_creacion`) VALUES
(314, 6, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 44, 'Inscripción actualizada: usuario_id=57 en curso_id=10', '{\"id\":44,\"usuario_id\":57,\"curso_id\":10,\"estado\":\"PENDIENTE\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-10 14:44:33\",\"fecha_completado\":null}', '{\"id\":44,\"usuario_id\":57,\"curso_id\":10,\"estado\":\"ACTIVO\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-10 14:44:33\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/44', '2026-07-10 18:45:07'),
(315, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-10 18:45:36'),
(319, 6, 'LOGIN_GOOGLE', 'Usuario', 6, 'Login via Google: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-10 18:47:59'),
(320, 6, 'ACTUALIZAR_CURSO', 'Curso', 10, 'Curso actualizado: \'Bombeo Solar\'', '{\"id\":10,\"categoria_id\":1,\"instructor_id\":6,\"titulo\":\"Bombeo Solar\",\"slug\":\"bombeo-solar\",\"descripcion_corta\":\"Curso te\\u00f3rico-pr\\u00e1ctico de la empresa Enervida para aprender a dise\\u00f1ar, dimensionar e instalar sistemas de bombeo solar fotovoltaico eficientes.\",\"descripcion\":\"\\u00a1Bienvenidos al Curso de Bombeo Solar de la empresa Enervida!\\n\\nEste programa de capacitaci\\u00f3n t\\u00e9cnica te brindar\\u00e1 todas las herramientas necesarias para dominar el uso de la energ\\u00eda solar en el transporte de agua. Est\\u00e1 dise\\u00f1ado especialmente para profesionales, t\\u00e9cnicos y personas del sector agr\\u00edcola que buscan implementar soluciones sostenibles y reducir costos operativos.\\n\\nLo que aprender\\u00e1s en este curso:\\n* Fundamentos de la energ\\u00eda solar fotovoltaica aplicada al bombeo de agua.\\n* C\\u00e1lculo y dimensionamiento de paneles solares seg\\u00fan la demanda de agua.\\n* Selecci\\u00f3n adecuada de bombas (corriente continua y alterna), controladores e inversores.\\n* Dise\\u00f1o hidr\\u00e1ulico, optimizaci\\u00f3n de caudales y p\\u00e9rdidas de carga en tuber\\u00edas.\\n* Buenas pr\\u00e1cticas de instalaci\\u00f3n, mantenimiento preventivo y seguridad el\\u00e9ctrica.\\n\\nOptimiza el uso del agua y aprovecha la energ\\u00eda del sol con la garant\\u00eda de aprendizaje de Enervida. \\u00a1Inscr\\u00edbete hoy mismo!\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1783005595_679475974-1577547564376963-2848436857219950621-n.jpg\",\"nivel\":\"Todos\",\"tipo_curso\":\"VOD\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":\"200.00\",\"fecha_creacion\":\"2026-07-02 11:20:24\",\"fecha_actualizacion\":\"2026-07-03 10:43:50\",\"edicion_actual\":2}', '{\"id\":10,\"categoria_id\":1,\"instructor_id\":6,\"titulo\":\"Bombeo Solar\",\"slug\":\"bombeo-solar\",\"descripcion_corta\":\"Curso te\\u00f3rico-pr\\u00e1ctico de la empresa Enervida para aprender a dise\\u00f1ar, dimensionar e instalar sistemas de bombeo solar fotovoltaico eficientes.\",\"descripcion\":\"\\u00a1Bienvenidos al Curso de Bombeo Solar de la empresa Enervida!\\n\\nEste programa de capacitaci\\u00f3n t\\u00e9cnica te brindar\\u00e1 todas las herramientas necesarias para dominar el uso de la energ\\u00eda solar en el transporte de agua. Est\\u00e1 dise\\u00f1ado especialmente para profesionales, t\\u00e9cnicos y personas del sector agr\\u00edcola que buscan implementar soluciones sostenibles y reducir costos operativos.\\n\\nLo que aprender\\u00e1s en este curso:\\n* Fundamentos de la energ\\u00eda solar fotovoltaica aplicada al bombeo de agua.\\n* C\\u00e1lculo y dimensionamiento de paneles solares seg\\u00fan la demanda de agua.\\n* Selecci\\u00f3n adecuada de bombas (corriente continua y alterna), controladores e inversores.\\n* Dise\\u00f1o hidr\\u00e1ulico, optimizaci\\u00f3n de caudales y p\\u00e9rdidas de carga en tuber\\u00edas.\\n* Buenas pr\\u00e1cticas de instalaci\\u00f3n, mantenimiento preventivo y seguridad el\\u00e9ctrica.\\n\\nOptimiza el uso del agua y aprovecha la energ\\u00eda del sol con la garant\\u00eda de aprendizaje de Enervida. \\u00a1Inscr\\u00edbete hoy mismo!\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1783005595_679475974-1577547564376963-2848436857219950621-n.jpg\",\"nivel\":\"Todos\",\"tipo_curso\":\"VOD\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":200,\"fecha_creacion\":\"2026-07-02 11:20:24\",\"fecha_actualizacion\":\"2026-07-03 10:43:50\",\"edicion_actual\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/cursos/10', '2026-07-10 19:03:12'),
(321, 6, 'ACTUALIZAR_CURSO', 'Curso', 10, 'Curso actualizado: \'Bombeo Solar\'', '{\"id\":10,\"categoria_id\":1,\"instructor_id\":6,\"titulo\":\"Bombeo Solar\",\"slug\":\"bombeo-solar\",\"descripcion_corta\":\"Curso te\\u00f3rico-pr\\u00e1ctico de la empresa Enervida para aprender a dise\\u00f1ar, dimensionar e instalar sistemas de bombeo solar fotovoltaico eficientes.\",\"descripcion\":\"\\u00a1Bienvenidos al Curso de Bombeo Solar de la empresa Enervida!\\n\\nEste programa de capacitaci\\u00f3n t\\u00e9cnica te brindar\\u00e1 todas las herramientas necesarias para dominar el uso de la energ\\u00eda solar en el transporte de agua. Est\\u00e1 dise\\u00f1ado especialmente para profesionales, t\\u00e9cnicos y personas del sector agr\\u00edcola que buscan implementar soluciones sostenibles y reducir costos operativos.\\n\\nLo que aprender\\u00e1s en este curso:\\n* Fundamentos de la energ\\u00eda solar fotovoltaica aplicada al bombeo de agua.\\n* C\\u00e1lculo y dimensionamiento de paneles solares seg\\u00fan la demanda de agua.\\n* Selecci\\u00f3n adecuada de bombas (corriente continua y alterna), controladores e inversores.\\n* Dise\\u00f1o hidr\\u00e1ulico, optimizaci\\u00f3n de caudales y p\\u00e9rdidas de carga en tuber\\u00edas.\\n* Buenas pr\\u00e1cticas de instalaci\\u00f3n, mantenimiento preventivo y seguridad el\\u00e9ctrica.\\n\\nOptimiza el uso del agua y aprovecha la energ\\u00eda del sol con la garant\\u00eda de aprendizaje de Enervida. \\u00a1Inscr\\u00edbete hoy mismo!\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1783005595_679475974-1577547564376963-2848436857219950621-n.jpg\",\"nivel\":\"Todos\",\"tipo_curso\":\"VOD\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":\"200.00\",\"fecha_creacion\":\"2026-07-02 11:20:24\",\"fecha_actualizacion\":\"2026-07-10 15:03:12\",\"edicion_actual\":1}', '{\"id\":10,\"categoria_id\":1,\"instructor_id\":6,\"titulo\":\"Bombeo Solar\",\"slug\":\"bombeo-solar\",\"descripcion_corta\":\"Curso te\\u00f3rico-pr\\u00e1ctico de la empresa Enervida para aprender a dise\\u00f1ar, dimensionar e instalar sistemas de bombeo solar fotovoltaico eficientes.\",\"descripcion\":\"\\u00a1Bienvenidos al Curso de Bombeo Solar de la empresa Enervida!\\n\\nEste programa de capacitaci\\u00f3n t\\u00e9cnica te brindar\\u00e1 todas las herramientas necesarias para dominar el uso de la energ\\u00eda solar en el transporte de agua. Est\\u00e1 dise\\u00f1ado especialmente para profesionales, t\\u00e9cnicos y personas del sector agr\\u00edcola que buscan implementar soluciones sostenibles y reducir costos operativos.\\n\\nLo que aprender\\u00e1s en este curso:\\n* Fundamentos de la energ\\u00eda solar fotovoltaica aplicada al bombeo de agua.\\n* C\\u00e1lculo y dimensionamiento de paneles solares seg\\u00fan la demanda de agua.\\n* Selecci\\u00f3n adecuada de bombas (corriente continua y alterna), controladores e inversores.\\n* Dise\\u00f1o hidr\\u00e1ulico, optimizaci\\u00f3n de caudales y p\\u00e9rdidas de carga en tuber\\u00edas.\\n* Buenas pr\\u00e1cticas de instalaci\\u00f3n, mantenimiento preventivo y seguridad el\\u00e9ctrica.\\n\\nOptimiza el uso del agua y aprovecha la energ\\u00eda del sol con la garant\\u00eda de aprendizaje de Enervida. \\u00a1Inscr\\u00edbete hoy mismo!\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1783005595_679475974-1577547564376963-2848436857219950621-n.jpg\",\"nivel\":\"Todos\",\"tipo_curso\":\"VOD\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":\"200.00\",\"fecha_creacion\":\"2026-07-02 11:20:24\",\"fecha_actualizacion\":\"2026-07-10 15:03:12\",\"edicion_actual\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/cursos/10', '2026-07-10 19:07:36'),
(322, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-10 19:07:51'),
(325, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: danielacopana@gmail.com', NULL, '{\"correo\":\"danielacopana@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-13 13:08:30'),
(326, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-13 13:08:47'),
(327, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-13 14:13:18'),
(328, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-13 18:37:49'),
(329, 6, 'ELIMINAR_USUARIO', 'Usuario', 57, 'Usuario eliminado: Jhonatan Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"Jhonatan\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/57', '2026-07-13 19:00:54'),
(330, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-13 19:01:03'),
(331, 58, 'REGISTRO', 'Usuario', 58, 'Nuevo registro: Juan David Parra Mendoza (juan@gmail.com)', NULL, '{\"nombres\":\"Juan David\",\"correo\":\"juan@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/register', '2026-07-13 19:02:08'),
(332, 58, 'INSCRIBIR_ESTUDIANTE', 'Inscripcion', 45, 'Inscripción creada: usuario_id=58 en curso_id=10 — estado: PENDIENTE', NULL, '{\"curso_id\":10,\"usuario_id\":58,\"estado\":\"PENDIENTE\",\"id\":45}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/inscripciones', '2026-07-13 19:02:43'),
(333, 58, 'LOGOUT', 'Usuario', 58, 'Cierre de sesion: Juan David Parra Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-13 19:03:20'),
(334, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-13 19:03:29'),
(335, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-13 19:12:11'),
(336, 59, 'REGISTRO_GOOGLE', 'Usuario', 59, 'Registro nuevo via Google: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-13 19:13:28'),
(337, 59, 'LOGIN_GOOGLE', 'Usuario', 59, 'Login via Google: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-13 19:14:16'),
(338, 59, 'INSCRIBIR_ESTUDIANTE', 'Inscripcion', 46, 'Inscripción creada: usuario_id=59 en curso_id=10 — estado: PENDIENTE', NULL, '{\"curso_id\":10,\"usuario_id\":59,\"estado\":\"PENDIENTE\",\"id\":46}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/inscripciones', '2026-07-13 19:14:48'),
(339, 59, 'LOGOUT', 'Usuario', 59, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-13 19:14:58'),
(340, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-13 19:15:12'),
(341, 6, 'ACTUALIZAR_USUARIO', 'Usuario', 6, 'Usuario actualizado: Angel Ramos Colque (danielacopana@gmail.com)', '{\"nombres\":\"Angel\",\"apellidos\":\"Ramos Colque\",\"correo\":\"danielacopana@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":1}', '{\"nombres\":\"Angel\",\"apellidos\":\"Ramos Colque\",\"correo\":\"danielacopana@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/6', '2026-07-13 19:19:05'),
(342, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-13 19:19:34'),
(343, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-13 19:19:45'),
(344, 6, 'ACTUALIZAR_USUARIO', 'Usuario', 6, 'Usuario actualizado: Angel Ramos Colque (danielacopana@gmail.com)', '{\"nombres\":\"Angel\",\"apellidos\":\"Ramos Colque\",\"correo\":\"danielacopana@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":1}', '{\"nombres\":\"Angel\",\"apellidos\":\"Ramos Colque\",\"correo\":\"danielacopana@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/6', '2026-07-13 19:21:51'),
(345, 6, 'ACTUALIZAR_USUARIO', 'Usuario', 6, 'Usuario actualizado: Angel Ramos Colque (danielacopana@gmail.com)', '{\"nombres\":\"Angel\",\"apellidos\":\"Ramos Colque\",\"correo\":\"danielacopana@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":1}', '{\"nombres\":\"Angel\",\"apellidos\":\"Ramos Colque\",\"correo\":\"danielacopana@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/6', '2026-07-13 19:22:47'),
(346, 6, 'ACTUALIZAR_USUARIO', 'Usuario', 6, 'Usuario actualizado: Angel Ramos Colque (danielacopana@gmail.com)', '{\"nombres\":\"Angel\",\"apellidos\":\"Ramos Colque\",\"correo\":\"danielacopana@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":1}', '{\"nombres\":\"Angel\",\"apellidos\":\"Ramos Colque\",\"correo\":\"danielacopana@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/6', '2026-07-13 19:23:30'),
(347, 6, 'ACTUALIZAR_USUARIO', 'Usuario', 6, 'Usuario actualizado: Angel Ramos Colque (danielacopana@gmail.com)', '{\"nombres\":\"Angel\",\"apellidos\":\"Ramos Colque\",\"correo\":\"danielacopana@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":1}', '{\"nombres\":\"Angel\",\"apellidos\":\"Ramos Colque\",\"correo\":\"danielacopana@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/6', '2026-07-13 19:24:10'),
(348, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-13 19:24:26'),
(349, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-13 19:24:50'),
(350, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-13 19:55:44'),
(351, 60, 'REGISTRO_GOOGLE', 'Usuario', 60, 'Registro nuevo via Google: Omar Ramos (omaramos1522@gmail.com)', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-13 19:56:16'),
(352, 60, 'INSCRIBIR_ESTUDIANTE', 'Inscripcion', 47, 'Inscripción creada: usuario_id=60 en curso_id=10 — estado: PENDIENTE', NULL, '{\"curso_id\":10,\"usuario_id\":60,\"estado\":\"PENDIENTE\",\"id\":47}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/inscripciones', '2026-07-13 19:56:46'),
(353, 60, 'LOGOUT', 'Usuario', 60, 'Cierre de sesion: Omar Ramos', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-13 19:56:54'),
(354, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-13 19:57:04'),
(355, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-13 19:59:12'),
(356, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-13 19:59:28'),
(357, 59, 'LOGIN', 'Usuario', 59, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-13 19:59:34'),
(358, 59, 'LOGOUT', 'Usuario', 59, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-13 19:59:47'),
(359, 58, 'LOGIN', 'Usuario', 58, 'Inicio de sesion: Juan David Parra Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-13 19:59:58'),
(360, 58, 'LOGOUT', 'Usuario', 58, 'Cierre de sesion: Juan David Parra Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-13 20:18:31'),
(361, 61, 'REGISTRO', 'Usuario', 61, 'Nuevo registro: maria magadalena laura gonzoles (maria@gmail.com)', NULL, '{\"nombres\":\"maria magadalena\",\"correo\":\"maria@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/register', '2026-07-13 20:19:03'),
(362, 61, 'LOGOUT', 'Usuario', 61, 'Cierre de sesion: maria magadalena laura gonzoles', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-14 13:08:09'),
(363, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-14 13:08:46'),
(364, 6, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 45, 'Inscripción actualizada: usuario_id=58 en curso_id=10', '{\"id\":45,\"usuario_id\":58,\"curso_id\":10,\"estado\":\"PENDIENTE\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-13 15:02:43\",\"fecha_completado\":null}', '{\"id\":45,\"usuario_id\":58,\"curso_id\":10,\"estado\":\"ACTIVO\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-13 15:02:43\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/45', '2026-07-14 14:30:46'),
(365, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-14 14:30:50'),
(366, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: juan@gmail.com', NULL, '{\"correo\":\"juan@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-14 14:31:01'),
(367, 58, 'LOGIN', 'Usuario', 58, 'Inicio de sesion: Juan David Parra Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-14 14:31:06'),
(368, 58, 'COMPLETAR_EVALUACION', 'IntentoEvaluacion', 26, 'Evaluación completada: evaluacion_id=5 — nota=100% — APROBADO — Certificado generado: BS02260001', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/intentos-evaluacion', '2026-07-14 14:46:23'),
(369, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-14 15:50:59'),
(370, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-14 17:20:13'),
(371, 6, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 46, 'Inscripción actualizada: usuario_id=59 en curso_id=10', '{\"id\":46,\"usuario_id\":59,\"curso_id\":10,\"estado\":\"PENDIENTE\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-13 15:14:48\",\"fecha_completado\":null}', '{\"id\":46,\"usuario_id\":59,\"curso_id\":10,\"estado\":\"ACTIVO\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-13 15:14:48\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/46', '2026-07-14 17:20:38'),
(372, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-14 17:20:52'),
(373, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-14 17:21:03'),
(374, 59, 'LOGIN', 'Usuario', 59, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-14 17:21:07'),
(375, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-17 13:48:47'),
(376, 59, 'LOGIN', 'Usuario', 59, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-17 13:48:56'),
(377, 59, 'COMPLETAR_EVALUACION', 'IntentoEvaluacion', 27, 'Evaluación completada: evaluacion_id=5 — nota=100% — APROBADO — Certificado generado: BS02260002', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/intentos-evaluacion', '2026-07-17 14:05:37'),
(378, 59, 'Verificar certificado', 'Certificado', 19, 'Certificado validado públicamente', '{\"codigo\":\"BS02260002\"}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'GET', 'api/certificados/validar/BS02260002', '2026-07-17 15:30:28'),
(379, NULL, 'Verificar certificado', 'Certificado', NULL, 'Intento de verificación no encontrado públicamente', '{\"codigo\":\"BS0226000222\"}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'GET', 'api/certificados/validar/BS0226000222', '2026-07-17 15:30:35'),
(380, NULL, 'Verificar certificado', 'Certificado', NULL, 'Intento de verificación no encontrado públicamente', '{\"codigo\":\"ENV-2025-0012\"}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'GET', 'api/certificados/validar/ENV-2025-0012', '2026-07-17 15:30:42'),
(381, NULL, 'Verificar certificado', 'Certificado', NULL, 'Intento de verificación no encontrado públicamente', '{\"codigo\":\"ENV-2025-00123\"}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'GET', 'api/certificados/validar/ENV-2025-00123', '2026-07-17 15:30:50'),
(382, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-17 15:31:32'),
(383, NULL, 'Verificar certificado', 'Certificado', NULL, 'Intento de verificación no encontrado públicamente', '{\"codigo\":\"ENV-2025-0012\"}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'GET', 'api/certificados/validar/ENV-2025-0012', '2026-07-17 15:33:06'),
(384, 59, 'Verificar certificado', 'Certificado', 19, 'Certificado validado públicamente', '{\"codigo\":\"BS02260002\"}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'GET', 'api/certificados/validar/BS02260002', '2026-07-17 15:33:21'),
(385, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-17 15:33:49'),
(386, 59, 'LOGIN', 'Usuario', 59, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-17 15:37:03'),
(387, 59, 'Verificar certificado', 'Certificado', 19, 'Certificado validado públicamente', '{\"codigo\":\"BS02260002\"}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'GET', 'api/certificados/validar/BS02260002', '2026-07-17 16:13:44'),
(388, 59, 'LOGOUT', 'Usuario', 59, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-17 16:19:17'),
(389, 62, 'REGISTRO_GOOGLE', 'Usuario', 62, 'Registro nuevo via Google: Angelica Collquehuanca (collquehuancaangelica@gmail.com)', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-17 16:19:41'),
(390, 62, 'LOGOUT', 'Usuario', 62, 'Cierre de sesion: Angelica Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-17 16:20:01'),
(391, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-17 16:20:08'),
(392, 6, 'CREAR_CURSO', 'Curso', 11, 'Curso creado: \'Técnico Instalador de Sistemas Fotovoltaicos de Generación Distribuida\'', NULL, '{\"categoria_id\":1,\"instructor_id\":6,\"titulo\":\"T\\u00e9cnico Instalador de Sistemas Fotovoltaicos de Generaci\\u00f3n Distribuida\",\"slug\":\"t-cnico-instalador-de-sistemas-fotovoltaicos-de-generaci-n-distribuida\",\"descripcion_corta\":\"dada\",\"descripcion\":\"dsadad\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":true,\"publicado\":false,\"precio\":0,\"edicion_actual\":1,\"id\":11}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/cursos', '2026-07-17 16:22:29'),
(393, 6, 'ACTUALIZAR_CURSO', 'Curso', 11, 'Curso actualizado: \'Técnico Instalador de Sistemas Fotovoltaicos de Generación Distribuida\'', '{\"id\":11,\"categoria_id\":1,\"instructor_id\":6,\"titulo\":\"T\\u00e9cnico Instalador de Sistemas Fotovoltaicos de Generaci\\u00f3n Distribuida\",\"slug\":\"t-cnico-instalador-de-sistemas-fotovoltaicos-de-generaci-n-distribuida\",\"descripcion_corta\":\"dada\",\"descripcion\":\"dsadad\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":0,\"precio\":\"0.00\",\"fecha_creacion\":\"2026-07-17 12:22:29\",\"fecha_actualizacion\":null,\"edicion_actual\":1}', '{\"id\":11,\"categoria_id\":1,\"instructor_id\":6,\"titulo\":\"T\\u00e9cnico Instalador de Sistemas Fotovoltaicos de Generaci\\u00f3n Distribuida\",\"slug\":\"t-cnico-instalador-de-sistemas-fotovoltaicos-de-generaci-n-distribuida\",\"descripcion_corta\":\"dada\",\"descripcion\":\"dsadad\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":true,\"precio\":0,\"fecha_creacion\":\"2026-07-17 12:22:29\",\"fecha_actualizacion\":null,\"edicion_actual\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/cursos/11', '2026-07-17 17:48:35'),
(394, 6, 'INSCRIBIR_ESTUDIANTE', 'Inscripcion', 48, 'Inscripción creada: usuario_id=59 en curso_id=11 — estado: ACTIVO', NULL, '{\"curso_id\":11,\"usuario_id\":59,\"estado\":\"ACTIVO\",\"id\":48}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/inscripciones', '2026-07-17 17:49:53'),
(395, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-17 17:51:16'),
(396, 59, 'LOGIN', 'Usuario', 59, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-17 17:51:27'),
(397, 59, 'LOGOUT', 'Usuario', 59, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-17 17:53:37'),
(398, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-17 17:53:48'),
(399, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-17 18:58:42'),
(400, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-20 19:38:32'),
(401, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 19:38:50'),
(402, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-20 19:42:32'),
(403, 59, 'LOGIN_FALLIDO', 'Usuario', 59, 'Contraseña incorrecta para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 19:42:40'),
(404, 59, 'LOGIN_FALLIDO', 'Usuario', 59, 'Contraseña incorrecta para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 19:42:43'),
(405, 59, 'LOGIN_FALLIDO', 'Usuario', 59, 'Contraseña incorrecta para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 19:42:46'),
(406, 59, 'CUENTA_BLOQUEADA', 'Usuario', 59, 'Cuenta bloqueada automaticamente tras 3 intentos fallidos', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 19:43:03'),
(407, 59, 'LOGIN_BLOQUEADO', 'Usuario', 59, 'Intento de acceso a cuenta bloqueada: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 19:43:09'),
(408, 6, 'LOGIN_FALLIDO', 'Usuario', 6, 'Contraseña incorrecta para: danielacopana@gmail.com', NULL, '{\"correo\":\"danielacopana@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 19:43:21'),
(409, 6, 'LOGIN_FALLIDO', 'Usuario', 6, 'Contraseña incorrecta para: danielacopana@gmail.com', NULL, '{\"correo\":\"danielacopana@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 19:45:38'),
(410, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 19:46:05'),
(411, 6, 'ACTUALIZAR_USUARIO', 'Usuario', 59, 'Usuario actualizado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":\"7875675675\",\"estado\":\"BLOQUEADO\",\"ci\":\"786786785\",\"rol_id\":2}', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":\"7875675675\",\"estado\":\"BLOQUEADO\",\"ci\":\"786786785\",\"rol_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/59', '2026-07-20 19:46:38'),
(412, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-20 19:46:46'),
(413, 59, 'LOGIN_BLOQUEADO', 'Usuario', 59, 'Intento de acceso a cuenta bloqueada: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 19:46:54'),
(414, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 19:47:03'),
(415, 6, 'ACTUALIZAR_USUARIO', 'Usuario', 59, 'Usuario actualizado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":\"7875675675\",\"estado\":\"BLOQUEADO\",\"ci\":\"786786785\",\"rol_id\":2}', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":\"7875675675\",\"estado\":\"ACTIVO\",\"ci\":\"786786785\",\"rol_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/59', '2026-07-20 19:47:49'),
(416, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-20 19:47:53'),
(417, 59, 'LOGIN', 'Usuario', 59, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 19:48:01'),
(418, 59, 'LOGOUT', 'Usuario', 59, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-20 19:48:06'),
(419, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 19:48:17'),
(420, 6, 'ELIMINAR_CURSO', 'Curso', 11, 'Curso eliminado: \'Técnico Instalador de Sistemas Fotovoltaicos de Generación Distribuida\' — todos sus contenidos fueron eliminados.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/cursos/11', '2026-07-20 19:53:15'),
(421, 6, 'CREAR_USUARIO', 'Usuario', 63, 'Usuario creado: alvaro Ramos Collquehuanca (ramosjho3natan659@gmail.com)', NULL, '{\"nombres\":\"alvaro\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjho3natan659@gmail.com\",\"rol_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/usuarios', '2026-07-20 21:37:14'),
(422, 6, 'CREAR_EVALUACION', 'Evaluacion', 6, 'Evaluación creada: \'examen 2 de ksmdjsncs\' para curso_id=10', NULL, '{\"curso_id\":10,\"titulo\":\"examen 2 de ksmdjsncs\",\"descripcion\":null,\"nota_aprobacion\":10,\"tiempo_limite\":60,\"intentos_permitidos\":2,\"id\":6}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/evaluaciones', '2026-07-20 22:04:50'),
(423, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-20 22:05:00'),
(424, 59, 'LOGIN', 'Usuario', 59, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 22:05:07'),
(425, 59, 'LOGOUT', 'Usuario', 59, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-20 22:05:24'),
(426, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 22:05:31'),
(427, 6, 'CREAR_CURSO', 'Curso', 12, 'Curso creado: \'Sistemas Fotovoltaicos\'', NULL, '{\"categoria_id\":1,\"instructor_id\":6,\"titulo\":\"Sistemas Fotovoltaicos\",\"slug\":\"sistemas-fotovoltaicos\",\"descripcion_corta\":\"curso curso\",\"descripcion\":\"curso curso\\ncieos\\nsdc\\na\\ncfq\\nec\\nw\\ncw\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1784570886_chatgpt-image-8-jul-2026-02-14-20-pm.png\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":true,\"publicado\":true,\"precio\":100,\"edicion_actual\":1,\"id\":12}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/cursos', '2026-07-20 22:08:15'),
(428, 6, 'ELIMINAR_EVALUACION', 'Evaluacion', 6, 'Evaluación eliminada: \'examen 2 de ksmdjsncs\' de curso_id=10', '{\"id\":6,\"curso_id\":10,\"titulo\":\"examen 2 de ksmdjsncs\",\"descripcion\":null,\"nota_aprobacion\":\"10.00\",\"tiempo_limite\":60,\"intentos_permitidos\":2,\"fecha_creacion\":\"2026-07-20 14:04:50\"}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/evaluaciones/6', '2026-07-20 22:08:34'),
(429, 6, 'CREAR_EVALUACION', 'Evaluacion', 7, 'Evaluación creada: \'Examen final del curso\' para curso_id=12', NULL, '{\"curso_id\":12,\"titulo\":\"Examen final del curso\",\"descripcion\":\"lea atentamente.\",\"nota_aprobacion\":70,\"tiempo_limite\":60,\"intentos_permitidos\":2,\"id\":7}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/evaluaciones', '2026-07-20 22:08:54'),
(430, 6, 'ELIMINAR_EVALUACION', 'Evaluacion', 7, 'Evaluación eliminada: \'Examen final del curso\' de curso_id=12', '{\"id\":7,\"curso_id\":12,\"titulo\":\"Examen final del curso\",\"descripcion\":\"lea atentamente.\",\"nota_aprobacion\":\"70.00\",\"tiempo_limite\":60,\"intentos_permitidos\":2,\"fecha_creacion\":\"2026-07-20 14:08:54\"}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/evaluaciones/7', '2026-07-20 22:10:11'),
(431, 6, 'CREAR_EVALUACION', 'Evaluacion', 8, 'Evaluación creada: \'Examen final del curso\' para curso_id=12', NULL, '{\"curso_id\":12,\"titulo\":\"Examen final del curso\",\"descripcion\":\"Lea atentamente las preguntas.....\",\"nota_aprobacion\":10,\"tiempo_limite\":60,\"intentos_permitidos\":2,\"id\":8}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/evaluaciones', '2026-07-20 22:10:40'),
(432, 6, 'INSCRIBIR_ESTUDIANTE', 'Inscripcion', 49, 'Inscripción creada: usuario_id=59 en curso_id=12 — estado: ACTIVO', NULL, '{\"curso_id\":12,\"usuario_id\":59,\"estado\":\"ACTIVO\",\"id\":49}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/inscripciones', '2026-07-20 22:17:22'),
(433, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-20 22:17:30'),
(434, 59, 'LOGIN_FALLIDO', 'Usuario', 59, 'Contraseña incorrecta para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 22:17:38'),
(435, 59, 'LOGIN', 'Usuario', 59, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 22:17:44'),
(436, 59, 'COMPLETAR_EVALUACION', 'IntentoEvaluacion', 28, 'Evaluación completada: evaluacion_id=8 — nota=80% — APROBADO — Certificado generado: FV01260001', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/intentos-evaluacion', '2026-07-20 22:18:36'),
(437, 59, 'LOGOUT', 'Usuario', 59, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-20 22:19:04'),
(438, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 22:19:10'),
(439, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-20 23:00:21'),
(440, 59, 'LOGIN', 'Usuario', 59, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 23:00:28'),
(441, 59, 'LOGOUT', 'Usuario', 59, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-20 23:04:07');
INSERT INTO `auditoria_logs` (`id`, `usuario_id`, `accion`, `entidad`, `entidad_id`, `descripcion`, `valores_anteriores`, `valores_nuevos`, `direccion_ip`, `user_agent`, `metodo_request`, `endpoint`, `fecha_creacion`) VALUES
(442, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 23:04:15'),
(443, 6, 'ACTUALIZAR_EVALUACION', 'Evaluacion', 8, 'Evaluación actualizada: \'Examen final del curso\'', '{\"id\":8,\"curso_id\":12,\"titulo\":\"Examen final del curso\",\"descripcion\":\"Lea atentamente las preguntas.....\",\"nota_aprobacion\":\"10.00\",\"tiempo_limite\":60,\"intentos_permitidos\":2,\"fecha_creacion\":\"2026-07-20 14:10:40\"}', '{\"id\":8,\"curso_id\":12,\"titulo\":\"Examen final del curso\",\"descripcion\":\"Lea atentamente las preguntas.....\",\"nota_aprobacion\":\"10.00\",\"tiempo_limite\":60,\"intentos_permitidos\":1,\"fecha_creacion\":\"2026-07-20 14:10:40\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/evaluaciones/8', '2026-07-20 23:04:31'),
(444, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-20 23:21:09'),
(445, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 23:21:20'),
(446, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-20 23:36:22'),
(447, 59, 'LOGIN', 'Usuario', 59, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 23:36:37'),
(448, 59, 'LOGOUT', 'Usuario', 59, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-20 23:38:53'),
(449, 6, 'LOGIN', 'Usuario', 6, 'Inicio de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 23:39:02'),
(450, 6, 'LOGOUT', 'Usuario', 6, 'Cierre de sesion: Angel Ramos Colque', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-20 23:47:36'),
(451, 59, 'LOGIN_FALLIDO', 'Usuario', 59, 'Contraseña incorrecta para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 23:47:48'),
(452, 59, 'LOGIN', 'Usuario', 59, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 23:47:55'),
(453, 59, 'LOGOUT', 'Usuario', 59, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-20 23:48:00'),
(454, 59, 'LOGIN', 'Usuario', 59, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-20 23:48:21'),
(455, 59, 'LOGIN', 'Usuario', 59, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-21 00:52:34');

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
('enervida-lms-cache-08Zg56yUczM3yEHo', 'a:1:{s:11:\"valid_until\";i:1783709261;}', 1784918861),
('enervida-lms-cache-0h4Iap0FTPZkCKy0', 'a:1:{s:11:\"valid_until\";i:1783102814;}', 1784312474),
('enervida-lms-cache-0Nq9nPhVMXo4FoHt', 'a:1:{s:11:\"valid_until\";i:1783004987;}', 1784210327),
('enervida-lms-cache-0PP1bMDKZcLBP7if', 'a:1:{s:11:\"valid_until\";i:1783083187;}', 1784229247),
('enervida-lms-cache-0xYbpyf8M5D0MbVy', 'a:1:{s:11:\"valid_until\";i:1783710652;}', 1784920192),
('enervida-lms-cache-1dPyhrKylbzdwOP0', 'a:1:{s:11:\"valid_until\";i:1783007459;}', 1784217119),
('enervida-lms-cache-2egmoXyLK5JuP8L5', 'a:1:{s:11:\"valid_until\";i:1783093204;}', 1784302804),
('enervida-lms-cache-2gmw7nyTvReM87eR', 'a:1:{s:11:\"valid_until\";i:1784302429;}', 1785511969),
('enervida-lms-cache-2KTt9F4rKyPuYqn2', 'a:1:{s:11:\"valid_until\";i:1782999360;}', 1783092180),
('enervida-lms-cache-30iiCXfp7FT2BrJb', 'a:1:{s:11:\"valid_until\";i:1783019074;}', 1784228734),
('enervida-lms-cache-3FpJg7dJSjxkasEL', 'a:1:{s:11:\"valid_until\";i:1783007388;}', 1784217048),
('enervida-lms-cache-3w7z79ucqbyLBaHH', 'a:1:{s:11:\"valid_until\";i:1783970098;}', 1785179758),
('enervida-lms-cache-43FsUUX1pk04mVFT', 'a:1:{s:11:\"valid_until\";i:1782999358;}', 1783092178),
('enervida-lms-cache-4BInPgZkdErmeFiU', 'a:1:{s:11:\"valid_until\";i:1783000605;}', 1784210265),
('enervida-lms-cache-4D8v3DJE9LBYNssu', 'a:1:{s:11:\"valid_until\";i:1784302281;}', 1785505821),
('enervida-lms-cache-4ockAuV0gkSc6XGt', 'a:1:{s:11:\"valid_until\";i:1783604542;}', 1784814022),
('enervida-lms-cache-4POUfzH3GO26Tw4y', 'a:1:{s:11:\"valid_until\";i:1783433997;}', 1784555697),
('enervida-lms-cache-5c785c036466adea360111aa28563bfd556b5fba', 'i:1;', 1784304884),
('enervida-lms-cache-5c785c036466adea360111aa28563bfd556b5fba:timer', 'i:1784304884;', 1784304884),
('enervida-lms-cache-6c8tIwYKuuUDlt1h', 'a:1:{s:11:\"valid_until\";i:1784576880;}', 1785786540),
('enervida-lms-cache-6fcaGr09lifoImQM', 'a:1:{s:11:\"valid_until\";i:1783698077;}', 1784907677),
('enervida-lms-cache-6HcZUEFXGanq7HOv', 'a:1:{s:11:\"valid_until\";i:1784310817;}', 1785520357),
('enervida-lms-cache-7b55sAH8YzrVxnUn', 'a:1:{s:11:\"valid_until\";i:1783710471;}', 1784918991),
('enervida-lms-cache-7uRGSPAemonpcXDW', 'a:1:{s:11:\"valid_until\";i:1783093258;}', 1784302918),
('enervida-lms-cache-7W8XY3nFu2wr48fK', 'a:1:{s:11:\"valid_until\";i:1784576182;}', 1785784942),
('enervida-lms-cache-84DgC1a2B14KSsQG', 'a:1:{s:11:\"valid_until\";i:1783090491;}', 1784300151),
('enervida-lms-cache-8icsEFL7xtx5UlrX', 'a:1:{s:11:\"valid_until\";i:1783007593;}', 1784217193),
('enervida-lms-cache-9acHphLVJg2bUqYV', 'a:1:{s:11:\"valid_until\";i:1784562486;}', 1785772146),
('enervida-lms-cache-9IlESiCKalEx8YNw', 'a:1:{s:11:\"valid_until\";i:1783973912;}', 1785182492),
('enervida-lms-cache-9pFdkOmchsxjfjsK', 'a:1:{s:11:\"valid_until\";i:1783102780;}', 1784312320),
('enervida-lms-cache-B6lq41MDzI774hqS', 'a:1:{s:11:\"valid_until\";i:1783695662;}', 1784905322),
('enervida-lms-cache-bgzgW1NjzHRpA8GC', 'a:1:{s:11:\"valid_until\";i:1783959238;}', 1785161698),
('enervida-lms-cache-BKQgEG8JdLixAOY9', 'a:1:{s:11:\"valid_until\";i:1782191551;}', 1783401211),
('enervida-lms-cache-BMgA164hJo6ECsCr', 'a:1:{s:11:\"valid_until\";i:1784571450;}', 1785780450),
('enervida-lms-cache-BW5Fu3RMhwE3SMIM', 'a:1:{s:11:\"valid_until\";i:1783007698;}', 1784217359),
('enervida-lms-cache-bZJQsgAUEreaks51', 'a:1:{s:11:\"valid_until\";i:1783102894;}', 1784312554),
('enervida-lms-cache-c0wUN6ayO9okCx44', 'a:1:{s:11:\"valid_until\";i:1783969263;}', 1785177543),
('enervida-lms-cache-CAdjd3ikw5lGUZil', 'a:1:{s:11:\"valid_until\";i:1783972614;}', 1785182274),
('enervida-lms-cache-ckLRZYTH293rrrTv', 'a:1:{s:11:\"valid_until\";i:1784570724;}', 1785780384),
('enervida-lms-cache-cNvnOtKP5bQMCokA', 'a:1:{s:11:\"valid_until\";i:1784570700;}', 1785772200),
('enervida-lms-cache-cUkV5YUSILzDXYDm', 'a:1:{s:11:\"valid_until\";i:1783007936;}', 1784217416),
('enervida-lms-cache-dbEmPXDD7qDMsHjw', 'a:1:{s:11:\"valid_until\";i:1782191521;}', 1783401181),
('enervida-lms-cache-DQ0Uf4Pr4m0bLVEm', 'a:1:{s:11:\"valid_until\";i:1783092107;}', 1784300507),
('enervida-lms-cache-Dztnem4GgN77gRFy', 'a:1:{s:11:\"valid_until\";i:1783007159;}', 1784216699),
('enervida-lms-cache-e4olP0fjJMTZdZ8H', 'a:1:{s:11:\"valid_until\";i:1783017155;}', 1784226695),
('enervida-lms-cache-EfsT3Z8dQeva3kOr', 'a:1:{s:11:\"valid_until\";i:1784562152;}', 1785771632),
('enervida-lms-cache-eiVbNurl3tNGDlLA', 'a:1:{s:11:\"valid_until\";i:1784574021;}', 1785781221),
('enervida-lms-cache-EqLZJ1CKeH6dXRga', 'a:1:{s:11:\"valid_until\";i:1783084216;}', 1784293816),
('enervida-lms-cache-F3hzHiraOSnFkjmm', 'a:1:{s:11:\"valid_until\";i:1783094217;}', 1784303757),
('enervida-lms-cache-f4FtdtyczMbfVO65', 'a:1:{s:11:\"valid_until\";i:1784296097;}', 1785259337),
('enervida-lms-cache-fGDzmvL0L9qDfnkB', 'a:1:{s:11:\"valid_until\";i:1783093323;}', 1784302983),
('enervida-lms-cache-fqTzE0mEpXa6VvQ2', 'a:1:{s:11:\"valid_until\";i:1783102607;}', 1784312267),
('enervida-lms-cache-fztpkUops7mS2u11', 'a:1:{s:11:\"valid_until\";i:1783972787;}', 1785182447),
('enervida-lms-cache-fZzVQMPMWoCAmERC', 'a:1:{s:11:\"valid_until\";i:1783007657;}', 1784217317),
('enervida-lms-cache-g1WRYhHvgnmEHB1s', 'a:1:{s:11:\"valid_until\";i:1783697924;}', 1784907584),
('enervida-lms-cache-G2W2HdEf78DqrEJc', 'a:1:{s:11:\"valid_until\";i:1783970667;}', 1785180087),
('enervida-lms-cache-G4dBGQygUFci3jAq', 'a:1:{s:11:\"valid_until\";i:1783016943;}', 1784226603),
('enervida-lms-cache-gDUI5BUMNyr14J53', 'a:1:{s:11:\"valid_until\";i:1783093778;}', 1784303438),
('enervida-lms-cache-GgBOnpeJo7yfLU4o', 'a:1:{s:11:\"valid_until\";i:1783017284;}', 1784226884),
('enervida-lms-cache-gHTp3fdTPSf56QqJ', 'a:1:{s:11:\"valid_until\";i:1782191562;}', 1783401222),
('enervida-lms-cache-gmHCO0lOj8DI48bA', 'a:1:{s:11:\"valid_until\";i:1783101799;}', 1784310439),
('enervida-lms-cache-GnnnDf0lSXLDrjqw', 'a:1:{s:11:\"valid_until\";i:1783019112;}', 1784228773),
('enervida-lms-cache-GyvOyredsBLR5uW0', 'a:1:{s:11:\"valid_until\";i:1783102638;}', 1784312298),
('enervida-lms-cache-H7kbVqvcjlk7H8mj', 'a:1:{s:11:\"valid_until\";i:1783007306;}', 1784216906),
('enervida-lms-cache-HI23MuA9y4RnVAfp', 'a:1:{s:11:\"valid_until\";i:1783688221;}', 1784897881),
('enervida-lms-cache-HtBeWNFfvYxjfMGz', 'a:1:{s:11:\"valid_until\";i:1784308818;}', 1785514878),
('enervida-lms-cache-HtC8IGwUljQvIKbT', 'a:1:{s:11:\"valid_until\";i:1783103776;}', 1784312596),
('enervida-lms-cache-hXGmRDE1GGPKRZwh', 'a:1:{s:11:\"valid_until\";i:1783102857;}', 1784312517),
('enervida-lms-cache-Hz8s8p5FihNYXRsk', 'a:1:{s:11:\"valid_until\";i:1783969400;}', 1785179000),
('enervida-lms-cache-HZN8WVbDNttAY7cb', 'a:1:{s:11:\"valid_until\";i:1784302284;}', 1785505824),
('enervida-lms-cache-IC7mCkafYF6Y2wUm', 'a:1:{s:11:\"valid_until\";i:1783100699;}', 1784310359),
('enervida-lms-cache-iCTu7cALqmrwQXG2', 'a:1:{s:11:\"valid_until\";i:1783433999;}', 1784555699),
('enervida-lms-cache-icy1Lkcmo6qVjy5p', 'a:1:{s:11:\"valid_until\";i:1784305157;}', 1785512297),
('enervida-lms-cache-ih6gNOF0rF0vwaA4', 'a:1:{s:11:\"valid_until\";i:1783697572;}', 1784906452),
('enervida-lms-cache-IIz5lQEHa5t79zCN', 'a:1:{s:11:\"valid_until\";i:1783098967;}', 1784308507),
('enervida-lms-cache-Il4WtQ7i8VZnRZ6l', 'a:1:{s:11:\"valid_until\";i:1783018867;}', 1784226967),
('enervida-lms-cache-JanM07wbtvTcxOOi', 'a:1:{s:11:\"valid_until\";i:1783000549;}', 1784209369),
('enervida-lms-cache-jFen4AQyOY4sLl5r', 'a:1:{s:11:\"valid_until\";i:1783353232;}', 1784555692),
('enervida-lms-cache-jjWH3mbRt5tfk3Tj', 'a:1:{s:11:\"valid_until\";i:1784562473;}', 1785772133),
('enervida-lms-cache-KOMvCy8nF9I0aJFU', 'a:1:{s:11:\"valid_until\";i:1783090475;}', 1784299415),
('enervida-lms-cache-KPb8YiJD8xe3EKWi', 'a:1:{s:11:\"valid_until\";i:1784569741;}', 1785772201),
('enervida-lms-cache-KTdG8qvwyTf8sS2i', 'a:1:{s:11:\"valid_until\";i:1783007177;}', 1784216837),
('enervida-lms-cache-kyvubGAzuXV8tJvT', 'a:1:{s:11:\"valid_until\";i:1783696751;}', 1784906411),
('enervida-lms-cache-KZm7z5efCxwu3BPp', 'a:1:{s:11:\"valid_until\";i:1783708608;}', 1784914668),
('enervida-lms-cache-Lb1SFRFMK21XaWjp', 'a:1:{s:11:\"valid_until\";i:1783092876;}', 1784301816),
('enervida-lms-cache-lfoNDVWvZ43dvApI', 'a:1:{s:11:\"valid_until\";i:1784561912;}', 1785771392),
('enervida-lms-cache-LgMBxgVc2tx5VRh1', 'a:1:{s:11:\"valid_until\";i:1783007197;}', 1784216857),
('enervida-lms-cache-LHwiDIe8egcj7Gx7', 'a:1:{s:11:\"valid_until\";i:1782191509;}', 1783401169),
('enervida-lms-cache-lHYngFtkdcndSDCl', 'a:1:{s:11:\"valid_until\";i:1784310676;}', 1785514876),
('enervida-lms-cache-llaNHTIzvGnMIdNh', 'a:1:{s:11:\"valid_until\";i:1784034483;}', 1785183603),
('enervida-lms-cache-ltOQ2kiPOh5mW3cW', 'a:1:{s:11:\"valid_until\";i:1783100764;}', 1784310424),
('enervida-lms-cache-LWhfEUcqDa6cYT41', 'a:1:{s:11:\"valid_until\";i:1783951938;}', 1785157818),
('enervida-lms-cache-M83pvbkvU6EphxF3', 'a:1:{s:11:\"valid_until\";i:1784039450;}', 1785244190),
('enervida-lms-cache-Mn706UlQvojuDWij', 'a:1:{s:11:\"valid_until\";i:1783007723;}', 1784217383),
('enervida-lms-cache-Mqgbhl9MRUVEfIBs', 'a:1:{s:11:\"valid_until\";i:1782191487;}', 1783399407),
('enervida-lms-cache-mtqunLuSZFMr6fkD', 'a:1:{s:11:\"valid_until\";i:1783969931;}', 1785179111),
('enervida-lms-cache-MTwHK60qqJrKzFwi', 'a:1:{s:11:\"valid_until\";i:1784580744;}', 1785786564),
('enervida-lms-cache-mUbe8W2J8WvFV9jT', 'a:1:{s:11:\"valid_until\";i:1783019470;}', 1784228890),
('enervida-lms-cache-N6QnQxZzdGI7Of1d', 'a:1:{s:11:\"valid_until\";i:1783695549;}', 1784905209),
('enervida-lms-cache-nTBWp1OpjJuyTWHu', 'a:1:{s:11:\"valid_until\";i:1783004986;}', 1784210326),
('enervida-lms-cache-NthPSBeHrBp5I0Ay', 'a:1:{s:11:\"valid_until\";i:1783006945;}', 1784216605),
('enervida-lms-cache-Nusk9FfbTnlD511o', 'a:1:{s:11:\"valid_until\";i:1783964202;}', 1785161682),
('enervida-lms-cache-O5RELynDfoavPAIW', 'a:1:{s:11:\"valid_until\";i:1783709136;}', 1784918796),
('enervida-lms-cache-oHzXyLwDrc1fahuq', 'a:1:{s:11:\"valid_until\";i:1783006994;}', 1784216654),
('enervida-lms-cache-Om3gRlgvAvEarEVS', 'a:1:{s:11:\"valid_until\";i:1784576856;}', 1785786036),
('enervida-lms-cache-OR4EPBn6rn9yD19z', 'a:1:{s:11:\"valid_until\";i:1783604251;}', 1784813371),
('enervida-lms-cache-pD4RxdYM3PgghOOy', 'a:1:{s:11:\"valid_until\";i:1783090683;}', 1784300283),
('enervida-lms-cache-PEOrgkJaXekCwIJc', 'a:1:{s:11:\"valid_until\";i:1783095698;}', 1784303918),
('enervida-lms-cache-PKFLE5v4hMA5JM8g', 'a:1:{s:11:\"valid_until\";i:1783093742;}', 1784303042),
('enervida-lms-cache-pL01sQiKcXveXyhJ', 'a:1:{s:11:\"valid_until\";i:1783972545;}', 1785180405),
('enervida-lms-cache-pl317g2oWMQMnsfk', 'a:1:{s:11:\"valid_until\";i:1783089620;}', 1784293940),
('enervida-lms-cache-pl4hr2lOLxcnrdcO', 'a:1:{s:11:\"valid_until\";i:1784049495;}', 1785253935),
('enervida-lms-cache-Pm7jcykW5z4XkSkX', 'a:1:{s:11:\"valid_until\";i:1784314431;}', 1785520491),
('enervida-lms-cache-pQJ9WuVU1iZJjB6r', 'a:1:{s:11:\"valid_until\";i:1783691861;}', 1784897921),
('enervida-lms-cache-q55xTMDeIf45NEG5', 'a:1:{s:11:\"valid_until\";i:1783955621;}', 1785161681),
('enervida-lms-cache-QdIe7TTgxMYRbP0P', 'a:1:{s:11:\"valid_until\";i:1783016695;}', 1784226355),
('enervida-lms-cache-QEPdt8M5TPRBWe9c', 'a:1:{s:11:\"valid_until\";i:1783688144;}', 1784897804),
('enervida-lms-cache-Qj3QZ64C4nexUk4G', 'a:1:{s:11:\"valid_until\";i:1783349620;}', 1784555680),
('enervida-lms-cache-qky0M9qUPiJDXCbt', 'a:1:{s:11:\"valid_until\";i:1783084078;}', 1784292898),
('enervida-lms-cache-qvdgqJtGi1JQ0PI4', 'a:1:{s:11:\"valid_until\";i:1783016556;}', 1784226096),
('enervida-lms-cache-RCAgutxLRoHQqHeK', 'a:1:{s:11:\"valid_until\";i:1784574247;}', 1785783727),
('enervida-lms-cache-rFBHG4eONmi8eAD9', 'a:1:{s:11:\"valid_until\";i:1783090596;}', 1784300196),
('enervida-lms-cache-RI4Ykt6UYUSPBtHN', 'a:1:{s:11:\"valid_until\";i:1783006874;}', 1784214674),
('enervida-lms-cache-rJ0JdtJNAoCA1yQk', 'a:1:{s:11:\"valid_until\";i:1783604719;}', 1784814379),
('enervida-lms-cache-RQjIfq3XOM5s1TSt', 'a:1:{s:11:\"valid_until\";i:1784038163;}', 1785244223),
('enervida-lms-cache-s2hd2bddZU30vc2a', 'a:1:{s:11:\"valid_until\";i:1783017196;}', 1784226856),
('enervida-lms-cache-S6bj53WTLwCpCi9H', 'a:1:{s:11:\"valid_until\";i:1784575269;}', 1785783969),
('enervida-lms-cache-S7s0uIxvPwn6ChOD', 'a:1:{s:11:\"valid_until\";i:1783094037;}', 1784303637),
('enervida-lms-cache-sBKQLa6r12GwQp7m', 'a:1:{s:11:\"valid_until\";i:1784566137;}', 1785772197),
('enervida-lms-cache-skeMJ0a6nOPK9cU3', 'a:1:{s:11:\"valid_until\";i:1784571544;}', 1785781144),
('enervida-lms-cache-smJZrrXwIVfesHUq', 'a:1:{s:11:\"valid_until\";i:1783016653;}', 1784226253),
('enervida-lms-cache-sNdTv2qhotYWDUqn', 'a:1:{s:11:\"valid_until\";i:1784562406;}', 1785772066),
('enervida-lms-cache-sNPJAtIHMiuE9ZLt', 'a:1:{s:11:\"valid_until\";i:1783695469;}', 1784897929),
('enervida-lms-cache-SrdgB2lxKz1h9Sez', 'a:1:{s:11:\"valid_until\";i:1783008000;}', 1784217660),
('enervida-lms-cache-sXbctdlv0Pgr1VsB', 'a:1:{s:11:\"valid_until\";i:1783019182;}', 1784228782),
('enervida-lms-cache-t7ge2NbmGTVsXJwh', 'a:1:{s:11:\"valid_until\";i:1783016980;}', 1784226640),
('enervida-lms-cache-tAkU23bc0WcFQ9xy', 'a:1:{s:11:\"valid_until\";i:1783708939;}', 1784914639),
('enervida-lms-cache-TGPw3peXr3ucOzSD', 'a:1:{s:11:\"valid_until\";i:1782999634;}', 1784209114),
('enervida-lms-cache-tPTttVvsblQfWXxk', 'a:1:{s:11:\"valid_until\";i:1783089611;}', 1784293931),
('enervida-lms-cache-tR9NYnLiw2MJ13ZY', 'a:1:{s:11:\"valid_until\";i:1783102584;}', 1784311524),
('enervida-lms-cache-TVphKs1mcnXdn8pj', 'a:1:{s:11:\"valid_until\";i:1783972752;}', 1785182292),
('enervida-lms-cache-U6iMPpkn7oknuZq6', 'a:1:{s:11:\"valid_until\";i:1784049652;}', 1785259312),
('enervida-lms-cache-UsGHN83EJYZfvKiX', 'a:1:{s:11:\"valid_until\";i:1783093924;}', 1784303464),
('enervida-lms-cache-uV2Wih44Tk1S0gd0', 'a:1:{s:11:\"valid_until\";i:1783016884;}', 1784226544),
('enervida-lms-cache-vBN0cvHEqn5cHJOg', 'a:1:{s:11:\"valid_until\";i:1783709079;}', 1784918739),
('enervida-lms-cache-vEPNHfbJdPrnrZBN', 'a:1:{s:11:\"valid_until\";i:1784034489;}', 1785183609),
('enervida-lms-cache-VgcQWKqq2J3FwOpj', 'a:1:{s:11:\"valid_until\";i:1784305201;}', 1785514861),
('enervida-lms-cache-vIp8bH4Ctf070Wna', 'a:1:{s:11:\"valid_until\";i:1783698195;}', 1784907855),
('enervida-lms-cache-Vj6Up7gJnoDFeuIh', 'a:1:{s:11:\"valid_until\";i:1783708980;}', 1784918640),
('enervida-lms-cache-VRdAe2HQVwqxZuMc', 'a:1:{s:11:\"valid_until\";i:1783967811;}', 1785161691),
('enervida-lms-cache-vRqRnB0O725F9u1t', 'a:1:{s:11:\"valid_until\";i:1783100677;}', 1784308657),
('enervida-lms-cache-vsbofOtwgLpahQ3x', 'a:1:{s:11:\"valid_until\";i:1783006977;}', 1784216637),
('enervida-lms-cache-vy0m0sMjJavbIMO5', 'a:1:{s:11:\"valid_until\";i:1784576333;}', 1785785873),
('enervida-lms-cache-W3U24JCCGANFwbNC', 'a:1:{s:11:\"valid_until\";i:1783098794;}', 1784305514),
('enervida-lms-cache-WgdSDrL67ahj73zc', 'a:1:{s:11:\"valid_until\";i:1783696687;}', 1784905867),
('enervida-lms-cache-x8qADSg3ZFlPyRp9', 'a:1:{s:11:\"valid_until\";i:1783970374;}', 1785179794),
('enervida-lms-cache-xJRz4Dh3pfNKl8zZ', 'a:1:{s:11:\"valid_until\";i:1783095788;}', 1784305388),
('enervida-lms-cache-xPwrlxCbcVJGX1JH', 'a:1:{s:11:\"valid_until\";i:1783016240;}', 1784217680),
('enervida-lms-cache-xWXFZGcnlTKrdRFu', 'a:1:{s:11:\"valid_until\";i:1783019575;}', 1784229175),
('enervida-lms-cache-XZKd6ikrPuniFn6H', 'a:1:{s:11:\"valid_until\";i:1783603401;}', 1784643741),
('enervida-lms-cache-y8MmLGciv65cO296', 'a:1:{s:11:\"valid_until\";i:1783709029;}', 1784918689),
('enervida-lms-cache-YHT6vMcuVp9UPile', 'a:1:{s:11:\"valid_until\";i:1784314722;}', 1785520542),
('enervida-lms-cache-ylWeZhe4N8PcnLXA', 'a:1:{s:11:\"valid_until\";i:1783019216;}', 1784228876),
('enervida-lms-cache-z8fp9e702Q3syira', 'a:1:{s:11:\"valid_until\";i:1783016864;}', 1784226404),
('enervida-lms-cache-ZkyXaFDnQkOi0TQo', 'a:1:{s:11:\"valid_until\";i:1783606092;}', 1784815152),
('enervida-lms-cache-ZOgso56qGzT7xIGv', 'a:1:{s:11:\"valid_until\";i:1784044244;}', 1785249164);

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
(1, 'General', 'Categoría creada automáticamente', '2026-05-21 19:06:50'),
(6, 'prueba', 'prueba prueba prueba', '2026-07-06 13:43:58'),
(7, 'prueba 1', 'prueba prueba prueba', '2026-07-06 13:45:07');

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

--
-- Volcado de datos para la tabla `certificados`
--

INSERT INTO `certificados` (`id`, `usuario_id`, `curso_id`, `codigo_certificado`, `pdf_url`, `fecha_emision`) VALUES
(18, 58, 10, 'BS02260001', '', '2026-07-14 14:46:23'),
(19, 59, 10, 'BS02260002', '', '2026-07-17 14:05:37'),
(20, 59, 12, 'FV01260001', '', '2026-07-20 18:18:36');

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
(4, 10, 'Plantilla - Bombeo Solar', 'http://localhost:8000/uploads/general/1783006112_plantilla.png', '{\"elements\":[{\"id\":\"6vugiln8ymr3nt0yv\",\"type\":\"qr\",\"x\":843.1984,\"y\":535.512,\"size\":120,\"width\":120,\"height\":120,\"rotate\":0,\"opacity\":100},{\"id\":\"msk53eaeemr3nt72r\",\"type\":\"text\",\"x\":840.936,\"y\":661.0752000000001,\"content\":\"{{codigo}}\",\"size\":22,\"width\":231.4512,\"height\":100,\"color\":\"#1a1a1a\",\"fontFamily\":\"Helvetica\",\"bold\":false,\"italic\":false,\"textAlign\":\"left\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false},{\"id\":\"bm4m5we74mr3nu8w8\",\"type\":\"text\",\"x\":131.6736,\"y\":268.5488,\"content\":\"{{estudiante}}\",\"size\":24,\"width\":576.2977213346815,\"height\":100,\"color\":\"#1a1a1a\",\"fontFamily\":\"Dancing Script\",\"bold\":false,\"italic\":true,\"textAlign\":\"center\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false},{\"id\":\"4m6y7sjuumr3nv6do\",\"type\":\"text\",\"x\":131.6736,\"y\":389.5872,\"content\":\"{{curso}}\",\"size\":32,\"width\":764.2464,\"height\":100,\"color\":\"#1a1a1a\",\"fontFamily\":\"Open Sans\",\"bold\":true,\"italic\":false,\"textAlign\":\"center\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false},{\"id\":\"0a4e96ep9mr3nw4mb\",\"type\":\"text\",\"x\":217.6448,\"y\":483.4768,\"content\":\"{{fecha}}\",\"size\":18,\"width\":160.18670010111222,\"height\":100,\"color\":\"#c79adf\",\"fontFamily\":\"Helvetica\",\"bold\":true,\"italic\":false,\"textAlign\":\"left\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false}],\"logicalWidth\":1000,\"logicalHeight\":707,\"selectedFormat\":\"A4\",\"orientation\":\"landscape\"}', '2026-07-02 15:32:20', '2026-07-02 15:39:39'),
(5, 12, 'Plantilla - Sistemas Fotovoltaicos', 'http://localhost:8000/uploads/general/1784573865_plantilla.png', '{\"elements\":[{\"id\":\"tb5arqxybmrtl7fhs\",\"type\":\"text\",\"x\":141.97080291970804,\"y\":371.89781021897807,\"content\":\"{{curso}}\",\"size\":32,\"width\":757.6642335766422,\"height\":100,\"color\":\"#1a1a1a\",\"fontFamily\":\"Helvetica\",\"bold\":false,\"italic\":false,\"textAlign\":\"left\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false},{\"id\":\"omb1bo42gmrtl85wr\",\"type\":\"text\",\"x\":147.44525547445255,\"y\":275.1824817518248,\"content\":\"{{estudiante}}\",\"size\":32,\"width\":724.8175182481751,\"height\":100,\"color\":\"#1a1a1a\",\"fontFamily\":\"Helvetica\",\"bold\":false,\"italic\":false,\"textAlign\":\"left\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false},{\"id\":\"gv85m1w2gmrtl8kv5\",\"type\":\"qr\",\"x\":820.8029197080292,\"y\":516.0583941605838,\"size\":134.5985401459854,\"width\":134.5985401459854,\"height\":134.5985401459854,\"rotate\":0,\"opacity\":100},{\"id\":\"v09aupc23mrtl8ytc\",\"type\":\"text\",\"x\":820.8029197080292,\"y\":654.7445255474452,\"content\":\"{{codigo}}\",\"size\":22,\"width\":239.4160583941606,\"height\":100,\"color\":\"#1a1a1a\",\"fontFamily\":\"Helvetica\",\"bold\":false,\"italic\":false,\"textAlign\":\"left\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false},{\"id\":\"ksfhua4qymrtl9zfh\",\"type\":\"image\",\"url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1784573990_whatsapp-image-2026-04-22-at-84407-am-removebg-preview.png\",\"x\":253.28467153284672,\"y\":468.6131386861314,\"width\":566.7883211678832,\"height\":340.0729927007299,\"rotate\":0,\"opacity\":100}],\"logicalWidth\":1000,\"logicalHeight\":707,\"selectedFormat\":\"A4\",\"orientation\":\"landscape\"}', '2026-07-20 19:00:02', NULL);

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
(10, 1, 6, 'Bombeo Solar', 'bombeo-solar', 'Curso teórico-práctico de la empresa Enervida para aprender a diseñar, dimensionar e instalar sistemas de bombeo solar fotovoltaico eficientes.', '¡Bienvenidos al Curso de Bombeo Solar de la empresa Enervida!\n\nEste programa de capacitación técnica te brindará todas las herramientas necesarias para dominar el uso de la energía solar en el transporte de agua. Está diseñado especialmente para profesionales, técnicos y personas del sector agrícola que buscan implementar soluciones sostenibles y reducir costos operativos.\n\nLo que aprenderás en este curso:\n* Fundamentos de la energía solar fotovoltaica aplicada al bombeo de agua.\n* Cálculo y dimensionamiento de paneles solares según la demanda de agua.\n* Selección adecuada de bombas (corriente continua y alterna), controladores e inversores.\n* Diseño hidráulico, optimización de caudales y pérdidas de carga en tuberías.\n* Buenas prácticas de instalación, mantenimiento preventivo y seguridad eléctrica.\n\nOptimiza el uso del agua y aprovecha la energía del sol con la garantía de aprendizaje de Enervida. ¡Inscríbete hoy mismo!', 'http://localhost:8000/uploads/general/1783005595_679475974-1577547564376963-2848436857219950621-n.jpg', 'Todos', 'VOD', 1, 1, 200.00, '2026-07-02 15:20:24', '2026-07-10 19:07:36', 2),
(12, 1, 6, 'Sistemas Fotovoltaicos', 'sistemas-fotovoltaicos', 'curso curso', 'curso curso\ncieos\nsdc\na\ncfq\nec\nw\ncw', 'http://localhost:8000/uploads/general/1784570886_chatgpt-image-8-jul-2026-02-14-20-pm.png', 'Todos', 'Hibrido', 1, 1, 100.00, '2026-07-20 18:08:15', NULL, 1);

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
(33, 6, 'Computadora', 'Windows 10/11', 'Chrome', '06606101dcf37c0e67adb1071e8a548d', '127.0.0.1', 1, '2026-07-20 23:39:03', '2026-07-10 15:18:16', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(36, 58, 'Computadora', 'Windows 10/11', 'Chrome', '06606101dcf37c0e67adb1071e8a548d', '127.0.0.1', 1, '2026-07-14 18:31:06', '2026-07-13 19:02:08', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(37, 59, 'Computadora', 'Windows 10/11', 'Chrome', '06606101dcf37c0e67adb1071e8a548d', '127.0.0.1', 1, '2026-07-21 00:52:34', '2026-07-13 19:13:28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(38, 60, 'Computadora', 'Windows 10/11', 'Chrome', '06606101dcf37c0e67adb1071e8a548d', '127.0.0.1', 1, '2026-07-13 23:56:16', '2026-07-13 19:56:16', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(39, 61, 'Computadora', 'Windows 10/11', 'Chrome', '06606101dcf37c0e67adb1071e8a548d', '127.0.0.1', 1, '2026-07-14 00:19:03', '2026-07-13 20:19:03', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(40, 62, 'Computadora', 'Windows 10/11', 'Chrome', '06606101dcf37c0e67adb1071e8a548d', '127.0.0.1', 1, '2026-07-17 20:19:41', '2026-07-17 16:19:41', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36');

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
(5, 10, 'Evaluacion Final', 'Lea atentamente las preguntas', 70.00, 20, 2, '2026-07-02 15:40:16'),
(8, 12, 'Examen final del curso', 'Lea atentamente las preguntas.....', 10.00, 60, 1, '2026-07-20 18:10:40');

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
(45, 58, 10, 'COMPLETADO', 100.00, '2026-07-13 19:02:43', '2026-07-14 18:45:36'),
(46, 59, 10, 'COMPLETADO', 100.00, '2026-07-13 19:14:48', '2026-07-17 18:05:00'),
(47, 60, 10, 'PENDIENTE', 0.00, '2026-07-13 19:56:46', NULL),
(49, 59, 12, 'COMPLETADO', 100.00, '2026-07-20 18:17:22', '2026-07-20 22:18:08');

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

--
-- Volcado de datos para la tabla `intentos_evaluacion`
--

INSERT INTO `intentos_evaluacion` (`id`, `evaluacion_id`, `usuario_id`, `nota`, `fecha_inicio`, `fecha_fin`, `aprobado`, `respuestas_seleccionadas`) VALUES
(26, 5, 58, 100.00, '2026-07-14 18:45:41', '2026-07-14 18:46:22', 1, '{\"5\":12,\"6\":13,\"7\":15}'),
(27, 5, 59, 100.00, '2026-07-17 18:05:07', '2026-07-17 18:05:36', 1, '{\"5\":12,\"6\":13,\"7\":15}'),
(28, 8, 59, 80.00, '2026-07-20 22:18:12', '2026-07-20 22:18:35', 1, '{\"8\":17,\"9\":19,\"10\":22,\"11\":24,\"12\":25}');

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
(16, 15, 'Reposiotrio de instalacion', 2, 'PDF', NULL, 'http://localhost:8000/uploads/general/1783005879_pg-jhonatan.pdf', NULL, NULL, 0, '2026-07-02 15:24:42'),
(19, 17, 'MANUAL DE ENSABBLE', 1, 'PDF', NULL, 'http://localhost:8000/uploads/general/1784571408_template.pdf', NULL, NULL, 0, '2026-07-20 18:16:52');

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
(15, 10, 'Instalacion e implementacion', 4, '2026-07-02 15:21:38'),
(17, 12, 'INTRIDUCCION', 1, '2026-07-20 18:16:24');

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
(7, 5, 'ioacnajkcmals;cmsa', 'MULTIPLE_CHOICE', 10),
(8, 8, 'que es energia', 'TRUE_FALSE', 10),
(9, 8, 'energia es vida.?', 'TRUE_FALSE', 10),
(10, 8, 'solar proviene del sol?', 'TRUE_FALSE', 10),
(11, 8, 'panel es una material o un comestible.?', 'TRUE_FALSE', 10),
(12, 8, 'que es fotovoltaico?', 'TRUE_FALSE', 10);

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
(144, 58, 12, 1, NULL, 0),
(145, 58, 13, 1, NULL, 0),
(146, 58, 14, 1, NULL, 0),
(147, 58, 15, 1, NULL, 0),
(148, 58, 16, 1, NULL, 0),
(149, 59, 12, 1, NULL, 0),
(150, 59, 13, 1, NULL, 0),
(151, 59, 14, 1, NULL, 0),
(152, 59, 15, 1, NULL, 0),
(153, 59, 16, 1, NULL, 0),
(154, 59, 19, 1, NULL, 0);

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
(16, 7, 'klncakcnjsc', 0),
(17, 8, 'F', 1),
(18, 8, 'V', 0),
(19, 9, 'F', 0),
(20, 9, 'V', 1),
(21, 10, 'V', 0),
(22, 10, 'F', 1),
(23, 11, 'F', 0),
(24, 11, 'V', 1),
(25, 12, 'F', 1),
(26, 12, 'V', 0);

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
(2, 'estudiante', '{\"info\":\"Estudiante del sistema\",\"permisos\":[\"CONFIG\",\"ARCHIVOS\"]}', '2026-05-21 18:40:02');

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
(6, 1, 'Angel', 'Ramos Colque', 'danielacopana@gmail.com', '$2y$12$krRZ5BrbklnKv/AXTzJWCOKtpipSakqQXc9BDbuBF5uR.2xeR3Tmy', NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJVoi_9IxipIq8ZCyKMX6IzdEhGTDPDgXWuPlHjYDCjEmIGYw=s96-c', 'ACTIVO', 1, '2026-07-20 23:39:02', '2026-05-21 19:03:57', '2026-07-20 19:39:02', NULL, NULL, '108515650607971543427'),
(58, 2, 'Juan David', 'Parra Mendoza', 'juan@gmail.com', '$2y$12$mwwABF.PIOOTMSS97bbxpOI2y2fbFhEbT4/yamWub8t4GZNi9O3SO', '264654654', NULL, 'ACTIVO', 0, '2026-07-14 18:31:06', '2026-07-13 19:02:08', '2026-07-14 14:31:06', NULL, '13054464', NULL),
(59, 2, 'JHONATAN', 'Ramos Collquehuanca', 'ramosjhonatan659@gmail.com', '$2y$12$rhy7xoZY7hJNWxu/iypWZ.vy.VCh.Md6Cc3m32weeZJM747S19cIW', '7875675675', 'https://lh3.googleusercontent.com/a/ACg8ocJddn9byvRrqboe0qx4Xmk7lYMSwFos3goeO5Yxk9enQPwOurcW=s96-c', 'ACTIVO', 1, '2026-07-21 00:52:33', '2026-07-13 19:13:28', '2026-07-20 20:52:33', NULL, '786786785', '112034738939767958183'),
(60, 2, 'Omar', 'Ramos', 'omaramos1522@gmail.com', '$2y$12$0MUCbpulGtVP1pKXTM7AZeojo5Fa42otwSZCPbD6Ntk4xpN6rWw5O', '6541654654', 'https://lh3.googleusercontent.com/a/ACg8ocJjESUPdgPngi4M1nxcedwGYMSO_-BXz040p3AhcC0D1KBipw=s96-c', 'ACTIVO', 1, '2026-07-13 23:56:16', '2026-07-13 19:56:16', '2026-07-13 19:56:44', NULL, '4658464', '116437308212656168830'),
(61, 2, 'maria magadalena', 'laura gonzoles', 'maria@gmail.com', '$2y$12$eNFQmFGCogqmABByI4SmMOVuxRLV0VNEoOW0Bu34Azmgq4//.IfNa', NULL, NULL, 'ACTIVO', 0, NULL, '2026-07-13 20:19:02', NULL, NULL, NULL, NULL),
(62, 2, 'Angelica', 'Collquehuanca', 'collquehuancaangelica@gmail.com', '$2y$12$ihrfTF6v9V7.TboY0rM5YORLjvpdGwGn/kD9WJwS4u1u2DcmOdHvm', NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLCMt0ahA2E_R7KZcuPskzrcg8B72rp_ceKql-08y2EuFZM5g=s96-c', 'ACTIVO', 1, '2026-07-17 20:19:41', '2026-07-17 16:19:41', '2026-07-17 16:19:41', NULL, NULL, '114312713684175149777'),
(63, 2, 'alvaro', 'Ramos Collquehuanca', 'ramosjho3natan659@gmail.com', '$2y$12$KL9WEIzyeHdyhWaUhMeA7eciTrAC8urKZNkuwqodunBfkoEqEKBoq', '+59173225724', NULL, 'ACTIVO', 0, NULL, '2026-07-20 17:37:14', NULL, NULL, '31313', NULL);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=456;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `certificados`
--
ALTER TABLE `certificados`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `certificado_plantillas`
--
ALTER TABLE `certificado_plantillas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `clases_en_vivo`
--
ALTER TABLE `clases_en_vivo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `dispositivos_usuario`
--
ALTER TABLE `dispositivos_usuario`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT de la tabla `intentos_evaluacion`
--
ALTER TABLE `intentos_evaluacion`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lecciones`
--
ALTER TABLE `lecciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `progreso_lecciones`
--
ALTER TABLE `progreso_lecciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=155;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

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
