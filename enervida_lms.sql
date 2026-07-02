-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-07-2026 a las 13:42:06
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
(61, 38, 'REGISTRO_GOOGLE', 'Usuario', 38, 'Registro nuevo via Google: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-06-23 05:11:57'),
(62, 38, 'LOGOUT', 'Usuario', 38, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-06-23 05:12:01'),
(63, 38, 'LOGIN_GOOGLE', 'Usuario', 38, 'Login via Google: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-06-23 05:12:11'),
(64, 38, 'LOGOUT', 'Usuario', 38, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-06-23 05:12:31'),
(65, 38, 'LOGIN', 'Usuario', 38, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 05:12:38'),
(66, 38, 'LOGOUT', 'Usuario', 38, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-06-23 05:12:42'),
(67, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 05:12:50'),
(68, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 05:12:52'),
(69, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 05:12:54'),
(70, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 05:12:56'),
(71, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 05:12:58'),
(72, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 05:12:59'),
(73, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 05:13:01'),
(74, 38, 'LOGIN', 'Usuario', 38, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-06-23 05:13:05');

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
('enervida-lms-cache-BKQgEG8JdLixAOY9', 'a:1:{s:11:\"valid_until\";i:1782191551;}', 1783401211),
('enervida-lms-cache-dbEmPXDD7qDMsHjw', 'a:1:{s:11:\"valid_until\";i:1782191521;}', 1783401181),
('enervida-lms-cache-gHTp3fdTPSf56QqJ', 'a:1:{s:11:\"valid_until\";i:1782191562;}', 1783401222),
('enervida-lms-cache-LHwiDIe8egcj7Gx7', 'a:1:{s:11:\"valid_until\";i:1782191509;}', 1783401169),
('enervida-lms-cache-Mqgbhl9MRUVEfIBs', 'a:1:{s:11:\"valid_until\";i:1782191487;}', 1783399407);

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
(4, 'frontend', 'dscripvionmdasdasd', '2026-06-11 20:15:50');

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
(3, 9, 'Plantilla - dssadsada', 'http://localhost:8000/uploads/general/1782189762_pngtree-blue-gradient-papercut-corner-border-for-graduation-diplomas-and-awards-certificates-vector-png-image-13372103.png', '{\"elements\":[{\"id\":\"mscwijfkbmqq5665b\",\"type\":\"text\",\"x\":156.26134301270417,\"y\":129.03811252268602,\"content\":\"{{curso}}\",\"size\":32,\"width\":744.8275862068965,\"height\":100,\"color\":\"#1a1a1a\",\"fontFamily\":\"Helvetica\",\"bold\":false,\"italic\":false,\"textAlign\":\"left\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false},{\"id\":\"ou8h4e64umqq5rzzq\",\"type\":\"image\",\"url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1782189775_firma-en-png-firmas-en-formato-11562869799c09le16rgz.png\",\"x\":256.7043618739903,\"y\":421.48626817447496,\"width\":424.5557350565428,\"height\":254.73344103392566,\"rotate\":0,\"opacity\":100}],\"logicalWidth\":1000,\"logicalHeight\":707,\"selectedFormat\":\"A4\",\"orientation\":\"landscape\"}', '2026-06-23 04:23:23', '2026-06-23 04:43:01');

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
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id`, `categoria_id`, `instructor_id`, `titulo`, `slug`, `descripcion_corta`, `descripcion`, `miniatura_url`, `nivel`, `tipo_curso`, `certificado_habilitado`, `publicado`, `precio`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(9, 1, 6, 'dssadsada', 'dssadsada', 'dasdsad', 'sadsadsadsa', 'http://localhost:8000/uploads/general/1782188554_hq720.jpg', 'Principiante', 'VOD', 1, 1, 100.00, '2026-06-23 04:22:47', NULL);

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
(2, 6, 'Computadora', 'Windows 10/11', 'Chrome', '580d06b833c946095cda7c271b0e07bf', '127.0.0.1', 1, '2026-06-23 09:11:36', '2026-06-22 19:11:40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36'),
(12, 38, 'Computadora', 'Windows 10/11', 'Chrome', '580d06b833c946095cda7c271b0e07bf', '127.0.0.1', 1, '2026-06-23 09:13:05', '2026-06-23 05:11:57', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36');

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
  `aprobado` tinyint(1) DEFAULT NULL
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
(23, '2026_06_23_012311_add_tipo_to_tokens_recuperacion_table', 2);

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
(6, 1, 'Angel', 'Ramos Colque', 'danielacopana@gmail.com', '$2y$12$krRZ5BrbklnKv/AXTzJWCOKtpipSakqQXc9BDbuBF5uR.2xeR3Tmy', NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJVoi_9IxipIq8ZCyKMX6IzdEhGTDPDgXWuPlHjYDCjEmIGYw=s96-c', 'ACTIVO', 1, '2026-06-23 09:11:36', '2026-05-21 19:03:57', '2026-06-23 05:11:36', NULL, NULL, '108515650607971543427'),
(38, 2, 'JHONATAN', 'Ramos Collquehuanca', 'ramosjhonatan659@gmail.com', '$2y$12$vL/9A4jjI71BuWAlMgdhI.U41XuxGtQaw96EPcFc3zyWfcTUCq2Xq', '73225724', 'https://lh3.googleusercontent.com/a/ACg8ocJddn9byvRrqboe0qx4Xmk7lYMSwFos3goeO5Yxk9enQPwOurcW=s96-c', 'ACTIVO', 1, '2026-06-23 09:13:05', '2026-06-23 05:11:57', '2026-06-23 05:13:05', NULL, '13054261', '112034738939767958183');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `certificados`
--
ALTER TABLE `certificados`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `certificado_plantillas`
--
ALTER TABLE `certificado_plantillas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `clases_en_vivo`
--
ALTER TABLE `clases_en_vivo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `dispositivos_usuario`
--
ALTER TABLE `dispositivos_usuario`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `intentos_evaluacion`
--
ALTER TABLE `intentos_evaluacion`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lecciones`
--
ALTER TABLE `lecciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `progreso_lecciones`
--
ALTER TABLE `progreso_lecciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tokens_recuperacion`
--
ALTER TABLE `tokens_recuperacion`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

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
