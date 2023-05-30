import { LOCAL_DATA } from "../config/constants.js";
import RecomentationService from "../services/recomentation.service.js";

const recomendationService = new RecomentationService();

export async function getRecomentationBooks(req, res) {
  try {
    //const response = await recomendationService.getBooks(req.body.categories);
    //return res.status(200).send(JSON.parse(response.data.choices[0].text));
    return res.status(200).send(LOCAL_DATA);
  } catch (err) {
    return res.status(500).json({
      message: err.message,
    });
  }
}
