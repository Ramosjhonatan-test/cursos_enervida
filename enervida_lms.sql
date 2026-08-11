-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-08-2026 a las 15:31:38
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
(1, 1, 'REGISTRO_GOOGLE', 'Usuario', 1, 'Registro nuevo via Google: Homy R. (danielacopana@gmail.com)', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-27 18:00:02'),
(2, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-27 18:00:35'),
(3, 1, 'LOGIN_GOOGLE', 'Usuario', 1, 'Login via Google: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-27 18:00:45'),
(4, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-27 18:36:32'),
(5, 1, 'LOGIN_GOOGLE', 'Usuario', 1, 'Login via Google: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-27 22:40:35'),
(6, 1, 'CREAR_CURSO', 'Curso', 1, 'Curso creado: \'EnerVivencial\'', NULL, '{\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"EnerVivencial\",\"slug\":\"enervivencial\",\"descripcion_corta\":\"Experiencia t\\u00e9cnica 100% pr\\u00e1ctica en campo para aprender el dise\\u00f1o, montaje y funcionamiento real de sistemas de energ\\u00eda solar en las instalaciones de Enervida.\",\"descripcion\":\"Aprende energ\\u00eda solar mediante una inmersi\\u00f3n pr\\u00e1ctica en nuestras instalaciones. EnerVivencial est\\u00e1 dise\\u00f1ado para que experimentes de primera mano el funcionamiento, instalaci\\u00f3n y mantenimiento de sistemas fotovoltaicos en un entorno real.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Pr\\u00e1ctica real en campo: Manipulaci\\u00f3n directa de paneles solares, inversores, controladores y bancos de bater\\u00edas.\\n\\u2022 Montaje e instalaci\\u00f3n: Pasos clave para el cableado, conexionado seguro y montaje de estructuras.\\n\\u2022 Diagn\\u00f3stico y mediciones: Uso de herramientas de medici\\u00f3n para evaluar rendimiento, voltaje y corriente en tiempo real.\\n\\u2022 Mantenimiento y resoluci\\u00f3n de fallas: Identificaci\\u00f3n de problemas comunes y t\\u00e9cnicas de mantenimiento preventivo.\\n\\u2022 Aplicaci\\u00f3n de tecnolog\\u00edas sostenibles: Integraci\\u00f3n de la energ\\u00eda solar con proyectos ecol\\u00f3gicos.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEstudiantes, t\\u00e9cnicos, ingenieros y entusiastas de las energ\\u00edas renovables que busquen adquirir experiencia pr\\u00e1ctica directa.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":true,\"publicado\":false,\"precio\":200,\"edicion_actual\":1,\"id\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/cursos', '2026-07-27 22:48:05'),
(7, 1, 'CREAR_CURSO', 'Curso', 2, 'Curso creado: \'Bombeo Solar\'', NULL, '{\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Bombeo Solar\",\"slug\":\"bombeo-solar\",\"descripcion_corta\":\"Aprende a dise\\u00f1ar, dimensionar e instalar sistemas de bombeo de agua alimentados por energ\\u00eda solar fotovoltaica para aplicaciones agr\\u00edcolas, ganaderas y comunitarias.\",\"descripcion\":\"Capacitaci\\u00f3n t\\u00e9cnica especializada en la selecci\\u00f3n, dise\\u00f1o y puesta en marcha de sistemas de bombeo solar fotovoltaico. Aprender\\u00e1s a aprovechar la energ\\u00eda solar para el suministro de agua eficiente en zonas rurales o aisladas de la red el\\u00e9ctrica.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Fundamentos hidr\\u00e1ulicos y solares: C\\u00e1lculo de caudales, altura din\\u00e1mica total (ADT) y radiaci\\u00f3n solar disponible.\\n\\u2022 Selecci\\u00f3n de equipos: Criterios para elegir bombas sumergibles\\/superficiales, variadores de frecuencia y controladores solares.\\n\\u2022 Dimensionamiento del sistema: C\\u00e1lculo preciso de la potencia requerida en paneles fotovoltaicos y estructuras.\\n\\u2022 Instalaci\\u00f3n y conexiones: Montaje el\\u00e9ctrico y mec\\u00e1nico de bombas solares y sistemas de protecci\\u00f3n.\\n\\u2022 Mantenimiento y optimizaci\\u00f3n: Diagn\\u00f3stico de fallas, mantenimiento preventivo y buenas pr\\u00e1cticas en campo.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nT\\u00e9cnicos, ingenieros, proyectistas, agricultores y profesionales del sector agropecuario o energ\\u00e9tico interesados en soluciones de bombeo sostenible.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":true,\"publicado\":false,\"precio\":150,\"edicion_actual\":1,\"id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/cursos', '2026-07-27 22:49:13'),
(8, 1, 'CREAR_CURSO', 'Curso', 3, 'Curso creado: \'Sistemas Fotovoltaicos\'', NULL, '{\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Sistemas Fotovoltaicos\",\"slug\":\"sistemas-fotovoltaicos\",\"descripcion_corta\":\"Capacitaci\\u00f3n integral en el dise\\u00f1o, dimensionamiento e instalaci\\u00f3n de sistemas solares fotovoltaicos aislados y conectados a la red el\\u00e9ctrica.\",\"descripcion\":\"Curso te\\u00f3rico-pr\\u00e1ctico dise\\u00f1ado para brindar los conocimientos t\\u00e9cnicos necesarios en el c\\u00e1lculo, selecci\\u00f3n de componentes e instalaci\\u00f3n de sistemas solares fotovoltaicos para uso residencial, comercial e industrial.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Principios de la energ\\u00eda solar: Radiaci\\u00f3n solar, geometr\\u00eda solar y evaluaci\\u00f3n del recurso en sitio.\\n\\u2022 Componentes del sistema: Funcionamiento y selecci\\u00f3n de paneles fotovoltaicos, inversores, reguladores de carga y bater\\u00edas.\\n\\u2022 Dimensionamiento de sistemas: C\\u00e1lculo de cargas energ\\u00e9ticas para sistemas aislados (off-grid) y conectados a la red (on-grid).\\n\\u2022 Instalaci\\u00f3n y normativa: Criterios de montaje de estructuras, cableado, protecciones el\\u00e9ctricas y seguridad laboral.\\n\\u2022 Pruebas y puesta en marcha: Mediciones de rendimiento, verificaci\\u00f3n de funcionamiento y mantenimiento preventivo.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nElectricistas, t\\u00e9cnicos, ingenieros, estudiantes y emprendedores que deseen capacitarse en la implementaci\\u00f3n de proyectos de energ\\u00eda solar fotovoltaica.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":true,\"publicado\":false,\"precio\":300,\"edicion_actual\":1,\"id\":3}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/cursos', '2026-07-27 22:50:01'),
(9, 1, 'CREAR_CURSO', 'Curso', 4, 'Curso creado: \'EnerVirtual\'', NULL, '{\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"EnerVirtual\",\"slug\":\"enervirtual\",\"descripcion_corta\":\"Programa de formaci\\u00f3n 100% online sobre energ\\u00edas renovables y sostenibilidad, dictado a trav\\u00e9s de nuestra plataforma e-learning interactiva.\",\"descripcion\":\"Capacitaci\\u00f3n t\\u00e9cnica flexible y accesible dise\\u00f1ada para aprender sobre energ\\u00eda solar, eficiencia energ\\u00e9tica y tecnolog\\u00edas limpias desde cualquier lugar y a tu propio ritmo mediante el campus virtual de Enervida.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Conceptos fundamentales: Introducci\\u00f3n a las energ\\u00edas renovables, sistemas fotovoltaicos y desarrollo sostenible.\\n\\u2022 Contenido multimedia interactivo: Acceso a videoclases, gu\\u00edas descargables, estudios de caso y material complementario.\\n\\u2022 Software y herramientas digitales: Introducci\\u00f3n a la simulaci\\u00f3n y dimensionamiento virtual de proyectos energ\\u00e9ticos.\\n\\u2022 Evaluaci\\u00f3n y acompa\\u00f1amiento: Cuestionarios interactivos, tareas pr\\u00e1cticas y soporte para la resoluci\\u00f3n de dudas.\\n\\u2022 Proyectos aplicados: Elaboraci\\u00f3n de propuestas t\\u00e9cnicas orientadas a casos reales de eficiencia y sostenibilidad.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEstudiantes, profesionales y apasionados de las energ\\u00edas limpias que buscan capacitarse a distancia de forma aut\\u00f3noma e interactiva.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":true,\"publicado\":false,\"precio\":0,\"edicion_actual\":1,\"id\":4}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/cursos', '2026-07-27 22:50:49'),
(10, 1, 'CREAR_CURSO', 'Curso', 5, 'Curso creado: \'Curso PVsyst\'', NULL, '{\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Curso PVsyst\",\"slug\":\"curso-pvsyst\",\"descripcion_corta\":\"Aprende a simular, dise\\u00f1ar y analizar el rendimiento de sistemas fotovoltaicos utilizando PVsyst, el software profesional est\\u00e1ndar de la industria solar.\",\"descripcion\":\"Capacitaci\\u00f3n especializada en el uso del software PVsyst para el modelado preciso y la simulaci\\u00f3n t\\u00e9cnica de proyectos fotovoltaicos interconectados a la red, aislados y de bombeo solar.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Configuraci\\u00f3n y datos meteorol\\u00f3gicos: Importaci\\u00f3n y gesti\\u00f3n de bases de datos de radiaci\\u00f3n solar y ubicaciones geogr\\u00e1ficas.\\n\\u2022 Dise\\u00f1o y dimensionamiento en PVsyst: Selecci\\u00f3n de m\\u00f3dulos, inversores, configuraci\\u00f3n de strings y compatibilidad el\\u00e9ctrica.\\n\\u2022 An\\u00e1lisis de p\\u00e9rdidas del sistema: Evaluaci\\u00f3n de sombreados, p\\u00e9rdidas por temperatura, cableado y ensuciamiento de paneles.\\n\\u2022 Interpretaci\\u00f3n de reportes: An\\u00e1lisis de producci\\u00f3n de energ\\u00eda, factores de rendimiento (PR) y generaci\\u00f3n de informes t\\u00e9cnicos.\\n\\u2022 Simulaci\\u00f3n 3D: Creaci\\u00f3n de escenas en tres dimensiones para evaluar sombreados cercanos y optimizar la disposici\\u00f3n de m\\u00f3dulos.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nIngenieros, proyectistas, consultores y t\\u00e9cnicos del sector solar que busquen certificar sus dise\\u00f1os y simulaciones energ\\u00e9ticas con est\\u00e1ndar internacional.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":true,\"publicado\":false,\"precio\":250,\"edicion_actual\":1,\"id\":5}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/cursos', '2026-07-27 22:51:33'),
(11, 1, 'CREAR_CURSO', 'Curso', 6, 'Curso creado: \'Generación Distribuida\'', NULL, '{\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Generaci\\u00f3n Distribuida\",\"slug\":\"generaci-n-distribuida\",\"descripcion_corta\":\"Aprende los aspectos t\\u00e9cnicos, normativos y econ\\u00f3micos para la integraci\\u00f3n de sistemas de autoconsumo e inyecci\\u00f3n de energ\\u00eda solar a la red el\\u00e9ctrica.\",\"descripcion\":\"Capacitaci\\u00f3n especializada en el concepto de generaci\\u00f3n distribuida y autoconsumo solar. Aprender\\u00e1s a dise\\u00f1ar e integrar sistemas fotovoltaicos conectados a la red bajo la normativa vigente y los esquemas de compensaci\\u00f3n energ\\u00e9tica.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Fundamentos de Generaci\\u00f3n Distribuida: Conceptos de autoconsumo, inyecci\\u00f3n a la red y balance neto (Net Metering).\\n\\u2022 Normativa y marco legal: Requisitos t\\u00e9cnicos, tr\\u00e1mites y procesos de interconexi\\u00f3n con las empresas distribuidoras de electricidad.\\n\\u2022 Dimensionamiento orientado al autoconsumo: An\\u00e1lisis de curvas de demanda el\\u00e9ctrica para optimizar la potencia a instalar.\\n\\u2022 Protecci\\u00f3n y calidad de energ\\u00eda: Inversores de red, protecciones anti-isla, sincronizaci\\u00f3n y seguridad en la instalaci\\u00f3n.\\n\\u2022 Viabilidad econ\\u00f3mica y financiera: C\\u00e1lculo de retornos de inversi\\u00f3n, ahorro energ\\u00e9tico y an\\u00e1lisis costo-beneficio de los proyectos.\\n\\n\\u00bfAQui\\u00e9n est\\u00e1 dirigido?\\nIngenieros, proyectistas, t\\u00e9cnicos electricistas, consultores y emprendedores interesados en desarrollar e interconectar proyectos solares a la red el\\u00e9ctrica.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":true,\"publicado\":false,\"precio\":150,\"edicion_actual\":1,\"id\":6}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/cursos', '2026-07-27 22:52:19'),
(12, 1, 'CREAR_CURSO', 'Curso', 7, 'Curso creado: \'Eficiencia Energética\'', NULL, '{\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Eficiencia Energ\\u00e9tica\",\"slug\":\"eficiencia-energ-tica\",\"descripcion_corta\":\"Aprende a diagnosticar, gestionar y optimizar el consumo de energ\\u00eda en instalaciones residenciales, comerciales e industriales para reducir costos y emisiones.\",\"descripcion\":\"Capacitaci\\u00f3n pr\\u00e1ctica orientada al an\\u00e1lisis del uso de la energ\\u00eda, identificaci\\u00f3n de desperdicios y dise\\u00f1o de estrategias de ahorro y optimizaci\\u00f3n energ\\u00e9tica para mejorar la competitividad y sostenibilidad.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Auditor\\u00edas energ\\u00e9ticas: M\\u00e9todos de inspecci\\u00f3n, medici\\u00f3n y diagn\\u00f3stico de consumo de energ\\u00eda el\\u00e9ctrica y t\\u00e9rmica.\\n\\u2022 Indicadores de desempe\\u00f1o energ\\u00e9tico: Definici\\u00f3n de l\\u00edneas base de consumo y m\\u00e9tricas de eficiencia.\\n\\u2022 Optimizaci\\u00f3n de sistemas clave: Buenas pr\\u00e1cticas en sistemas de iluminaci\\u00f3n, climatizaci\\u00f3n, motores y equipos de potencia.\\n\\u2022 Gesti\\u00f3n de la demanda: Estrategias para la reducci\\u00f3n de picos de consumo y correcci\\u00f3n del factor de potencia.\\n\\u2022 Evaluaci\\u00f3n econ\\u00f3mica: An\\u00e1lisis de retorno de inversi\\u00f3n para medidas de ahorro y eficiencia energ\\u00e9tica.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nT\\u00e9cnicos, ingenieros, gestores de mantenimiento, consultores y profesionales interesados en reducir costos operativos mediante el uso eficiente de la energ\\u00eda.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":true,\"publicado\":false,\"precio\":250,\"edicion_actual\":1,\"id\":7}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/cursos', '2026-07-27 22:52:58'),
(13, 1, 'CREAR_CURSO', 'Curso', 8, 'Curso creado: \'Huella de Carbono\'', NULL, '{\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Huella de Carbono\",\"slug\":\"huella-de-carbono\",\"descripcion_corta\":\"Aprende a medir, reportar y gestionar la huella de carbono en organizaciones y productos para implementar estrategias efectivas de mitigaci\\u00f3n ambiental.\",\"descripcion\":\"Capacitaci\\u00f3n especializada en las metodolog\\u00edas y herramientas para el c\\u00e1lculo de emisiones de gases de efecto invernadero (GEI). Orientado a la cuantificaci\\u00f3n del impacto ambiental y al dise\\u00f1o de planes de reducci\\u00f3n y neutralidad de carbono.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Fundamentos y cambio clim\\u00e1tico: Conceptos clave de gases de efecto invernadero (GEI) y marcos normativos (ISO 14064, Protocolo GHG).\\n\\u2022 Identificaci\\u00f3n de alcance: Clasificaci\\u00f3n de emisiones en Alcance 1 (directas), Alcance 2 (indirectas por energ\\u00eda) y Alcance 3 (cadena de valor).\\n\\u2022 Metodolog\\u00eda de c\\u00e1lculo: Recopilaci\\u00f3n de datos de actividad, aplicaci\\u00f3n de factores de emisi\\u00f3n y estimaci\\u00f3n de la huella.\\n\\u2022 Estrategias de reducci\\u00f3n: Planes de mitigaci\\u00f3n, eficiencia energ\\u00e9tica, uso de energ\\u00edas renovables y compensaci\\u00f3n de carbono.\\n\\u2022 Elaboraci\\u00f3n de informes: Estructuraci\\u00f3n de reportes de sostenibilidad y preparaci\\u00f3n para procesos de verificaci\\u00f3n.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nConsultores ambientales, ingenieros, gestores de sostenibilidad, auditores y profesionales interesados en la gesti\\u00f3n ambiental y descarbonizaci\\u00f3n empresarial.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":true,\"publicado\":false,\"precio\":0,\"edicion_actual\":1,\"id\":8}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/cursos', '2026-07-27 22:53:31'),
(14, 1, 'CREAR_CURSO', 'Curso', 9, 'Curso creado: \'Sostenibilidad Aplicada\'', NULL, '{\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Sostenibilidad Aplicada\",\"slug\":\"sostenibilidad-aplicada\",\"descripcion_corta\":\"Aprende a integrar criterios socioambientales, econom\\u00eda circular y modelos sostenibles en la gesti\\u00f3n de proyectos, empresas y comunidades.\",\"descripcion\":\"Capacitaci\\u00f3n pr\\u00e1ctica enfocada en transformar conceptos de desarrollo sostenible en acciones concretas. Aprender\\u00e1s a dise\\u00f1ar, implementar y evaluar estrategias que equilibren el impacto ambiental, la viabilidad econ\\u00f3mica y el bienestar social.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Principios de desarrollo sostenible: An\\u00e1lisis de los Objetivos de Desarrollo Sostenible (ODS) y su aplicaci\\u00f3n pr\\u00e1ctica.\\n\\u2022 Econom\\u00eda circular y residuos: Estrategias de reducci\\u00f3n, reutilizaci\\u00f3n, reciclaje y ciclo de vida de productos\\/servicios.\\n\\u2022 Diagn\\u00f3stico y m\\u00e9tricas socioambientales: Herramientas para evaluar el impacto de proyectos y definir indicadores de sostenibilidad.\\n\\u2022 Gesti\\u00f3n e innovaci\\u00f3n sostenible: Implementaci\\u00f3n de pr\\u00e1cticas ecol\\u00f3gicas en procesos productivos y cadenas de suministro.\\n\\u2022 Formulaci\\u00f3n de proyectos verdes: Dise\\u00f1o de propuestas sostenibles aptas para financiamiento e inversi\\u00f3n responsable.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEmprendedores, consultores, profesionales de proyectos, gestores ambientales y l\\u00edderes comunitarios que busquen aplicar la sostenibilidad de forma pr\\u00e1ctica y rentable.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":true,\"publicado\":false,\"precio\":300,\"edicion_actual\":1,\"id\":9}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/cursos', '2026-07-27 22:54:19'),
(15, 1, 'CREAR_CURSO', 'Curso', 10, 'Curso creado: \'Construcción Sostenible\'', NULL, '{\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Construcci\\u00f3n Sostenible\",\"slug\":\"construcci-n-sostenible\",\"descripcion_corta\":\"Aprende criterios de arquitectura bioclim\\u00e1tica, eficiencia energ\\u00e9tica y uso de materiales ecol\\u00f3gicos para el dise\\u00f1o y edificaci\\u00f3n de construcciones sostenibles.\",\"descripcion\":\"Capacitaci\\u00f3n orientada a la integraci\\u00f3n de pr\\u00e1cticas sostenibles en la planificaci\\u00f3n, dise\\u00f1o y ejecuci\\u00f3n de obras de construcci\\u00f3n. Aprender\\u00e1s a minimizar el impacto ambiental de las edificaciones optimizando recursos naturales y reduciendo el consumo energ\\u00e9tico.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Principios de arquitectura bioclim\\u00e1tica: Orientaci\\u00f3n, ventilaci\\u00f3n natural, asoleamiento e iluminaci\\u00f3n eficiente para confort t\\u00e9rmico.\\n\\u2022 Materiales ecoeficientes: Selecci\\u00f3n de materiales de bajo impacto ambiental, reciclados, locales y de alta eficiencia t\\u00e9rmica.\\n\\u2022 Eficiencia h\\u00eddrica y energ\\u00e9tica: Sistemas de captaci\\u00f3n de agua de lluvia, tratamiento de aguas grises e integraci\\u00f3n de energ\\u00edas renovables.\\n\\u2022 Certificaciones y est\\u00e1ndares verdes: Introducci\\u00f3n a marcos de evaluaci\\u00f3n de sostenibilidad en edificaci\\u00f3n (como EDGE o LEED).\\n\\u2022 Gesti\\u00f3n de residuos de construcci\\u00f3n: Estrategias para la reducci\\u00f3n, separaci\\u00f3n y manejo responsable de escombros en obra.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nArquitectos, ingenieros civiles, constructores, estudiantes y profesionales del sector inmobiliario interesados en la edificaci\\u00f3n ecol\\u00f3gica y sostenible.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":true,\"publicado\":false,\"precio\":400,\"edicion_actual\":1,\"id\":10}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/cursos', '2026-07-27 22:54:59'),
(16, 1, 'CREAR_CURSO', 'Curso', 11, 'Curso creado: \'Modelo SAPIENS Solar\'', NULL, '{\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Modelo SAPIENS Solar\",\"slug\":\"modelo-sapiens-solar\",\"descripcion_corta\":\"Aprende la metodolog\\u00eda SAPIENS para la planificaci\\u00f3n, estructuraci\\u00f3n y ejecuci\\u00f3n integral de proyectos de energ\\u00eda solar sostenibles y de alto impacto.\",\"descripcion\":\"Capacitaci\\u00f3n especializada en la metodolog\\u00eda SAPIENS aplicada a la energ\\u00eda solar. Un enfoque estructurado que combina diagn\\u00f3stico, dise\\u00f1o t\\u00e9cnico, viabilidad socioecon\\u00f3mica y sostenibilidad a largo plazo para garantizar el \\u00e9xito de proyectos fotovoltaicos.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Fundamentos del Modelo SAPIENS: Principios, pilares y metodolog\\u00eda paso a paso aplicada al desarrollo de proyectos solares.\\n\\u2022 Diagn\\u00f3stico territorial y de necesidades: Evaluaci\\u00f3n del contexto social, t\\u00e9cnico y ambiental para una soluci\\u00f3n a medida.\\n\\u2022 Planificaci\\u00f3n y dise\\u00f1o integral: Selecci\\u00f3n de tecnolog\\u00edas, dimensionamiento adecuado y gesti\\u00f3n de recursos energ\\u00e9ticos.\\n\\u2022 Viabilidad econ\\u00f3mica y sostenibilidad: Estrategias de financiamiento, retorno de inversi\\u00f3n y modelos de operaci\\u00f3n continua.\\n\\u2022 Gesti\\u00f3n y puesta en marcha: Control de ejecuci\\u00f3n, indicadores de rendimiento y transferencia de conocimientos a la comunidad o cliente.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nIngenieros, proyectistas, consultores, gestores de proyectos de desarrollo y profesionales interesados en metodolog\\u00edas estructuradas para soluciones solares.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":true,\"publicado\":false,\"precio\":190,\"edicion_actual\":1,\"id\":11}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/cursos', '2026-07-27 22:55:58'),
(17, 1, 'CREAR_CURSO', 'Curso', 12, 'Curso creado: \'Lombricultura\'', NULL, '{\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Lombricultura\",\"slug\":\"lombricultura\",\"descripcion_corta\":\"Aprende a transformar residuos org\\u00e1nicos en humus de lombriz de alta calidad para la regeneraci\\u00f3n de suelos y la agricultura sostenible.\",\"descripcion\":\"Capacitaci\\u00f3n pr\\u00e1ctica enfocada en el manejo, cr\\u00eda y reproducci\\u00f3n de la lombriz roja californiana para la producci\\u00f3n de abonos org\\u00e1nicos. Un enfoque integral para aprovechar residuos, mejorar la fertilidad del suelo y promover pr\\u00e1cticas de econom\\u00eda circular.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Biolog\\u00eda y comportamiento: Ciclo de vida, requerimientos ambientales y alimentaci\\u00f3n de la lombriz roja californiana.\\n\\u2022 Dise\\u00f1o y preparaci\\u00f3n de vermicomposteras: Construcci\\u00f3n, acondicionamiento y mantenimiento de camas o lechos de cultivo.\\n\\u2022 Manejo de sustratos y alimentaci\\u00f3n: Selecci\\u00f3n y preparaci\\u00f3n adecuada de residuos org\\u00e1nicos para evitar fermentaciones indeseadas.\\n\\u2022 Control de par\\u00e1metros clave: Monitoreo de humedad, temperatura, pH, aireaci\\u00f3n y control de plagas o depredadores.\\n\\u2022 Cosecha y aplicaci\\u00f3n de productos: M\\u00e9todos de extracci\\u00f3n de humus s\\u00f3lido y lixiviado (biol), y su uso como fertilizante natural.\\n\\n\\u00bfAQui\\u00e9n est\\u00e1 dirigido?\\nAgricultores, horticultores, emprendedores ecol\\u00f3gicos, educadores ambientales y cualquier persona interesada en el reciclaje de residuos org\\u00e1nicos y la fertilizaci\\u00f3n natural.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":true,\"publicado\":false,\"precio\":100,\"edicion_actual\":1,\"id\":12}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/cursos', '2026-07-27 22:56:41'),
(18, 1, 'ACTUALIZAR_CURSO', 'Curso', 1, 'Curso actualizado: \'EnerVivencial\'', '{\"id\":1,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"EnerVivencial\",\"slug\":\"enervivencial\",\"descripcion_corta\":\"Experiencia t\\u00e9cnica 100% pr\\u00e1ctica en campo para aprender el dise\\u00f1o, montaje y funcionamiento real de sistemas de energ\\u00eda solar en las instalaciones de Enervida.\",\"descripcion\":\"Aprende energ\\u00eda solar mediante una inmersi\\u00f3n pr\\u00e1ctica en nuestras instalaciones. EnerVivencial est\\u00e1 dise\\u00f1ado para que experimentes de primera mano el funcionamiento, instalaci\\u00f3n y mantenimiento de sistemas fotovoltaicos en un entorno real.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Pr\\u00e1ctica real en campo: Manipulaci\\u00f3n directa de paneles solares, inversores, controladores y bancos de bater\\u00edas.\\n\\u2022 Montaje e instalaci\\u00f3n: Pasos clave para el cableado, conexionado seguro y montaje de estructuras.\\n\\u2022 Diagn\\u00f3stico y mediciones: Uso de herramientas de medici\\u00f3n para evaluar rendimiento, voltaje y corriente en tiempo real.\\n\\u2022 Mantenimiento y resoluci\\u00f3n de fallas: Identificaci\\u00f3n de problemas comunes y t\\u00e9cnicas de mantenimiento preventivo.\\n\\u2022 Aplicaci\\u00f3n de tecnolog\\u00edas sostenibles: Integraci\\u00f3n de la energ\\u00eda solar con proyectos ecol\\u00f3gicos.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEstudiantes, t\\u00e9cnicos, ingenieros y entusiastas de las energ\\u00edas renovables que busquen adquirir experiencia pr\\u00e1ctica directa.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":0,\"precio\":\"200.00\",\"fecha_creacion\":\"2026-07-27 14:48:05\",\"fecha_actualizacion\":null,\"edicion_actual\":1}', '{\"id\":1,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"EnerVivencial\",\"slug\":\"enervivencial\",\"descripcion_corta\":\"Experiencia t\\u00e9cnica 100% pr\\u00e1ctica en campo para aprender el dise\\u00f1o, montaje y funcionamiento real de sistemas de energ\\u00eda solar en las instalaciones de Enervida.\",\"descripcion\":\"Aprende energ\\u00eda solar mediante una inmersi\\u00f3n pr\\u00e1ctica en nuestras instalaciones. EnerVivencial est\\u00e1 dise\\u00f1ado para que experimentes de primera mano el funcionamiento, instalaci\\u00f3n y mantenimiento de sistemas fotovoltaicos en un entorno real.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Pr\\u00e1ctica real en campo: Manipulaci\\u00f3n directa de paneles solares, inversores, controladores y bancos de bater\\u00edas.\\n\\u2022 Montaje e instalaci\\u00f3n: Pasos clave para el cableado, conexionado seguro y montaje de estructuras.\\n\\u2022 Diagn\\u00f3stico y mediciones: Uso de herramientas de medici\\u00f3n para evaluar rendimiento, voltaje y corriente en tiempo real.\\n\\u2022 Mantenimiento y resoluci\\u00f3n de fallas: Identificaci\\u00f3n de problemas comunes y t\\u00e9cnicas de mantenimiento preventivo.\\n\\u2022 Aplicaci\\u00f3n de tecnolog\\u00edas sostenibles: Integraci\\u00f3n de la energ\\u00eda solar con proyectos ecol\\u00f3gicos.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEstudiantes, t\\u00e9cnicos, ingenieros y entusiastas de las energ\\u00edas renovables que busquen adquirir experiencia pr\\u00e1ctica directa.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785178846_gemini-generated-image-kq570ikq570ikq57.png\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":true,\"precio\":200,\"fecha_creacion\":\"2026-07-27 14:48:05\",\"fecha_actualizacion\":null,\"edicion_actual\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/cursos/1', '2026-07-27 23:00:50'),
(19, 1, 'ACTUALIZAR_CURSO', 'Curso', 2, 'Curso actualizado: \'Bombeo Solar\'', '{\"id\":2,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Bombeo Solar\",\"slug\":\"bombeo-solar\",\"descripcion_corta\":\"Aprende a dise\\u00f1ar, dimensionar e instalar sistemas de bombeo de agua alimentados por energ\\u00eda solar fotovoltaica para aplicaciones agr\\u00edcolas, ganaderas y comunitarias.\",\"descripcion\":\"Capacitaci\\u00f3n t\\u00e9cnica especializada en la selecci\\u00f3n, dise\\u00f1o y puesta en marcha de sistemas de bombeo solar fotovoltaico. Aprender\\u00e1s a aprovechar la energ\\u00eda solar para el suministro de agua eficiente en zonas rurales o aisladas de la red el\\u00e9ctrica.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Fundamentos hidr\\u00e1ulicos y solares: C\\u00e1lculo de caudales, altura din\\u00e1mica total (ADT) y radiaci\\u00f3n solar disponible.\\n\\u2022 Selecci\\u00f3n de equipos: Criterios para elegir bombas sumergibles\\/superficiales, variadores de frecuencia y controladores solares.\\n\\u2022 Dimensionamiento del sistema: C\\u00e1lculo preciso de la potencia requerida en paneles fotovoltaicos y estructuras.\\n\\u2022 Instalaci\\u00f3n y conexiones: Montaje el\\u00e9ctrico y mec\\u00e1nico de bombas solares y sistemas de protecci\\u00f3n.\\n\\u2022 Mantenimiento y optimizaci\\u00f3n: Diagn\\u00f3stico de fallas, mantenimiento preventivo y buenas pr\\u00e1cticas en campo.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nT\\u00e9cnicos, ingenieros, proyectistas, agricultores y profesionales del sector agropecuario o energ\\u00e9tico interesados en soluciones de bombeo sostenible.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":0,\"precio\":\"150.00\",\"fecha_creacion\":\"2026-07-27 14:49:13\",\"fecha_actualizacion\":null,\"edicion_actual\":1}', '{\"id\":2,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Bombeo Solar\",\"slug\":\"bombeo-solar\",\"descripcion_corta\":\"Aprende a dise\\u00f1ar, dimensionar e instalar sistemas de bombeo de agua alimentados por energ\\u00eda solar fotovoltaica para aplicaciones agr\\u00edcolas, ganaderas y comunitarias.\",\"descripcion\":\"Capacitaci\\u00f3n t\\u00e9cnica especializada en la selecci\\u00f3n, dise\\u00f1o y puesta en marcha de sistemas de bombeo solar fotovoltaico. Aprender\\u00e1s a aprovechar la energ\\u00eda solar para el suministro de agua eficiente en zonas rurales o aisladas de la red el\\u00e9ctrica.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Fundamentos hidr\\u00e1ulicos y solares: C\\u00e1lculo de caudales, altura din\\u00e1mica total (ADT) y radiaci\\u00f3n solar disponible.\\n\\u2022 Selecci\\u00f3n de equipos: Criterios para elegir bombas sumergibles\\/superficiales, variadores de frecuencia y controladores solares.\\n\\u2022 Dimensionamiento del sistema: C\\u00e1lculo preciso de la potencia requerida en paneles fotovoltaicos y estructuras.\\n\\u2022 Instalaci\\u00f3n y conexiones: Montaje el\\u00e9ctrico y mec\\u00e1nico de bombas solares y sistemas de protecci\\u00f3n.\\n\\u2022 Mantenimiento y optimizaci\\u00f3n: Diagn\\u00f3stico de fallas, mantenimiento preventivo y buenas pr\\u00e1cticas en campo.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nT\\u00e9cnicos, ingenieros, proyectistas, agricultores y profesionales del sector agropecuario o energ\\u00e9tico interesados en soluciones de bombeo sostenible.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785179871_bombeo-solar.png\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":true,\"precio\":150,\"fecha_creacion\":\"2026-07-27 14:49:13\",\"fecha_actualizacion\":null,\"edicion_actual\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/cursos/2', '2026-07-27 23:17:56'),
(20, 1, 'ACTUALIZAR_CURSO', 'Curso', 3, 'Curso actualizado: \'Sistemas Fotovoltaicos\'', '{\"id\":3,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Sistemas Fotovoltaicos\",\"slug\":\"sistemas-fotovoltaicos\",\"descripcion_corta\":\"Capacitaci\\u00f3n integral en el dise\\u00f1o, dimensionamiento e instalaci\\u00f3n de sistemas solares fotovoltaicos aislados y conectados a la red el\\u00e9ctrica.\",\"descripcion\":\"Curso te\\u00f3rico-pr\\u00e1ctico dise\\u00f1ado para brindar los conocimientos t\\u00e9cnicos necesarios en el c\\u00e1lculo, selecci\\u00f3n de componentes e instalaci\\u00f3n de sistemas solares fotovoltaicos para uso residencial, comercial e industrial.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Principios de la energ\\u00eda solar: Radiaci\\u00f3n solar, geometr\\u00eda solar y evaluaci\\u00f3n del recurso en sitio.\\n\\u2022 Componentes del sistema: Funcionamiento y selecci\\u00f3n de paneles fotovoltaicos, inversores, reguladores de carga y bater\\u00edas.\\n\\u2022 Dimensionamiento de sistemas: C\\u00e1lculo de cargas energ\\u00e9ticas para sistemas aislados (off-grid) y conectados a la red (on-grid).\\n\\u2022 Instalaci\\u00f3n y normativa: Criterios de montaje de estructuras, cableado, protecciones el\\u00e9ctricas y seguridad laboral.\\n\\u2022 Pruebas y puesta en marcha: Mediciones de rendimiento, verificaci\\u00f3n de funcionamiento y mantenimiento preventivo.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nElectricistas, t\\u00e9cnicos, ingenieros, estudiantes y emprendedores que deseen capacitarse en la implementaci\\u00f3n de proyectos de energ\\u00eda solar fotovoltaica.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":0,\"precio\":\"300.00\",\"fecha_creacion\":\"2026-07-27 14:50:01\",\"fecha_actualizacion\":null,\"edicion_actual\":1}', '{\"id\":3,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Sistemas Fotovoltaicos\",\"slug\":\"sistemas-fotovoltaicos\",\"descripcion_corta\":\"Capacitaci\\u00f3n integral en el dise\\u00f1o, dimensionamiento e instalaci\\u00f3n de sistemas solares fotovoltaicos aislados y conectados a la red el\\u00e9ctrica.\",\"descripcion\":\"Curso te\\u00f3rico-pr\\u00e1ctico dise\\u00f1ado para brindar los conocimientos t\\u00e9cnicos necesarios en el c\\u00e1lculo, selecci\\u00f3n de componentes e instalaci\\u00f3n de sistemas solares fotovoltaicos para uso residencial, comercial e industrial.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Principios de la energ\\u00eda solar: Radiaci\\u00f3n solar, geometr\\u00eda solar y evaluaci\\u00f3n del recurso en sitio.\\n\\u2022 Componentes del sistema: Funcionamiento y selecci\\u00f3n de paneles fotovoltaicos, inversores, reguladores de carga y bater\\u00edas.\\n\\u2022 Dimensionamiento de sistemas: C\\u00e1lculo de cargas energ\\u00e9ticas para sistemas aislados (off-grid) y conectados a la red (on-grid).\\n\\u2022 Instalaci\\u00f3n y normativa: Criterios de montaje de estructuras, cableado, protecciones el\\u00e9ctricas y seguridad laboral.\\n\\u2022 Pruebas y puesta en marcha: Mediciones de rendimiento, verificaci\\u00f3n de funcionamiento y mantenimiento preventivo.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nElectricistas, t\\u00e9cnicos, ingenieros, estudiantes y emprendedores que deseen capacitarse en la implementaci\\u00f3n de proyectos de energ\\u00eda solar fotovoltaica.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785180302_sistemas-fotovoltaicos.png\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":true,\"precio\":300,\"fecha_creacion\":\"2026-07-27 14:50:01\",\"fecha_actualizacion\":null,\"edicion_actual\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/cursos/3', '2026-07-27 19:25:07'),
(21, 1, 'ACTUALIZAR_CURSO', 'Curso', 4, 'Curso actualizado: \'EnerVirtual\'', '{\"id\":4,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"EnerVirtual\",\"slug\":\"enervirtual\",\"descripcion_corta\":\"Programa de formaci\\u00f3n 100% online sobre energ\\u00edas renovables y sostenibilidad, dictado a trav\\u00e9s de nuestra plataforma e-learning interactiva.\",\"descripcion\":\"Capacitaci\\u00f3n t\\u00e9cnica flexible y accesible dise\\u00f1ada para aprender sobre energ\\u00eda solar, eficiencia energ\\u00e9tica y tecnolog\\u00edas limpias desde cualquier lugar y a tu propio ritmo mediante el campus virtual de Enervida.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Conceptos fundamentales: Introducci\\u00f3n a las energ\\u00edas renovables, sistemas fotovoltaicos y desarrollo sostenible.\\n\\u2022 Contenido multimedia interactivo: Acceso a videoclases, gu\\u00edas descargables, estudios de caso y material complementario.\\n\\u2022 Software y herramientas digitales: Introducci\\u00f3n a la simulaci\\u00f3n y dimensionamiento virtual de proyectos energ\\u00e9ticos.\\n\\u2022 Evaluaci\\u00f3n y acompa\\u00f1amiento: Cuestionarios interactivos, tareas pr\\u00e1cticas y soporte para la resoluci\\u00f3n de dudas.\\n\\u2022 Proyectos aplicados: Elaboraci\\u00f3n de propuestas t\\u00e9cnicas orientadas a casos reales de eficiencia y sostenibilidad.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEstudiantes, profesionales y apasionados de las energ\\u00edas limpias que buscan capacitarse a distancia de forma aut\\u00f3noma e interactiva.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":0,\"precio\":\"0.00\",\"fecha_creacion\":\"2026-07-27 14:50:49\",\"fecha_actualizacion\":null,\"edicion_actual\":1}', '{\"id\":4,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"EnerVirtual\",\"slug\":\"enervirtual\",\"descripcion_corta\":\"Programa de formaci\\u00f3n 100% online sobre energ\\u00edas renovables y sostenibilidad, dictado a trav\\u00e9s de nuestra plataforma e-learning interactiva.\",\"descripcion\":\"Capacitaci\\u00f3n t\\u00e9cnica flexible y accesible dise\\u00f1ada para aprender sobre energ\\u00eda solar, eficiencia energ\\u00e9tica y tecnolog\\u00edas limpias desde cualquier lugar y a tu propio ritmo mediante el campus virtual de Enervida.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Conceptos fundamentales: Introducci\\u00f3n a las energ\\u00edas renovables, sistemas fotovoltaicos y desarrollo sostenible.\\n\\u2022 Contenido multimedia interactivo: Acceso a videoclases, gu\\u00edas descargables, estudios de caso y material complementario.\\n\\u2022 Software y herramientas digitales: Introducci\\u00f3n a la simulaci\\u00f3n y dimensionamiento virtual de proyectos energ\\u00e9ticos.\\n\\u2022 Evaluaci\\u00f3n y acompa\\u00f1amiento: Cuestionarios interactivos, tareas pr\\u00e1cticas y soporte para la resoluci\\u00f3n de dudas.\\n\\u2022 Proyectos aplicados: Elaboraci\\u00f3n de propuestas t\\u00e9cnicas orientadas a casos reales de eficiencia y sostenibilidad.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEstudiantes, profesionales y apasionados de las energ\\u00edas limpias que buscan capacitarse a distancia de forma aut\\u00f3noma e interactiva.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785180680_enervirtual.png\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":true,\"precio\":250,\"fecha_creacion\":\"2026-07-27 14:50:49\",\"fecha_actualizacion\":null,\"edicion_actual\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/cursos/4', '2026-07-27 19:31:29'),
(22, 1, 'ACTUALIZAR_CURSO', 'Curso', 5, 'Curso actualizado: \'Curso PVsyst\'', '{\"id\":5,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Curso PVsyst\",\"slug\":\"curso-pvsyst\",\"descripcion_corta\":\"Aprende a simular, dise\\u00f1ar y analizar el rendimiento de sistemas fotovoltaicos utilizando PVsyst, el software profesional est\\u00e1ndar de la industria solar.\",\"descripcion\":\"Capacitaci\\u00f3n especializada en el uso del software PVsyst para el modelado preciso y la simulaci\\u00f3n t\\u00e9cnica de proyectos fotovoltaicos interconectados a la red, aislados y de bombeo solar.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Configuraci\\u00f3n y datos meteorol\\u00f3gicos: Importaci\\u00f3n y gesti\\u00f3n de bases de datos de radiaci\\u00f3n solar y ubicaciones geogr\\u00e1ficas.\\n\\u2022 Dise\\u00f1o y dimensionamiento en PVsyst: Selecci\\u00f3n de m\\u00f3dulos, inversores, configuraci\\u00f3n de strings y compatibilidad el\\u00e9ctrica.\\n\\u2022 An\\u00e1lisis de p\\u00e9rdidas del sistema: Evaluaci\\u00f3n de sombreados, p\\u00e9rdidas por temperatura, cableado y ensuciamiento de paneles.\\n\\u2022 Interpretaci\\u00f3n de reportes: An\\u00e1lisis de producci\\u00f3n de energ\\u00eda, factores de rendimiento (PR) y generaci\\u00f3n de informes t\\u00e9cnicos.\\n\\u2022 Simulaci\\u00f3n 3D: Creaci\\u00f3n de escenas en tres dimensiones para evaluar sombreados cercanos y optimizar la disposici\\u00f3n de m\\u00f3dulos.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nIngenieros, proyectistas, consultores y t\\u00e9cnicos del sector solar que busquen certificar sus dise\\u00f1os y simulaciones energ\\u00e9ticas con est\\u00e1ndar internacional.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":0,\"precio\":\"250.00\",\"fecha_creacion\":\"2026-07-27 14:51:33\",\"fecha_actualizacion\":null,\"edicion_actual\":1}', '{\"id\":5,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Curso PVsyst\",\"slug\":\"curso-pvsyst\",\"descripcion_corta\":\"Aprende a simular, dise\\u00f1ar y analizar el rendimiento de sistemas fotovoltaicos utilizando PVsyst, el software profesional est\\u00e1ndar de la industria solar.\",\"descripcion\":\"Capacitaci\\u00f3n especializada en el uso del software PVsyst para el modelado preciso y la simulaci\\u00f3n t\\u00e9cnica de proyectos fotovoltaicos interconectados a la red, aislados y de bombeo solar.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Configuraci\\u00f3n y datos meteorol\\u00f3gicos: Importaci\\u00f3n y gesti\\u00f3n de bases de datos de radiaci\\u00f3n solar y ubicaciones geogr\\u00e1ficas.\\n\\u2022 Dise\\u00f1o y dimensionamiento en PVsyst: Selecci\\u00f3n de m\\u00f3dulos, inversores, configuraci\\u00f3n de strings y compatibilidad el\\u00e9ctrica.\\n\\u2022 An\\u00e1lisis de p\\u00e9rdidas del sistema: Evaluaci\\u00f3n de sombreados, p\\u00e9rdidas por temperatura, cableado y ensuciamiento de paneles.\\n\\u2022 Interpretaci\\u00f3n de reportes: An\\u00e1lisis de producci\\u00f3n de energ\\u00eda, factores de rendimiento (PR) y generaci\\u00f3n de informes t\\u00e9cnicos.\\n\\u2022 Simulaci\\u00f3n 3D: Creaci\\u00f3n de escenas en tres dimensiones para evaluar sombreados cercanos y optimizar la disposici\\u00f3n de m\\u00f3dulos.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nIngenieros, proyectistas, consultores y t\\u00e9cnicos del sector solar que busquen certificar sus dise\\u00f1os y simulaciones energ\\u00e9ticas con est\\u00e1ndar internacional.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785180739_curso-pvsyst.png\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":true,\"precio\":250,\"fecha_creacion\":\"2026-07-27 14:51:33\",\"fecha_actualizacion\":null,\"edicion_actual\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/cursos/5', '2026-07-27 19:32:23'),
(23, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-27 19:33:30'),
(26, 1, 'LOGIN_GOOGLE', 'Usuario', 1, 'Login via Google: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-27 19:36:19');
INSERT INTO `auditoria_logs` (`id`, `usuario_id`, `accion`, `entidad`, `entidad_id`, `descripcion`, `valores_anteriores`, `valores_nuevos`, `direccion_ip`, `user_agent`, `metodo_request`, `endpoint`, `fecha_creacion`) VALUES
(27, 1, 'ACTUALIZAR_CURSO', 'Curso', 6, 'Curso actualizado: \'Generación Distribuida\'', '{\"id\":6,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Generaci\\u00f3n Distribuida\",\"slug\":\"generaci-n-distribuida\",\"descripcion_corta\":\"Aprende los aspectos t\\u00e9cnicos, normativos y econ\\u00f3micos para la integraci\\u00f3n de sistemas de autoconsumo e inyecci\\u00f3n de energ\\u00eda solar a la red el\\u00e9ctrica.\",\"descripcion\":\"Capacitaci\\u00f3n especializada en el concepto de generaci\\u00f3n distribuida y autoconsumo solar. Aprender\\u00e1s a dise\\u00f1ar e integrar sistemas fotovoltaicos conectados a la red bajo la normativa vigente y los esquemas de compensaci\\u00f3n energ\\u00e9tica.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Fundamentos de Generaci\\u00f3n Distribuida: Conceptos de autoconsumo, inyecci\\u00f3n a la red y balance neto (Net Metering).\\n\\u2022 Normativa y marco legal: Requisitos t\\u00e9cnicos, tr\\u00e1mites y procesos de interconexi\\u00f3n con las empresas distribuidoras de electricidad.\\n\\u2022 Dimensionamiento orientado al autoconsumo: An\\u00e1lisis de curvas de demanda el\\u00e9ctrica para optimizar la potencia a instalar.\\n\\u2022 Protecci\\u00f3n y calidad de energ\\u00eda: Inversores de red, protecciones anti-isla, sincronizaci\\u00f3n y seguridad en la instalaci\\u00f3n.\\n\\u2022 Viabilidad econ\\u00f3mica y financiera: C\\u00e1lculo de retornos de inversi\\u00f3n, ahorro energ\\u00e9tico y an\\u00e1lisis costo-beneficio de los proyectos.\\n\\n\\u00bfAQui\\u00e9n est\\u00e1 dirigido?\\nIngenieros, proyectistas, t\\u00e9cnicos electricistas, consultores y emprendedores interesados en desarrollar e interconectar proyectos solares a la red el\\u00e9ctrica.\",\"miniatura_url\":null,\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":0,\"precio\":\"150.00\",\"fecha_creacion\":\"2026-07-27 14:52:19\",\"fecha_actualizacion\":null,\"edicion_actual\":1}', '{\"id\":6,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Generaci\\u00f3n Distribuida\",\"slug\":\"generaci-n-distribuida\",\"descripcion_corta\":\"Aprende los aspectos t\\u00e9cnicos, normativos y econ\\u00f3micos para la integraci\\u00f3n de sistemas de autoconsumo e inyecci\\u00f3n de energ\\u00eda solar a la red el\\u00e9ctrica.\",\"descripcion\":\"Capacitaci\\u00f3n especializada en el concepto de generaci\\u00f3n distribuida y autoconsumo solar. Aprender\\u00e1s a dise\\u00f1ar e integrar sistemas fotovoltaicos conectados a la red bajo la normativa vigente y los esquemas de compensaci\\u00f3n energ\\u00e9tica.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Fundamentos de Generaci\\u00f3n Distribuida: Conceptos de autoconsumo, inyecci\\u00f3n a la red y balance neto (Net Metering).\\n\\u2022 Normativa y marco legal: Requisitos t\\u00e9cnicos, tr\\u00e1mites y procesos de interconexi\\u00f3n con las empresas distribuidoras de electricidad.\\n\\u2022 Dimensionamiento orientado al autoconsumo: An\\u00e1lisis de curvas de demanda el\\u00e9ctrica para optimizar la potencia a instalar.\\n\\u2022 Protecci\\u00f3n y calidad de energ\\u00eda: Inversores de red, protecciones anti-isla, sincronizaci\\u00f3n y seguridad en la instalaci\\u00f3n.\\n\\u2022 Viabilidad econ\\u00f3mica y financiera: C\\u00e1lculo de retornos de inversi\\u00f3n, ahorro energ\\u00e9tico y an\\u00e1lisis costo-beneficio de los proyectos.\\n\\n\\u00bfAQui\\u00e9n est\\u00e1 dirigido?\\nIngenieros, proyectistas, t\\u00e9cnicos electricistas, consultores y emprendedores interesados en desarrollar e interconectar proyectos solares a la red el\\u00e9ctrica.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785180998_generacion-distribuida.png\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":true,\"precio\":150,\"fecha_creacion\":\"2026-07-27 14:52:19\",\"fecha_actualizacion\":null,\"edicion_actual\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/cursos/6', '2026-07-27 19:36:42'),
(28, 1, 'ACTUALIZAR_CURSO', 'Curso', 1, 'Curso actualizado: \'EnerVivencial\'', '{\"id\":1,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"EnerVivencial\",\"slug\":\"enervivencial\",\"descripcion_corta\":\"Experiencia t\\u00e9cnica 100% pr\\u00e1ctica en campo para aprender el dise\\u00f1o, montaje y funcionamiento real de sistemas de energ\\u00eda solar en las instalaciones de Enervida.\",\"descripcion\":\"Aprende energ\\u00eda solar mediante una inmersi\\u00f3n pr\\u00e1ctica en nuestras instalaciones. EnerVivencial est\\u00e1 dise\\u00f1ado para que experimentes de primera mano el funcionamiento, instalaci\\u00f3n y mantenimiento de sistemas fotovoltaicos en un entorno real.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Pr\\u00e1ctica real en campo: Manipulaci\\u00f3n directa de paneles solares, inversores, controladores y bancos de bater\\u00edas.\\n\\u2022 Montaje e instalaci\\u00f3n: Pasos clave para el cableado, conexionado seguro y montaje de estructuras.\\n\\u2022 Diagn\\u00f3stico y mediciones: Uso de herramientas de medici\\u00f3n para evaluar rendimiento, voltaje y corriente en tiempo real.\\n\\u2022 Mantenimiento y resoluci\\u00f3n de fallas: Identificaci\\u00f3n de problemas comunes y t\\u00e9cnicas de mantenimiento preventivo.\\n\\u2022 Aplicaci\\u00f3n de tecnolog\\u00edas sostenibles: Integraci\\u00f3n de la energ\\u00eda solar con proyectos ecol\\u00f3gicos.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEstudiantes, t\\u00e9cnicos, ingenieros y entusiastas de las energ\\u00edas renovables que busquen adquirir experiencia pr\\u00e1ctica directa.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785178846_gemini-generated-image-kq570ikq570ikq57.png\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":\"200.00\",\"fecha_creacion\":\"2026-07-27 14:48:05\",\"fecha_actualizacion\":\"2026-07-27 15:00:50\",\"edicion_actual\":1}', '{\"id\":1,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"EnerVivencial\",\"slug\":\"enervivencial\",\"descripcion_corta\":\"Experiencia t\\u00e9cnica 100% pr\\u00e1ctica en campo para aprender el dise\\u00f1o, montaje y funcionamiento real de sistemas de energ\\u00eda solar en las instalaciones de Enervida.\",\"descripcion\":\"Aprende energ\\u00eda solar mediante una inmersi\\u00f3n pr\\u00e1ctica en nuestras instalaciones. EnerVivencial est\\u00e1 dise\\u00f1ado para que experimentes de primera mano el funcionamiento, instalaci\\u00f3n y mantenimiento de sistemas fotovoltaicos en un entorno real.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Pr\\u00e1ctica real en campo: Manipulaci\\u00f3n directa de paneles solares, inversores, controladores y bancos de bater\\u00edas.\\n\\u2022 Montaje e instalaci\\u00f3n: Pasos clave para el cableado, conexionado seguro y montaje de estructuras.\\n\\u2022 Diagn\\u00f3stico y mediciones: Uso de herramientas de medici\\u00f3n para evaluar rendimiento, voltaje y corriente en tiempo real.\\n\\u2022 Mantenimiento y resoluci\\u00f3n de fallas: Identificaci\\u00f3n de problemas comunes y t\\u00e9cnicas de mantenimiento preventivo.\\n\\u2022 Aplicaci\\u00f3n de tecnolog\\u00edas sostenibles: Integraci\\u00f3n de la energ\\u00eda solar con proyectos ecol\\u00f3gicos.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEstudiantes, t\\u00e9cnicos, ingenieros y entusiastas de las energ\\u00edas renovables que busquen adquirir experiencia pr\\u00e1ctica directa.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785181049_679475974-1577547564376963-2848436857219950621-n.jpg\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":200,\"fecha_creacion\":\"2026-07-27 14:48:05\",\"fecha_actualizacion\":\"2026-07-27 15:00:50\",\"edicion_actual\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/cursos/1', '2026-07-27 19:37:34'),
(29, 1, 'CREAR_EVALUACION', 'Evaluacion', 1, 'Evaluación creada: \'Examen Final\' para curso_id=1', NULL, '{\"curso_id\":1,\"titulo\":\"Examen Final\",\"descripcion\":\"Responda de manera correcta para poder obtener su certificado.\",\"nota_aprobacion\":10,\"tiempo_limite\":20,\"intentos_permitidos\":1,\"id\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/evaluaciones', '2026-07-27 19:50:05'),
(30, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-27 20:24:49'),
(34, 1, 'LOGIN_GOOGLE', 'Usuario', 1, 'Login via Google: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-27 20:26:52'),
(35, 1, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 1, 'Inscripción actualizada: usuario_id=2 en curso_id=1', '{\"id\":1,\"usuario_id\":2,\"curso_id\":1,\"estado\":\"PENDIENTE\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-27 16:26:30\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785183990_whatsapp-image-2026-07-27-at-120414-pm.jpeg\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-27 16:26:31\",\"fecha_completado\":null}', '{\"id\":1,\"usuario_id\":2,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-27 16:26:30\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785183990_whatsapp-image-2026-07-27-at-120414-pm.jpeg\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-27 16:26:31\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/1', '2026-07-27 20:27:13'),
(36, 1, 'ACTUALIZAR_USUARIO', 'Usuario', 1, 'Usuario actualizado: Homy R. (danielacopana@gmail.com)', '{\"nombres\":\"Homy\",\"apellidos\":\"R.\",\"correo\":\"danielacopana@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":1}', '{\"nombres\":\"Homy\",\"apellidos\":\"R.\",\"correo\":\"danielacopana@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/1', '2026-07-27 20:27:42'),
(37, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-27 20:27:50'),
(41, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-27 20:37:27'),
(42, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-27 20:41:21'),
(46, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-27 20:42:31'),
(47, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 12:35:40'),
(48, 1, 'ELIMINAR_INSCRIPCION', 'Inscripcion', 2, 'Inscripción eliminada: usuario_id=3 de curso_id=1', '{\"id\":2,\"usuario_id\":3,\"curso_id\":1,\"estado\":\"PENDIENTE\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-27 16:42:18\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785184938_screencapture-localhost-5173-admin-certificados-diseno-10-2026-07-24-10-28-52.png\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-27 16:42:19\",\"fecha_completado\":null}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/inscripciones/2', '2026-07-28 12:52:39'),
(49, 1, 'ELIMINAR_INSCRIPCION', 'Inscripcion', 1, 'Inscripción eliminada: usuario_id=2 de curso_id=1', '{\"id\":1,\"usuario_id\":2,\"curso_id\":1,\"estado\":\"COMPLETADO\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-27 16:26:30\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785183990_whatsapp-image-2026-07-27-at-120414-pm.jpeg\",\"porcentaje_progreso\":\"100.00\",\"fecha_inscripcion\":\"2026-07-27 16:26:31\",\"fecha_completado\":\"2026-07-27 16:30:20\"}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/inscripciones/1', '2026-07-28 12:52:47'),
(50, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 12:54:29'),
(54, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 12:56:22'),
(55, 1, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 3, 'Inscripción actualizada: usuario_id=2 en curso_id=1', '{\"id\":3,\"usuario_id\":2,\"curso_id\":1,\"estado\":\"PENDIENTE\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-28 08:55:51\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785243351_whatsapp-image-2026-07-27-at-120414-pm.jpeg\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 08:55:52\",\"fecha_completado\":null}', '{\"id\":3,\"usuario_id\":2,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"APROBADO\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-28 08:55:51\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785243351_whatsapp-image-2026-07-27-at-120414-pm.jpeg\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 08:55:52\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/3', '2026-07-28 12:57:13'),
(56, 1, 'INSCRIBIR_ESTUDIANTE', 'Inscripcion', 4, 'Inscripción creada: usuario_id=3 en curso_id=1 — estado: ACTIVO', NULL, '{\"curso_id\":1,\"usuario_id\":3,\"estado\":\"ACTIVO\",\"estado_pago\":\"APROBADO\",\"metodo_pago\":\"QR\",\"fecha_pago\":null,\"comprobante_pago_url\":null,\"monto_pago\":\"200.00\",\"porcentaje_progreso\":0,\"id\":4}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/inscripciones', '2026-07-28 12:58:22'),
(57, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 12:58:47'),
(60, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 12:59:55'),
(61, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 13:13:22'),
(64, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 13:16:47'),
(65, 1, 'ELIMINAR_USUARIO', 'Usuario', 2, 'Usuario eliminado: Jhonatan Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"Jhonatan\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/2', '2026-07-28 13:17:24'),
(66, 1, 'ACTUALIZAR_CURSO', 'Curso', 1, 'Curso actualizado: \'EnerVivencial\'', '{\"id\":1,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"EnerVivencial\",\"slug\":\"enervivencial\",\"descripcion_corta\":\"Experiencia t\\u00e9cnica 100% pr\\u00e1ctica en campo para aprender el dise\\u00f1o, montaje y funcionamiento real de sistemas de energ\\u00eda solar en las instalaciones de Enervida.\",\"descripcion\":\"Aprende energ\\u00eda solar mediante una inmersi\\u00f3n pr\\u00e1ctica en nuestras instalaciones. EnerVivencial est\\u00e1 dise\\u00f1ado para que experimentes de primera mano el funcionamiento, instalaci\\u00f3n y mantenimiento de sistemas fotovoltaicos en un entorno real.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Pr\\u00e1ctica real en campo: Manipulaci\\u00f3n directa de paneles solares, inversores, controladores y bancos de bater\\u00edas.\\n\\u2022 Montaje e instalaci\\u00f3n: Pasos clave para el cableado, conexionado seguro y montaje de estructuras.\\n\\u2022 Diagn\\u00f3stico y mediciones: Uso de herramientas de medici\\u00f3n para evaluar rendimiento, voltaje y corriente en tiempo real.\\n\\u2022 Mantenimiento y resoluci\\u00f3n de fallas: Identificaci\\u00f3n de problemas comunes y t\\u00e9cnicas de mantenimiento preventivo.\\n\\u2022 Aplicaci\\u00f3n de tecnolog\\u00edas sostenibles: Integraci\\u00f3n de la energ\\u00eda solar con proyectos ecol\\u00f3gicos.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEstudiantes, t\\u00e9cnicos, ingenieros y entusiastas de las energ\\u00edas renovables que busquen adquirir experiencia pr\\u00e1ctica directa.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785181049_679475974-1577547564376963-2848436857219950621-n.jpg\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":\"200.00\",\"fecha_creacion\":\"2026-07-27 14:48:05\",\"fecha_actualizacion\":\"2026-07-27 15:37:34\",\"edicion_actual\":1}', '{\"id\":1,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"EnerVivencial\",\"slug\":\"EV\",\"descripcion_corta\":\"Experiencia t\\u00e9cnica 100% pr\\u00e1ctica en campo para aprender el dise\\u00f1o, montaje y funcionamiento real de sistemas de energ\\u00eda solar en las instalaciones de Enervida.\",\"descripcion\":\"Aprende energ\\u00eda solar mediante una inmersi\\u00f3n pr\\u00e1ctica en nuestras instalaciones. EnerVivencial est\\u00e1 dise\\u00f1ado para que experimentes de primera mano el funcionamiento, instalaci\\u00f3n y mantenimiento de sistemas fotovoltaicos en un entorno real.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Pr\\u00e1ctica real en campo: Manipulaci\\u00f3n directa de paneles solares, inversores, controladores y bancos de bater\\u00edas.\\n\\u2022 Montaje e instalaci\\u00f3n: Pasos clave para el cableado, conexionado seguro y montaje de estructuras.\\n\\u2022 Diagn\\u00f3stico y mediciones: Uso de herramientas de medici\\u00f3n para evaluar rendimiento, voltaje y corriente en tiempo real.\\n\\u2022 Mantenimiento y resoluci\\u00f3n de fallas: Identificaci\\u00f3n de problemas comunes y t\\u00e9cnicas de mantenimiento preventivo.\\n\\u2022 Aplicaci\\u00f3n de tecnolog\\u00edas sostenibles: Integraci\\u00f3n de la energ\\u00eda solar con proyectos ecol\\u00f3gicos.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEstudiantes, t\\u00e9cnicos, ingenieros y entusiastas de las energ\\u00edas renovables que busquen adquirir experiencia pr\\u00e1ctica directa.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785181049_679475974-1577547564376963-2848436857219950621-n.jpg\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":200,\"fecha_creacion\":\"2026-07-27 14:48:05\",\"fecha_actualizacion\":\"2026-07-27 15:37:34\",\"edicion_actual\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/cursos/1', '2026-07-28 13:22:12'),
(67, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 13:22:37'),
(68, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 13:22:45'),
(69, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 13:22:55'),
(73, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 13:24:24'),
(74, 1, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 5, 'Inscripción actualizada: usuario_id=4 en curso_id=1', '{\"id\":5,\"usuario_id\":4,\"curso_id\":1,\"estado\":\"PENDIENTE\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-28 09:24:07\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785245047_whatsapp-image-2026-07-27-at-120414-pm.jpeg\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 09:24:09\",\"fecha_completado\":null}', '{\"id\":5,\"usuario_id\":4,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-28 09:24:07\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785245047_whatsapp-image-2026-07-27-at-120414-pm.jpeg\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 09:24:09\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/5', '2026-07-28 13:24:57'),
(75, 1, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 5, 'Inscripción actualizada: usuario_id=4 en curso_id=1', '{\"id\":5,\"usuario_id\":4,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-28 09:24:07\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785245047_whatsapp-image-2026-07-27-at-120414-pm.jpeg\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 09:24:09\",\"fecha_completado\":null}', '{\"id\":5,\"usuario_id\":4,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"APROBADO\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-28 09:24:07\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785245047_whatsapp-image-2026-07-27-at-120414-pm.jpeg\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 09:24:09\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/5', '2026-07-28 13:25:50'),
(76, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 13:26:07'),
(79, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 13:26:58'),
(80, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 13:28:12'),
(84, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 13:36:13'),
(85, 1, 'ACTUALIZAR_CURSO', 'Curso', 1, 'Curso actualizado: \'EnerVivencial\'', '{\"id\":1,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"EnerVivencial\",\"slug\":\"EV\",\"descripcion_corta\":\"Experiencia t\\u00e9cnica 100% pr\\u00e1ctica en campo para aprender el dise\\u00f1o, montaje y funcionamiento real de sistemas de energ\\u00eda solar en las instalaciones de Enervida.\",\"descripcion\":\"Aprende energ\\u00eda solar mediante una inmersi\\u00f3n pr\\u00e1ctica en nuestras instalaciones. EnerVivencial est\\u00e1 dise\\u00f1ado para que experimentes de primera mano el funcionamiento, instalaci\\u00f3n y mantenimiento de sistemas fotovoltaicos en un entorno real.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Pr\\u00e1ctica real en campo: Manipulaci\\u00f3n directa de paneles solares, inversores, controladores y bancos de bater\\u00edas.\\n\\u2022 Montaje e instalaci\\u00f3n: Pasos clave para el cableado, conexionado seguro y montaje de estructuras.\\n\\u2022 Diagn\\u00f3stico y mediciones: Uso de herramientas de medici\\u00f3n para evaluar rendimiento, voltaje y corriente en tiempo real.\\n\\u2022 Mantenimiento y resoluci\\u00f3n de fallas: Identificaci\\u00f3n de problemas comunes y t\\u00e9cnicas de mantenimiento preventivo.\\n\\u2022 Aplicaci\\u00f3n de tecnolog\\u00edas sostenibles: Integraci\\u00f3n de la energ\\u00eda solar con proyectos ecol\\u00f3gicos.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEstudiantes, t\\u00e9cnicos, ingenieros y entusiastas de las energ\\u00edas renovables que busquen adquirir experiencia pr\\u00e1ctica directa.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785181049_679475974-1577547564376963-2848436857219950621-n.jpg\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":\"200.00\",\"fecha_creacion\":\"2026-07-27 14:48:05\",\"fecha_actualizacion\":\"2026-07-28 09:22:12\",\"edicion_actual\":1}', '{\"id\":1,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"EnerVivencial\",\"slug\":\"CEV\",\"descripcion_corta\":\"Experiencia t\\u00e9cnica 100% pr\\u00e1ctica en campo para aprender el dise\\u00f1o, montaje y funcionamiento real de sistemas de energ\\u00eda solar en las instalaciones de Enervida.\",\"descripcion\":\"Aprende energ\\u00eda solar mediante una inmersi\\u00f3n pr\\u00e1ctica en nuestras instalaciones. EnerVivencial est\\u00e1 dise\\u00f1ado para que experimentes de primera mano el funcionamiento, instalaci\\u00f3n y mantenimiento de sistemas fotovoltaicos en un entorno real.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Pr\\u00e1ctica real en campo: Manipulaci\\u00f3n directa de paneles solares, inversores, controladores y bancos de bater\\u00edas.\\n\\u2022 Montaje e instalaci\\u00f3n: Pasos clave para el cableado, conexionado seguro y montaje de estructuras.\\n\\u2022 Diagn\\u00f3stico y mediciones: Uso de herramientas de medici\\u00f3n para evaluar rendimiento, voltaje y corriente en tiempo real.\\n\\u2022 Mantenimiento y resoluci\\u00f3n de fallas: Identificaci\\u00f3n de problemas comunes y t\\u00e9cnicas de mantenimiento preventivo.\\n\\u2022 Aplicaci\\u00f3n de tecnolog\\u00edas sostenibles: Integraci\\u00f3n de la energ\\u00eda solar con proyectos ecol\\u00f3gicos.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEstudiantes, t\\u00e9cnicos, ingenieros y entusiastas de las energ\\u00edas renovables que busquen adquirir experiencia pr\\u00e1ctica directa.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785181049_679475974-1577547564376963-2848436857219950621-n.jpg\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":200,\"fecha_creacion\":\"2026-07-27 14:48:05\",\"fecha_actualizacion\":\"2026-07-28 09:22:12\",\"edicion_actual\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/cursos/1', '2026-07-28 13:36:42'),
(86, 1, 'ACTUALIZAR_USUARIO', 'Usuario', 3, 'Usuario actualizado: Omar Ramos Ramos (omaramos1522@gmail.com)', '{\"nombres\":\"Omar\",\"apellidos\":\"Ramos Ramos\",\"correo\":\"omaramos1522@gmail.com\",\"telefono\":\"1894984894\",\"estado\":\"ACTIVO\",\"ci\":\"89741984\",\"rol_id\":2}', '{\"nombres\":\"Omar\",\"apellidos\":\"Ramos Ramos\",\"correo\":\"omaramos1522@gmail.com\",\"telefono\":\"1894984894\",\"estado\":\"ACTIVO\",\"ci\":\"89741984\",\"rol_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/3', '2026-07-28 13:37:10'),
(87, 1, 'ELIMINAR_INSCRIPCION', 'Inscripcion', 4, 'Inscripción eliminada: usuario_id=3 de curso_id=1', '{\"id\":4,\"usuario_id\":3,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"APROBADO\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":null,\"comprobante_pago_url\":null,\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 08:58:22\",\"fecha_completado\":null}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/inscripciones/4', '2026-07-28 13:37:50'),
(88, 1, 'INSCRIBIR_ESTUDIANTE', 'Inscripcion', 6, 'Inscripción creada: usuario_id=3 en curso_id=1 — estado: ACTIVO', NULL, '{\"curso_id\":1,\"usuario_id\":3,\"estado\":\"ACTIVO\",\"estado_pago\":\"APROBADO\",\"metodo_pago\":\"QR\",\"fecha_pago\":null,\"comprobante_pago_url\":null,\"monto_pago\":\"200.00\",\"porcentaje_progreso\":0,\"id\":6}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/inscripciones', '2026-07-28 13:38:00'),
(89, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 13:38:08'),
(93, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 13:40:32'),
(94, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 13:41:28'),
(95, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 13:41:35'),
(96, 1, 'INSCRIBIR_ESTUDIANTE', 'Inscripcion', 7, 'Inscripción creada: usuario_id=4 en curso_id=2 — estado: ACTIVO', NULL, '{\"curso_id\":2,\"usuario_id\":4,\"estado\":\"ACTIVO\",\"estado_pago\":\"EN_REVISION\",\"metodo_pago\":\"TRANSFERENCIA\",\"fecha_pago\":null,\"comprobante_pago_url\":null,\"monto_pago\":\"150.00\",\"porcentaje_progreso\":0,\"id\":7}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/inscripciones', '2026-07-28 13:42:02'),
(97, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 13:42:09'),
(100, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 13:43:31'),
(101, 1, 'ELIMINAR_USUARIO', 'Usuario', 4, 'Usuario eliminado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/4', '2026-07-28 13:43:44'),
(102, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 13:43:48'),
(106, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 13:45:07'),
(107, 1, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 8, 'Inscripción actualizada: usuario_id=5 en curso_id=1', '{\"id\":8,\"usuario_id\":5,\"curso_id\":1,\"estado\":\"PENDIENTE\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"transfer\",\"fecha_pago\":\"2026-07-28 09:44:45\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785246285_whatsapp-image-2026-07-27-at-120414-pm.jpeg\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 09:44:46\",\"fecha_completado\":null}', '{\"id\":8,\"usuario_id\":5,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"transfer\",\"fecha_pago\":\"2026-07-28 09:44:45\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785246285_whatsapp-image-2026-07-27-at-120414-pm.jpeg\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 09:44:46\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/8', '2026-07-28 13:45:37'),
(108, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 13:45:42'),
(112, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 15:01:29'),
(113, 1, 'ELIMINAR_USUARIO', 'Usuario', 5, 'Usuario eliminado: Jhonatan Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"Jhonatan\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/5', '2026-07-28 15:02:20'),
(114, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 15:02:25'),
(118, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 15:03:43'),
(119, 1, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 9, 'Inscripción actualizada: usuario_id=6 en curso_id=1', '{\"id\":9,\"usuario_id\":6,\"curso_id\":1,\"estado\":\"PENDIENTE\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"deposit\",\"fecha_pago\":\"2026-07-28 11:03:16\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785250996_rse.png\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 11:03:17\",\"fecha_completado\":null}', '{\"id\":9,\"usuario_id\":6,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"deposit\",\"fecha_pago\":\"2026-07-28 11:03:16\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785250996_rse.png\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 11:03:17\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/9', '2026-07-28 15:03:58'),
(120, 1, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 9, 'Inscripción actualizada: usuario_id=6 en curso_id=1', '{\"id\":9,\"usuario_id\":6,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"deposit\",\"fecha_pago\":\"2026-07-28 11:03:16\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785250996_rse.png\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 11:03:17\",\"fecha_completado\":null}', '{\"id\":9,\"usuario_id\":6,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"APROBADO\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"deposit\",\"fecha_pago\":\"2026-07-28 11:03:16\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785250996_rse.png\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 11:03:17\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/9', '2026-07-28 15:04:12'),
(121, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 15:04:17'),
(125, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 15:16:54'),
(126, 1, 'ELIMINAR_USUARIO', 'Usuario', 6, 'Usuario eliminado: Jhonatan Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"Jhonatan\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/6', '2026-07-28 15:17:09'),
(127, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 15:17:13'),
(131, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 15:18:17'),
(132, 1, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 10, 'Inscripción actualizada: usuario_id=7 en curso_id=1', '{\"id\":10,\"usuario_id\":7,\"curso_id\":1,\"estado\":\"PENDIENTE\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-28 11:17:55\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785251875_chatgpt-image-27-jul-2026-03-15-58-pm.png\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 11:17:56\",\"fecha_completado\":null}', '{\"id\":10,\"usuario_id\":7,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-28 11:17:55\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785251875_chatgpt-image-27-jul-2026-03-15-58-pm.png\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 11:17:56\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/10', '2026-07-28 15:18:32'),
(133, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 15:18:36'),
(137, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 15:25:02'),
(138, 1, 'ELIMINAR_USUARIO', 'Usuario', 7, 'Usuario eliminado: Jhonatan Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"Jhonatan\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/7', '2026-07-28 15:25:44'),
(139, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 15:25:47'),
(143, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 15:26:47'),
(144, 1, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 11, 'Inscripción actualizada: usuario_id=8 en curso_id=1', '{\"id\":11,\"usuario_id\":8,\"curso_id\":1,\"estado\":\"PENDIENTE\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-28 11:26:30\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785252390_auditoria-report-1785184796656.pdf\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 11:26:31\",\"fecha_completado\":null}', '{\"id\":11,\"usuario_id\":8,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-28 11:26:30\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785252390_auditoria-report-1785184796656.pdf\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-28 11:26:31\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/11', '2026-07-28 15:27:56'),
(145, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 15:27:58'),
(149, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 15:30:49'),
(150, 1, 'ACTUALIZAR_CURSO', 'Curso', 1, 'Curso actualizado: \'EnerVivencial\'', '{\"id\":1,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"EnerVivencial\",\"slug\":\"CEV\",\"descripcion_corta\":\"Experiencia t\\u00e9cnica 100% pr\\u00e1ctica en campo para aprender el dise\\u00f1o, montaje y funcionamiento real de sistemas de energ\\u00eda solar en las instalaciones de Enervida.\",\"descripcion\":\"Aprende energ\\u00eda solar mediante una inmersi\\u00f3n pr\\u00e1ctica en nuestras instalaciones. EnerVivencial est\\u00e1 dise\\u00f1ado para que experimentes de primera mano el funcionamiento, instalaci\\u00f3n y mantenimiento de sistemas fotovoltaicos en un entorno real.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Pr\\u00e1ctica real en campo: Manipulaci\\u00f3n directa de paneles solares, inversores, controladores y bancos de bater\\u00edas.\\n\\u2022 Montaje e instalaci\\u00f3n: Pasos clave para el cableado, conexionado seguro y montaje de estructuras.\\n\\u2022 Diagn\\u00f3stico y mediciones: Uso de herramientas de medici\\u00f3n para evaluar rendimiento, voltaje y corriente en tiempo real.\\n\\u2022 Mantenimiento y resoluci\\u00f3n de fallas: Identificaci\\u00f3n de problemas comunes y t\\u00e9cnicas de mantenimiento preventivo.\\n\\u2022 Aplicaci\\u00f3n de tecnolog\\u00edas sostenibles: Integraci\\u00f3n de la energ\\u00eda solar con proyectos ecol\\u00f3gicos.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEstudiantes, t\\u00e9cnicos, ingenieros y entusiastas de las energ\\u00edas renovables que busquen adquirir experiencia pr\\u00e1ctica directa.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785181049_679475974-1577547564376963-2848436857219950621-n.jpg\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":\"200.00\",\"fecha_creacion\":\"2026-07-27 14:48:05\",\"fecha_actualizacion\":\"2026-07-28 09:36:42\",\"edicion_actual\":2}', '{\"id\":1,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"EnerVivencial\",\"slug\":\"EV\",\"descripcion_corta\":\"Experiencia t\\u00e9cnica 100% pr\\u00e1ctica en campo para aprender el dise\\u00f1o, montaje y funcionamiento real de sistemas de energ\\u00eda solar en las instalaciones de Enervida.\",\"descripcion\":\"Aprende energ\\u00eda solar mediante una inmersi\\u00f3n pr\\u00e1ctica en nuestras instalaciones. EnerVivencial est\\u00e1 dise\\u00f1ado para que experimentes de primera mano el funcionamiento, instalaci\\u00f3n y mantenimiento de sistemas fotovoltaicos en un entorno real.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Pr\\u00e1ctica real en campo: Manipulaci\\u00f3n directa de paneles solares, inversores, controladores y bancos de bater\\u00edas.\\n\\u2022 Montaje e instalaci\\u00f3n: Pasos clave para el cableado, conexionado seguro y montaje de estructuras.\\n\\u2022 Diagn\\u00f3stico y mediciones: Uso de herramientas de medici\\u00f3n para evaluar rendimiento, voltaje y corriente en tiempo real.\\n\\u2022 Mantenimiento y resoluci\\u00f3n de fallas: Identificaci\\u00f3n de problemas comunes y t\\u00e9cnicas de mantenimiento preventivo.\\n\\u2022 Aplicaci\\u00f3n de tecnolog\\u00edas sostenibles: Integraci\\u00f3n de la energ\\u00eda solar con proyectos ecol\\u00f3gicos.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEstudiantes, t\\u00e9cnicos, ingenieros y entusiastas de las energ\\u00edas renovables que busquen adquirir experiencia pr\\u00e1ctica directa.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785181049_679475974-1577547564376963-2848436857219950621-n.jpg\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":200,\"fecha_creacion\":\"2026-07-27 14:48:05\",\"fecha_actualizacion\":\"2026-07-28 09:36:42\",\"edicion_actual\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/cursos/1', '2026-07-28 15:35:31'),
(151, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 15:42:12'),
(154, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 16:04:42');
INSERT INTO `auditoria_logs` (`id`, `usuario_id`, `accion`, `entidad`, `entidad_id`, `descripcion`, `valores_anteriores`, `valores_nuevos`, `direccion_ip`, `user_agent`, `metodo_request`, `endpoint`, `fecha_creacion`) VALUES
(155, 1, 'ELIMINAR_USUARIO', 'Usuario', 8, 'Usuario eliminado: Jhonatan Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"Jhonatan\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/8', '2026-07-28 16:04:54'),
(156, 1, 'ELIMINAR_USUARIO', 'Usuario', 3, 'Usuario eliminado: Omar Ramos Ramos (omaramos1522@gmail.com)', '{\"nombres\":\"Omar\",\"apellidos\":\"Ramos Ramos\",\"correo\":\"omaramos1522@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/3', '2026-07-28 16:04:57'),
(157, 1, 'ACTUALIZAR_EVALUACION', 'Evaluacion', 1, 'Evaluación actualizada: \'Examen Final\'', '{\"id\":1,\"curso_id\":1,\"titulo\":\"Examen Final\",\"descripcion\":\"Responda de manera correcta para poder obtener su certificado.\",\"nota_aprobacion\":\"10.00\",\"tiempo_limite\":20,\"intentos_permitidos\":1,\"fecha_creacion\":\"2026-07-27 15:50:05\"}', '{\"id\":1,\"curso_id\":1,\"titulo\":\"Examen Final\",\"descripcion\":\"Responda de manera correcta para poder obtener su certificado.\",\"nota_aprobacion\":\"10.00\",\"tiempo_limite\":30,\"intentos_permitidos\":1,\"fecha_creacion\":\"2026-07-27 15:50:05\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/evaluaciones/1', '2026-07-28 16:05:26'),
(158, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 16:18:28'),
(161, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 16:20:01'),
(162, 1, 'ACTUALIZAR_USUARIO', 'Usuario', 9, 'Usuario actualizado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":2}', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":3}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/9', '2026-07-28 16:20:15'),
(163, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 16:20:24'),
(166, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 16:27:04'),
(167, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 16:29:29'),
(170, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-28 16:31:36'),
(171, 1, 'ACTUALIZAR_USUARIO', 'Usuario', 9, 'Usuario actualizado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":3}', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/9', '2026-07-28 16:31:47'),
(172, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-28 17:22:09'),
(177, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-29 14:07:36'),
(178, 1, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 12, 'Inscripción actualizada: usuario_id=9 en curso_id=1', '{\"id\":12,\"usuario_id\":9,\"curso_id\":1,\"estado\":\"PENDIENTE\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-29 10:07:10\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785334030_whatsapp-image-2026-07-27-at-120414-pm.jpeg\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-29 10:07:12\",\"fecha_completado\":null}', '{\"id\":12,\"usuario_id\":9,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"EN_REVISION\",\"monto_pago\":\"200.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-29 10:07:10\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785334030_whatsapp-image-2026-07-27-at-120414-pm.jpeg\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-29 10:07:12\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/12', '2026-07-29 14:08:18'),
(179, 1, 'ACTUALIZAR_EVALUACION', 'Evaluacion', 1, 'Evaluación actualizada: \'Examen Final\'', '{\"id\":1,\"curso_id\":1,\"titulo\":\"Examen Final\",\"descripcion\":\"Responda de manera correcta para poder obtener su certificado.\",\"nota_aprobacion\":\"10.00\",\"tiempo_limite\":30,\"intentos_permitidos\":1,\"fecha_creacion\":\"2026-07-27 15:50:05\"}', '{\"id\":1,\"curso_id\":1,\"titulo\":\"Examen Final\",\"descripcion\":\"Responda de manera correcta para poder obtener su certificado.\",\"nota_aprobacion\":\"10.00\",\"tiempo_limite\":60,\"intentos_permitidos\":2,\"fecha_creacion\":\"2026-07-27 15:50:05\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/evaluaciones/1', '2026-07-29 14:08:49'),
(180, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-29 14:08:55'),
(189, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 13:03:38'),
(190, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 13:04:01'),
(191, 1, 'ELIMINAR_USUARIO', 'Usuario', 9, 'Usuario eliminado: Jhonatan Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"Jhonatan\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/9', '2026-07-30 13:41:36'),
(192, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 13:45:58'),
(193, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 13:47:06'),
(194, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 13:48:25'),
(195, 10, 'REGISTRO_GOOGLE', 'Usuario', 10, 'Registro nuevo via Google: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-30 13:48:51'),
(196, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 13:49:19'),
(197, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 13:49:30'),
(198, 1, 'ACTUALIZAR_USUARIO', 'Usuario', 10, 'Usuario actualizado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":2}', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/10', '2026-07-30 13:51:34'),
(199, 1, 'ACTUALIZAR_USUARIO', 'Usuario', 10, 'Usuario actualizado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":2}', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":4}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/10', '2026-07-30 13:51:51'),
(200, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 13:51:57'),
(201, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 13:52:12'),
(202, 10, 'ACTUALIZAR_EVALUACION', 'Evaluacion', 1, 'Evaluación actualizada: \'Examen Final\'', '{\"id\":1,\"curso_id\":1,\"titulo\":\"Examen Final\",\"descripcion\":\"Responda de manera correcta para poder obtener su certificado.\",\"nota_aprobacion\":\"10.00\",\"tiempo_limite\":60,\"intentos_permitidos\":2,\"fecha_creacion\":\"2026-07-27 15:50:05\"}', '{\"id\":1,\"curso_id\":1,\"titulo\":\"Examen Final\",\"descripcion\":\"Responda de manera correcta para poder obtener su certificado.\",\"nota_aprobacion\":\"10.00\",\"tiempo_limite\":50,\"intentos_permitidos\":2,\"fecha_creacion\":\"2026-07-27 15:50:05\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/evaluaciones/1', '2026-07-30 13:55:26'),
(203, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 13:56:26'),
(204, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 13:56:40'),
(205, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 14:13:13'),
(206, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 14:13:24'),
(207, 10, 'ACTUALIZAR_CURSO', 'Curso', 1, 'Curso actualizado: \'EnerVivencial\'', '{\"id\":1,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"EnerVivencial\",\"slug\":\"EV\",\"descripcion_corta\":\"Experiencia t\\u00e9cnica 100% pr\\u00e1ctica en campo para aprender el dise\\u00f1o, montaje y funcionamiento real de sistemas de energ\\u00eda solar en las instalaciones de Enervida.\",\"descripcion\":\"Aprende energ\\u00eda solar mediante una inmersi\\u00f3n pr\\u00e1ctica en nuestras instalaciones. EnerVivencial est\\u00e1 dise\\u00f1ado para que experimentes de primera mano el funcionamiento, instalaci\\u00f3n y mantenimiento de sistemas fotovoltaicos en un entorno real.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Pr\\u00e1ctica real en campo: Manipulaci\\u00f3n directa de paneles solares, inversores, controladores y bancos de bater\\u00edas.\\n\\u2022 Montaje e instalaci\\u00f3n: Pasos clave para el cableado, conexionado seguro y montaje de estructuras.\\n\\u2022 Diagn\\u00f3stico y mediciones: Uso de herramientas de medici\\u00f3n para evaluar rendimiento, voltaje y corriente en tiempo real.\\n\\u2022 Mantenimiento y resoluci\\u00f3n de fallas: Identificaci\\u00f3n de problemas comunes y t\\u00e9cnicas de mantenimiento preventivo.\\n\\u2022 Aplicaci\\u00f3n de tecnolog\\u00edas sostenibles: Integraci\\u00f3n de la energ\\u00eda solar con proyectos ecol\\u00f3gicos.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEstudiantes, t\\u00e9cnicos, ingenieros y entusiastas de las energ\\u00edas renovables que busquen adquirir experiencia pr\\u00e1ctica directa.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785181049_679475974-1577547564376963-2848436857219950621-n.jpg\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":\"200.00\",\"fecha_creacion\":\"2026-07-27 14:48:05\",\"fecha_actualizacion\":\"2026-07-28 11:35:31\",\"edicion_actual\":1}', '{\"id\":1,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"EnerVivencial\",\"slug\":\"EV\",\"descripcion_corta\":\"Experiencia t\\u00e9cnica 100% pr\\u00e1ctica en campo para aprender el dise\\u00f1o, montaje y funcionamiento real de sistemas de energ\\u00eda solar en las instalaciones de Enervida.\",\"descripcion\":\"Aprende energ\\u00eda solar mediante una inmersi\\u00f3n pr\\u00e1ctica en nuestras instalaciones. EnerVivencial est\\u00e1 dise\\u00f1ado para que experimentes de primera mano el funcionamiento, instalaci\\u00f3n y mantenimiento de sistemas fotovoltaicos en un entorno real.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Pr\\u00e1ctica real en campo: Manipulaci\\u00f3n directa de paneles solares, inversores, controladores y bancos de bater\\u00edas.\\n\\u2022 Montaje e instalaci\\u00f3n: Pasos clave para el cableado, conexionado seguro y montaje de estructuras.\\n\\u2022 Diagn\\u00f3stico y mediciones: Uso de herramientas de medici\\u00f3n para evaluar rendimiento, voltaje y corriente en tiempo real.\\n\\u2022 Mantenimiento y resoluci\\u00f3n de fallas: Identificaci\\u00f3n de problemas comunes y t\\u00e9cnicas de mantenimiento preventivo.\\n\\u2022 Aplicaci\\u00f3n de tecnolog\\u00edas sostenibles: Integraci\\u00f3n de la energ\\u00eda solar con proyectos ecol\\u00f3gicos.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nEstudiantes, t\\u00e9cnicos, ingenieros y entusiastas de las energ\\u00edas renovables que busquen adquirir experiencia pr\\u00e1ctica directa.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785181049_679475974-1577547564376963-2848436857219950621-n.jpg\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":205,\"fecha_creacion\":\"2026-07-27 14:48:05\",\"fecha_actualizacion\":\"2026-07-28 11:35:31\",\"edicion_actual\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/cursos/1', '2026-07-30 14:14:39'),
(208, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 14:16:15'),
(209, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 14:19:27'),
(210, 10, 'CREAR_EVALUACION', 'Evaluacion', 2, 'Evaluación creada: \'Prueba de examen\' para curso_id=2', NULL, '{\"curso_id\":2,\"titulo\":\"Prueba de examen\",\"descripcion\":null,\"nota_aprobacion\":70,\"tiempo_limite\":60,\"intentos_permitidos\":2,\"id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/evaluaciones', '2026-07-30 14:24:08'),
(211, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 14:24:21'),
(212, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 14:24:32'),
(213, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 14:25:36'),
(214, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 14:25:43'),
(215, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 14:28:10'),
(216, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 14:28:18'),
(217, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 14:28:57'),
(218, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 14:29:04'),
(219, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 14:40:16'),
(220, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 14:42:35'),
(221, 1, 'ACTUALIZAR_USUARIO', 'Usuario', 10, 'Usuario actualizado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":4}', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/10', '2026-07-30 14:42:50'),
(222, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 14:42:57'),
(223, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 14:43:09'),
(224, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 14:43:37'),
(225, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 14:43:45'),
(226, 1, 'ACTUALIZAR_USUARIO', 'Usuario', 10, 'Usuario actualizado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":2}', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":4}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/10', '2026-07-30 14:44:02'),
(227, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 14:44:07'),
(228, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 14:44:16'),
(229, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 14:44:48'),
(233, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 14:47:10'),
(234, 10, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 13, 'Inscripción actualizada: usuario_id=11 en curso_id=1', '{\"id\":13,\"usuario_id\":11,\"curso_id\":1,\"estado\":\"PENDIENTE\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"205.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-30 10:46:46\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785422805_306008221-462658489223414-4208839956678849536-n.jpg\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-30 10:46:47\",\"fecha_completado\":null}', '{\"id\":13,\"usuario_id\":11,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"205.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-30 10:46:46\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785422805_306008221-462658489223414-4208839956678849536-n.jpg\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-30 10:46:47\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/13', '2026-07-30 14:47:46'),
(235, 10, 'ACTUALIZAR_USUARIO', 'Usuario', 11, 'Usuario actualizado: Omar Ramos Mendoza (omaramos1522@gmail.com)', '{\"nombres\":\"Omar\",\"apellidos\":\"Ramos Mendoza\",\"correo\":\"omaramos1522@gmail.com\",\"telefono\":\"65247813\",\"estado\":\"ACTIVO\",\"ci\":\"9965321\",\"rol_id\":2}', '{\"nombres\":\"Omar\",\"apellidos\":\"Ramos Mendoza\",\"correo\":\"omaramos1522@gmail.com\",\"telefono\":\"652478132\",\"estado\":\"ACTIVO\",\"ci\":\"9965321\",\"rol_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/11', '2026-07-30 14:48:39'),
(236, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 14:49:23'),
(240, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 14:53:15'),
(241, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 14:55:56'),
(242, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 15:02:05'),
(243, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 15:02:35'),
(244, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 15:12:26'),
(245, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 15:46:07'),
(248, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 15:50:13'),
(249, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 16:13:55'),
(250, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 16:14:08'),
(251, 1, 'ACTUALIZAR_USUARIO', 'Usuario', 10, 'Usuario actualizado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":4}', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/10', '2026-07-30 16:14:40'),
(252, 1, 'ELIMINAR_USUARIO', 'Usuario', 11, 'Usuario eliminado: Omar Ramos Mendoza (omaramos1522@gmail.com)', '{\"nombres\":\"Omar\",\"apellidos\":\"Ramos Mendoza\",\"correo\":\"omaramos1522@gmail.com\",\"rol_id\":2}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/usuarios/11', '2026-07-30 16:18:13'),
(253, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 17:21:26'),
(254, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 17:21:36'),
(255, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 17:23:35'),
(256, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 17:26:42'),
(257, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 17:38:14'),
(258, 12, 'REGISTRO_GOOGLE', 'Usuario', 12, 'Registro nuevo via Google: Omar Ramos (omaramos1522@gmail.com)', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-30 17:38:28'),
(259, 12, 'INSCRIBIR_ESTUDIANTE', 'Inscripcion', 14, 'Inscripción creada: usuario_id=12 en curso_id=1 — estado: PENDIENTE', NULL, '{\"curso_id\":1,\"usuario_id\":12,\"estado_pago\":\"PENDIENTE\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-30 13:39:13\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785433153_1534510209115.jpg\",\"estado\":\"PENDIENTE\",\"monto_pago\":\"205.00\",\"id\":14}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/inscripciones', '2026-07-30 17:39:15'),
(260, 12, 'LOGOUT', 'Usuario', 12, 'Cierre de sesion: Omar Ramos Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 17:39:23'),
(261, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 17:39:34'),
(262, 1, 'ACTUALIZAR_USUARIO', 'Usuario', 10, 'Usuario actualizado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":2}', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":4}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/10', '2026-07-30 17:39:56'),
(263, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 17:40:05'),
(264, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 17:40:16'),
(265, 10, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 14, 'Inscripción actualizada: usuario_id=12 en curso_id=1', '{\"id\":14,\"usuario_id\":12,\"curso_id\":1,\"estado\":\"PENDIENTE\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"205.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-30 13:39:13\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785433153_1534510209115.jpg\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-30 13:39:15\",\"fecha_completado\":null}', '{\"id\":14,\"usuario_id\":12,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"APROBADO\",\"monto_pago\":\"205.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-30 13:39:13\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785433153_1534510209115.jpg\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-30 13:39:15\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/14', '2026-07-30 17:41:01'),
(266, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 17:41:36'),
(267, 12, 'LOGIN', 'Usuario', 12, 'Inicio de sesion: Omar Ramos Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 17:41:56'),
(268, 12, 'COMPLETAR_EVALUACION', 'IntentoEvaluacion', 9, 'Evaluación completada: evaluacion_id=1 — nota=20% — APROBADO — Certificado generado: EV01260001', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/intentos-evaluacion', '2026-07-30 17:43:15'),
(269, 12, 'LOGOUT', 'Usuario', 12, 'Cierre de sesion: Omar Ramos Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 17:43:48'),
(270, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 17:43:57'),
(271, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 17:44:30'),
(272, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 17:44:45'),
(273, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 18:02:57'),
(274, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 18:21:51'),
(275, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 18:22:34'),
(276, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 18:22:52'),
(277, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 18:24:21'),
(278, 10, 'RECUPERACION_CONTRASENA', 'Usuario', 10, 'Solicitud de recuperacion de contrasena para: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/forgot-password', '2026-07-30 18:25:25'),
(279, 10, 'CONTRASENA_RESTABLECIDA', 'Usuario', 10, 'Contrasena restablecida para: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/reset-password', '2026-07-30 18:33:59'),
(280, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 18:34:12'),
(281, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 18:34:20'),
(282, 10, 'LOGIN_FALLIDO', 'Usuario', 10, 'Contraseña incorrecta para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 18:34:52'),
(283, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 18:35:01'),
(284, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 18:35:08'),
(285, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 18:35:15'),
(286, 1, 'ACTUALIZAR_USUARIO', 'Usuario', 10, 'Usuario actualizado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":4}', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":4}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/10', '2026-07-30 18:35:51'),
(287, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 18:36:03'),
(288, 1, 'RECUPERACION_CONTRASENA', 'Usuario', 1, 'Solicitud de recuperacion de contrasena para: danielacopana@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/forgot-password', '2026-07-30 18:36:40'),
(289, 12, 'RECUPERACION_CONTRASENA', 'Usuario', 12, 'Solicitud de recuperacion de contrasena para: omaramos1522@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/forgot-password', '2026-07-30 18:37:12'),
(290, 1, 'RECUPERACION_CONTRASENA', 'Usuario', 1, 'Solicitud de recuperacion de contrasena para: danielacopana@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/forgot-password', '2026-07-30 18:37:27'),
(291, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 18:41:49'),
(292, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 18:52:13'),
(293, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 18:59:48'),
(294, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 19:00:09'),
(295, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 19:00:44'),
(296, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 19:01:25'),
(297, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 19:01:58'),
(298, 1, 'LOGIN_GOOGLE', 'Usuario', 1, 'Login via Google: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-30 19:07:28'),
(299, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 19:12:38'),
(300, 13, 'REGISTRO_GOOGLE', 'Usuario', 13, 'Registro nuevo via Google: Daniel Alvarez (daniealvarez597@gmail.com)', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-30 19:14:36'),
(301, 13, 'INSCRIBIR_ESTUDIANTE', 'Inscripcion', 15, 'Inscripción creada: usuario_id=13 en curso_id=1 — estado: PENDIENTE', NULL, '{\"curso_id\":1,\"usuario_id\":13,\"estado_pago\":\"PENDIENTE\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-30 15:18:46\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785439126_15036651-252342725181129-4260676635123463260-n.png\",\"estado\":\"PENDIENTE\",\"monto_pago\":\"205.00\",\"id\":15}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/inscripciones', '2026-07-30 19:18:48'),
(302, 13, 'LOGOUT', 'Usuario', 13, 'Cierre de sesion: Daniel Alvarez Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 19:19:06'),
(303, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 19:19:15'),
(304, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 19:19:37'),
(305, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 19:19:48'),
(306, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 19:34:10'),
(307, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 19:34:22'),
(308, 1, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 15, 'Inscripción actualizada: usuario_id=13 en curso_id=1', '{\"id\":15,\"usuario_id\":13,\"curso_id\":1,\"estado\":\"PENDIENTE\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"205.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-30 15:18:46\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785439126_15036651-252342725181129-4260676635123463260-n.png\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-30 15:18:48\",\"fecha_completado\":null}', '{\"id\":15,\"usuario_id\":13,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"205.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-30 15:18:46\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785439126_15036651-252342725181129-4260676635123463260-n.png\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-30 15:18:48\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/15', '2026-07-30 19:35:03'),
(309, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 19:35:29'),
(310, 13, 'LOGIN_GOOGLE', 'Usuario', 13, 'Login via Google: Daniel Alvarez Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-30 19:44:30'),
(311, 13, 'LOGIN_GOOGLE', 'Usuario', 13, 'Login via Google: Daniel Alvarez Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-30 19:46:00'),
(312, 13, 'LOGOUT', 'Usuario', 13, 'Cierre de sesion: Daniel Alvarez Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 19:49:04'),
(313, 13, 'LOGIN', 'Usuario', 13, 'Inicio de sesion: Daniel Alvarez Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 19:49:46'),
(314, 13, 'LOGOUT', 'Usuario', 13, 'Cierre de sesion: Daniel Alvarez Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 19:54:39');
INSERT INTO `auditoria_logs` (`id`, `usuario_id`, `accion`, `entidad`, `entidad_id`, `descripcion`, `valores_anteriores`, `valores_nuevos`, `direccion_ip`, `user_agent`, `metodo_request`, `endpoint`, `fecha_creacion`) VALUES
(315, 13, 'LOGIN', 'Usuario', 13, 'Inicio de sesion: Daniel Alvarez Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 19:55:50'),
(316, 13, 'COMPLETAR_EVALUACION', 'IntentoEvaluacion', 10, 'Evaluación completada: evaluacion_id=1 — nota=60% — APROBADO — Certificado generado: EV01260002', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/intentos-evaluacion', '2026-07-30 19:56:21'),
(317, 13, 'LOGOUT', 'Usuario', 13, 'Cierre de sesion: Daniel Alvarez Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 19:56:53'),
(318, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 19:57:04'),
(319, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 20:08:23'),
(320, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 20:09:34'),
(321, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 20:46:51'),
(322, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-30 20:48:35'),
(323, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-30 20:51:01'),
(324, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-31 13:46:16'),
(325, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-31 13:46:26'),
(326, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-31 14:15:23'),
(327, 14, 'REGISTRO_GOOGLE', 'Usuario', 14, 'Registro nuevo via Google: Jhonas Ramos (ramosjhonas231@gmail.com)', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-07-31 14:15:52'),
(328, 14, 'INSCRIBIR_ESTUDIANTE', 'Inscripcion', 16, 'Inscripción creada: usuario_id=14 en curso_id=1 — estado: PENDIENTE', NULL, '{\"curso_id\":1,\"usuario_id\":14,\"estado_pago\":\"PENDIENTE\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-31 10:16:45\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785507405_chatgpt-image-22-jul-2026-03-18-21-pm.png\",\"estado\":\"PENDIENTE\",\"monto_pago\":\"205.00\",\"id\":16}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/inscripciones', '2026-07-31 14:16:46'),
(329, 14, 'LOGOUT', 'Usuario', 14, 'Cierre de sesion: Jhonas Suxo Mamani', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-31 14:16:55'),
(330, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-31 14:17:06'),
(331, 1, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 16, 'Inscripción actualizada: usuario_id=14 en curso_id=1', '{\"id\":16,\"usuario_id\":14,\"curso_id\":1,\"estado\":\"PENDIENTE\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"205.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-31 10:16:45\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785507405_chatgpt-image-22-jul-2026-03-18-21-pm.png\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-31 10:16:46\",\"fecha_completado\":null}', '{\"id\":16,\"usuario_id\":14,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"205.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-07-31 10:16:45\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785507405_chatgpt-image-22-jul-2026-03-18-21-pm.png\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-07-31 10:16:46\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/16', '2026-07-31 14:17:33'),
(332, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-31 17:36:59'),
(333, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-07-31 19:21:53'),
(334, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-07-31 19:26:34'),
(335, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-03 13:26:15'),
(336, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 16:03:10'),
(337, 15, 'REGISTRO_GOOGLE', 'Usuario', 15, 'Registro nuevo via Google: Angelica Collquehuanca (collquehuancaangelica@gmail.com)', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-08-03 16:03:33'),
(338, 15, 'INSCRIBIR_ESTUDIANTE', 'Inscripcion', 17, 'Inscripción creada: usuario_id=15 en curso_id=1 — estado: PENDIENTE', NULL, '{\"curso_id\":1,\"usuario_id\":15,\"estado_pago\":\"PENDIENTE\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-08-03 12:04:42\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785773082_comprobante.png\",\"estado\":\"PENDIENTE\",\"monto_pago\":\"205.00\",\"id\":17}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/inscripciones', '2026-08-03 16:04:44'),
(339, 15, 'LOGOUT', 'Usuario', 15, 'Cierre de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 16:04:57'),
(340, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-03 16:05:03'),
(341, 1, 'ACTUALIZAR_CURSO', 'Curso', 3, 'Curso actualizado: \'Sistemas Fotovoltaicos\'', '{\"id\":3,\"categoria_id\":1,\"instructor_id\":1,\"titulo\":\"Sistemas Fotovoltaicos\",\"slug\":\"sistemas-fotovoltaicos\",\"descripcion_corta\":\"Capacitaci\\u00f3n integral en el dise\\u00f1o, dimensionamiento e instalaci\\u00f3n de sistemas solares fotovoltaicos aislados y conectados a la red el\\u00e9ctrica.\",\"descripcion\":\"Curso te\\u00f3rico-pr\\u00e1ctico dise\\u00f1ado para brindar los conocimientos t\\u00e9cnicos necesarios en el c\\u00e1lculo, selecci\\u00f3n de componentes e instalaci\\u00f3n de sistemas solares fotovoltaicos para uso residencial, comercial e industrial.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Principios de la energ\\u00eda solar: Radiaci\\u00f3n solar, geometr\\u00eda solar y evaluaci\\u00f3n del recurso en sitio.\\n\\u2022 Componentes del sistema: Funcionamiento y selecci\\u00f3n de paneles fotovoltaicos, inversores, reguladores de carga y bater\\u00edas.\\n\\u2022 Dimensionamiento de sistemas: C\\u00e1lculo de cargas energ\\u00e9ticas para sistemas aislados (off-grid) y conectados a la red (on-grid).\\n\\u2022 Instalaci\\u00f3n y normativa: Criterios de montaje de estructuras, cableado, protecciones el\\u00e9ctricas y seguridad laboral.\\n\\u2022 Pruebas y puesta en marcha: Mediciones de rendimiento, verificaci\\u00f3n de funcionamiento y mantenimiento preventivo.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nElectricistas, t\\u00e9cnicos, ingenieros, estudiantes y emprendedores que deseen capacitarse en la implementaci\\u00f3n de proyectos de energ\\u00eda solar fotovoltaica.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785180302_sistemas-fotovoltaicos.png\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":\"300.00\",\"fecha_creacion\":\"2026-07-27 14:50:01\",\"fecha_actualizacion\":\"2026-07-27 15:25:07\",\"edicion_actual\":1}', '{\"id\":3,\"categoria_id\":2,\"instructor_id\":1,\"titulo\":\"Sistemas Fotovoltaicos\",\"slug\":\"sistemas-fotovoltaicos\",\"descripcion_corta\":\"Capacitaci\\u00f3n integral en el dise\\u00f1o, dimensionamiento e instalaci\\u00f3n de sistemas solares fotovoltaicos aislados y conectados a la red el\\u00e9ctrica.\",\"descripcion\":\"Curso te\\u00f3rico-pr\\u00e1ctico dise\\u00f1ado para brindar los conocimientos t\\u00e9cnicos necesarios en el c\\u00e1lculo, selecci\\u00f3n de componentes e instalaci\\u00f3n de sistemas solares fotovoltaicos para uso residencial, comercial e industrial.\\n\\n\\u00bfQu\\u00e9 aprender\\u00e1s en este curso?\\n\\u2022 Principios de la energ\\u00eda solar: Radiaci\\u00f3n solar, geometr\\u00eda solar y evaluaci\\u00f3n del recurso en sitio.\\n\\u2022 Componentes del sistema: Funcionamiento y selecci\\u00f3n de paneles fotovoltaicos, inversores, reguladores de carga y bater\\u00edas.\\n\\u2022 Dimensionamiento de sistemas: C\\u00e1lculo de cargas energ\\u00e9ticas para sistemas aislados (off-grid) y conectados a la red (on-grid).\\n\\u2022 Instalaci\\u00f3n y normativa: Criterios de montaje de estructuras, cableado, protecciones el\\u00e9ctricas y seguridad laboral.\\n\\u2022 Pruebas y puesta en marcha: Mediciones de rendimiento, verificaci\\u00f3n de funcionamiento y mantenimiento preventivo.\\n\\n\\u00bfA qui\\u00e9n est\\u00e1 dirigido?\\nElectricistas, t\\u00e9cnicos, ingenieros, estudiantes y emprendedores que deseen capacitarse en la implementaci\\u00f3n de proyectos de energ\\u00eda solar fotovoltaica.\",\"miniatura_url\":\"http:\\/\\/localhost:8000\\/uploads\\/general\\/1785180302_sistemas-fotovoltaicos.png\",\"nivel\":\"Todos\",\"tipo_curso\":\"Hibrido\",\"certificado_habilitado\":1,\"publicado\":1,\"precio\":300,\"fecha_creacion\":\"2026-07-27 14:50:01\",\"fecha_actualizacion\":\"2026-07-27 15:25:07\",\"edicion_actual\":1}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/cursos/3', '2026-08-03 16:06:18'),
(342, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 17:11:32'),
(343, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-03 17:11:52'),
(344, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 17:19:48'),
(345, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-03 17:19:54'),
(346, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 17:28:17'),
(347, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-03 17:28:25'),
(348, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 18:13:46'),
(349, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-03 18:13:54'),
(350, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 18:21:13'),
(351, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-03 18:21:24'),
(352, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 18:43:38'),
(353, 10, 'LOGIN_GOOGLE', 'Usuario', 10, 'Login via Google: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-08-03 18:43:53'),
(354, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 18:44:04'),
(355, 1, 'LOGIN_FALLIDO', 'Usuario', 1, 'Contraseña incorrecta para: danielacopana@gmail.com', NULL, '{\"correo\":\"danielacopana@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-03 18:44:11'),
(356, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-03 18:45:59'),
(357, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 18:47:50'),
(358, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-03 18:47:59'),
(359, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 18:49:25'),
(360, 12, 'LOGIN_GOOGLE', 'Usuario', 12, 'Login via Google: Omar Ramos Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-08-03 18:49:38'),
(361, 12, 'LOGOUT', 'Usuario', 12, 'Cierre de sesion: Omar Ramos Mendoza', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 18:50:56'),
(362, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-03 18:51:06'),
(363, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 18:53:50'),
(364, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-03 18:54:02'),
(365, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 18:54:09'),
(366, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-03 18:54:18'),
(367, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 19:22:11'),
(368, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-03 19:22:20'),
(369, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 19:22:25'),
(370, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-03 19:22:33'),
(371, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 19:30:24'),
(372, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-03 19:30:33'),
(373, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-03 19:39:53'),
(374, 1, 'LOGIN_FALLIDO', 'Usuario', 1, 'Contraseña incorrecta para: danielacopana@gmail.com', NULL, '{\"correo\":\"danielacopana@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 12:49:12'),
(375, 1, 'LOGIN_FALLIDO', 'Usuario', 1, 'Contraseña incorrecta para: danielacopana@gmail.com', NULL, '{\"correo\":\"danielacopana@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 12:49:33'),
(376, 1, 'LOGIN_FALLIDO', 'Usuario', 1, 'Contraseña incorrecta para: danielacopana@gmail.com', NULL, '{\"correo\":\"danielacopana@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 12:49:36'),
(377, 1, 'CUENTA_BLOQUEADA', 'Usuario', 1, 'Cuenta bloqueada automaticamente tras 3 intentos fallidos', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 12:49:58'),
(378, 10, 'LOGIN_FALLIDO', 'Usuario', 10, 'Contraseña incorrecta para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 12:50:24'),
(379, 10, 'LOGIN_FALLIDO', 'Usuario', 10, 'Contraseña incorrecta para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 12:50:32'),
(380, 10, 'LOGIN_FALLIDO', 'Usuario', 10, 'Contraseña incorrecta para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 12:50:36'),
(381, 10, 'CUENTA_BLOQUEADA', 'Usuario', 10, 'Cuenta bloqueada automaticamente tras 3 intentos fallidos', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 12:50:41'),
(382, 10, 'LOGIN_BLOQUEADO', 'Usuario', 10, 'Intento de acceso a cuenta bloqueada: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 12:51:14'),
(383, 10, 'LOGIN_BLOQUEADO', 'Usuario', 10, 'Intento de acceso a cuenta bloqueada: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 12:51:16'),
(384, 10, 'LOGIN_BLOQUEADO', 'Usuario', 10, 'Intento de acceso a cuenta bloqueada: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 12:51:49'),
(385, 10, 'LOGIN_BLOQUEADO', 'Usuario', 10, 'Intento de acceso a cuenta bloqueada: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:32:51'),
(386, 10, 'LOGIN_BLOQUEADO', 'Usuario', 10, 'Intento de acceso a cuenta bloqueada: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:32:53'),
(387, 10, 'LOGIN_BLOQUEADO', 'Usuario', 10, 'Intento de acceso a cuenta bloqueada: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:32:55'),
(388, 10, 'LOGIN_BLOQUEADO', 'Usuario', 10, 'Intento de acceso a cuenta bloqueada: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:32:58'),
(389, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: daniealvares597@gmail.com', NULL, '{\"correo\":\"daniealvares597@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:33:53'),
(390, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: daniealvares597@gmail.com', NULL, '{\"correo\":\"daniealvares597@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:33:55'),
(391, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: daniealvares597@gmail.com', NULL, '{\"correo\":\"daniealvares597@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:33:57'),
(392, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: daniealvares597@gmail.com', NULL, '{\"correo\":\"daniealvares597@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:34:00'),
(393, NULL, 'LOGIN_FALLIDO', 'Usuario', NULL, 'Intento de login fallido para: daniealvares597@gmail.com', NULL, '{\"correo\":\"daniealvares597@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:34:02'),
(394, 1, 'LOGIN_BLOQUEADO', 'Usuario', 1, 'Intento de acceso a cuenta bloqueada: danielacopana@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:35:26'),
(395, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:37:02'),
(396, 1, 'ACTUALIZAR_USUARIO', 'Usuario', 10, 'Usuario actualizado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"BLOQUEADO\",\"ci\":null,\"rol_id\":4}', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":4}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/10', '2026-08-04 13:37:32'),
(397, 1, 'ACTUALIZAR_USUARIO', 'Usuario', 10, 'Usuario actualizado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":4}', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/10', '2026-08-04 13:37:40'),
(398, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 13:37:45'),
(399, 10, 'LOGIN_FALLIDO', 'Usuario', 10, 'Contraseña incorrecta para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:37:57'),
(400, 10, 'LOGIN_FALLIDO', 'Usuario', 10, 'Contraseña incorrecta para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:37:59'),
(401, 10, 'LOGIN_FALLIDO', 'Usuario', 10, 'Contraseña incorrecta para: ramosjhonatan659@gmail.com', NULL, '{\"correo\":\"ramosjhonatan659@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:38:01'),
(402, 10, 'CUENTA_BLOQUEADA', 'Usuario', 10, 'Cuenta bloqueada automaticamente tras 3 intentos fallidos', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:38:12'),
(403, 10, 'LOGIN_BLOQUEADO', 'Usuario', 10, 'Intento de acceso a cuenta bloqueada: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:58:16'),
(404, 10, 'LOGIN_BLOQUEADO', 'Usuario', 10, 'Intento de acceso a cuenta bloqueada: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:58:18'),
(405, 10, 'LOGIN_BLOQUEADO', 'Usuario', 10, 'Intento de acceso a cuenta bloqueada: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:58:20'),
(406, 10, 'LOGIN_BLOQUEADO', 'Usuario', 10, 'Intento de acceso a cuenta bloqueada: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:58:23'),
(407, 10, 'LOGIN_BLOQUEADO', 'Usuario', 10, 'Intento de acceso a cuenta bloqueada: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:58:25'),
(408, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 13:59:43'),
(409, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 13:59:55'),
(410, 10, 'LOGIN_BLOQUEADO', 'Usuario', 10, 'Intento de acceso a cuenta bloqueada: ramosjhonatan659@gmail.com', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 14:22:02'),
(411, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 14:22:29'),
(412, 1, 'ACTUALIZAR_USUARIO', 'Usuario', 10, 'Usuario actualizado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"BLOQUEADO\",\"ci\":null,\"rol_id\":2}', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/10', '2026-08-04 14:23:45'),
(413, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 14:23:54'),
(414, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 14:24:03'),
(415, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 14:26:48'),
(416, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 14:26:56'),
(417, 1, 'ACTUALIZAR_INSCRIPCION', 'Inscripcion', 17, 'Inscripción actualizada: usuario_id=15 en curso_id=1', '{\"id\":17,\"usuario_id\":15,\"curso_id\":1,\"estado\":\"PENDIENTE\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"205.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-08-03 12:04:42\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785773082_comprobante.png\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-08-03 12:04:44\",\"fecha_completado\":null}', '{\"id\":17,\"usuario_id\":15,\"curso_id\":1,\"estado\":\"ACTIVO\",\"estado_pago\":\"PENDIENTE\",\"monto_pago\":\"205.00\",\"metodo_pago\":\"QR\",\"fecha_pago\":\"2026-08-03 12:04:42\",\"comprobante_pago_url\":\"http:\\/\\/localhost:8000\\/uploads\\/comprobantes\\/1785773082_comprobante.png\",\"porcentaje_progreso\":\"0.00\",\"fecha_inscripcion\":\"2026-08-03 12:04:44\",\"fecha_completado\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/inscripciones/17', '2026-08-04 14:27:22'),
(418, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 14:27:25'),
(419, 15, 'LOGIN', 'Usuario', 15, 'Inicio de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 14:27:34'),
(420, 15, 'LOGOUT', 'Usuario', 15, 'Cierre de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 14:28:30'),
(421, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 14:28:38'),
(422, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 14:50:29'),
(423, 15, 'LOGIN', 'Usuario', 15, 'Inicio de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 14:50:40'),
(424, 15, 'LOGOUT', 'Usuario', 15, 'Cierre de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 14:52:53'),
(425, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 14:53:04'),
(426, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 14:55:14'),
(427, 15, 'LOGIN', 'Usuario', 15, 'Inicio de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 14:56:46'),
(428, 15, 'LOGOUT', 'Usuario', 15, 'Cierre de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 15:09:39'),
(429, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 15:09:50'),
(430, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 15:11:13'),
(431, 15, 'LOGIN', 'Usuario', 15, 'Inicio de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 15:16:07'),
(432, 15, 'LOGOUT', 'Usuario', 15, 'Cierre de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 17:02:53'),
(433, 10, 'LOGIN', 'Usuario', 10, 'Inicio de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 17:03:01'),
(434, 10, 'LOGOUT', 'Usuario', 10, 'Cierre de sesion: JHONATAN Ramos Collquehuanca', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 17:03:46'),
(435, 15, 'LOGIN', 'Usuario', 15, 'Inicio de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 17:04:04'),
(436, 15, 'LOGOUT', 'Usuario', 15, 'Cierre de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 17:19:11'),
(437, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 17:19:16'),
(438, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 17:21:10'),
(439, 15, 'LOGIN', 'Usuario', 15, 'Inicio de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 17:21:22'),
(440, 15, 'LOGIN_GOOGLE', 'Usuario', 15, 'Login via Google: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-08-04 18:30:32'),
(441, 15, 'LOGOUT', 'Usuario', 15, 'Cierre de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 18:53:29'),
(442, 1, 'LOGIN_FALLIDO', 'Usuario', 1, 'Contraseña incorrecta para: danielacopana@gmail.com', NULL, '{\"correo\":\"danielacopana@gmail.com\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 18:53:38'),
(443, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 18:53:50'),
(444, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 18:54:33'),
(445, 15, 'LOGIN', 'Usuario', 15, 'Inicio de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 18:54:43'),
(446, 15, 'LOGOUT', 'Usuario', 15, 'Cierre de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 19:01:11'),
(447, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 19:01:58'),
(448, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 19:08:09'),
(449, 15, 'LOGIN', 'Usuario', 15, 'Inicio de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 19:08:23'),
(450, 15, 'COMPLETAR_EVALUACION', 'IntentoEvaluacion', 11, 'Evaluación completada: evaluacion_id=1 — nota=0% — REPROBADO', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/intentos-evaluacion', '2026-08-04 19:09:46'),
(451, 15, 'LOGOUT', 'Usuario', 15, 'Cierre de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 19:10:03'),
(452, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 19:10:11'),
(453, 1, 'ACTUALIZAR_USUARIO', 'Usuario', 10, 'Usuario actualizado: JHONATAN Ramos Collquehuanca (ramosjhonatan659@gmail.com)', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":2}', '{\"nombres\":\"JHONATAN\",\"apellidos\":\"Ramos Collquehuanca\",\"correo\":\"ramosjhonatan659@gmail.com\",\"telefono\":null,\"estado\":\"ACTIVO\",\"ci\":null,\"rol_id\":4}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'PATCH', 'api/usuarios/10', '2026-08-04 19:13:04'),
(454, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 19:43:31'),
(455, 15, 'LOGIN_GOOGLE', 'Usuario', 15, 'Login via Google: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/google', '2026-08-04 19:43:46'),
(456, 15, 'LOGOUT', 'Usuario', 15, 'Cierre de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 19:44:12'),
(457, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 19:44:25'),
(458, 1, 'LOGOUT', 'Usuario', 1, 'Cierre de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 19:57:26'),
(459, 15, 'LOGIN', 'Usuario', 15, 'Inicio de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 19:57:55'),
(460, 15, 'LOGOUT', 'Usuario', 15, 'Cierre de sesion: Angelica Collquehuanca Callisaya', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/logout', '2026-08-04 19:58:19'),
(461, 1, 'LOGIN', 'Usuario', 1, 'Inicio de sesion: Homy R.', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'POST', 'api/auth/login', '2026-08-04 19:58:29'),
(462, 1, 'ELIMINAR_EVALUACION', 'Evaluacion', 2, 'Evaluación eliminada: \'Prueba de examen\' de curso_id=2', '{\"id\":2,\"curso_id\":2,\"titulo\":\"Prueba de examen\",\"descripcion\":null,\"nota_aprobacion\":\"70.00\",\"tiempo_limite\":60,\"intentos_permitidos\":2,\"fecha_creacion\":\"2026-07-30 10:24:08\"}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'DELETE', 'api/evaluaciones/2', '2026-08-04 20:04:42');

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
('enervida-lms-cache-04sal30li5adOtbe', 'a:1:{s:11:\"valid_until\";i:1785433470;}', 1786643130),
('enervida-lms-cache-06vuijfvlZLM7wFy', 'a:1:{s:11:\"valid_until\";i:1785184070;}', 1786393730),
('enervida-lms-cache-1JMGRlOdsPJzGM3q', 'a:1:{s:11:\"valid_until\";i:1785436460;}', 1786646120),
('enervida-lms-cache-1xTPntzaPzNHwBQc', 'a:1:{s:11:\"valid_until\";i:1785252640;}', 1786462180),
('enervida-lms-cache-1zHezdsSAQeTRs1B', 'a:1:{s:11:\"valid_until\";i:1785334042;}', 1786543642),
('enervida-lms-cache-24DvjpIszRixitoU', 'a:1:{s:11:\"valid_until\";i:1785505576;}', 1786715236),
('enervida-lms-cache-2BKHYx0G17uCkSqk', 'a:1:{s:11:\"valid_until\";i:1785853645;}', 1787063305),
('enervida-lms-cache-2lb6Qanp8MPP0S5u', 'a:1:{s:11:\"valid_until\";i:1785246020;}', 1786455620),
('enervida-lms-cache-2QOOTCmuSOPsscKF', 'a:1:{s:11:\"valid_until\";i:1785242126;}', 1786394667),
('enervida-lms-cache-2VmT0IDQb1Q0As8x', 'a:1:{s:11:\"valid_until\";i:1785440050;}', 1786648871),
('enervida-lms-cache-3fUo4tCT4I1Qwsbv', 'a:1:{s:11:\"valid_until\";i:1785784931;}', 1786992971),
('enervida-lms-cache-3OFMNUN0OKMEYYs5', 'a:1:{s:11:\"valid_until\";i:1785422617;}', 1786632277),
('enervida-lms-cache-3yKwzKD9iphehsIC', 'a:1:{s:11:\"valid_until\";i:1785431651;}', 1786637711),
('enervida-lms-cache-43e14pt72tm9KDtR', 'a:1:{s:11:\"valid_until\";i:1785184637;}', 1786393757),
('enervida-lms-cache-4dus0lBwmNQqOErs', 'a:1:{s:11:\"valid_until\";i:1785251013;}', 1786460673),
('enervida-lms-cache-4uOrvSsh6IETAQhH', 'a:1:{s:11:\"valid_until\";i:1785772990;}', 1786980550),
('enervida-lms-cache-5c785c036466adea360111aa28563bfd556b5fba', 'i:1;', 1785872685),
('enervida-lms-cache-5c785c036466adea360111aa28563bfd556b5fba:timer', 'i:1785872685;', 1785872685),
('enervida-lms-cache-68lcLPzJInI8KhJg', 'a:1:{s:11:\"valid_until\";i:1785345957;}', 1786546137),
('enervida-lms-cache-7IEbS2fqB8ndUmbs', 'a:1:{s:11:\"valid_until\";i:1785855173;}', 1787064713),
('enervida-lms-cache-7T5JB8LnfNwk0Dhq', 'a:1:{s:11:\"valid_until\";i:1785856273;}', 1787065873),
('enervida-lms-cache-8FDSfgrKK3heaCQg', 'a:1:{s:11:\"valid_until\";i:1785421690;}', 1786631230),
('enervida-lms-cache-8NtzFGvn50kacFer', 'a:1:{s:11:\"valid_until\";i:1785252478;}', 1786462078),
('enervida-lms-cache-8pTpMPs1qKSNXxBW', 'a:1:{s:11:\"valid_until\";i:1785422688;}', 1786632348),
('enervida-lms-cache-8ZeqjpyHCTvzG5lw', 'a:1:{s:11:\"valid_until\";i:1785175142;}', 1786384202),
('enervida-lms-cache-8zt20QJORUT7lo6d', 'a:1:{s:11:\"valid_until\";i:1785334135;}', 1786543735),
('enervida-lms-cache-94d92f976fd06fd3e8cf53ec4e03d646', 'i:2;', 1785873534),
('enervida-lms-cache-94d92f976fd06fd3e8cf53ec4e03d646:timer', 'i:1785873534;', 1785873534),
('enervida-lms-cache-94kCFO9UZmhRxik5', 'a:1:{s:11:\"valid_until\";i:1785255624;}', 1786465284),
('enervida-lms-cache-9AYzoJS0cVMTVtjZ', 'a:1:{s:11:\"valid_until\";i:1785244957;}', 1786454317),
('enervida-lms-cache-9Jf4b3sVq1G1ELBe', 'a:1:{s:11:\"valid_until\";i:1785507415;}', 1786717015),
('enervida-lms-cache-9X8ON18Fm9GyNkA8', 'a:1:{s:11:\"valid_until\";i:1785243369;}', 1786452969),
('enervida-lms-cache-a4d73cuuyuNjCv8g', 'a:1:{s:11:\"valid_until\";i:1785440129;}', 1786649729),
('enervida-lms-cache-Ad3zBSkQ3nXpDFXU', 'a:1:{s:11:\"valid_until\";i:1785252401;}', 1786462061),
('enervida-lms-cache-ADodBrRrg5TUSSyA', 'a:1:{s:11:\"valid_until\";i:1785433094;}', 1786642094),
('enervida-lms-cache-AfFv96HOTYgxphxO', 'a:1:{s:11:\"valid_until\";i:1785783230;}', 1786992770),
('enervida-lms-cache-aNay3xn3rACTHuNo', 'a:1:{s:11:\"valid_until\";i:1785419517;}', 1786629057),
('enervida-lms-cache-avTyuxgbDWb4uwEq', 'a:1:{s:11:\"valid_until\";i:1785245167;}', 1786454767),
('enervida-lms-cache-AWshUE8zIKq0syEm', 'a:1:{s:11:\"valid_until\";i:1785436508;}', 1786646168),
('enervida-lms-cache-BcVay0bqlCseeddE', 'a:1:{s:11:\"valid_until\";i:1785435861;}', 1786645461),
('enervida-lms-cache-bGLoqCafdBmVCthT', 'a:1:{s:11:\"valid_until\";i:1785243585;}', 1786453245),
('enervida-lms-cache-BMNjhrAsUWI9SSHP', 'a:1:{s:11:\"valid_until\";i:1785350527;}', 1786559707),
('enervida-lms-cache-bMYd8IP2zAtfYT4n', 'a:1:{s:11:\"valid_until\";i:1785434577;}', 1786643157),
('enervida-lms-cache-Bno1lMx19gz89QiL', 'a:1:{s:11:\"valid_until\";i:1785439177;}', 1786648837),
('enervida-lms-cache-By6kj6EXdBfZmvfd', 'a:1:{s:11:\"valid_until\";i:1785423356;}', 1786632896),
('enervida-lms-cache-ByxGHiyUKCScHKoQ', 'a:1:{s:11:\"valid_until\";i:1785785993;}', 1786995113),
('enervida-lms-cache-BzewE2av2kTNvDoX', 'a:1:{s:11:\"valid_until\";i:1785243269;}', 1786451849),
('enervida-lms-cache-c7w9moIiPOUFqPnr', 'a:1:{s:11:\"valid_until\";i:1785245888;}', 1786455488),
('enervida-lms-cache-CdnmVVTagxB8Zd4W', 'a:1:{s:11:\"valid_until\";i:1785432086;}', 1786637726),
('enervida-lms-cache-ce70bg4SJdMGwtB0', 'a:1:{s:11:\"valid_until\";i:1785252347;}', 1786462007),
('enervida-lms-cache-Ck2RGE8mPiGPi73j', 'a:1:{s:11:\"valid_until\";i:1785180966;}', 1786390506),
('enervida-lms-cache-ClBPIleKnyGlhC8p', 'a:1:{s:11:\"valid_until\";i:1785428035;}', 1786636315),
('enervida-lms-cache-ctR7YpEiKNbrsUFG', 'a:1:{s:11:\"valid_until\";i:1785437533;}', 1786646593),
('enervida-lms-cache-cX1bfd6kP7M9bCGR', 'a:1:{s:11:\"valid_until\";i:1785253332;}', 1786462332),
('enervida-lms-cache-D34YA0RpoemJoxi2', 'a:1:{s:11:\"valid_until\";i:1785419158;}', 1786626358),
('enervida-lms-cache-da8XiM86XAHHuwGG', 'a:1:{s:11:\"valid_until\";i:1785244402;}', 1786453282),
('enervida-lms-cache-DaDsk74HbS7s35uP', 'a:1:{s:11:\"valid_until\";i:1785419305;}', 1786628905),
('enervida-lms-cache-Do6QJNbuDbs3f95u', 'a:1:{s:11:\"valid_until\";i:1785780826;}', 1786987786),
('enervida-lms-cache-dsKkAZxbywzWP7K5', 'a:1:{s:11:\"valid_until\";i:1785426588;}', 1786636068),
('enervida-lms-cache-DuLk0cPpAKHeLTxo', 'a:1:{s:11:\"valid_until\";i:1785246296;}', 1786455956),
('enervida-lms-cache-efRX109sn0MQjRXT', 'a:1:{s:11:\"valid_until\";i:1785778097;}', 1786987277),
('enervida-lms-cache-enHL4nh2rnO0rxe1', 'a:1:{s:11:\"valid_until\";i:1785785424;}', 1786994664),
('enervida-lms-cache-EVI0H7tsbjP8atUq', 'a:1:{s:11:\"valid_until\";i:1785184881;}', 1786394361),
('enervida-lms-cache-FHaCL00E1DQXotzE', 'a:1:{s:11:\"valid_until\";i:1785250874;}', 1786456034),
('enervida-lms-cache-FS5z4p06gd2e53GI', 'a:1:{s:11:\"valid_until\";i:1785435754;}', 1786645414),
('enervida-lms-cache-gAXpu4QzKetPLZEf', 'a:1:{s:11:\"valid_until\";i:1785175181;}', 1786384181),
('enervida-lms-cache-ggVip3aeFctvI6Ur', 'a:1:{s:11:\"valid_until\";i:1785781273;}', 1786990513),
('enervida-lms-cache-ghxbedYg3POgTQUN', 'a:1:{s:11:\"valid_until\";i:1785175235;}', 1786384895),
('enervida-lms-cache-gNUjtHKofrC1lvWX', 'a:1:{s:11:\"valid_until\";i:1785873499;}', 1787083159),
('enervida-lms-cache-GoKguo7ftNeWmrJA', 'a:1:{s:11:\"valid_until\";i:1785433428;}', 1786643028),
('enervida-lms-cache-H8vFeFKx5rideRAJ', 'a:1:{s:11:\"valid_until\";i:1785782644;}', 1786992304),
('enervida-lms-cache-h9uzxDXSyfbbTqXy', 'a:1:{s:11:\"valid_until\";i:1785251833;}', 1786461493),
('enervida-lms-cache-hBcNc4RR5kRRjMeI', 'a:1:{s:11:\"valid_until\";i:1785423755;}', 1786633415),
('enervida-lms-cache-HEWGu8VRtqbGqCsI', 'a:1:{s:11:\"valid_until\";i:1785777092;}', 1786986392),
('enervida-lms-cache-hKJDSGEvOOwnw8HV', 'a:1:{s:11:\"valid_until\";i:1785250872;}', 1786456032),
('enervida-lms-cache-hNsxlmGTf0EDHFAL', 'a:1:{s:11:\"valid_until\";i:1785773097;}', 1786982697),
('enervida-lms-cache-HoQorQZSt66Z7z8I', 'a:1:{s:11:\"valid_until\";i:1785256011;}', 1786465311),
('enervida-lms-cache-HsHRbfNJ4eABnyWM', 'a:1:{s:11:\"valid_until\";i:1785853434;}', 1787063034),
('enervida-lms-cache-HzdhhA8KFsmZz3HG', 'a:1:{s:11:\"valid_until\";i:1785251808;}', 1786460748),
('enervida-lms-cache-IakNxeADqFsyo2ML', 'a:1:{s:11:\"valid_until\";i:1785422416;}', 1786631416),
('enervida-lms-cache-Iew9BJ5LNcIQFFbf', 'a:1:{s:11:\"valid_until\";i:1785246197;}', 1786455857),
('enervida-lms-cache-ISwAKO1B2dXop053', 'a:1:{s:11:\"valid_until\";i:1785421461;}', 1786630881),
('enervida-lms-cache-J4snKtqGoJBWYh62', 'a:1:{s:11:\"valid_until\";i:1785423184;}', 1786632664),
('enervida-lms-cache-jnEApKM657MZvsnn', 'a:1:{s:11:\"valid_until\";i:1785863951;}', 1787072711),
('enervida-lms-cache-JPQIqK8zLAdi3Uu6', 'a:1:{s:11:\"valid_until\";i:1785419786;}', 1786629206),
('enervida-lms-cache-JqBxvBaa1XLQCACQ', 'a:1:{s:11:\"valid_until\";i:1785246228;}', 1786455888),
('enervida-lms-cache-JQynyJ9l82NtYeof', 'a:1:{s:11:\"valid_until\";i:1785872652;}', 1787082312),
('enervida-lms-cache-jV1GqTjZxSp1S8Ok', 'a:1:{s:11:\"valid_until\";i:1785246088;}', 1786455748),
('enervida-lms-cache-KGxCo3U2b72xGB82', 'a:1:{s:11:\"valid_until\";i:1785870603;}', 1787080203),
('enervida-lms-cache-KK2jA12sycPVHUMi', 'a:1:{s:11:\"valid_until\";i:1785244459;}', 1786454119),
('enervida-lms-cache-KL104wrUXdSfID1M', 'a:1:{s:11:\"valid_until\";i:1785850665;}', 1787060325),
('enervida-lms-cache-kp0nKDBxSGBfaFMH', 'a:1:{s:11:\"valid_until\";i:1785421536;}', 1786631136),
('enervida-lms-cache-kpiLUdUXSrSerLK4', 'a:1:{s:11:\"valid_until\";i:1785438758;}', 1786648118),
('enervida-lms-cache-kZGvTPwxn6On5RkL', 'a:1:{s:11:\"valid_until\";i:1785853710;}', 1787063370),
('enervida-lms-cache-L0IFXP7k4ylunfxt', 'a:1:{s:11:\"valid_until\";i:1785433296;}', 1786642896),
('enervida-lms-cache-LPkMXrWM32cRK3VQ', 'a:1:{s:11:\"valid_until\";i:1785507323;}', 1786715303),
('enervida-lms-cache-lvxbVMsASNZz8hgQ', 'a:1:{s:11:\"valid_until\";i:1785422577;}', 1786632237),
('enervida-lms-cache-LXwtznZTYrW540WN', 'a:1:{s:11:\"valid_until\";i:1785245765;}', 1786455005),
('enervida-lms-cache-lxxDXMyQCOnmWXLe', 'a:1:{s:11:\"valid_until\";i:1785863026;}', 1787072686),
('enervida-lms-cache-lzSqzwfHqxea1lAB', 'a:1:{s:11:\"valid_until\";i:1785250945;}', 1786460605),
('enervida-lms-cache-mgYwFB83Rx42OAa4', 'a:1:{s:11:\"valid_until\";i:1785855314;}', 1787064854),
('enervida-lms-cache-mn2XBQer1DKaaWFd', 'a:1:{s:11:\"valid_until\";i:1785254675;}', 1786463015),
('enervida-lms-cache-mPrOokvsikN0Y4R3', 'a:1:{s:11:\"valid_until\";i:1785873446;}', 1787082326),
('enervida-lms-cache-mSho5iLdpJAvZXxF', 'a:1:{s:11:\"valid_until\";i:1785782870;}', 1786992470),
('enervida-lms-cache-msSxfp1V2mKridsP', 'a:1:{s:11:\"valid_until\";i:1785245057;}', 1786454717),
('enervida-lms-cache-MzYWLWmgKqeaB5TI', 'a:1:{s:11:\"valid_until\";i:1785243527;}', 1786453067),
('enervida-lms-cache-NiAElLKk4vfnC323', 'a:1:{s:11:\"valid_until\";i:1785420975;}', 1786630515),
('enervida-lms-cache-nOU6Ws2a601Pmnuz', 'a:1:{s:11:\"valid_until\";i:1785184000;}', 1786393600),
('enervida-lms-cache-noz34zqtlHw6RMUc', 'a:1:{s:11:\"valid_until\";i:1785175172;}', 1786384172),
('enervida-lms-cache-NZdmaoebPGWLrLDf', 'a:1:{s:11:\"valid_until\";i:1785174884;}', 1786384184),
('enervida-lms-cache-oDlfr8DVSaA4qusJ', 'a:1:{s:11:\"valid_until\";i:1785420793;}', 1786629493),
('enervida-lms-cache-OGB8uuT8wb17wAJQ', 'a:1:{s:11:\"valid_until\";i:1785174945;}', 1786384185),
('enervida-lms-cache-oQJRBGLQzldM6SGH', 'a:1:{s:11:\"valid_until\";i:1785349627;}', 1786555687),
('enervida-lms-cache-OXClLLuGf1XptAvz', 'a:1:{s:11:\"valid_until\";i:1785345953;}', 1786546133),
('enervida-lms-cache-P0EDk8rlVPApTKlE', 'a:1:{s:11:\"valid_until\";i:1785255508;}', 1786464388),
('enervida-lms-cache-pLaOLE0rdNk7LVae', 'a:1:{s:11:\"valid_until\";i:1785246129;}', 1786455789),
('enervida-lms-cache-pLKo8LDE9KhwWCt5', 'a:1:{s:11:\"valid_until\";i:1785862973;}', 1787069813),
('enervida-lms-cache-QcolqVApuSRxDFi7', 'a:1:{s:11:\"valid_until\";i:1785177392;}', 1786384952),
('enervida-lms-cache-qD19f4eQnzZ5lc6r', 'a:1:{s:11:\"valid_until\";i:1785433163;}', 1786642823),
('enervida-lms-cache-qpHG5dm63oBLOfuJ', 'a:1:{s:11:\"valid_until\";i:1785439146;}', 1786648566),
('enervida-lms-cache-QTK53r3careKNctk', 'a:1:{s:11:\"valid_until\";i:1785864070;}', 1787073670),
('enervida-lms-cache-qZNA3hLjO9lS0GI8', 'a:1:{s:11:\"valid_until\";i:1785350811;}', 1786560231),
('enervida-lms-cache-RdMXkWL8QITPX0gw', 'a:1:{s:11:\"valid_until\";i:1785782965;}', 1786992565),
('enervida-lms-cache-RHJbntfyGAy8W5t4', 'a:1:{s:11:\"valid_until\";i:1785432215;}', 1786641815),
('enervida-lms-cache-RHo2reHFtjYQypEA', 'a:1:{s:11:\"valid_until\";i:1785870489;}', 1787079789),
('enervida-lms-cache-riwDAGCdyCHXe0Iu', 'a:1:{s:11:\"valid_until\";i:1785259329;}', 1786465989),
('enervida-lms-cache-rsgCO8hnVovx6bWW', 'a:1:{s:11:\"valid_until\";i:1785251891;}', 1786461551),
('enervida-lms-cache-RyhquUagUNayMCjF', 'a:1:{s:11:\"valid_until\";i:1785252295;}', 1786461595),
('enervida-lms-cache-S8SpZnFkYHmTduh5', 'a:1:{s:11:\"valid_until\";i:1785438044;}', 1786647704),
('enervida-lms-cache-sHJJtNn6ROe9xmmf', 'a:1:{s:11:\"valid_until\";i:1785421737;}', 1786631397),
('enervida-lms-cache-SjBvqeXIitVDJdQU', 'a:1:{s:11:\"valid_until\";i:1785340183;}', 1786546123),
('enervida-lms-cache-SmjyfRbUCkLoX55h', 'a:1:{s:11:\"valid_until\";i:1785851995;}', 1787061655),
('enervida-lms-cache-sMNmQbdqeYBoaqH8', 'a:1:{s:11:\"valid_until\";i:1785442103;}', 1786651103),
('enervida-lms-cache-StBm02PGSLPVGyrg', 'a:1:{s:11:\"valid_until\";i:1785426367;}', 1786634047),
('enervida-lms-cache-SUp1fgCkRTe73kwn', 'a:1:{s:11:\"valid_until\";i:1785175067;}', 1786384187),
('enervida-lms-cache-T0oODOOi7wZClRZi', 'a:1:{s:11:\"valid_until\";i:1785175006;}', 1786384186),
('enervida-lms-cache-tAVojUGyE06HLo9d', 'a:1:{s:11:\"valid_until\";i:1785869609;}', 1787077949),
('enervida-lms-cache-tL6Q6rF3TIPvFVwF', 'a:1:{s:11:\"valid_until\";i:1785245210;}', 1786454870),
('enervida-lms-cache-tnyHmNVNU9iCduG2', 'a:1:{s:11:\"valid_until\";i:1785246342;}', 1786456002),
('enervida-lms-cache-TsLjZ19llF3Sq5Qg', 'a:1:{s:11:\"valid_until\";i:1785422647;}', 1786632307),
('enervida-lms-cache-Tv268qeq8uTjmnQt', 'a:1:{s:11:\"valid_until\";i:1785525713;}', 1786732734),
('enervida-lms-cache-TwRIklmN3qAJ2aAa', 'a:1:{s:11:\"valid_until\";i:1785183889;}', 1786390669),
('enervida-lms-cache-uEF0RBRDGuhayNpv', 'a:1:{s:11:\"valid_until\";i:1785853608;}', 1787063148),
('enervida-lms-cache-umvJddSsxkraWxs1', 'a:1:{s:11:\"valid_until\";i:1785175121;}', 1786384181),
('enervida-lms-cache-UT9s7dAmUGEpJQp4', 'a:1:{s:11:\"valid_until\";i:1785251057;}', 1786460717),
('enervida-lms-cache-UusnWIir71aRTk3c', 'a:1:{s:11:\"valid_until\";i:1785251916;}', 1786461576),
('enervida-lms-cache-V3O0wLdtyu1JdGvu', 'a:1:{s:11:\"valid_until\";i:1785440944;}', 1786650424),
('enervida-lms-cache-Vbk9kavKfQT5hZFp', 'a:1:{s:11:\"valid_until\";i:1785438118;}', 1786647778),
('enervida-lms-cache-VCul6qRQX07Oad4a', 'a:1:{s:11:\"valid_until\";i:1785422963;}', 1786632503),
('enervida-lms-cache-VJcVFxw5HaCgKM14', 'a:1:{s:11:\"valid_until\";i:1785783249;}', 1786992909),
('enervida-lms-cache-VmjDAIXq8Dcct8AX', 'a:1:{s:11:\"valid_until\";i:1785245292;}', 1786454892),
('enervida-lms-cache-VMzwBNraecjq5EgW', 'a:1:{s:11:\"valid_until\";i:1785419359;}', 1786629019),
('enervida-lms-cache-VnEU0TnJ8F3Y9rib', 'a:1:{s:11:\"valid_until\";i:1785783056;}', 1786992656),
('enervida-lms-cache-wRWfIBSHVGrOZJzi', 'a:1:{s:11:\"valid_until\";i:1785777588;}', 1786986828),
('enervida-lms-cache-Wx9fqJTLrRIel80B', 'a:1:{s:11:\"valid_until\";i:1785784945;}', 1786994605),
('enervida-lms-cache-wY7Mr0zRpvH0i3qS', 'a:1:{s:11:\"valid_until\";i:1785870071;}', 1787079371),
('enervida-lms-cache-x2vZkmgXPi4iuoEK', 'a:1:{s:11:\"valid_until\";i:1785856179;}', 1787065119),
('enervida-lms-cache-xDSVwJBUW0X0GeiJ', 'a:1:{s:11:\"valid_until\";i:1785256193;}', 1786465853),
('enervida-lms-cache-xM3EXMksxLxIjhIr', 'a:1:{s:11:\"valid_until\";i:1785869673;}', 1787079333),
('enervida-lms-cache-Xo4qM2H509Ka4jbS', 'a:1:{s:11:\"valid_until\";i:1785436563;}', 1786646223),
('enervida-lms-cache-y16AGScTKC5Ga6nq', 'a:1:{s:11:\"valid_until\";i:1785180810;}', 1786387350),
('enervida-lms-cache-yEiHpmzkLn25SIO2', 'a:1:{s:11:\"valid_until\";i:1785855029;}', 1787063429),
('enervida-lms-cache-YeKdiBcGkg0CcviE', 'a:1:{s:11:\"valid_until\";i:1785256169;}', 1786465709),
('enervida-lms-cache-yGVfVkyV0eHnltTk', 'a:1:{s:11:\"valid_until\";i:1785872611;}', 1787080291),
('enervida-lms-cache-yiWEfsFIq6etRPRG', 'a:1:{s:11:\"valid_until\";i:1785441279;}', 1786650699),
('enervida-lms-cache-YiwnaeWSADSTSc16', 'a:1:{s:11:\"valid_until\";i:1785422816;}', 1786632416),
('enervida-lms-cache-YVoZST9qTQvx9Khv', 'a:1:{s:11:\"valid_until\";i:1785184944;}', 1786394604),
('enervida-lms-cache-yxWh32szTvi9Lpo5', 'a:1:{s:11:\"valid_until\";i:1785444515;}', 1786654115),
('enervida-lms-cache-z1sPgG1EFRUkcZYh', 'a:1:{s:11:\"valid_until\";i:1785255594;}', 1786465254),
('enervida-lms-cache-Zc11mnzb6oKyGY6J', 'a:1:{s:11:\"valid_until\";i:1785441413;}', 1786651013),
('enervida-lms-cache-ZC1pipmWuGuHVuVk', 'a:1:{s:11:\"valid_until\";i:1785433205;}', 1786642865),
('enervida-lms-cache-Zq2ft0D9uyji6Fsm', 'a:1:{s:11:\"valid_until\";i:1785782618;}', 1786990958);

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
(1, 'General', 'Categoría creada automáticamente', '2026-07-27 18:42:57'),
(2, 'Vivenciales', 'Experiencias presenciales en La Casa Solar de ENERVIDA. Aprende tocando, viendo y experimentando la energía solar en acción.', '2026-07-27 19:22:55'),
(3, 'Online', 'Energía solar aplicada a todos los sectores. Aprende a tu ritmo desde cualquier lugar.', '2026-07-27 19:23:12'),
(4, 'Técnicos', 'Especialización avanzada en diseño, dimensionamiento e implementación de sistemas solares profesionales.', '2026-07-27 19:24:08');

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
(9, 12, 1, 'EV01260001', '', '2026-07-30 17:43:15'),
(10, 13, 1, 'EV01260002', '', '2026-07-30 19:56:21'),
(11, 15, 1, 'EV01260003', '', '2026-08-04 19:55:58');

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
(1, 1, 'Plantilla - EnerVivencial', 'http://localhost:8000/uploads/general/1785182699_anverso-1.jpg', '{\"elements\":[{\"id\":\"5tokvwqqems3nov13\",\"type\":\"text\",\"x\":131.7955172413793,\"y\":259.36,\"content\":\"{{estudiante}}\",\"size\":25,\"width\":658.5113793103449,\"height\":29.263793103448275,\"color\":\"#e2762b\",\"fontFamily\":\"Courier New, Courier, monospace\",\"bold\":true,\"italic\":false,\"textAlign\":\"left\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false},{\"id\":\"5wlu72kvjms3nskka\",\"type\":\"text\",\"x\":106.91206896551724,\"y\":333.62793103448274,\"content\":\"{{curso}}\",\"size\":25,\"width\":612.8917241379311,\"height\":50,\"color\":\"#e2762b\",\"fontFamily\":\"Courier New, Courier, monospace\",\"bold\":true,\"italic\":false,\"textAlign\":\"center\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false},{\"id\":\"beim70caqms3nvndq\",\"type\":\"text\",\"x\":192.4161025940287,\"y\":398.9741476335948,\"content\":\"{{fecha}}\",\"size\":14,\"width\":124.4800970256028,\"height\":20,\"color\":\"#e2762b\",\"fontFamily\":\"Helvetica\",\"bold\":true,\"italic\":false,\"textAlign\":\"left\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false},{\"id\":\"b3gs7jovkms3nz5zr\",\"type\":\"text\",\"x\":513.5280042005613,\"y\":397.27260514830505,\"content\":\"20\",\"size\":14,\"width\":59.95636660210016,\"height\":21.39055969008054,\"color\":\"#e2762b\",\"fontFamily\":\"Helvetica\",\"bold\":true,\"italic\":false,\"textAlign\":\"left\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false},{\"id\":\"mwutb1roims3o1rqn\",\"type\":\"qr\",\"x\":716.2194067750825,\"y\":455.2196228861635,\"size\":89.67637365605921,\"width\":89.67637365605921,\"height\":89.67637365605921,\"rotate\":0,\"opacity\":100},{\"id\":\"ulv6qhy6gms3o4sz0\",\"type\":\"text\",\"x\":718.1261570006444,\"y\":547.8091501651471,\"content\":\"{{codigo}}\",\"size\":14,\"width\":84.95015062199525,\"height\":50,\"color\":\"#1a1a1a\",\"fontFamily\":\"Helvetica\",\"bold\":true,\"italic\":false,\"textAlign\":\"left\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false}],\"logicalWidth\":841.89,\"logicalHeight\":595.28,\"selectedFormat\":\"A4\",\"orientation\":\"landscape\"}', '2026-07-27 20:20:18', '2026-07-28 16:05:50'),
(2, 2, 'Plantilla - Bombeo Solar', 'http://localhost:8000/uploads/general/1785873952_plantilla-certificado.jpg', '{\"elements\":[{\"id\":\"igc5aezltmsf3amfa\",\"type\":\"text\",\"x\":131.74547511312218,\"y\":253.64809954751132,\"content\":\"{{estudiante}}\",\"size\":32,\"width\":643.8052488687783,\"height\":50,\"color\":\"#e2762b\",\"fontFamily\":\"Helvetica\",\"bold\":false,\"italic\":false,\"textAlign\":\"left\",\"letterSpacing\":0,\"rotate\":0,\"opacity\":100,\"locked\":false,\"hidden\":false}],\"logicalWidth\":841.89,\"logicalHeight\":595.28,\"selectedFormat\":\"A4\",\"orientation\":\"landscape\"}', '2026-08-04 20:08:00', '2026-08-04 20:10:05');

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

--
-- Volcado de datos para la tabla `clases_en_vivo`
--

INSERT INTO `clases_en_vivo` (`id`, `curso_id`, `titulo`, `descripcion`, `sala_jitsi`, `fecha_inicio`, `fecha_fin`, `creado_por`, `fecha_creacion`) VALUES
(1, 1, 'Clase de prueba', 'oihcuibcscsd', 'Enervida-Aula-609', '2026-07-30 20:54:00', NULL, 10, '2026-07-30 13:54:48');

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
(1, 1, 1, 'EnerVivencial', 'EV', 'Experiencia técnica 100% práctica en campo para aprender el diseño, montaje y funcionamiento real de sistemas de energía solar en las instalaciones de Enervida.', 'Aprende energía solar mediante una inmersión práctica en nuestras instalaciones. EnerVivencial está diseñado para que experimentes de primera mano el funcionamiento, instalación y mantenimiento de sistemas fotovoltaicos en un entorno real.\n\n¿Qué aprenderás en este curso?\n• Práctica real en campo: Manipulación directa de paneles solares, inversores, controladores y bancos de baterías.\n• Montaje e instalación: Pasos clave para el cableado, conexionado seguro y montaje de estructuras.\n• Diagnóstico y mediciones: Uso de herramientas de medición para evaluar rendimiento, voltaje y corriente en tiempo real.\n• Mantenimiento y resolución de fallas: Identificación de problemas comunes y técnicas de mantenimiento preventivo.\n• Aplicación de tecnologías sostenibles: Integración de la energía solar con proyectos ecológicos.\n\n¿A quién está dirigido?\nEstudiantes, técnicos, ingenieros y entusiastas de las energías renovables que busquen adquirir experiencia práctica directa.', 'http://localhost:8000/uploads/general/1785181049_679475974-1577547564376963-2848436857219950621-n.jpg', 'Todos', 'Hibrido', 1, 1, 205.00, '2026-07-27 18:48:05', '2026-07-30 14:14:39', 1),
(2, 1, 1, 'Bombeo Solar', 'bombeo-solar', 'Aprende a diseñar, dimensionar e instalar sistemas de bombeo de agua alimentados por energía solar fotovoltaica para aplicaciones agrícolas, ganaderas y comunitarias.', 'Capacitación técnica especializada en la selección, diseño y puesta en marcha de sistemas de bombeo solar fotovoltaico. Aprenderás a aprovechar la energía solar para el suministro de agua eficiente en zonas rurales o aisladas de la red eléctrica.\n\n¿Qué aprenderás en este curso?\n• Fundamentos hidráulicos y solares: Cálculo de caudales, altura dinámica total (ADT) y radiación solar disponible.\n• Selección de equipos: Criterios para elegir bombas sumergibles/superficiales, variadores de frecuencia y controladores solares.\n• Dimensionamiento del sistema: Cálculo preciso de la potencia requerida en paneles fotovoltaicos y estructuras.\n• Instalación y conexiones: Montaje eléctrico y mecánico de bombas solares y sistemas de protección.\n• Mantenimiento y optimización: Diagnóstico de fallas, mantenimiento preventivo y buenas prácticas en campo.\n\n¿A quién está dirigido?\nTécnicos, ingenieros, proyectistas, agricultores y profesionales del sector agropecuario o energético interesados en soluciones de bombeo sostenible.', 'http://localhost:8000/uploads/general/1785179871_bombeo-solar.png', 'Todos', 'Hibrido', 1, 1, 150.00, '2026-07-27 18:49:13', '2026-07-27 19:17:56', 1),
(3, 2, 1, 'Sistemas Fotovoltaicos', 'sistemas-fotovoltaicos', 'Capacitación integral en el diseño, dimensionamiento e instalación de sistemas solares fotovoltaicos aislados y conectados a la red eléctrica.', 'Curso teórico-práctico diseñado para brindar los conocimientos técnicos necesarios en el cálculo, selección de componentes e instalación de sistemas solares fotovoltaicos para uso residencial, comercial e industrial.\n\n¿Qué aprenderás en este curso?\n• Principios de la energía solar: Radiación solar, geometría solar y evaluación del recurso en sitio.\n• Componentes del sistema: Funcionamiento y selección de paneles fotovoltaicos, inversores, reguladores de carga y baterías.\n• Dimensionamiento de sistemas: Cálculo de cargas energéticas para sistemas aislados (off-grid) y conectados a la red (on-grid).\n• Instalación y normativa: Criterios de montaje de estructuras, cableado, protecciones eléctricas y seguridad laboral.\n• Pruebas y puesta en marcha: Mediciones de rendimiento, verificación de funcionamiento y mantenimiento preventivo.\n\n¿A quién está dirigido?\nElectricistas, técnicos, ingenieros, estudiantes y emprendedores que deseen capacitarse en la implementación de proyectos de energía solar fotovoltaica.', 'http://localhost:8000/uploads/general/1785180302_sistemas-fotovoltaicos.png', 'Todos', 'Hibrido', 1, 1, 300.00, '2026-07-27 18:50:01', '2026-08-03 16:06:18', 1),
(4, 1, 1, 'EnerVirtual', 'enervirtual', 'Programa de formación 100% online sobre energías renovables y sostenibilidad, dictado a través de nuestra plataforma e-learning interactiva.', 'Capacitación técnica flexible y accesible diseñada para aprender sobre energía solar, eficiencia energética y tecnologías limpias desde cualquier lugar y a tu propio ritmo mediante el campus virtual de Enervida.\n\n¿Qué aprenderás en este curso?\n• Conceptos fundamentales: Introducción a las energías renovables, sistemas fotovoltaicos y desarrollo sostenible.\n• Contenido multimedia interactivo: Acceso a videoclases, guías descargables, estudios de caso y material complementario.\n• Software y herramientas digitales: Introducción a la simulación y dimensionamiento virtual de proyectos energéticos.\n• Evaluación y acompañamiento: Cuestionarios interactivos, tareas prácticas y soporte para la resolución de dudas.\n• Proyectos aplicados: Elaboración de propuestas técnicas orientadas a casos reales de eficiencia y sostenibilidad.\n\n¿A quién está dirigido?\nEstudiantes, profesionales y apasionados de las energías limpias que buscan capacitarse a distancia de forma autónoma e interactiva.', 'http://localhost:8000/uploads/general/1785180680_enervirtual.png', 'Todos', 'Hibrido', 1, 1, 250.00, '2026-07-27 18:50:49', '2026-07-27 19:31:29', 1),
(5, 1, 1, 'Curso PVsyst', 'curso-pvsyst', 'Aprende a simular, diseñar y analizar el rendimiento de sistemas fotovoltaicos utilizando PVsyst, el software profesional estándar de la industria solar.', 'Capacitación especializada en el uso del software PVsyst para el modelado preciso y la simulación técnica de proyectos fotovoltaicos interconectados a la red, aislados y de bombeo solar.\n\n¿Qué aprenderás en este curso?\n• Configuración y datos meteorológicos: Importación y gestión de bases de datos de radiación solar y ubicaciones geográficas.\n• Diseño y dimensionamiento en PVsyst: Selección de módulos, inversores, configuración de strings y compatibilidad eléctrica.\n• Análisis de pérdidas del sistema: Evaluación de sombreados, pérdidas por temperatura, cableado y ensuciamiento de paneles.\n• Interpretación de reportes: Análisis de producción de energía, factores de rendimiento (PR) y generación de informes técnicos.\n• Simulación 3D: Creación de escenas en tres dimensiones para evaluar sombreados cercanos y optimizar la disposición de módulos.\n\n¿A quién está dirigido?\nIngenieros, proyectistas, consultores y técnicos del sector solar que busquen certificar sus diseños y simulaciones energéticas con estándar internacional.', 'http://localhost:8000/uploads/general/1785180739_curso-pvsyst.png', 'Todos', 'Hibrido', 1, 1, 250.00, '2026-07-27 18:51:33', '2026-07-27 19:32:23', 1),
(6, 1, 1, 'Generación Distribuida', 'generaci-n-distribuida', 'Aprende los aspectos técnicos, normativos y económicos para la integración de sistemas de autoconsumo e inyección de energía solar a la red eléctrica.', 'Capacitación especializada en el concepto de generación distribuida y autoconsumo solar. Aprenderás a diseñar e integrar sistemas fotovoltaicos conectados a la red bajo la normativa vigente y los esquemas de compensación energética.\n\n¿Qué aprenderás en este curso?\n• Fundamentos de Generación Distribuida: Conceptos de autoconsumo, inyección a la red y balance neto (Net Metering).\n• Normativa y marco legal: Requisitos técnicos, trámites y procesos de interconexión con las empresas distribuidoras de electricidad.\n• Dimensionamiento orientado al autoconsumo: Análisis de curvas de demanda eléctrica para optimizar la potencia a instalar.\n• Protección y calidad de energía: Inversores de red, protecciones anti-isla, sincronización y seguridad en la instalación.\n• Viabilidad económica y financiera: Cálculo de retornos de inversión, ahorro energético y análisis costo-beneficio de los proyectos.\n\n¿AQuién está dirigido?\nIngenieros, proyectistas, técnicos electricistas, consultores y emprendedores interesados en desarrollar e interconectar proyectos solares a la red eléctrica.', 'http://localhost:8000/uploads/general/1785180998_generacion-distribuida.png', 'Todos', 'Hibrido', 1, 1, 150.00, '2026-07-27 18:52:19', '2026-07-27 19:36:42', 1),
(7, 1, 1, 'Eficiencia Energética', 'eficiencia-energ-tica', 'Aprende a diagnosticar, gestionar y optimizar el consumo de energía en instalaciones residenciales, comerciales e industriales para reducir costos y emisiones.', 'Capacitación práctica orientada al análisis del uso de la energía, identificación de desperdicios y diseño de estrategias de ahorro y optimización energética para mejorar la competitividad y sostenibilidad.\n\n¿Qué aprenderás en este curso?\n• Auditorías energéticas: Métodos de inspección, medición y diagnóstico de consumo de energía eléctrica y térmica.\n• Indicadores de desempeño energético: Definición de líneas base de consumo y métricas de eficiencia.\n• Optimización de sistemas clave: Buenas prácticas en sistemas de iluminación, climatización, motores y equipos de potencia.\n• Gestión de la demanda: Estrategias para la reducción de picos de consumo y corrección del factor de potencia.\n• Evaluación económica: Análisis de retorno de inversión para medidas de ahorro y eficiencia energética.\n\n¿A quién está dirigido?\nTécnicos, ingenieros, gestores de mantenimiento, consultores y profesionales interesados en reducir costos operativos mediante el uso eficiente de la energía.', NULL, 'Todos', 'Hibrido', 1, 0, 250.00, '2026-07-27 18:52:58', NULL, 1),
(8, 1, 1, 'Huella de Carbono', 'huella-de-carbono', 'Aprende a medir, reportar y gestionar la huella de carbono en organizaciones y productos para implementar estrategias efectivas de mitigación ambiental.', 'Capacitación especializada en las metodologías y herramientas para el cálculo de emisiones de gases de efecto invernadero (GEI). Orientado a la cuantificación del impacto ambiental y al diseño de planes de reducción y neutralidad de carbono.\n\n¿Qué aprenderás en este curso?\n• Fundamentos y cambio climático: Conceptos clave de gases de efecto invernadero (GEI) y marcos normativos (ISO 14064, Protocolo GHG).\n• Identificación de alcance: Clasificación de emisiones en Alcance 1 (directas), Alcance 2 (indirectas por energía) y Alcance 3 (cadena de valor).\n• Metodología de cálculo: Recopilación de datos de actividad, aplicación de factores de emisión y estimación de la huella.\n• Estrategias de reducción: Planes de mitigación, eficiencia energética, uso de energías renovables y compensación de carbono.\n• Elaboración de informes: Estructuración de reportes de sostenibilidad y preparación para procesos de verificación.\n\n¿A quién está dirigido?\nConsultores ambientales, ingenieros, gestores de sostenibilidad, auditores y profesionales interesados en la gestión ambiental y descarbonización empresarial.', NULL, 'Todos', 'Hibrido', 1, 0, 0.00, '2026-07-27 18:53:31', NULL, 1),
(9, 1, 1, 'Sostenibilidad Aplicada', 'sostenibilidad-aplicada', 'Aprende a integrar criterios socioambientales, economía circular y modelos sostenibles en la gestión de proyectos, empresas y comunidades.', 'Capacitación práctica enfocada en transformar conceptos de desarrollo sostenible en acciones concretas. Aprenderás a diseñar, implementar y evaluar estrategias que equilibren el impacto ambiental, la viabilidad económica y el bienestar social.\n\n¿Qué aprenderás en este curso?\n• Principios de desarrollo sostenible: Análisis de los Objetivos de Desarrollo Sostenible (ODS) y su aplicación práctica.\n• Economía circular y residuos: Estrategias de reducción, reutilización, reciclaje y ciclo de vida de productos/servicios.\n• Diagnóstico y métricas socioambientales: Herramientas para evaluar el impacto de proyectos y definir indicadores de sostenibilidad.\n• Gestión e innovación sostenible: Implementación de prácticas ecológicas en procesos productivos y cadenas de suministro.\n• Formulación de proyectos verdes: Diseño de propuestas sostenibles aptas para financiamiento e inversión responsable.\n\n¿A quién está dirigido?\nEmprendedores, consultores, profesionales de proyectos, gestores ambientales y líderes comunitarios que busquen aplicar la sostenibilidad de forma práctica y rentable.', NULL, 'Todos', 'Hibrido', 1, 0, 300.00, '2026-07-27 18:54:19', NULL, 1),
(10, 1, 1, 'Construcción Sostenible', 'construcci-n-sostenible', 'Aprende criterios de arquitectura bioclimática, eficiencia energética y uso de materiales ecológicos para el diseño y edificación de construcciones sostenibles.', 'Capacitación orientada a la integración de prácticas sostenibles en la planificación, diseño y ejecución de obras de construcción. Aprenderás a minimizar el impacto ambiental de las edificaciones optimizando recursos naturales y reduciendo el consumo energético.\n\n¿Qué aprenderás en este curso?\n• Principios de arquitectura bioclimática: Orientación, ventilación natural, asoleamiento e iluminación eficiente para confort térmico.\n• Materiales ecoeficientes: Selección de materiales de bajo impacto ambiental, reciclados, locales y de alta eficiencia térmica.\n• Eficiencia hídrica y energética: Sistemas de captación de agua de lluvia, tratamiento de aguas grises e integración de energías renovables.\n• Certificaciones y estándares verdes: Introducción a marcos de evaluación de sostenibilidad en edificación (como EDGE o LEED).\n• Gestión de residuos de construcción: Estrategias para la reducción, separación y manejo responsable de escombros en obra.\n\n¿A quién está dirigido?\nArquitectos, ingenieros civiles, constructores, estudiantes y profesionales del sector inmobiliario interesados en la edificación ecológica y sostenible.', NULL, 'Todos', 'Hibrido', 1, 0, 400.00, '2026-07-27 18:54:59', NULL, 1),
(11, 1, 1, 'Modelo SAPIENS Solar', 'modelo-sapiens-solar', 'Aprende la metodología SAPIENS para la planificación, estructuración y ejecución integral de proyectos de energía solar sostenibles y de alto impacto.', 'Capacitación especializada en la metodología SAPIENS aplicada a la energía solar. Un enfoque estructurado que combina diagnóstico, diseño técnico, viabilidad socioeconómica y sostenibilidad a largo plazo para garantizar el éxito de proyectos fotovoltaicos.\n\n¿Qué aprenderás en este curso?\n• Fundamentos del Modelo SAPIENS: Principios, pilares y metodología paso a paso aplicada al desarrollo de proyectos solares.\n• Diagnóstico territorial y de necesidades: Evaluación del contexto social, técnico y ambiental para una solución a medida.\n• Planificación y diseño integral: Selección de tecnologías, dimensionamiento adecuado y gestión de recursos energéticos.\n• Viabilidad económica y sostenibilidad: Estrategias de financiamiento, retorno de inversión y modelos de operación continua.\n• Gestión y puesta en marcha: Control de ejecución, indicadores de rendimiento y transferencia de conocimientos a la comunidad o cliente.\n\n¿A quién está dirigido?\nIngenieros, proyectistas, consultores, gestores de proyectos de desarrollo y profesionales interesados en metodologías estructuradas para soluciones solares.', NULL, 'Todos', 'Hibrido', 1, 0, 190.00, '2026-07-27 18:55:57', NULL, 1),
(12, 1, 1, 'Lombricultura', 'lombricultura', 'Aprende a transformar residuos orgánicos en humus de lombriz de alta calidad para la regeneración de suelos y la agricultura sostenible.', 'Capacitación práctica enfocada en el manejo, cría y reproducción de la lombriz roja californiana para la producción de abonos orgánicos. Un enfoque integral para aprovechar residuos, mejorar la fertilidad del suelo y promover prácticas de economía circular.\n\n¿Qué aprenderás en este curso?\n• Biología y comportamiento: Ciclo de vida, requerimientos ambientales y alimentación de la lombriz roja californiana.\n• Diseño y preparación de vermicomposteras: Construcción, acondicionamiento y mantenimiento de camas o lechos de cultivo.\n• Manejo de sustratos y alimentación: Selección y preparación adecuada de residuos orgánicos para evitar fermentaciones indeseadas.\n• Control de parámetros clave: Monitoreo de humedad, temperatura, pH, aireación y control de plagas o depredadores.\n• Cosecha y aplicación de productos: Métodos de extracción de humus sólido y lixiviado (biol), y su uso como fertilizante natural.\n\n¿AQuién está dirigido?\nAgricultores, horticultores, emprendedores ecológicos, educadores ambientales y cualquier persona interesada en el reciclaje de residuos orgánicos y la fertilización natural.', NULL, 'Todos', 'Hibrido', 1, 0, 100.00, '2026-07-27 18:56:41', NULL, 1);

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
(10, 10, 'Computadora', 'Windows 10/11', 'Chrome', '06606101dcf37c0e67adb1071e8a548d', '127.0.0.1', 1, '2026-08-04 17:03:01', '2026-07-30 13:48:51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(13, 12, 'Computadora', 'Windows 10/11', 'Chrome', '06606101dcf37c0e67adb1071e8a548d', '127.0.0.1', 1, '2026-08-03 18:49:38', '2026-07-30 17:38:28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(14, 13, 'Computadora', 'Windows 10/11', 'Chrome', '06606101dcf37c0e67adb1071e8a548d', '127.0.0.1', 1, '2026-07-30 19:55:50', '2026-07-30 19:14:36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(15, 14, 'Computadora', 'Windows 10/11', 'Chrome', '06606101dcf37c0e67adb1071e8a548d', '127.0.0.1', 1, '2026-07-31 14:15:52', '2026-07-31 14:15:52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(16, 15, 'Computadora', 'Windows 10/11', 'Chrome', '06606101dcf37c0e67adb1071e8a548d', '127.0.0.1', 1, '2026-08-04 19:57:55', '2026-08-03 16:03:33', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(17, 1, 'Computadora', 'Windows 10/11', 'Chrome', '06606101dcf37c0e67adb1071e8a548d', '127.0.0.1', 1, '2026-08-04 19:58:29', '2026-08-04 13:37:02', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36');

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
(1, 1, 'Examen Final', 'Responda de manera correcta para poder obtener su certificado.', 10.00, 50, 2, '2026-07-27 19:50:05');

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
  `estado_pago` varchar(50) NOT NULL DEFAULT 'PENDIENTE',
  `monto_pago` decimal(10,2) NOT NULL DEFAULT 0.00,
  `metodo_pago` varchar(255) DEFAULT NULL,
  `fecha_pago` timestamp NULL DEFAULT NULL,
  `comprobante_pago_url` varchar(255) DEFAULT NULL,
  `porcentaje_progreso` decimal(5,2) NOT NULL DEFAULT 0.00,
  `fecha_inscripcion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_completado` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inscripciones`
--

INSERT INTO `inscripciones` (`id`, `usuario_id`, `curso_id`, `estado`, `estado_pago`, `monto_pago`, `metodo_pago`, `fecha_pago`, `comprobante_pago_url`, `porcentaje_progreso`, `fecha_inscripcion`, `fecha_completado`) VALUES
(14, 12, 1, 'COMPLETADO', 'APROBADO', 205.00, 'QR', '2026-07-30 17:39:13', 'http://localhost:8000/uploads/comprobantes/1785433153_1534510209115.jpg', 100.00, '2026-07-30 17:39:15', '2026-07-30 17:42:37'),
(15, 13, 1, 'COMPLETADO', 'PENDIENTE', 205.00, 'QR', '2026-07-30 19:18:46', 'http://localhost:8000/uploads/comprobantes/1785439126_15036651-252342725181129-4260676635123463260-n.png', 100.00, '2026-07-30 19:18:48', '2026-07-30 19:50:52'),
(16, 14, 1, 'ACTIVO', 'PENDIENTE', 205.00, 'QR', '2026-07-31 14:16:45', 'http://localhost:8000/uploads/comprobantes/1785507405_chatgpt-image-22-jul-2026-03-18-21-pm.png', 0.00, '2026-07-31 14:16:46', NULL),
(17, 15, 1, 'COMPLETADO', 'PENDIENTE', 205.00, 'QR', '2026-08-03 16:04:42', 'http://localhost:8000/uploads/comprobantes/1785773082_comprobante.png', 100.00, '2026-08-03 16:04:44', '2026-08-04 19:08:45');

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
(9, 1, 12, 20.00, '2026-07-30 21:42:57', '2026-07-30 21:43:14', 1, '{\"1\":1,\"2\":3,\"3\":6,\"4\":10,\"5\":13}'),
(10, 1, 13, 60.00, '2026-07-30 23:56:07', '2026-07-30 23:56:20', 1, '{\"1\":1,\"2\":3,\"3\":5,\"4\":8,\"5\":14}'),
(11, 1, 15, 0.00, '2026-08-04 23:08:50', '2026-08-04 23:09:45', 0, '{\"1\":2,\"2\":3,\"3\":6,\"4\":9,\"5\":13}');

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
(1, 1, 'Introducción al cambio climático y la transición energética', 1, 'VIDEO', 'http://localhost:8000/uploads/general/1785181471_video-prototipo-pg-jrc.mp4', NULL, NULL, NULL, 0, '2026-07-27 19:44:34'),
(2, 2, 'Navegación y recorrido por la plataforma LMS de ENERVIDA', 1, 'PDF', NULL, 'http://localhost:8000/uploads/general/1785181565_informe-proyecto-ia.pdf', NULL, NULL, 0, '2026-07-27 19:46:07'),
(3, 3, 'Funcionamiento y tipos de paneles solares (Monocristalinos, Policristalinos y Bifaciales)', 1, 'PDF', NULL, 'http://localhost:8000/uploads/general/1785181632_informe-examen-final-robotica.pdf', NULL, NULL, 0, '2026-07-27 19:47:14'),
(4, 4, 'Lectura e interpretación de hojas de datos (datasheets) de equipos solares', 1, 'VIDEO', 'http://localhost:8000/uploads/general/1785181657_video.mp4', NULL, NULL, NULL, 0, '2026-07-27 19:47:39'),
(5, 5, 'Sistemas de monitorización remota y aplicaciones móviles para instalaciones solares', 1, 'VIDEO', 'http://localhost:8000/uploads/general/1785181710_video-prototipo-pg-jrc.mp4', NULL, NULL, NULL, 0, '2026-07-27 19:48:32'),
(7, 7, 'Fundamentos de la energía solar', 1, 'PDF', NULL, 'http://localhost:8000/uploads/general/1785872405_reporte-certificados-1785770992472.pdf', NULL, NULL, 0, '2026-08-04 19:40:09'),
(8, 9, 'Cálculo de la altura dinámica total (ADT)', 1, 'VIDEO', 'http://localhost:8000/uploads/general/1785872442_video.mp4', NULL, NULL, NULL, 0, '2026-08-04 19:40:54'),
(9, 10, 'Herramientas y seguridad en la instalación', 1, 'PDF', NULL, 'http://localhost:8000/uploads/general/1785872474_reporte-cursos-1785530515884.pdf', NULL, NULL, 0, '2026-08-04 19:41:18'),
(10, 11, 'Evaluación de necesidades del cliente agrícola', 1, 'VIDEO', 'https://youtu.be/hEIMZBz1k7M?si=-I9vNEjVkxGAJw_-', NULL, NULL, NULL, 0, '2026-08-04 19:42:26'),
(11, 12, 'Sensores de pozo y automatización de llenado', 1, 'VIDEO', 'https://youtu.be/RVSHrrd8tOA?si=E-ahTTbZqm4WT1-K', NULL, NULL, NULL, 0, '2026-08-04 19:43:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 1, 'Fundamentos de Energías Renovables y Sostenibilidad', 1, '2026-07-27 19:41:15'),
(2, 1, 'Arquitectura y Funcionamiento de las Plataformas E-Learning en el Sector Energético', 2, '2026-07-27 19:41:30'),
(3, 1, 'Tecnologías Fotovoltaicas y Soluciones Solares Conectadas', 3, '2026-07-27 19:41:42'),
(4, 1, 'Análisis de Documentación Técnica, Normativas y Cálculos Preliminares', 4, '2026-07-27 19:41:57'),
(5, 1, 'Evaluación Integral, Monitoreo Digital y Certificación', 5, '2026-07-27 19:42:01'),
(7, 2, 'Introducción al Bombeo Solar', 1, '2026-08-04 19:36:58'),
(9, 2, 'Diseño y Cálculo de Sistemas de Bombeo Solar', 2, '2026-08-04 19:37:33'),
(10, 2, 'Instalación y Mantenimiento de Bombas Solares', 3, '2026-08-04 19:37:47'),
(11, 2, 'Dimensionamiento y Venta de Proyectos de Bombeo Solar', 4, '2026-08-04 19:37:59'),
(12, 2, 'Optimización y Automatización en Bombeo Solar Hidráulico', 5, '2026-08-04 19:38:13');

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
(1, 1, 'La energía solar fotovoltaica transforma directamente la radiación solar en energía eléctrica.', 'TRUE_FALSE', 20),
(2, 1, 'Los paneles solares dejan de funcionar por completo cuando hay luz del día pero el cielo está nublado.', 'TRUE_FALSE', 20),
(3, 1, 'La eficiencia energética consiste en utilizar menos energía para realizar las mismas actividades o servicios.', 'TRUE_FALSE', 20),
(4, 1, '¿Cuál es el componente principal encargado de transformar la corriente continua de los paneles en corriente alterna para el hogar?', 'MULTIPLE_CHOICE', 20),
(5, 1, '¿Qué tipo de sistema solar se encuentra conectado a la red eléctrica pública de distribución?', 'MULTIPLE_CHOICE', 20);

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
(46, 12, 1, 1, NULL, 0),
(47, 12, 2, 1, NULL, 0),
(48, 12, 3, 1, NULL, 0),
(49, 12, 4, 1, NULL, 0),
(50, 12, 5, 1, NULL, 0),
(51, 13, 1, 1, NULL, 0),
(52, 13, 2, 1, NULL, 0),
(53, 13, 3, 1, NULL, 0),
(54, 13, 4, 1, NULL, 0),
(55, 13, 5, 1, NULL, 0),
(56, 15, 1, 1, NULL, 0),
(57, 15, 2, 1, NULL, 0),
(58, 15, 3, 1, NULL, 0),
(59, 15, 4, 1, NULL, 0),
(60, 15, 5, 1, NULL, 0);

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
(1, 1, 'Verdadero', 1),
(2, 1, 'Falso', 0),
(3, 2, 'Verdadero', 0),
(4, 2, 'Falso', 1),
(5, 3, 'Verdadero', 1),
(6, 3, 'Falso', 0),
(7, 4, 'A) El medidor inteligente', 0),
(8, 4, 'B) El inversor solar', 1),
(9, 4, 'C) La batería de litio', 0),
(10, 4, 'D) El cable de alta tensión', 0),
(11, 5, 'A) Sistema Off-Grid (Aislado)', 0),
(12, 5, 'B) Sistema On-Grid (Conectado a la red)', 1),
(13, 5, 'C) Sistema puramente mecánico', 0),
(14, 5, 'D) Sistema sin inversor', 0),
(15, 5, 'E) Ninguno', 0),
(16, 4, 'E) Ninguno', 0);

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
(1, 'admin', 'Administrador del sistema LMS', '2026-07-27 17:57:27'),
(2, 'estudiante', 'Estudiante del sistema LMS', '2026-07-27 17:57:53'),
(4, 'docente', '{\"info\":\"Personal que tenga solo acceso a dictar clases.\",\"permisos\":[\"CURSOS\",\"CLASES_VIVO\",\"EVALUACIONES\",\"CALIFICACIONES\",\"SOLICITUDES\",\"VERIFICACIONES QR\",\"INSCRIPCIONES\",\"DISPOSITIVOS\",\"ARCHIVOS\",\"NOTIFICACIONES\",\"ESTUDIANTES\"]}', '2026-07-30 13:51:04');

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
(2, 10, 'dvolGe3IQYrka4lZZfhX7wgEktkdphTB6Zfv1RBLKvngvghonQJqIJ4BF3kBfW63', 'RESET_PASSWORD', '2026-07-30 18:33:59', 1, '2026-07-30 18:25:21'),
(4, 12, 'c9QpjryrprURe0htmLAXxOHGUj9tc9GgtjI0FNimbOluy4s54PBwoNpKYekKvow3', 'RESET_PASSWORD', '2026-07-30 19:37:08', 0, '2026-07-30 18:37:08'),
(5, 1, '7K3vEXNUscf1DHAaVgdUdPryRVc6RDGIwMIG72N1RE3HMNfZRD45TENmeEkInUnV', 'RESET_PASSWORD', '2026-07-30 19:37:23', 0, '2026-07-30 18:37:23');

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
(1, 1, 'Homy', 'R.', 'danielacopana@gmail.com', '$2y$12$lLgJRNoQ3Ad02dq8QJ41oeKOyUR6f6z9rAbG7SfBV5gdaZ78.Wu/G', NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJVoi_9IxipIq8ZCyKMX6IzdEhGTDPDgXWuPlHjYDCjEmIGYw=s96-c', 'ACTIVO', 1, '2026-08-04 19:58:28', '2026-07-27 18:00:02', '2026-08-04 19:58:29', '$2y$12$zxq.ZDxcjjTXvJR9Ho8kuO77e4RhSADOUGTx/6Gcp83lR3Kf1zViO', NULL, '108515650607971543427'),
(10, 4, 'JHONATAN', 'Ramos Collquehuanca', 'ramosjhonatan659@gmail.com', '$2y$12$7a0/218.59laTG14DkCaDuwyby6u5Ppq7DRoqbTkFseZpk/kv5C5C', NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJddn9byvRrqboe0qx4Xmk7lYMSwFos3goeO5Yxk9enQPwOurcW=s96-c', 'ACTIVO', 1, '2026-08-04 17:03:01', '2026-07-30 13:48:51', '2026-08-04 19:13:04', NULL, NULL, '112034738939767958183'),
(12, 2, 'Omar', 'Ramos Mendoza', 'omaramos1522@gmail.com', '$2y$12$SLIrkk0DkXhLjjC7m1I9Nu/hrcF3DMlzHzmcjQT8dO1XlrOWdHe0.', '75423698', 'https://lh3.googleusercontent.com/a/ACg8ocJjESUPdgPngi4M1nxcedwGYMSO_-BXz040p3AhcC0D1KBipw=s96-c', 'ACTIVO', 1, '2026-08-03 18:49:38', '2026-07-30 17:38:28', '2026-08-03 18:50:56', NULL, '13054264', '116437308212656168830'),
(13, 2, 'Daniel', 'Alvarez Mendoza', 'daniealvarez597@gmail.com', '$2y$12$Ca7zp.kNsVQ7bO3WxnMl1uVwHpkqgpIj8Mzz97TRrVmBAm3igUW6W', '6325487849', 'https://lh3.googleusercontent.com/a/ACg8ocJFsGSWb2GrTQMKB7yKlPFlDvGk4KT0Aji6iRfJkDIkYyDsZA=s96-c', 'ACTIVO', 1, '2026-07-30 19:55:49', '2026-07-30 19:14:36', '2026-07-30 19:56:53', NULL, '89454156165', '100255754557653723851'),
(14, 2, 'Jhonas', 'Suxo Mamani', 'ramosjhonas231@gmail.com', '$2y$12$DbJV3/8vtrhufbI1bwdQSerAXbOkPpgy9gVHPOjvVUjzwx7iE7baa', '74256398', 'https://lh3.googleusercontent.com/a/ACg8ocKiCuk1uuD2lja2hmjf8KBfShrf4ouE5aqmBFbanCoaRCV8yA=s96-c', 'ACTIVO', 1, '2026-07-31 14:15:52', '2026-07-31 14:15:52', '2026-07-31 14:16:54', NULL, '56897521', '115548750146673786503'),
(15, 2, 'Angelica', 'Collquehuanca Callisaya', 'collquehuancaangelica@gmail.com', '$2y$12$NsH45JLUpTXksG.OZ3Slpey739JCRd921SUQw.so7scLtiaobdJpe', '654235624', 'https://lh3.googleusercontent.com/a/ACg8ocLCMt0ahA2E_R7KZcuPskzrcg8B72rp_ceKql-08y2EuFZM5g=s96-c', 'ACTIVO', 1, '2026-08-04 19:57:55', '2026-08-03 16:03:33', '2026-08-04 19:58:19', NULL, '19563247', '114312713684175149777');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=463;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `certificados`
--
ALTER TABLE `certificados`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `certificado_plantillas`
--
ALTER TABLE `certificado_plantillas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `clases_en_vivo`
--
ALTER TABLE `clases_en_vivo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `dispositivos_usuario`
--
ALTER TABLE `dispositivos_usuario`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `intentos_evaluacion`
--
ALTER TABLE `intentos_evaluacion`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `participantes_clase_en_vivo`
--
ALTER TABLE `participantes_clase_en_vivo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `progreso_lecciones`
--
ALTER TABLE `progreso_lecciones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tokens_recuperacion`
--
ALTER TABLE `tokens_recuperacion`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
