/**
 * Genera o recupera un ID único para el dispositivo actual
 * almacenado en localStorage para persistencia.
 */
export const getDeviceFingerprint = () => {
  let fingerprint = localStorage.getItem('device_fingerprint');
  if (!fingerprint) {
    fingerprint = crypto.randomUUID ? crypto.randomUUID() : Math.random().toString(36).substring(2) + Date.now().toString(36);
    localStorage.setItem('device_fingerprint', fingerprint);
  }
  return fingerprint;
};

/**
 * Obtiene información básica del navegador y sistema operativo
 */
export const getDeviceInfo = () => {
  const ua = navigator.userAgent;
  let browser = "Desconocido";
  let os = "Desconocido";

  // Detección simple de navegador
  if (ua.indexOf("Firefox") > -1) browser = "Firefox";
  else if (ua.indexOf("SamsungBrowser") > -1) browser = "Samsung Browser";
  else if (ua.indexOf("Opera") > -1 || ua.indexOf("OPR") > -1) browser = "Opera";
  else if (ua.indexOf("Trident") > -1) browser = "Internet Explorer";
  else if (ua.indexOf("Edge") > -1) browser = "Microsoft Edge";
  else if (ua.indexOf("Chrome") > -1) browser = "Google Chrome";
  else if (ua.indexOf("Safari") > -1) browser = "Safari";

  // Detección simple de OS
  if (ua.indexOf("Win") > -1) os = "Windows";
  else if (ua.indexOf("Mac") > -1) os = "MacOS";
  else if (ua.indexOf("X11") > -1) os = "UNIX";
  else if (ua.indexOf("Linux") > -1) os = "Linux";
  else if (ua.indexOf("Android") > -1) os = "Android";
  else if (ua.indexOf("iPhone") > -1) os = "iOS";

  return {
    browser,
    os,
    userAgent: ua,
    fingerprint: getDeviceFingerprint()
  };
};
