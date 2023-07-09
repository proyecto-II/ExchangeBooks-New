import axios from "axios";
import { AUTH_SERVICE_URL } from "../config/constants";

/**
 * Metodo que obtiene la informacion del usuario por su id
 * @return lista con la informacion del usuario
 */
export async function getUserInfo(userId) {
  try {
    const { status, data } = await axios.get(
      `${AUTH_SERVICE_URL}/user/${userId}`
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
