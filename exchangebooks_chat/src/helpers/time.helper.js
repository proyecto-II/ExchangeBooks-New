export function getLastMessageDate(dateString) {
  const date = new Date(dateString);

  const diferencia = Date.now() - date.getTime();

  const MILISECONDS_IN_24_HOURS = 24 * 60 * 60 * 1000;

  if (diferencia < MILISECONDS_IN_24_HOURS) {
    const hora = date.getUTCHours().toString().padStart(2, "0");
    const minuto = date.getUTCMinutes().toString().padStart(2, "0");

    return `${hora}:${minuto}`;
  } else {
    const dia = date.getUTCDate().toString().padStart(2, "0");
    const mes = date.getUTCMonth() + 1;
    const anio = date.getUTCFullYear();

    const fechaConvertida = `${dia}/${mes.toString().padStart(2, "0")}/${anio}`;

    return fechaConvertida;
  }
}
