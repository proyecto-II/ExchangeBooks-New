/**
 * Metodo que formatea la fecha, verifica si la fecha es de ayer si no buscara la diferencia entre la fecha actual y la fecha por parametros es inferior a un dia nos retornara la hora y los minutos en caso contrario no retornara dia/mes/año
 * @return String con la fecha formateada
 */
export function formatDate(dateString) {
  const date = new Date(dateString);
  const dateNow = new Date();

  const diferencia = Date.now() - date.getTime();
  const MILISECONDS_IN_24_HOURS = 24 * 60 * 60 * 1000;

  if (date.getDate() === dateNow.getDate() - 1) {
    return "Ayer";
  } else {
    if (diferencia < MILISECONDS_IN_24_HOURS) {
      const hora = date.getUTCHours().toString().padStart(2, "0");
      const minuto = date.getUTCMinutes().toString().padStart(2, "0");

      return `${hora}:${minuto}`;
    } else {
      const dia = date.getUTCDate().toString().padStart(2, "0");
      const mes = date.getUTCMonth() + 1;
      const anio = date.getUTCFullYear();

      const fechaConvertida = `${dia}/${mes
        .toString()
        .padStart(2, "0")}/${anio}`;

      return fechaConvertida;
    }
  }
}
