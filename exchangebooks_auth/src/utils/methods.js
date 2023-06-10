export async function generateVerficationCode() {
  const min = 100000; // El número mínimo de 6 dígitos
  const max = 999999; // El número máximo de 6 dígitos
  const code = Math.floor(Math.random() * (max - min + 1) + min).toString();
  return Number(code);
}

export async function genereteExpiresDate() {
  const date = new Date();
  date.setHours(date.getHours() + 1);
  return date;
}
