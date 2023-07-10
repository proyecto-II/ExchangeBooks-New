import { BOOK_SERVICE_URL, LOCAL_DATA } from "../config/constants.js";
import RecomentationService from "../services/recomentation.service.js";
import axios from "axios";

const recomendationService = new RecomentationService();

export async function getRecomentationBooks(req, res) {
  try {
    const response = await recomendationService.getBooks(req.body.categories);
    const id = response.data.choices[0].text;
    const bookId = id.replace(/\s+/g, "");
    const bookResponse = await axios.get(`${BOOK_SERVICE_URL}/${bookId}`);

    if (bookResponse.status === 200) {
      return res.status(200).send(bookResponse.data);
    }
    return res.status(200).send("hola");
    //return res.status(200).send(LOCAL_DATA);
  } catch (err) {
    return res.status(500).json({
      message: err.message,
      data: LOCAL_DATA,
    });
  }
}
