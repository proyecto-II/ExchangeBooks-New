import axios from "axios";

export async function getUserInfo(userId) {
  try {
    const { status, data } = await axios.get(
      `http://localhost:3003/user/${userId}`
    );
    console.log(status);
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
