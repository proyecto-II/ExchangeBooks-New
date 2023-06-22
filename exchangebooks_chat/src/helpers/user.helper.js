import axios from "axios";

/**
 * Metodo que obtiene la informacion del usuario por su id
 * @return lista con la informacion del usuario
 */
export async function getUserInfo(userId) {
  try {
    const { status, data } = await axios.get(
      `http://localhost:3003/user/${userId}`
    );

    if (status === 200) {
      return data;
    } else {
      return null;
    }
  } catch (err) {
    console.error(err);
    return null;
  }
}
